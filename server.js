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

// ── Roblox system prompt (concise) ──
const ROBLOX_SYSTEM = `Expert Roblox Lua dev. Rules: Server scripts use DataStore/PlayerAdded/FireClient/OnServerEvent, never LocalPlayer. LocalScripts use LocalPlayer/PlayerGui/UserInputService/FireServer/OnClientEvent, never DataStoreService. RemoteEvents created server-side only; LocalScript uses WaitForChild(). Use task.wait() not wait(). Output complete code, no placeholders, no markdown fences.
Multi-script format:
===SCRIPT_SERVER===
===SCRIPT_LOCAL===
===SCRIPT_MODULE===
Only include needed sections.`;

// ═══════════════════════════════════════════
// AI — Groq
// ═══════════════════════════════════════════
app.post("/api/ai", async (req, res) => {
  const { prompt, system } = req.body;
  if (!prompt) return res.status(400).json({ error: "prompt required" });

  const key = process.env.GROQ_API_KEY;
  if (!key) return res.status(500).json({ error: "GROQ_API_KEY not set on server" });

  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), 60000);

  const extraSystem = system ? system.slice(0, 200) : "";
  const fullSystem = ROBLOX_SYSTEM + (extraSystem ? "\n" + extraSystem : "");

  // Trim prompt to avoid token limit (llama-3.3-70b TPM limit on free tier)
  const trimmedPrompt = prompt.slice(0, 6000);

  try {
    const response = await fetch("https://api.groq.com/openai/v1/chat/completions", {
      method: "POST",
      signal: controller.signal,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + key
      },
      body: JSON.stringify({
        model: "llama-3.3-70b-versatile",
        max_tokens: 6000,
        temperature: 0.2,
        messages: [
          { role: "system", content: fullSystem },
          { role: "user",   content: trimmedPrompt }
        ]
      })
    });

    clearTimeout(timeout);
    const data = await response.json();

    if (!response.ok) {
      console.error("Groq error:", data);
      return res.status(500).json({ error: data.error?.message || "Groq API error" });
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
  console.log("Groq key: " + (process.env.GROQ_API_KEY ? "SET" : "MISSING"));
});
