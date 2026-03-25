// Fallback to DeepSeek
const deepseekKey = process.env.DEEPSEEK_API_KEY;

if (!deepseekKey) {
  return res.status(500).json({
    error: "No AI keys configured. Set ANTHROPIC_API_KEY or DEEPSEEK_API_KEY."
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
  return res.status(500).json({
    error: "All AI engines failed: " + err.message
  });
}
