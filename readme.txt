--[[
╔══════════════════════════════════════════════════════════════╗
║          STUDIO BRIDGE v3 — ROBLOX STUDIO PLUGIN            ║
║                                                              ║
║  Connects Roblox Studio to the Studio Bridge web app.        ║
║  Polls the backend for commands, executes them in Studio,    ║
║  and reports results back.                                   ║
║                                                              ║
║  INSTALL INSTRUCTIONS:                                       ║
║  1. Open Roblox Studio                                       ║
║  2. Go to: Plugins tab → Plugins Folder                      ║
║     (or: View → Plugins Folder)                              ║
║  3. Copy this file into that folder                          ║
║  4. Restart Roblox Studio                                    ║
║  5. A "Studio Bridge" toolbar button will appear             ║
║  6. Click it → enter your token from the web app            ║
║  7. The web app will show "Studio connected" ✓               ║
╚══════════════════════════════════════════════════════════════╝
--]]

-- ── SERVICES ──────────────────────────────────────────────────
local HttpService       = game:GetService("HttpService")
local StudioService     = game:GetService("StudioService")
local Selection         = game:GetService("Selection")
local RunService        = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer     = game:GetService("StarterPlayer")
local StarterGui        = game:GetService("StarterGui")
local Workspace         = game:GetService("Workspace")

-- ── CONFIG ────────────────────────────────────────────────────
local CONFIG = {
	BACKEND      = "https://enesai-production.up.railway.app",
	POLL_INTERVAL = 2,      -- seconds between backend polls
	PLUGIN_NAME  = "StudioBridge",
	VERSION      = "3.0.0",
	TOOLBAR_NAME = "Studio Bridge v3",
}

-- ── PLUGIN SETUP ──────────────────────────────────────────────
local toolbar    = plugin:CreateToolbar(CONFIG.TOOLBAR_NAME)
local toggleBtn  = toolbar:CreateButton(
	"Bridge",
	"Toggle Studio Bridge connection panel",
	"rbxassetid://7072706796"  -- plug/connect icon
)

-- ── STATE ─────────────────────────────────────────────────────
local sessionToken    = nil
local isConnected     = false
local pollConnection  = nil
local widgetOpen      = false

