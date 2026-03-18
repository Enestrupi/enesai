// ============================================================
// Studio Bridge — server.js
// Node.js backend that bridges your website ↔ Roblox Studio plugin
//
// HOW IT WORKS:
//   1. Website POSTs a command to /api/command
//   2. Plugin GETs /api/poll/:token every 2s, receives the command
//   3. Plugin executes it in Studio, then POSTs result to /api/result
//   4. Website GETs /api/result/:token to display the result
//
// DEPLOY: Railway, Render, Fly.io, or any Node.js host.
//   npm init -y && npm install express cors
//   node server.js
// ============================================================

const express = require("express");
const cors = require("cors");

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// ── In-memory store (replace with Redis or a DB for production) ──
const pendingCommands = {}; // token -> { type, body, sentAt }
const results = {};         // token -> { output, receivedAt }
const sessions = {};        // token -> { username, connectedAt, lastPing }

// ── Health check ──
app.get("/", (req, res) => {
  res.json({ ok: true, service: "studio-bridge", version: "1.0.0" });
});

// ── Verify Roblox username ──
// The plugin polls the Roblox API to check if the user's profile description
// contains the verification code. In this demo we simulate it.
// Real implementation: fetch https://users.roblox.com/v1/users/search?keyword=USERNAME
// then GET https://users.roblox.com/v1/users/:id to read description.
app.post("/api/verify", async (req, res) => {
  const { username, code } = req.body;

  if (!username || !code) {
    return res.status(400).json({ verified: false, error: "Missing username or code" });
  }

  try {
    // Step 1: Resolve username -> userId
    const searchRes = await fetch(
      `https://users.roblox.com/v1/usernames/users`,
      {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ usernames: [username], excludeBannedUsers: true }),
      }
    );
    const searchData = await searchRes.json();
    const userData = searchData.data?.[0];

    if (!userData) {
      return res.json({ verified: false, error: "Roblox user not found" });
    }

    // Step 2: Get user profile description
    const profileRes = await fetch(
      `https://users.roblox.com/v1/users/${userData.id}`
    );
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
  } catch (err) {
    console.error("[verify] Error:", err.message);
    return res.status(500).json({ verified: false, error: "Server error during verification" });
  }
});

// ── Website: send command to Studio ──
// POST /api/command
// Body: { token: string, type: string, body: string }
app.post("/api/command", (req, res) => {
  const { token, type, body } = req.body;

  if (!token || !body) {
    return res.status(400).json({ ok: false, error: "Missing token or body" });
  }

  // Store command for plugin to pick up
  pendingCommands[token] = {
    id: Date.now().toString(36),
    type: type || "eval",
    body,
    sentAt: Date.now(),
  };

  // Clear old result for this token
  delete results[token];

  console.log(`[command] token=${token} type=${type}`);
  res.json({ ok: true, commandId: pendingCommands[token].id });
});

// ── Plugin: poll for pending commands ──
// GET /api/poll/:token
// Plugin calls this every 2 seconds from Studio
app.get("/api/poll/:token", (req, res) => {
  const { token } = req.params;

  // Register/update session ping
  sessions[token] = {
    ...(sessions[token] || {}),
    lastPing: Date.now(),
    connectedAt: sessions[token]?.connectedAt || Date.now(),
  };

  const cmd = pendingCommands[token];
  if (!cmd) {
    return res.json({ hasCommand: false });
  }

  // Return and clear — plugin will execute it
  delete pendingCommands[token];
  console.log(`[poll] Delivering command to plugin: token=${token} type=${cmd.type}`);
  res.json({ hasCommand: true, command: cmd });
});

// ── Plugin: post execution result back ──
// POST /api/result
// Body: { token: string, commandId: string, output: string, success: boolean }
app.post("/api/result", (req, res) => {
  const { token, commandId, output, success } = req.body;

  if (!token) {
    return res.status(400).json({ ok: false, error: "Missing token" });
  }

  results[token] = {
    commandId,
    output: output || "(no output)",
    success: success !== false,
    receivedAt: Date.now(),
  };

  console.log(`[result] token=${token} success=${success} output=${String(output).slice(0, 80)}`);
  res.json({ ok: true });
});

// ── Website: check for result ──
// GET /api/result/:token
app.get("/api/result/:token", (req, res) => {
  const { token } = req.params;
  const r = results[token];

  if (!r) {
    return res.json({ ready: false });
  }

  // Deliver result once
  delete results[token];
  res.json({ ready: true, ...r });
});

// ── Check if plugin is connected (website polls this) ──
// GET /api/ping/:token
app.get("/api/ping/:token", (req, res) => {
  const { token } = req.params;
  const session = sessions[token];

  if (!session) return res.json({ connected: false });

  const age = Date.now() - session.lastPing;
  const connected = age < 6000; // consider connected if pinged in last 6s

  res.json({ connected, lastPing: session.lastPing });
});

// ── Cleanup stale sessions every minute ──
setInterval(() => {
  const now = Date.now();
  for (const token in sessions) {
    if (now - sessions[token].lastPing > 30000) {
      delete sessions[token];
    }
  }
  // Clean stale commands older than 30s
  for (const token in pendingCommands) {
    if (now - pendingCommands[token].sentAt > 30000) {
      delete pendingCommands[token];
    }
  }
}, 60000);

app.listen(PORT, () => {
  console.log(`Studio Bridge server running on port ${PORT}`);
  console.log(`Endpoints:`);
  console.log(`  POST /api/command      — website sends command`);
  console.log(`  GET  /api/poll/:token  — plugin polls for command`);
  console.log(`  POST /api/result       — plugin posts result`);
  console.log(`  GET  /api/result/:token — website gets result`);
  console.log(`  POST /api/verify       — verify Roblox username`);
  console.log(`  GET  /api/ping/:token  — check plugin connection`);
});
