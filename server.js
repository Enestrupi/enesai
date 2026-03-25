app.post("/api/ai", async (req, res) => {
  const { prompt, system } = req.body;
  if (!prompt) return res.status(400).json({ error: "prompt required" });

  const key = process.env.DEEPSEEK_API_KEY;
  if (!key) return res.status(500).json({ error: "DEEPSEEK_API_KEY not set on server" });

  try {
    const response = await fetch("https://api.deepseek.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + key
      },
      body: JSON.stringify({
        model: "deepseek-chat", // or "deepseek-coder" if you prefer
        max_tokens: 4000,
        temperature: 0.2,
        messages: [
          { role: "system", content: system || "You are a Roblox Lua expert." },
          { role: "user", content: prompt }
        ]
      })
    });

    const data = await response.json();

    if (!response.ok) {
      console.error("DeepSeek error:", data);
      return res.status(500).json({ error: data.error?.message || "DeepSeek API error" });
    }

    const text = data.choices?.[0]?.message?.content || "";
    res.json({ content: [{ text }] });

  } catch (e) {
    console.error("AI route error:", e.message);
    res.status(500).json({ error: e.message });
  }
});
