const express = require("express");
const app = express();

app.use(express.json());

// ── CORS — allow browser requests from any origin ──
app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
  if (req.method === "OPTIONS") return res.sendStatus(204);
  next();
});

// ── In-memory store for plugin commands + results ──
// token → { connected, command, result }
const sessions = {};

function getSession(token) {
  if (!sessions[token]) sessions[token] = { connected: false, command: null, result: null };
  return sessions[token];
}

// ═══════════════════════════════════════════
// AI ROUTE — Groq
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
        max_tokens: 4000,
        temperature: 0.2,
        messages: [
          { role: "system", content: system || "You are a Roblox Lua expert." },
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
    console.error("AI route error:", e.message);
    res.status(500).json({ error: e.message });
  }
});

// ═══════════════════════════════════════════
// PING — dashboard polls this to check if
//         the Roblox plugin is connected
// ═══════════════════════════════════════════
app.get("/api/ping/:token", (req, res) => {
  const session = getSession(req.params.token);
  res.json({ connected: session.connected });
});

// ═══════════════════════════════════════════
// PLUGIN HEARTBEAT — Roblox plugin calls this
//                    every few seconds to stay alive
// ═══════════════════════════════════════════
app.post("/api/heartbeat/:token", (req, res) => {
  const session = getSession(req.params.token);
  session.connected = true;

  // If there's a pending command, send it to the plugin
  if (session.command) {
    const cmd = session.command;
    session.command = null; // clear it so it's only sent once
    return res.json({ hasCommand: true, command: cmd });
  }

  res.json({ hasCommand: false });
});

// ═══════════════════════════════════════════
// COMMAND — dashboard sends a script to run
//           in Roblox Studio via the plugin
// ═══════════════════════════════════════════
app.post("/api/command", (req, res) => {
  const { token, type, body } = req.body;
  if (!token || !body) return res.status(400).json({ ok: false, error: "token and body required" });

  const session = getSession(token);
  session.command = { type: type || "run_script", body };
  session.result  = null; // clear old result

  res.json({ ok: true });
});

// ═══════════════════════════════════════════
// RESULT — plugin posts the output back here
//           after running the script
// ═══════════════════════════════════════════
app.post("/api/result/:token", (req, res) => {
  const session = getSession(req.params.token);
  session.result = {
    ready:   true,
    success: req.body.success !== false,
    output:  req.body.output || ""
  };
  res.json({ ok: true });
});

// ═══════════════════════════════════════════
// GET RESULT — dashboard polls this waiting
//              for the plugin's output
// ═══════════════════════════════════════════
app.get("/api/result/:token", (req, res) => {
  const session = getSession(req.params.token);
  if (session.result?.ready) {
    const r = session.result;
    session.result = null; // clear after reading
    return res.json(r);
  }
  res.json({ ready: false });
});

// ═══════════════════════════════════════════
// DISCONNECT — plugin calls this on shutdown
// ═══════════════════════════════════════════
app.post("/api/disconnect/:token", (req, res) => {
  const session = getSession(req.params.token);
  session.connected = false;
  res.json({ ok: true });
});

// ── Auto-disconnect sessions that haven't
//    pinged in 10 seconds ──
setInterval(() => {
  // nothing to clean up with simple in-memory store,
  // but you could add timestamps here if needed
}, 10000);

// ═══════════════════════════════════════════
// START
// ═══════════════════════════════════════════
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Studio Bridge backend running on port ${PORT}`);
  console.log(`Groq key: ${process.env.GROQ_API_KEY ? "✓ set" : "✗ MISSING"}`);
});