-- ── WIDGET (Connection Panel) ──────────────────────────────────
local widgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Float,
	false,  -- initially hidden
	false,
	320,    -- width
	280,    -- height
	280,    -- min width
	200     -- min height
)
local widget = plugin:CreateDockWidgetPluginGui("StudioBridgePanel", widgetInfo)
widget.Title = "Studio Bridge v3"
widget.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ── BUILD UI ──────────────────────────────────────────────────
local function buildUI()
	-- Root frame
	local root = Instance.new("Frame")
	root.Size = UDim2.new(1,0,1,0)
	root.BackgroundColor3 = Color3.fromRGB(5, 7, 9)
	root.BorderSizePixel = 0
	root.Parent = widget

	-- Gradient background
	local grad = Instance.new("UIGradient")
	grad.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 13, 20)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(5,  7,  9)),
	}
	grad.Rotation = 135
	grad.Parent = root

	local padding = Instance.new("UIPadding")
	padding.PaddingLeft   = UDim.new(0, 16)
	padding.PaddingRight  = UDim.new(0, 16)
	padding.PaddingTop    = UDim.new(0, 16)
	padding.PaddingBottom = UDim.new(0, 16)
	padding.Parent = root

	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 10)
	layout.Parent = root

	-- Header
	local header = Instance.new("Frame")
	header.Size = UDim2.new(1, 0, 0, 40)
	header.BackgroundTransparency = 1
	header.LayoutOrder = 1
	header.Parent = root

	local headerLayout = Instance.new("UIListLayout")
	headerLayout.FillDirection = Enum.FillDirection.Horizontal
	headerLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	headerLayout.Padding = UDim.new(0, 8)
	headerLayout.Parent = header

	local logo = Instance.new("TextLabel")
	logo.Size = UDim2.new(0, 30, 0, 30)
	logo.BackgroundColor3 = Color3.fromRGB(0, 229, 255)
	logo.TextColor3 = Color3.fromRGB(5, 7, 9)
	logo.Text = "✦"
	logo.Font = Enum.Font.GothamBold
	logo.TextSize = 14
	logo.LayoutOrder = 1
	logo.Parent = header

	local logoCorner = Instance.new("UICorner")
	logoCorner.CornerRadius = UDim.new(0, 6)
	logoCorner.Parent = logo

	local titleBlock = Instance.new("Frame")
	titleBlock.Size = UDim2.new(1, -38, 1, 0)
	titleBlock.BackgroundTransparency = 1
	titleBlock.LayoutOrder = 2
	titleBlock.Parent = header

	local titleLayout2 = Instance.new("UIListLayout")
	titleLayout2.SortOrder = Enum.SortOrder.LayoutOrder
	titleLayout2.Padding = UDim.new(0, 1)
	titleLayout2.Parent = titleBlock

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 18)
	title.BackgroundTransparency = 1
	title.Text = "Studio Bridge v3"
	title.TextColor3 = Color3.fromRGB(221, 225, 240)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 13
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.LayoutOrder = 1
	title.Parent = titleBlock

	local subtitle = Instance.new("TextLabel")
	subtitle.Size = UDim2.new(1, 0, 0, 12)
	subtitle.BackgroundTransparency = 1
	subtitle.Text = "GENIUS EDITION · v" .. CONFIG.VERSION
	subtitle.TextColor3 = Color3.fromRGB(107, 115, 148)
	subtitle.Font = Enum.Font.Gotham
	subtitle.TextSize = 9
	subtitle.TextXAlignment = Enum.TextXAlignment.Left
	subtitle.LayoutOrder = 2
	subtitle.Parent = titleBlock

	-- Status pill
	local statusFrame = Instance.new("Frame")
	statusFrame.Size = UDim2.new(1, 0, 0, 32)
	statusFrame.BackgroundColor3 = Color3.fromRGB(15, 19, 32)
	statusFrame.LayoutOrder = 2
	statusFrame.Parent = root

	local statusCorner = Instance.new("UICorner")
	statusCorner.CornerRadius = UDim.new(0, 6)
	statusCorner.Parent = statusFrame

	local statusBorder = Instance.new("UIStroke")
	statusBorder.Color = Color3.fromRGB(46, 52, 74)
	statusBorder.Thickness = 0.5
	statusBorder.Parent = statusFrame

	local statusLayout = Instance.new("UIListLayout")
	statusLayout.FillDirection = Enum.FillDirection.Horizontal
	statusLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	statusLayout.Padding = UDim.new(0, 8)
	statusLayout.Parent = statusFrame

	local statusPadding = Instance.new("UIPadding")
	statusPadding.PaddingLeft = UDim.new(0, 10)
	statusPadding.Parent = statusFrame

	local dot = Instance.new("Frame")
	dot.Name = "StatusDot"
	dot.Size = UDim2.new(0, 7, 0, 7)
	dot.BackgroundColor3 = Color3.fromRGB(46, 52, 74)
	dot.LayoutOrder = 1
	dot.Parent = statusFrame

	local dotCorner = Instance.new("UICorner")
	dotCorner.CornerRadius = UDim.new(1, 0)
	dotCorner.Parent = dot

	local statusLabel = Instance.new("TextLabel")
	statusLabel.Name = "StatusLabel"
	statusLabel.Size = UDim2.new(1, -30, 1, 0)
	statusLabel.BackgroundTransparency = 1
	statusLabel.Text = "Not connected"
	statusLabel.TextColor3 = Color3.fromRGB(107, 115, 148)
	statusLabel.Font = Enum.Font.Gotham
	statusLabel.TextSize = 10
	statusLabel.TextXAlignment = Enum.TextXAlignment.Left
	statusLabel.LayoutOrder = 2
	statusLabel.Parent = statusFrame

	-- Token label
	local tokenLabel = Instance.new("TextLabel")
	tokenLabel.Size = UDim2.new(1, 0, 0, 12)
	tokenLabel.BackgroundTransparency = 1
	tokenLabel.Text = "PASTE YOUR TOKEN FROM THE WEB APP"
	tokenLabel.TextColor3 = Color3.fromRGB(107, 115, 148)
	tokenLabel.Font = Enum.Font.Gotham
	tokenLabel.TextSize = 9
	tokenLabel.TextXAlignment = Enum.TextXAlignment.Left
	tokenLabel.LayoutOrder = 3
	tokenLabel.Parent = root

	-- Token input
	local tokenBox = Instance.new("TextBox")
	tokenBox.Name = "TokenBox"
	tokenBox.Size = UDim2.new(1, 0, 0, 36)
	tokenBox.BackgroundColor3 = Color3.fromRGB(15, 19, 32)
	tokenBox.TextColor3 = Color3.fromRGB(0, 229, 255)
	tokenBox.PlaceholderText = "e.g. ABC123XYZ789"
	tokenBox.PlaceholderColor3 = Color3.fromRGB(46, 52, 74)
	tokenBox.Text = ""
	tokenBox.Font = Enum.Font.Code
	tokenBox.TextSize = 12
	tokenBox.ClearTextOnFocus = false
	tokenBox.LayoutOrder = 4
	tokenBox.Parent = root

	local tbCorner = Instance.new("UICorner")
	tbCorner.CornerRadius = UDim.new(0, 6)
	tbCorner.Parent = tokenBox

	local tbBorder = Instance.new("UIStroke")
	tbBorder.Name = "TokenBorder"
	tbBorder.Color = Color3.fromRGB(46, 52, 74)
	tbBorder.Thickness = 0.5
	tbBorder.Parent = tokenBox

	local tbPad = Instance.new("UIPadding")
	tbPad.PaddingLeft = UDim.new(0, 10)
	tbPad.Parent = tokenBox

	-- Connect button
	local connectBtn = Instance.new("TextButton")
	connectBtn.Name = "ConnectBtn"
	connectBtn.Size = UDim2.new(1, 0, 0, 36)
	connectBtn.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
	connectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	connectBtn.Text = "▶  Connect to Web App"
	connectBtn.Font = Enum.Font.GothamBold
	connectBtn.TextSize = 11
	connectBtn.LayoutOrder = 5
	connectBtn.AutoButtonColor = false
	connectBtn.Parent = root

	local cbCorner = Instance.new("UICorner")
	cbCorner.CornerRadius = UDim.new(0, 6)
	cbCorner.Parent = connectBtn

	-- Disconnect button (hidden initially)
	local disconnectBtn = Instance.new("TextButton")
	disconnectBtn.Name = "DisconnectBtn"
	disconnectBtn.Size = UDim2.new(1, 0, 0, 28)
	disconnectBtn.BackgroundColor3 = Color3.fromRGB(15, 19, 32)
	disconnectBtn.TextColor3 = Color3.fromRGB(239, 68, 68)
	disconnectBtn.Text = "⏻  Disconnect"
	disconnectBtn.Font = Enum.Font.Gotham
	disconnectBtn.TextSize = 10
	disconnectBtn.LayoutOrder = 6
	disconnectBtn.Visible = false
	disconnectBtn.Parent = root

	local dbCorner = Instance.new("UICorner")
	dbCorner.CornerRadius = UDim.new(0, 6)
	dbCorner.Parent = disconnectBtn

	local dbBorder = Instance.new("UIStroke")
	dbBorder.Color = Color3.fromRGB(239, 68, 68)
	dbBorder.Thickness = 0.5
	dbBorder.Parent = disconnectBtn

	-- Log area label
	local logLabel = Instance.new("TextLabel")
	logLabel.Size = UDim2.new(1, 0, 0, 12)
	logLabel.BackgroundTransparency = 1
	logLabel.Text = "ACTIVITY LOG"
	logLabel.TextColor3 = Color3.fromRGB(107, 115, 148)
	logLabel.Font = Enum.Font.Gotham
	logLabel.TextSize = 9
	logLabel.TextXAlignment = Enum.TextXAlignment.Left
	logLabel.LayoutOrder = 7
	logLabel.Parent = root

	-- Log box
	local logFrame = Instance.new("Frame")
	logFrame.Size = UDim2.new(1, 0, 0, 60)
	logFrame.BackgroundColor3 = Color3.fromRGB(10, 13, 20)
	logFrame.LayoutOrder = 8
	logFrame.ClipsDescendants = true
	logFrame.Parent = root

	local lfCorner = Instance.new("UICorner")
	lfCorner.CornerRadius = UDim.new(0, 6)
	lfCorner.Parent = logFrame

	local lfBorder = Instance.new("UIStroke")
	lfBorder.Color = Color3.fromRGB(46, 52, 74)
	lfBorder.Thickness = 0.5
	lfBorder.Parent = logFrame

	local logText = Instance.new("TextLabel")
	logText.Name = "LogText"
	logText.Size = UDim2.new(1, 0, 1, 0)
	logText.BackgroundTransparency = 1
	logText.Text = "Waiting for connection…"
	logText.TextColor3 = Color3.fromRGB(107, 115, 148)
	logText.Font = Enum.Font.Code
	logText.TextSize = 9
	logText.TextXAlignment = Enum.TextXAlignment.Left
	logText.TextYAlignment = Enum.TextYAlignment.Top
	logText.TextWrapped = true
	logText.LayoutOrder = 1
	logText.Parent = logFrame

	local logPad = Instance.new("UIPadding")
	logPad.PaddingLeft   = UDim.new(0, 8)
	logPad.PaddingRight  = UDim.new(0, 8)
	logPad.PaddingTop    = UDim.new(0, 6)
	logPad.PaddingBottom = UDim.new(0, 6)
	logPad.Parent = logFrame

	return {
		dot          = dot,
		statusLabel  = statusLabel,
		tokenBox     = tokenBox,
		tokenBorder  = tbBorder,
		connectBtn   = connectBtn,
		disconnectBtn= disconnectBtn,
		logText      = logText,
	}
