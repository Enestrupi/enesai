const express = require(“express”);
const app = express();

app.use(express.json());

// ── CORS ──
app.use((req, res, next) => {
res.setHeader(“Access-Control-Allow-Origin”, “*”);
res.setHeader(“Access-Control-Allow-Methods”, “GET, POST, OPTIONS”);
res.setHeader(“Access-Control-Allow-Headers”, “Content-Type, Authorization”);
if (req.method === “OPTIONS”) return res.sendStatus(204);
next();
});

// ── In-memory sessions ──
const sessions = {};
function getSession(token) {
if (!sessions[token]) sessions[token] = { connected: false, command: null, result: null, lastSeen: Date.now() };
return sessions[token];
}

// ── System prompt ──
const ROBLOX_SYSTEM = `You are an expert Roblox Lua developer. Follow these rules strictly:

- Server Script: use DataStoreService, PlayerAdded, FireClient, OnServerEvent. NEVER use LocalPlayer/PlayerGui/UserInputService.
- LocalScript: use LocalPlayer, PlayerGui, UserInputService, FireServer, OnClientEvent. NEVER use DataStoreService/OnServerEvent.
- RemoteEvents must be created in the server Script only. LocalScript uses WaitForChild() to get them.
- Always use task.wait(), never wait().
- Output ONLY raw Lua. No markdown, no code fences, no explanations.
- Write complete, fully working code. No placeholders like “PlayerName” or “put code here”.
- GUIs must be fully functional with real TextBox inputs, not hardcoded strings.
  Multi-script separator format (only include sections needed):
  ===SCRIPT_SERVER===
  ===SCRIPT_LOCAL===
  ===SCRIPT_MODULE===`;

// ── Pinned / featured models (always shown first) ──
const PINNED_MODELS = [
{ id: “deepseek/deepseek-chat-v3-0324”, name: “DeepSeek V3.2”,          pinned: true },
{ id: “deepseek/deepseek-r1”,           name: “DeepSeek R1 (Immersive)”, pinned: true },
{ id: “google/gemma-3-27b-it”,          name: “Gemma 4 31B”,             pinned: true },
{ id: “google/gemini-flash-1.5-8b”,     name: “Gemini Flash Lite”,       pinned: true },
{ id: “anthropic/claude-sonnet-4-5”,    name: “Claude Sonnet 4.6”,       pinned: true },
];

// ── Dynamic model cache ──
let modelCache = [];
let modelCacheTime = 0;
const MODEL_CACHE_TTL = 10 * 60 * 1000; // 10 minutes

async function fetchOpenRouterModels() {
const now = Date.now();
if (modelCache.length && now - modelCacheTime < MODEL_CACHE_TTL) {
return modelCache;
}

try {
const key = process.env.OPENROUTER_API_KEY;
const headers = { “Content-Type”: “application/json” };
if (key) headers[“Authorization”] = “Bearer “ + key;

```
const res = await fetch("https://openrouter.ai/api/v1/models", { headers });
const data = await res.json();

if (!data.data) throw new Error("No model data returned");

const pinnedIds = new Set(PINNED_MODELS.map(m => m.id));

const allFromAPI = data.data.map(m => ({
  id: m.id,
  name: m.name || m.id,
  context_length: m.context_length,
  pricing: m.pricing,
  pinned: pinnedIds.has(m.id)
}));

// Pinned first (in defined order), then rest alphabetically
const pinnedOrdered = PINNED_MODELS.map(p => {
  const found = allFromAPI.find(m => m.id === p.id);
  return found ? { ...found, name: p.name, pinned: true } : { ...p, pinned: true };
});

const rest = allFromAPI
  .filter(m => !pinnedIds.has(m.id))
  .sort((a, b) => a.name.localeCompare(b.name));

modelCache = [...pinnedOrdered, ...rest];
modelCacheTime = now;
console.log(`Model cache refreshed: ${modelCache.length} models`);
return modelCache;
```

} catch (e) {
console.error(“Failed to fetch OpenRouter models:”, e.message);
if (!modelCache.length) modelCache = PINNED_MODELS;
return modelCache;
}
}

// Pre-fetch on startup
fetchOpenRouterModels();

// ═══════════════════════════════════════════
// GET /api/models — full live model list
// ═══════════════════════════════════════════
app.get(”/api/models”, async (req, res) => {
const models = await fetchOpenRouterModels();
res.json({ models, count: models.length });
});

