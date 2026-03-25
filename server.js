const express = require('express');
const app = express();

// =====================================================
// Middleware
// =====================================================
app.use(express.json());

// =====================================================
// In-memory session storage (replace with DB later)
// =====================================================
const sessions = {};

// =====================================================
// SESSION + COMMAND SYSTEM (FIXES YOUR 404)
// =====================================================

// Create a session
app.post("/api/session", (req, res) => {
  const { token } = req.body;

  if (!token) {
    return res.status(400).json({ error: "Missing token" });
  }

  sessions[token] = {
    commands: [],
    lastResult: null
  };

  console.log("[SESSION] Created:", token);

  res.json({ success: true });
});

// Send a command (from dashboard)
app.post("/api/command", (req, res) => {
  const { token, command } = req.body;

  if (!sessions[token]) {
    return res.status(404).json({ error: "Session not found" });
  }

  const cmd = {
    id: Date.now().toString(),
    ...command
  };

  sessions[token].commands.push(cmd);

  console.log("[COMMAND] Added:", cmd.type);

  res.json({ success: true, command: cmd });
});

// Poll for commands (🔥 THIS FIXES YOUR ERROR)
app.get("/api/poll/:token", (req, res) => {
  const { token } = req.params;

  const session = sessions[token];
  if (!session) {
    return res.status(404).json({ error: "Invalid session" });
  }

  if (session.commands.length === 0) {
    return res.json({ hasCommand: false });
  }

  const command = session.commands.shift();

  console.log("[POLL] Sending command:", command.type);

  res.json({
    hasCommand: true,
    command
  });
});

// Receive result from plugin
app.post("/api/result", (req, res) => {
  const { token, commandId, output, success } = req.body;

  const session = sessions[token];
  if (!session) {
    return res.status(404).json({ error: "Invalid session" });
  }

  session.lastResult = {
    commandId,
    output,
    success,
    timestamp: Date.now()
  };

  console.log("[RESULT]", session.lastResult);

  res.json({ success: true });
});

// =====================================================
// AI ENDPOINT (your original code)
// =====================================================
app.post("/api/ai", async (req, res) => {
  try {
    const { prompt, system } = req.body;

    if (!prompt) {
      return res.status(400).json({ error: "Missing prompt" });
    }

    const claudeKey = process.env.ANTHROPIC_API_KEY;
    const deepseekKey = process.env.DEEPSEEK_API_KEY;

    console.log("[AI] Prompt:", prompt.substring(0, 100));

    // Try Claude
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
            model: "claude-3-sonnet-20240229",
            max_tokens: 4000,
            system: system || "You are an expert Roblox Lua developer.",
            messages: [{ role: "user", content: prompt }]
          })
        });

        if (response.ok) {
          const data = await response.json();
          const text = data.content?.[0]?.text || "";

          if (text) {
            console.log("[AI] Claude ✓");
            return res.json({
              success: true,
              content: [{ text }],
              engine: "claude"
            });
          }
        }
      } catch (err) {
        console.warn("[AI] Claude error:", err.message);
      }
    }

    // Fallback DeepSeek
    if (!deepseekKey) {
      return res.status(500).json({
        error: "No AI keys configured"
      });
    }

    const response = await fetch("https://api.deepseek.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + deepseekKey
      },
      body: JSON.stringify({
        model: "deepseek-chat",
        max_tokens: 4000,
        temperature: 0.3,
        messages: [
          {
            role: "system",
            content: system || "You are an expert Roblox Lua developer."
          },
          {
            role: "user",
            content: prompt
          }
        ]
      })
    });

    const data = await response.json();

    if (!response.ok) {
      return res.status(response.status).json({
        error: data.error?.message || "DeepSeek API error"
      });
    }

    const text = data.choices?.[0]?.message?.content || "";

    return res.json({
      success: true,
      content: [{ text }],
      engine: "deepseek"
    });

  } catch (err) {
    console.error("[AI] Error:", err);
    res.status(500).json({
      error: err.message
    });
  }
});

// =====================================================
// HEALTH + ROOT
// =====================================================
app.get("/health", (req, res) => {
  res.json({ status: "ok" });
});

app.get("/", (req, res) => {
  res.json({
    message: "Server running",
    endpoints: [
      "/api/session",
      "/api/command",
      "/api/poll/:token",
      "/api/result",
      "/api/ai"
    ]
  });
});

// =====================================================
// START SERVER
// =====================================================
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

// =====================================================
// ERROR HANDLING
// =====================================================
process.on('uncaughtException', (err) => {
  console.error('Uncaught Exception:', err);
});

process.on('unhandledRejection', (reason) => {
  console.error('Unhandled Rejection:', reason);
});