end

local ui = buildUI()

-- ── LOGGING ───────────────────────────────────────────────────
local logLines = {}
local function log(msg, color)
	local ts = os.date("%H:%M:%S")
	local line = "[" .. ts .. "] " .. msg
	table.insert(logLines, line)
	if #logLines > 8 then table.remove(logLines, 1) end
	ui.logText.Text = table.concat(logLines, "\n")
	if color then
		ui.logText.TextColor3 = color
	else
		ui.logText.TextColor3 = Color3.fromRGB(107, 115, 148)
	end
	print("[StudioBridge] " .. msg)
end

-- ── STATUS UPDATE ─────────────────────────────────────────────
local function setStatus(connected)
	isConnected = connected
	if connected then
		ui.dot.BackgroundColor3        = Color3.fromRGB(16, 185, 129)
		ui.statusLabel.Text            = "Connected · listening for scripts…"
		ui.statusLabel.TextColor3      = Color3.fromRGB(16, 185, 129)
		ui.connectBtn.Visible          = false
		ui.disconnectBtn.Visible       = true
		ui.tokenBox.TextEditable       = false
		ui.tokenBorder.Color           = Color3.fromRGB(16, 185, 129)
	else
		ui.dot.BackgroundColor3        = Color3.fromRGB(46, 52, 74)
		ui.statusLabel.Text            = "Not connected"
		ui.statusLabel.TextColor3      = Color3.fromRGB(107, 115, 148)
		ui.connectBtn.Visible          = true
		ui.disconnectBtn.Visible       = false
		ui.tokenBox.TextEditable       = true
		ui.tokenBorder.Color           = Color3.fromRGB(46, 52, 74)
	end
