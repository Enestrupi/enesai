const express = require("express");
const app = express();

app.use(express.json({ limit: "2mb" }));

// CORS
app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
  if (req.method === "OPTIONS") return res.sendStatus(204);
  next();
});

// In-memory sessions
const sessions = {};
function getSession(token) {
  if (!sessions[token]) sessions[token] = { connected: false, command: null, result: null, lastSeen: Date.now() };
  return sessions[token];
}

// System prompt fallback
const ROBLOX_SYSTEM = `You are an expert Roblox Luau developer. Write complete, working code only.
- Always use task.wait() never wait()
- Always use game:GetService() cached at top
- Server Scripts go in ServerScriptService
- LocalScripts go in StarterPlayerScripts or StarterGui
- ModuleScripts go in ReplicatedStorage
- pcall() around all DataStore calls
- Validate all RemoteEvent args server-side`;

// Translate frontend model IDs to OpenRouter slugs
// OpenRouter requires the "provider/model" format
const MODEL_MAP = {
  "claude-haiku-4-5-20251001": "anthropic/claude-haiku-4-5",
  "claude-sonnet-4-20250514":  "anthropic/claude-sonnet-4-5",
  "claude-opus-4-5":           "anthropic/claude-opus-4-5",
};
const DEFAULT_OR_MODEL = "anthropic/claude-haiku-4-5";

function resolveModel(raw) {
  if (!raw) return DEFAULT_OR_MODEL;
  if (MODEL_MAP[raw]) return MODEL_MAP[raw];
  // already an OpenRouter slug
  if (raw.includes("/")) return raw;
  return DEFAULT_OR_MODEL;
}

// AI endpoint - OpenRouter
app.post("/api/ai", async (req, res) => {
  const { prompt, system, model, maxTokens } = req.body;
  if (!prompt) return res.status(400).json({ error: "prompt required" });

  const key = process.env.OPENROUTER_API_KEY;
  if (!key) {
    console.error("OPENROUTER_API_KEY is not set!");
    return res.status(500).json({ error: "OPENROUTER_API_KEY not set on server" });
  }

  const resolvedModel = resolveModel(model);
  console.log("AI request | model raw:", model, "-> resolved:", resolvedModel, "| prompt:", prompt.length, "chars");

  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), 90000);

  try {
    const response = await fetch("https://openrouter.ai/api/v1/chat/completions", {
      method: "POST",
      signal: controller.signal,
      headers: {
        "Content-Type":  "application/json",
        "Authorization": "Bearer " + key,
        "HTTP-Referer":  "https://studio-bridge.app",
        "X-Title":       "Studio Bridge"
      },
      body: JSON.stringify({
        model:      resolvedModel,
        max_tokens: maxTokens || 8000,
        temperature: 0.2,
        messages: [
          { role: "system", content: system || ROBLOX_SYSTEM },
          { role: "user",   content: prompt }
        ]
      })
    });

    clearTimeout(timeout);
    const data = await response.json();

    if (!response.ok) {
      console.error("OpenRouter HTTP", response.status, JSON.stringify(data));
      return res.status(500).json({
        error: data.error?.message || ("OpenRouter error HTTP " + response.status),
        detail: data
      });
    }

    const text = (data.choices || [])[0]?.message?.content || "";
    if (!text) {
      console.warn("OpenRouter empty response:", JSON.stringify(data));
      return res.status(500).json({ error: "Empty response from OpenRouter", detail: data });
    }

    console.log("AI ok | chars:", text.length);
    res.json({ content: [{ text }] });

  } catch (e) {
    clearTimeout(timeout);
    const msg = e.name === "AbortError" ? "Request timed out after 90s" : e.message;
    console.error("AI error:", msg);
    res.status(500).json({ error: msg });
  }
});

// PING
app.get("/api/ping/:token", (req, res) => {
  const s = getSession(req.params.token);
  res.json({ connected: s.connected });
});

// POLL
app.get("/api/poll/:token", (req, res) => {
  const s = getSession(req.params.token);
  s.connected = true;
  s.lastSeen = Date.now();
  if (s.command) {
    const cmd = s.command;
    s.command = null;
    return res.json({ hasCommand: true, command: cmd });
  }
  res.json({ hasCommand: false });
});

// HEARTBEAT
app.post("/api/heartbeat/:token", (req, res) => {
  const s = getSession(req.params.token);
  s.connected = true;
  s.lastSeen = Date.now();
  if (s.command) {
    const cmd = s.command;
    s.command = null;
    return res.json({ hasCommand: true, command: cmd });
  }
  res.json({ hasCommand: false });
});

// COMMAND
app.post("/api/command", (req, res) => {
  const { token, type, body } = req.body;
  if (!token || !body) return res.status(400).json({ ok: false, error: "token and body required" });
  const s = getSession(token);
  s.command = { type: type || "run_script", body };
  s.result = null;
  res.json({ ok: true });
});

// RESULT POST
app.post("/api/result/:token", (req, res) => {
  const s = getSession(req.params.token);
  s.result = { ready: true, success: req.body.success !== false, output: req.body.output || "" };
  res.json({ ok: true });
});

// RESULT GET
app.get("/api/result/:token", (req, res) => {
  const s = getSession(req.params.token);
  if (s.result && s.result.ready) {
    const r = s.result;
    s.result = null;
    return res.json(r);
  }
  res.json({ ready: false });
});

// DISCONNECT
app.post("/api/disconnect/:token", (req, res) => {
  const s = getSession(req.params.token);
  s.connected = false;
  res.json({ ok: true });
});

// Health
app.get("/", (req, res) => res.send("Studio Bridge OK"));

// Favicon suppress
app.get("/favicon.ico", (req, res) => res.sendStatus(204));

// Debug
app.get("/api/debug", (req, res) => {
  res.json({
    status: "ok",
    openrouterKeySet: !!process.env.OPENROUTER_API_KEY,
    openrouterKeyPrefix: process.env.OPENROUTER_API_KEY
      ? process.env.OPENROUTER_API_KEY.slice(0, 10) + "..."
      : "MISSING",
    activeSessions: Object.keys(sessions).length,
    nodeVersion: process.version,
    uptime: Math.floor(process.uptime()) + "s"
  });
});

// Test - fires a real minimal OpenRouter call
app.get("/api/test", async (req, res) => {
  const key = process.env.OPENROUTER_API_KEY;
  if (!key) return res.json({ ok: false, error: "OPENROUTER_API_KEY not set" });
  try {
    const r = await fetch("https://openrouter.ai/api/v1/chat/completions", {
      method: "POST",
      headers: {
        "Content-Type":  "application/json",
        "Authorization": "Bearer " + key,
        "HTTP-Referer":  "https://studio-bridge.app",
        "X-Title":       "Studio Bridge"
      },
      body: JSON.stringify({
        model: "anthropic/claude-haiku-4-5",
        max_tokens: 20,
        messages: [{ role: "user", content: "Say: OK" }]
      })
    });
    const data = await r.json();
    res.json({ httpStatus: r.status, data });
  } catch (e) {
    res.json({ ok: false, error: e.message });
  }
});

// Clean up idle sessions
setInterval(() => {
  const cutoff = Date.now() - 5 * 60 * 1000;
  for (const token in sessions) {
    if (sessions[token].lastSeen < cutoff) {
      sessions[token].connected = false;
    }
  }
}, 30000);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log("Studio Bridge running on port " + PORT);
  console.log("OPENROUTER_API_KEY:", process.env.OPENROUTER_API_KEY ? "SET" : "MISSING");
});
