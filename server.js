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

// ═══════════════════════════════════════════
// AI — Groq (fast, free tier available)
// Add GROQ_API_KEY to Railway environment variables
// ═══════════════════════════════════════════
app.post("/api/ai", async (req, res) => {
  const { prompt, system } = req.body;
  if (!prompt) return res.status(400).json({ error: "prompt required" });

  const key = process.env.GROQ_API_KEY;
  if (!key) return res.status(500).json({ error: "GROQ_API_KEY not set on server" });

  try {
    const response = await fetch("https://api.groq.com/openai/v1/chat/completions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + key
      },
      body: JSON.stringify({
        model: "llama-3.3-70b-versatile",
        max_tokens: 8000,
        temperature: 0.2,
        messages: [
          { role: "system", content: system || "You are an expert Roblox Lua developer." },
          { role: "user",   content: prompt }
        ]
      })
    });

    const data = await response.json();

    if (!response.ok) {
      console.error("Groq error:", data);
      return res.status(500).json({ error: data.error?.message || "Groq API error" });
    }

    const text = data.choices?.[0]?.message?.content || "";
    res.json({ content: [{ text }] });

  } catch (e) {
    console.error("AI error:", e.message);
    res.status(500).json({ error: e.message });
  }
});

// ═══════════════════════════════════════════
// PING — dashboard checks if plugin is live
// ═══════════════════════════════════════════
app.get("/api/ping/:token", (req, res) => {
  const s = getSession(req.params.token);
  res.json({ connected: s.connected });
});

// ═══════════════════════════════════════════
// HEARTBEAT — plugin calls this every ~1s
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
// COMMAND — dashboard queues a script
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
// RESULT POST — plugin sends back output
// ═══════════════════════════════════════════
app.post("/api/result/:token", (req, res) => {
  const s = getSession(req.params.token);
  s.result = { ready: true, success: req.body.success !== false, output: req.body.output || "" };
  res.json({ ok: true });
});

// ═══════════════════════════════════════════
// RESULT GET — dashboard polls for output
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
// DISCONNECT — plugin calls on close
// ═══════════════════════════════════════════
app.post("/api/disconnect/:token", (req, res) => {
  const s = getSession(req.params.token);
  s.connected = false;
  res.json({ ok: true });
});

// ── Clean up sessions idle > 5 min ──
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