end

-- ── SCRIPT EXECUTION ──────────────────────────────────────────
--[[
  The web app sends a small Lua snippet via /api/command that:
    1. Creates a Script/LocalScript/ModuleScript instance
    2. Sets its .Source
    3. Parents it to the correct service
  We loadstring() that wrapper code in the Studio plugin context.
--]]
local function resolveParent(parentStr)
	-- Map common path strings → actual instances
	local map = {
		['game:GetService("ServerScriptService")']         = ServerScriptService,
		['game:GetService("ReplicatedStorage")']           = ReplicatedStorage,
		['game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts")'] =
			StarterPlayer:FindFirstChild("StarterPlayerScripts") or StarterPlayer,
		['game:GetService("StarterGui")']                  = StarterGui,
		['game:GetService("Workspace")']                   = Workspace,
	}
	return map[parentStr] or ServerScriptService
end

local function executeCommand(body)
	-- body is the Lua wrapper string from wrapInsert() in the web app
	-- We run it via loadstring in the plugin's Lua environment
	local ok, err = pcall(function()
		local fn, loadErr = loadstring(body)
		if not fn then
			error("Parse error: " .. tostring(loadErr))
		end
		fn()
	end)
	return ok, err
end

-- ── HTTP HELPERS ──────────────────────────────────────────────
local function httpGet(path)
	local ok, res = pcall(function()
		return HttpService:GetAsync(CONFIG.BACKEND .. path, true)
	end)
	if not ok then return nil, res end
	local dec, data = pcall(function()
		return HttpService:JSONDecode(res)
	end)
	if not dec then return nil, "JSON decode failed" end
	return data, nil
