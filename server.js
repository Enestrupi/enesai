// In-memory storage (temporary, replace with DB later)
const sessions = {};

// Create session (optional helper)
app.post("/api/session", (req, res) => {
  const { token } = req.body;
  if (!token) return res.status(400).json({ error: "Missing token" });

  sessions[token] = {
    commands: [],
    lastResult: null
  };

  res.json({ success: true });
});

// Add command (from your dashboard)
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

  res.json({ success: true, command: cmd });
});

// 🔥 THIS FIXES YOUR 404
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

  res.json({
    hasCommand: true,
    command
  });
});

// 🔥 THIS FIXES RESULT POST
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
