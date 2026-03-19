// ============================================================
// Studio Bridge — server.js
// Node.js backend that bridges your website ↔ Roblox Studio plugin
//
// HOW IT WORKS:
//   1. Website POSTs a command to /api/command
//   2. Plugin GETs /api/poll/:token every 2s, receives the command
//   3. Plugin executes it in Studio, then POSTs result to /api/result
//   4. Website GETs /api/result/:token to display the result
//   5. Website POSTs to /api/ai to generate Lua via Groq (FREE)
//
// DEPLOY: Railway, Render, Fly.io, or any Node.js host.
//   npm init -y && npm install express cors
//   node server.js
//
// ENVIRONMENT VARIABLES:
//   GROQ_API_KEY = gsk_your_key_here  (get free at groq.com)
// ============================================================

const express = require(“express”);
const cors = require(“cors”);

const app = express();
const PORT = process.env.PORT || 3000;

// ── CORS — allow everything ──
app.use(cors({
origin: “*”,
methods: [“GET”, “POST”, “PUT”, “DELETE”, “OPTIONS”],
allowedHeaders: [“Content-Type”, “Authorization”, “Accept”],
credentials: false
}));

// Handle preflight OPTIONS requests for all routes
app.options(”*”, cors());

app.use(express.json({ limit: “10mb” }));
app.use(express.urlencoded({ extended: true }));

// ── In-memory store ──
const pendingCommands = {};
const results = {};
const sessions = {};

// ── Health check ──
app.get(”/”, (req, res) => {
res.json({ ok: true, service: “studio-bridge”, version: “2.0.0” });
});

// ============================================================
// ✦ GROQ AI — Generate Roblox Lua from plain English (FREE)
// POST /api/ai
// Body: { prompt: string, system: string }
// Requires GROQ_API_KEY environment variable
// ============================================================
app.post(”/api/ai”, async (req, res) => {
const { prompt, system } = req.body;

if (!prompt) {
return res.status(400).json({ error: “Missing prompt” });
}

const apiKey = process.env.GROQ_API_KEY;
if (!apiKey) {
return res.status(500).json({ error: “GROQ_API_KEY not set on server. Add it to Railway environment variables.” });
}

try {
const response = await fetch(“https://api.groq.com/openai/v1/chat/completions”, {
method: “POST”,
headers: {
“Content-Type”: “application/json”,
“Authorization”: “Bearer “ + apiKey
},
body: JSON.stringify({
model: “llama-3.3-70b-versatile”,
max_tokens: 4000,
temperature: 0.3,
messages: [
{
role: “system”,
content: system || “You are an expert Roblox Lua developer. Generate complete working Lua code.”
},
{
role: “user”,
content: prompt
}
]
})
});

```
const data = await response.json();

if (!response.ok) {
  console.error("[ai] Groq error:", data);
  return res.status(500).json({ error: data.error?.message || "Groq API error" });
}

const text = data.choices?.[0]?.message?.content || "";
console.log(`[ai] Generated ${text.length} chars for prompt: "${prompt.slice(0, 60)}"`);

// Return in same format as Anthropic so dashboard works unchanged
res.json({ content: [{ text }] });
```

} catch (err) {
console.error(”[ai] Fetch error:”, err.message);
res.status(500).json({ error: “Failed to reach Groq: “ + err.message });
}
});

// ── Roblox: lookup user by username ──
// GET /api/roblox/user/:username
app.get(”/api/roblox/user/:username”, async (req, res) => {
const username = req.params.username;
try {
// Try exact lookup first
const r = await fetch(“https://users.roblox.com/v1/usernames/users”, {
method: “POST”,
headers: { “Content-Type”: “application/json” },
body: JSON.stringify({ usernames: [username], excludeBannedUsers: false })
});
const d = await r.json();
console.log(”[roblox/user] Response:”, JSON.stringify(d));
const user = d.data?.[0];
if (!user) {
// Try alternate lookup via search
const r2 = await fetch(`https://users.roblox.com/v1/users/search?keyword=${encodeURIComponent(username)}&limit=10`);
const d2 = await r2.json();
console.log(”[roblox/user] Search response:”, JSON.stringify(d2));
const match = d2.data?.find(u => u.name.toLowerCase() === username.toLowerCase());
if (!match) return res.json({ found: false, debug: d });
return res.json({ found: true, userId: match.id, username: match.name, displayName: match.displayName });
}
res.json({ found: true, userId: user.id, username: user.name, displayName: user.displayName });
} catch(e) {
console.error(”[roblox/user] Error:”, e.message);
res.status(500).json({ found: false, error: e.message });
}
});