end

local function httpPost(path, payload)
	local body = HttpService:JSONEncode(payload)
	local ok, res = pcall(function()
		return HttpService:PostAsync(
			CONFIG.BACKEND .. path,
			body,
			Enum.HttpContentType.ApplicationJson,
			false
		)
	end)
	if not ok then return nil, res end
	local dec, data = pcall(function()
		return HttpService:JSONDecode(res)
	end)
	if not dec then return nil, "JSON decode failed" end
	return data, nil
end

-- ── SEND RESULT BACK ──────────────────────────────────────────
local function sendResult(success, message)
	httpPost("/api/result/" .. sessionToken, {
		ready   = true,
		success = success,
		message = message or "",
	})
end

-- ── PING LOOP ─────────────────────────────────────────────────
local lastCommandId = nil

local function pollLoop()
	-- 1. Ping to keep alive + announce connected
	local pingData, pingErr = httpGet("/api/ping/" .. sessionToken .. "?plugin=true")
	if pingErr then
		log("Ping failed: " .. tostring(pingErr), Color3.fromRGB(239, 68, 68))
		return
	end

	-- 2. Poll for pending command
	local cmdData, cmdErr = httpGet("/api/command/" .. sessionToken)
	if cmdErr then
		log("Poll error: " .. tostring(cmdErr), Color3.fromRGB(239, 68, 68))
		return
	end

	if not cmdData or not cmdData.pending then return end
	if cmdData.id == lastCommandId then return end  -- already handled

	lastCommandId = cmdData.id
	log("📥 Received: " .. (cmdData.type or "unknown"), Color3.fromRGB(0, 229, 255))

	if cmdData.type == "run_script" and cmdData.body then
		local ok, err = executeCommand(cmdData.body)
		if ok then
			log("✓ Script inserted successfully!", Color3.fromRGB(16, 185, 129))
			sendResult(true, "Script inserted.")
		else
			log("✗ Error: " .. tostring(err), Color3.fromRGB(239, 68, 68))
			sendResult(false, tostring(err))
		end
	elseif cmdData.type == "ping" then
		sendResult(true, "pong")
	else
		log("Unknown command type: " .. tostring(cmdData.type))
		sendResult(false, "Unknown command type.")
	end
end

