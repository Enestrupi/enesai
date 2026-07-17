--[[
    Local AI Assistant Plugin for Roblox Studio
    Talks to a local llama-server (Qwen2.5-Coder) over HTTP.

    INSTALL:
    1. In Roblox Studio: Plugins tab > Plugins Folder (opens file explorer)
    2. Create a folder e.g. "LocalAI" inside the Plugins folder
    3. Save this file inside it as "AIAssistant.lua" (or use Studio's built-in
       plugin script editor / Rojo if you prefer)
    4. Restart Studio - a new toolbar button "Local AI" will appear

    NOTE: Update SERVER_URL below to match your llama-server address.
]]

local SERVER_URL = "http://192.168.1.168:8080/v1/chat/completions"

local toolbar = plugin:CreateToolbar("Local AI")
local button = toolbar:CreateButton(
    "Ask AI",
    "Send a prompt to your local Qwen model",
    "rbxassetid://4458901886" -- placeholder icon
)

local widgetInfo = DockWidgetPluginGuiInfo.new(
    Enum.InitialDockState.Right,
    true,  -- enabled by default
    false, -- override previous enabled state
    350, 400, -- default width/height
    250, 200  -- min width/height
)

local widget = plugin:CreateDockWidgetPluginGui("LocalAIWidget", widgetInfo)
widget.Title = "Local AI Assistant"

-- Build UI
local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Parent = widget

local promptBox = Instance.new("TextBox")
promptBox.Size = UDim2.new(1, -20, 0, 100)
promptBox.Position = UDim2.new(0, 10, 0, 10)
promptBox.PlaceholderText = "Describe what you want the script to do..."
promptBox.MultiLine = true
promptBox.ClearTextOnFocus = false
promptBox.TextWrapped = true
promptBox.TextXAlignment = Enum.TextXAlignment.Left
promptBox.TextYAlignment = Enum.TextYAlignment.Top
promptBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
promptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
promptBox.Parent = frame

local askButton = Instance.new("TextButton")
askButton.Size = UDim2.new(1, -20, 0, 35)
askButton.Position = UDim2.new(0, 10, 0, 120)
askButton.Text = "Generate Script"
askButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
askButton.TextColor3 = Color3.fromRGB(255, 255, 255)
askButton.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 160)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = frame

local outputBox = Instance.new("TextBox")
outputBox.Size = UDim2.new(1, -20, 1, -190)
outputBox.Position = UDim2.new(0, 10, 0, 185)
outputBox.MultiLine = true
outputBox.ClearTextOnFocus = false
outputBox.TextWrapped = true
outputBox.TextXAlignment = Enum.TextXAlignment.Left
outputBox.TextYAlignment = Enum.TextYAlignment.Top
outputBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
outputBox.TextColor3 = Color3.fromRGB(150, 255, 150)
outputBox.Font = Enum.Font.Code
outputBox.TextSize = 14
outputBox.Parent = frame

-- Services
local HttpService = game:GetService("HttpService")

-- System prompt to keep it focused on Luau/Roblox
local SYSTEM_PROMPT = [[You are a Roblox Luau scripting assistant embedded in Roblox Studio.
Respond ONLY with valid Luau code (no markdown fences, no explanation) unless the user
explicitly asks a question rather than requesting code. Follow Roblox API conventions.]]

local function askAI(userPrompt)
    local requestBody = {
        model = "qwen2.5-coder",
        messages = {
            { role = "system", content = SYSTEM_PROMPT },
            { role = "user", content = userPrompt }
        },
        temperature = 0.3,
        max_tokens = 1024
    }

    local success, result = pcall(function()
        return HttpService:RequestAsync({
            Url = SERVER_URL,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode(requestBody)
        })
    end)

    if not success then
        return nil, "Request failed: " .. tostring(result)
    end

    if not result.Success then
        return nil, "Server error " .. tostring(result.StatusCode) .. ": " .. tostring(result.Body)
    end

    local ok, decoded = pcall(function()
        return HttpService:JSONDecode(result.Body)
    end)

    if not ok then
        return nil, "Failed to parse response"
    end

    local content = decoded.choices and decoded.choices[1] and decoded.choices[1].message
        and decoded.choices[1].message.content

    if not content then
        return nil, "Unexpected response format"
    end

    return content, nil
end

askButton.MouseButton1Click:Connect(function()
    local prompt = promptBox.Text
    if prompt == "" then
        statusLabel.Text = "Enter a prompt first."
        return
    end

    statusLabel.Text = "Thinking..."
    outputBox.Text = ""
    askButton.Active = false

    task.spawn(function()
        local response, err = askAI(prompt)
        askButton.Active = true

        if err then
            statusLabel.Text = "Error"
            outputBox.Text = err
            return
        end

        statusLabel.Text = "Done. Click below to insert as a script."
        outputBox.Text = response
    end)
end)

button.Click:Connect(function()
    widget.Enabled = not widget.Enabled
end)

-- Optional: insert output as a new Script into the selected instance (or Workspace)
local Selection = game:GetService("Selection")

local insertButton = Instance.new("TextButton")
insertButton.Size = UDim2.new(1, -20, 0, 30)
insertButton.Position = UDim2.new(0, 10, 1, -35)
insertButton.Text = "Insert as Script"
insertButton.BackgroundColor3 = Color3.fromRGB(60, 160, 60)
insertButton.TextColor3 = Color3.fromRGB(255, 255, 255)
insertButton.ZIndex = 2
insertButton.Parent = frame

insertButton.MouseButton1Click:Connect(function()
    if outputBox.Text == "" then return end

    local parent = Selection:Get()[1] or workspace
    local script_ = Instance.new("Script")
    script_.Name = "AIGeneratedScript"
    script_.Source = outputBox.Text
    script_.Parent = parent
    Selection:Set({script_})
    statusLabel.Text = "Inserted into " .. parent.Name
end)