// ═══════════════════════════════════════════
// GET /api/models/pinned — featured models only
// ═══════════════════════════════════════════
app.get(”/api/models/pinned”, (req, res) => {
res.json({ models: PINNED_MODELS });
});

// ═══════════════════════════════════════════
// AI — OpenRouter (any model)
// ═══════════════════════════════════════════
app.post(”/api/ai”, async (req, res) => {
const { prompt, system, model } = req.body;
if (!prompt) return res.status(400).json({ error: “prompt required” });

// Accept any valid OpenRouter model ID, default to auto
const resolvedModel = model || “openrouter/auto”;

const key = process.env.OPENROUTER_API_KEY;
if (!key) return res.status(500).json({ error: “OPENROUTER_API_KEY not set” });

const controller = new AbortController();
const timeout = setTimeout(() => controller.abort(), 60000);

try {
const response = await fetch(“https://openrouter.ai/api/v1/chat/completions”, {
method: “POST”,
signal: controller.signal,
headers: {
“Content-Type”: “application/json”,
“Authorization”: “Bearer “ + key
},
body: JSON.stringify({
model: resolvedModel,
max_tokens: 10000,
temperature: 0.2,
messages: [
{ role: “system”, content: system || ROBLOX_SYSTEM },
{ role: “user”,   content: prompt }
]
})
});

```
clearTimeout(timeout);
const data = await response.json();
console.log(`OpenRouter [${resolvedModel}]:`, JSON.stringify(data).slice(0, 200));

if (!response.ok) {
  console.error("OpenRouter error:", data);
  return res.status(500).json({ error: data.error?.message || "OpenRouter API error" });
}

const text = data.choices?.[0]?.message?.content || "";
res.json({ content: [{ text }], model: resolvedModel });
```

} catch (e) {
clearTimeout(timeout);
const msg = e.name === “AbortError” ? “Request timed out (60s)” : e.message;
console.error(“AI error:”, msg);
res.status(500).json({ error: msg });
}
});

// ═══════════════════════════════════════════
// PING
// ═══════════════════════════════════════════
app.get(”/api/ping/:token”, (req, res) => {
const s = getSession(req.params.token);
res.json({ connected: s.connected });
});

// ═══════════════════════════════════════════
// POLL
// ═══════════════════════════════════════════
app.get(”/api/poll/:token”, (req, res) => {
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
// HEARTBEAT
// ═══════════════════════════════════════════
app.post(”/api/heartbeat/:token”, (req, res) => {
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
// COMMAND
// ═══════════════════════════════════════════
app.post(”/api/command”, (req, res) => {
const { token, type, body } = req.body;
if (!token || !body) return res.status(400).json({ ok: false, error: “token and body required” });
const s = getSession(token);
s.command = { type: type || “run_script”, body };
s.result  = null;
res.json({ ok: true });
});

// ═══════════════════════════════════════════
// RESULT POST
// ═══════════════════════════════════════════
app.post(”/api/result/:token”, (req, res) => {
const s = getSession(req.params.token);
s.result = { ready: true, success: req.body.success !== false, output: req.body.output || “” };
res.json({ ok: true });
});

// ═══════════════════════════════════════════
// RESULT GET
// ═══════════════════════════════════════════
app.get(”/api/result/:token”, (req, res) => {
const s = getSession(req.params.token);
if (s.result?.ready) {
const r = s.result;
s.result = null;
return res.json(r);
}
res.json({ ready: false });
});

// ═══════════════════════════════════════════
// DISCONNECT
// ═══════════════════════════════════════════
app.post(”/api/disconnect/:token”, (req, res) => {
const s = getSession(req.params.token);
s.connected = false;
res.json({ ok: true });
});

// ── Health check ──
app.get(”/”, (req, res) => res.send(“Studio Bridge OK”));

// ── Clean up idle sessions ──
setInterval(() => {
const cutoff = Date.now() - 5 * 60 * 1000;
for (const token in sessions) {
if (sessions[token].lastSeen < cutoff) {
sessions[token].connected = false;
}
}
}, 30000);

// ── Refresh model cache periodically ──
setInterval(fetchOpenRouterModels, MODEL_CACHE_TTL);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
console.log(“Studio Bridge on port “ + PORT);
console.log(“OpenRouter key: “ + (process.env.OPENROUTER_API_KEY ? “SET” : “MISSING”));
});
