const express = require("express");
const cors = require("cors");
const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors({ origin: "*" }));
app.use(express.json({ limit: "10mb" }));

const pendingCommands = {};
const results = {};
const sessions = {};

app.get("/", (req, res) => {
  res.json({ ok: true, service: "studio-bridge", version: "3.0.0" });
});

// ── AI endpoint — Claude primary, Groq fallback ──
app.post("/api/ai", async (req, res) => {
  const { prompt, system } = req.body;
  if (!prompt) return res.status(400).json({ error: "Missing prompt" });

  const claudeKey = process.env.ANTHROPIC_API_KEY;
  const groqKey = process.env.GROQ_API_KEY;

  // Try Claude first if key exists
  if (claudeKey) {
    try {
      const response = await fetch("https://api.anthropic.com/v1/messages", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "x-api-key": claudeKey,
          "anthropic-version": "2023-06-01"
        },
        body: JSON.stringify({
          model: "claude-sonnet-4-20250514",
          max_tokens: 4000,
          system: system || "You are an expert Roblox Lua developer.",
          messages: [{ role: "user", content: prompt }]
        })
      });

      if (response.ok) {
        const data = await response.json();
        const text = data.content?.[0]?.text || "";
        if (text) {
          console.log("[AI] Claude responded ✓");
          return res.json({ content: [{ text }], engine: "claude" });
        }
      } else {
        const err = await response.text();
        console.warn("[AI] Claude failed:", response.status, err.slice(0, 100));
      }
    } catch (err) {
      console.warn("[AI] Claude error:", err.message);
    }
  }

  // Fallback to Groq
  if (!groqKey) return res.status(500).json({ error: "No AI keys configured. Set ANTHROPIC_API_KEY or GROQ_API_KEY." });

  try {
    const response = await fetch("https://api.groq.com/openai/v1/chat/completions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + groqKey
      },
      body: JSON.stringify({
        model: "llama-3.3-70b-versatile",
        max_tokens: 4000,
        temperature: 0.3,
        messages: [
          { role: "system", content: system || "You are an expert Roblox Lua developer." },
          { role: "user", content: prompt }
        ]
      })
    });

    const data = await response.json();
    if (!response.ok) return res.status(500).json({ error: data.error?.message || "Groq error" });

    const text = data.choices?.[0]?.message?.content || "";
    console.log("[AI] Groq responded ✓");
    return res.json({ content: [{ text }], engine: "groq" });

  } catch (err) {
    return res.status(500).json({ error: "All AI engines failed: " + err.message });
  }
});

// ── Studio Bridge endpoints ──
app.post("/api/command", (req, res) => {
  const { token, type, body } = req.body;
  if (!token || !body) return res.status(400).json({ ok: false, error: "Missing token or body" });
  pendingCommands[token] = {
    id: Date.now().toString(36),
    type: type || "eval",
    body,
    sentAt: Date.now()
  };
  delete results[token];
  res.json({ ok: true, commandId: pendingCommands[token].id });
});

app.get("/api/poll/:token", (req, res) => {
  const { token } = req.params;
  sessions[token] = { lastPing: Date.now(), connectedAt: sessions[token]?.connectedAt || Date.now() };
  const cmd = pendingCommands[token];
  if (!cmd) return res.json({ hasCommand: false });
  delete pendingCommands[token];
  res.json({ hasCommand: true, command: cmd });
});

app.post("/api/result", (req, res) => {
  const { token, commandId, output, success } = req.body;
  if (!token) return res.status(400).json({ ok: false, error: "Missing token" });
  results[token] = {
    commandId,
    output: output || "(no output)",
    success: success !== false,
    receivedAt: Date.now()
  };
  res.json({ ok: true });
});

app.get("/api/result/:token", (req, res) => {
  const { token } = req.params;
  const r = results[token];
  if (!r) return res.json({ ready: false });
  delete results[token];
  res.json({ ready: true, ...r });
});

app.get("/api/ping/:token", (req, res) => {
  const { token } = req.params;
  const session = sessions[token];
  if (!session) return res.json({ connected: false });
  const connected = Date.now() - session.lastPing < 6000;
  res.json({ connected, lastPing: session.lastPing });
});

// Cleanup old sessions
setInterval(() => {
  const now = Date.now();
  for (const token in sessions) {
    if (now - sessions[token].lastPing > 30000) delete sessions[token];
  }
  for (const token in pendingCommands) {
    if (now - pendingCommands[token].sentAt > 30000) delete pendingCommands[token];
  }
}, 60000);

app.listen(PORT, () => {
  console.log("Studio Bridge v3 running on port " + PORT);
  console.log("Claude AI: " + (process.env.ANTHROPIC_API_KEY ? "✓ configured" : "✗ not set"));
  console.log("Groq AI:   " + (process.env.GROQ_API_KEY ? "✓ configured" : "✗ not set"));
});
