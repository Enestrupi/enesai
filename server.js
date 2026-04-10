const express = require("express");
const app = express();

app.use(express.json());

// ── CORS ──
app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
  if (req.method === "OPTIONS") return res.sendStatus(204);
  next();
});

// ── In-memory sessions ──
const sessions = {};
function getSession(token) {
  if (!sessions[token]) sessions[token] = { connected: false, command: null, result: null, lastSeen: Date.now() };
  return sessions[token];
}

// ── System prompt ──
const ROBLOX_SYSTEM = `You are an expert Roblox Lua developer. Follow these rules strictly:
- Server Script: use DataStoreService, PlayerAdded, FireClient, OnServerEvent. NEVER use LocalPlayer/PlayerGui/UserInputService.
- LocalScript: use LocalPlayer, PlayerGui, UserInputService, FireServer, OnClientEvent. NEVER use DataStoreService/OnServerEvent.
- RemoteEvents must be created in the server Script only. LocalScript uses WaitForChild() to get them.
- Always use task.wait(), never wait().
- Output ONLY raw Lua. No markdown, no code fences, no explanations.
- Write complete, fully working code. No placeholders like "PlayerName" or "put code here".
- GUIs must be fully functional with real TextBox inputs, not hardcoded strings.
Multi-script separator format (only include sections needed):
===SCRIPT_SERVER===
===SCRIPT_LOCAL===
===SCRIPT_MODULE===`;

// ── Token estimator (rough: 1 token ≈ 4 chars) ──
function estimateTokens(str) {
  return Math.ceil(str.length / 4);
}

// ── Trim to fit within a token budget ──
function trimToTokens(str, maxTokens) {
  return str.slice(0, maxTokens * 4);
}

// ═══════════════════════════════════════════
// AI — Groq
// ═══════════════════════════════════════════
app.post("/api/ai", async (req, res) => {
  const { prompt, system } = req.body;
  if (!prompt) return res.status(400).json({ error: "prompt required" });

  const key = process.env.OPENROUTER_API_KEY;
  if (!key) return res.status(500).json({ error: "OPENROUTER_API_KEY not set" });

  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), 60000);

  try {
    const response = await fetch("https://openrouter.ai/api/v1/chat/completions", {
      method: "POST",
      signal: controller.signal,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + key
      },
      body: JSON.stringify({
        model: "google/gemini-2.0-flash-exp:free",
        max_tokens: 12000,
        temperature: 0.2,
        messages: [
          { role: "system", content: system || ROBLOX_SYSTEM },
          { role: "user", content: prompt }
        ]
      })
    });

    clearTimeout(timeout);
    const data = await response.json();
    console.log("OpenRouter response:", JSON.stringify(data));

    if (!response.ok) {
      console.error("OpenRouter error:", data);
      return res.status(500).json({ error: data.error?.message || "OpenRouter API error" });
    }

    const text = data.choices?.[0]?.message?.content || "";
    res.json({ content: [{ text }] });

  } catch (e) {
    clearTimeout(timeout);
    const msg = e.name === "AbortError" ? "Request timed out (60s)" : e.message;
    console.error("AI error:", msg);
    res.status(500).json({ error: msg });
  }
});

// ═══════════════════════════════════════════
// PING
// ═══════════════════════════════════════════
app.get("/api/ping/:token", (req, res) => {
  const s = getSession(req.params.token);
  res.json({ connected: s.connected });
});

// ═══════════════════════════════════════════
// POLL
// ═══════════════════════════════════════════
app.get("/api/poll/:token", (req, res) => {
  const s = getSession(req.params.token);
  s.connected = true;
  s.lastSeen  = Date.now();
  if (s.command) {
    const cmd = s.command;
    s.command = null;
    return res.json({ hasCommand: true, command: cmd });
  }
  res.json({ hasCommand: false });
});

// ═══════════════════════════════════════════
// HEARTBEAT
// ═══════════════════════════════════════════
app.post("/api/heartbeat/:token", (req, res) => {
  const s = getSession(req.params.token);
  s.connected = true;
  s.lastSeen  = Date.now();
  if (s.command) {
    const cmd = s.command;
    s.command = null;
    return res.json({ hasCommand: true, command: cmd });
  }
  res.json({ hasCommand: false });
});

// ═══════════════════════════════════════════
// COMMAND
// ═══════════════════════════════════════════
app.post("/api/command", (req, res) => {
  const { token, type, body } = req.body;
  if (!token || !body) return res.status(400).json({ ok: false, error: "token and body required" });
  const s = getSession(token);
  s.command = { type: type || "run_script", body };
  s.result  = null;
  res.json({ ok: true });
});

// ═══════════════════════════════════════════
// RESULT POST
// ═══════════════════════════════════════════
app.post("/api/result/:token", (req, res) => {
  const s = getSession(req.params.token);
  s.result = { ready: true, success: req.body.success !== false, output: req.body.output || "" };
  res.json({ ok: true });
});

// ═══════════════════════════════════════════
// RESULT GET
// ═══════════════════════════════════════════
app.get("/api/result/:token", (req, res) => {
  const s = getSession(req.params.token);
  if (s.result?.ready) {
    const r = s.result;
    s.result = null;
    return res.json(r);
  }
  res.json({ ready: false });
});

// ═══════════════════════════════════════════
// DISCONNECT
// ═══════════════════════════════════════════
app.post("/api/disconnect/:token", (req, res) => {
  const s = getSession(req.params.token);
  s.connected = false;
  res.json({ ok: true });
});

// ── Health check ──
app.get("/", (req, res) => res.send("Studio Bridge OK"));

// ── Clean up idle sessions ──
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
  console.log("Studio Bridge on port " + PORT);
 console.log("OpenRouter key: " + (process.env.OPENROUTER_API_KEY ? "SET" : "MISSING"));
});