// ── Roblox: get profile description ──
// GET /api/roblox/profile/:userId
app.get(”/api/roblox/profile/:userId”, async (req, res) => {
const { userId } = req.params;
try {
const r = await fetch(`https://users.roblox.com/v1/users/${userId}`);
const d = await r.json();
res.json({ description: d.description || “”, displayName: d.displayName || “”, username: d.name || “” });
} catch(e) {
res.status(500).json({ description: “”, error: e.message });
}
});

// ── Roblox: get avatar headshot ──
// GET /api/roblox/avatar/:userId
app.get(”/api/roblox/avatar/:userId”, async (req, res) => {
const { userId } = req.params;
try {
const r = await fetch(`https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=${userId}&size=150x150&format=Png&isCircular=true`);
const d = await r.json();
const url = d.data?.[0]?.imageUrl || null;
res.json({ avatarUrl: url });
} catch(e) {
res.status(500).json({ avatarUrl: null, error: e.message });
}
});

// ── Verify Roblox username ──
app.post(”/api/verify”, async (req, res) => {
const { username, code } = req.body;

if (!username || !code) {
return res.status(400).json({ verified: false, error: “Missing username or code” });
}

try {
const searchRes = await fetch(
`https://users.roblox.com/v1/usernames/users`,
{
method: “POST”,
headers: { “Content-Type”: “application/json” },
body: JSON.stringify({ usernames: [username], excludeBannedUsers: true }),
}
);
const searchData = await searchRes.json();
const userData = searchData.data?.[0];

```
if (!userData) {
  return res.json({ verified: false, error: "Roblox user not found" });
}

const profileRes = await fetch(`https://users.roblox.com/v1/users/${userData.id}`);
const profile = await profileRes.json();
const description = profile.description || "";

if (description.includes(code)) {
  return res.json({
    verified: true,
    userId: userData.id,
    displayName: profile.displayName || username,
  });
} else {
  return res.json({
    verified: false,
    error: "Verification code not found in profile description",
  });
}
```

} catch (err) {
console.error(”[verify] Error:”, err.message);
return res.status(500).json({ verified: false, error: “Server error during verification” });
}
});

// ── Website: send command to Studio ──
app.post(”/api/command”, (req, res) => {
const { token, type, body } = req.body;

if (!token || !body) {
return res.status(400).json({ ok: false, error: “Missing token or body” });
}

pendingCommands[token] = {
id: Date.now().toString(36),
type: type || “eval”,
body,
sentAt: Date.now(),
};

delete results[token];

console.log(`[command] token=${token} type=${type}`);
res.json({ ok: true, commandId: pendingCommands[token].id });
});

// ── Plugin: poll for pending commands ──
app.get(”/api/poll/:token”, (req, res) => {
const { token } = req.params;

sessions[token] = {
…(sessions[token] || {}),
lastPing: Date.now(),
connectedAt: sessions[token]?.connectedAt || Date.now(),
};

const cmd = pendingCommands[token];
if (!cmd) {
return res.json({ hasCommand: false });
}

delete pendingCommands[token];
console.log(`[poll] Delivering command to plugin: token=${token} type=${cmd.type}`);
res.json({ hasCommand: true, command: cmd });
});

// ── Plugin: post execution result back ──
app.post(”/api/result”, (req, res) => {
const { token, commandId, output, success } = req.body;

if (!token) {
return res.status(400).json({ ok: false, error: “Missing token” });
}

results[token] = {
commandId,
output: output || “(no output)”,
success: success !== false,
receivedAt: Date.now(),
};

console.log(`[result] token=${token} success=${success} output=${String(output).slice(0, 80)}`);
res.json({ ok: true });
});

// ── Website: check for result ──
app.get(”/api/result/:token”, (req, res) => {
const { token } = req.params;
const r = results[token];

if (!r) {
return res.json({ ready: false });
}

delete results[token];
res.json({ ready: true, …r });
});

// ── Check if plugin is connected ──
app.get(”/api/ping/:token”, (req, res) => {
const { token } = req.params;
const session = sessions[token];

if (!session) return res.json({ connected: false });

const age = Date.now() - session.lastPing;
const connected = age < 6000;

res.json({ connected, lastPing: session.lastPing });
});

// ── Cleanup stale sessions every minute ──
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
console.log(`Studio Bridge server running on port ${PORT}`);
console.log(`Endpoints:`);
console.log(`  POST /api/ai           — Groq AI Lua generation (FREE)`);
console.log(`  POST /api/command      — website sends command`);
console.log(`  GET  /api/poll/:token  — plugin polls for command`);
console.log(`  POST /api/result       — plugin posts result`);
console.log(`  GET  /api/result/:token — website gets result`);
console.log(`  POST /api/verify       — verify Roblox username`);
console.log(`  GET  /api/ping/:token  — check plugin connection`);
console.log(`Groq AI: ${process.env.GROQ_API_KEY ? "✓ API key found" : "✗ GROQ_API_KEY not set!"}`);
});