-- ── START / STOP POLLING ──────────────────────────────────────
local function startPolling()
	if pollConnection then pollConnection:Disconnect() end
	local elapsed = 0
	pollConnection = RunService.Heartbeat:Connect(function(dt)
		elapsed = elapsed + dt
		if elapsed >= CONFIG.POLL_INTERVAL then
			elapsed = 0
			pollLoop()
		end
	end)
	log("Polling started — every " .. CONFIG.POLL_INTERVAL .. "s", Color3.fromRGB(0, 229, 255))
end

local function stopPolling()
	if pollConnection then
		pollConnection:Disconnect()
		pollConnection = nil
	end
	sessionToken = nil
	setStatus(false)
	log("Disconnected.", Color3.fromRGB(239, 68, 68))
end

-- ── CONNECT FLOW ──────────────────────────────────────────────
local function tryConnect()
	local token = ui.tokenBox.Text:match("^%s*(.-)%s*$")  -- trim whitespace
	if token == "" then
		log("⚠ Please enter your token from the web app.", Color3.fromRGB(245, 158, 11))
		ui.tokenBorder.Color = Color3.fromRGB(245, 158, 11)
		return
	end

	-- Check HttpService is enabled
	local httpOk = pcall(function()
		HttpService:GetAsync("https://example.com", true)
	end)
	-- We don't care about the result — just that it doesn't throw "Http requests are not enabled"
	-- Actually check the right way:
	if not HttpService.HttpEnabled then
		log("⚠ Enable HTTP Requests: Game Settings → Security → Allow HTTP Requests", Color3.fromRGB(245, 158, 11))
		return
	end

	log("Connecting with token: " .. token:sub(1,4) .. "****", Color3.fromRGB(0, 229, 255))
	sessionToken = token

	-- Test connection
	local data, err = httpGet("/api/ping/" .. token .. "?plugin=true")
	if err then
		log("✗ Cannot reach backend: " .. tostring(err), Color3.fromRGB(239, 68, 68))
		sessionToken = nil
		return
	end

	setStatus(true)
	log("✓ Connected! Web app should show 'Studio connected'", Color3.fromRGB(16, 185, 129))

	-- Save token for this session
	plugin:SetSetting("LastToken", token)

	startPolling()
end

-- ── BUTTON EVENTS ─────────────────────────────────────────────
ui.connectBtn.MouseButton1Click:Connect(function()
	ui.connectBtn.BackgroundColor3 = Color3.fromRGB(109, 40, 217)
	task.wait(0.1)
	ui.connectBtn.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
	tryConnect()
end)

ui.disconnectBtn.MouseButton1Click:Connect(function()
	stopPolling()
end)

-- Also connect on Enter key in token box
ui.tokenBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		tryConnect()
	end
end)

-- Hover effects for connect button
ui.connectBtn.MouseEnter:Connect(function()
	ui.connectBtn.BackgroundColor3 = Color3.fromRGB(109, 40, 217)
end)
ui.connectBtn.MouseLeave:Connect(function()
	ui.connectBtn.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
end)

-- ── TOOLBAR TOGGLE ────────────────────────────────────────────
toggleBtn.Click:Connect(function()
	widgetOpen = not widgetOpen
	widget.Enabled = widgetOpen
	toggleBtn:SetActive(widgetOpen)
end)

-- ── RESTORE LAST TOKEN ────────────────────────────────────────
local savedToken = plugin:GetSetting("LastToken")
if savedToken and savedToken ~= "" then
	ui.tokenBox.Text = savedToken
	log("Last token restored. Click Connect to reconnect.", Color3.fromRGB(107, 115, 148))
end

-- ── OPEN WIDGET ON LOAD ───────────────────────────────────────
widget.Enabled = true
widgetOpen = true
toggleBtn:SetActive(true)

-- ── PLUGIN UNLOAD ─────────────────────────────────────────────
plugin.Unloading:Connect(function()
	stopPolling()
end)

print("[StudioBridge] Plugin v" .. CONFIG.VERSION .. " loaded. Click the toolbar button to open.")
