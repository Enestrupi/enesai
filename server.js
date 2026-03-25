app.post("/api/ai", async (req, res) => {
  try {
    const { prompt, system } = req.body;
    if (!prompt) {
      return res.status(400).json({ error: "Missing prompt" });
    }

    const claudeKey = process.env.ANTHROPIC_API_KEY;
    const deepseekKey = process.env.DEEPSEEK_API_KEY;

    // ── Claude (primary) ──
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
          console.warn("[AI] Claude error status:", response.status);
        }
      } catch (err) {
        console.warn("[AI] Claude error:", err.message);
      }
    }

    // ── DeepSeek (fallback) ──
    if (!deepseekKey) {
      return res.status(500).json({
        error: "No AI keys configured."
      });
    }

    try {
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
        return res.status(500).json({
          error: data.error?.message || "DeepSeek error"
        });
      }

      const text = data.choices?.[0]?.message?.content || "";
      console.log("[AI] DeepSeek responded ✓");

      return res.json({
        content: [{ text }],
        engine: "deepseek"
      });

    } catch (err) {
      console.error("[AI] DeepSeek error:", err.message);
      return res.status(500).json({
        error: "DeepSeek failed: " + err.message
      });
    }

  } catch (err) {
    console.error("[AI] Unexpected error:", err);
    return res.status(500).json({
      error: "Internal server error: " + err.message
    });
  }
});
