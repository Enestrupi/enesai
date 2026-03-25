// server.js
const express = require('express');
const app = express();

// Middleware
app.use(express.json());

// Your AI endpoint
app.post("/api/ai", async (req, res) => {
  try {
    const { prompt, system } = req.body;
    
    if (!prompt) {
      return res.status(400).json({ error: "Missing prompt" });
    }

    const claudeKey = process.env.ANTHROPIC_API_KEY;
    const deepseekKey = process.env.DEEPSEEK_API_KEY;

    // Log for debugging
    console.log("[AI] Received prompt:", prompt.substring(0, 100));
    console.log("[AI] Claude key exists:", !!claudeKey);
    console.log("[AI] DeepSeek key exists:", !!deepseekKey);

    // Try Claude first
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
            model: "claude-3-sonnet-20240229", // Using a valid model name
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
            return res.json({ 
              success: true,
              content: [{ text }], 
              engine: "claude" 
            });
          }
        } else {
          const errorText = await response.text();
          console.warn("[AI] Claude error status:", response.status, errorText);
        }
      } catch (err) {
        console.warn("[AI] Claude error:", err.message);
      }
    }

    // Fallback to DeepSeek
    if (!deepseekKey) {
      console.error("[AI] No DeepSeek API key configured");
      return res.status(500).json({ 
        error: "No AI keys configured. Please set ANTHROPIC_API_KEY or DEEPSEEK_API_KEY" 
      });
    }

    try {
      console.log("[AI] Trying DeepSeek...");
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
        console.error("[AI] DeepSeek API error:", data);
        return res.status(response.status).json({
          error: data.error?.message || "DeepSeek API error",
          details: data
        });
      }

      const text = data.choices?.[0]?.message?.content || "";
      
      if (!text) {
        console.error("[AI] DeepSeek returned empty response:", data);
        return res.status(500).json({
          error: "DeepSeek returned empty response"
        });
      }

      console.log("[AI] DeepSeek responded ✓");
      return res.json({
        success: true,
        content: [{ text }],
        engine: "deepseek"
      });

    } catch (err) {
      console.error("[AI] DeepSeek fetch error:", err);
      return res.status(500).json({
        error: "DeepSeek request failed: " + err.message
      });
    }

  } catch (err) {
    console.error("[AI] Unexpected error:", err);
    return res.status(500).json({
      error: "Internal server error: " + err.message,
      stack: process.env.NODE_ENV === 'development' ? err.stack : undefined
    });
  }
});

// Health check endpoint
app.get("/health", (req, res) => {
  res.json({ 
    status: "ok",
    timestamp: new Date().toISOString(),
    env: {
      hasClaudeKey: !!process.env.ANTHROPIC_API_KEY,
      hasDeepSeekKey: !!process.env.DEEPSEEK_API_KEY
    }
  });
});

// Root endpoint
app.get("/", (req, res) => {
  res.json({ 
    message: "AI API Server is running",
    endpoints: ["POST /api/ai", "GET /health"]
  });
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);
  console.log(`Claude API key configured: ${!!process.env.ANTHROPIC_API_KEY}`);
  console.log(`DeepSeek API key configured: ${!!process.env.DEEPSEEK_API_KEY}`);
});

// Error handling for uncaught exceptions
process.on('uncaughtException', (error) => {
  console.error('Uncaught Exception:', error);
});

process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled Rejection at:', promise, 'reason:', reason);
});
