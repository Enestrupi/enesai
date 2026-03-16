const express = require('express');
const cors = require('cors');
const Groq = require('groq-sdk');

const app = express();
app.use(cors());
app.use(express.json());

const groq = new Groq({ apiKey: process.env.GROQ_API_KEY });

app.get('/api/healthz', (req, res) => {
  res.json({ status: 'ok' });
});

app.post('/api/generate', async (req, res) => {
  const { prompt, mode } = req.body;
  
  const modeMap = {
    LocalScript: "Generate a Roblox LOCALSCRIPT. Use game.Players.LocalPlayer and WaitForChild for PlayerGui.",
    GUI: "Generate a Roblox LOCALSCRIPT with beautiful UI using Instance.new(). Dark theme, UICorner, UIGradient, TweenService.",
    Combat: "Generate a Roblox LOCALSCRIPT for combat system with hit detection and effects.",
    Script: "Generate a Roblox server SCRIPT. Server side only.",
    NPC: "Generate a Roblox server SCRIPT for NPC with PathfindingService.",
    DataStore: "Generate a Roblox server SCRIPT using DataStoreService with pcall.",
    Module: "Generate a Roblox MODULESCRIPT returning a table."
  };

  const system = `You are Enes's AI, expert Roblox Lua scripter. ${modeMap[mode] || modeMap.LocalScript} Output ONLY raw Lua code. No markdown. No backticks. No explanation.`;

  try {
    const completion = await groq.chat.completions.create({
      model: 'llama-3.3-70b-versatile',
      messages: [
        { role: 'system', content: system },
        { role: 'user', content: prompt }
      ]
    });

    const code = completion.choices[0].message.content;
    res.json({ code });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Enes's AI Server running on port ${PORT}`);
});
