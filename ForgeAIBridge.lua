-- Forge AI Bridge (Studio Plugin)
-- Polls your self-hosted Forge AI backend and automatically inserts any
-- generated scripts into the right service in this place - no copy/paste.
--
-- INSTALL: save this file as ForgeAIBridge.lua (or .server.lua) inside your
-- Studio Plugins folder (Plugins tab -> Plugins Folder button opens it),
-- then restart Studio or reload plugins.

local HttpService = game:GetService("HttpService")

-- ====================== CONFIG - edit these two lines ======================
local BACKEND_URL = "https://backend-xrd1.onrender.com"
local STUDIO_TOKEN = "dashboard-preview" -- must match the token the dashboard/API sends
-- =============================================================================

local POLL_INTERVAL = 2 -- seconds between checks

-- ---------------------------------------------------------------------------
-- Toolbar UI
-- ---------------------------------------------------------------------------
local toolbar = plugin:CreateToolbar("Forge AI")
local toggleButton = toolbar:CreateButton(
    "Forge AI Bridge",
    "Connect to your Forge AI backend and auto-insert generated scripts",
    ""
)
toggleButton.ClickableWhenViewportHidden = true

local connected = false

-- ---------------------------------------------------------------------------
-- Where each "path" string from a template maps to in this place.
-- Anything unrecognized falls back to ServerScriptService with a comment
-- noting where it was actually meant to go, so nothing silently vanishes.
-- ---------------------------------------------------------------------------
local function buildServiceMap()
    local starterPlayer = game:GetService("StarterPlayer")
    local starterPlayerScripts = starterPlayer:FindFirstChildOfClass("StarterPlayerScripts")
    local starterCharacterScripts = starterPlayer:FindFirstChildOfClass("StarterCharacterScripts")

    return {
        ["ServerScriptService"] = game:GetService("ServerScriptService"),
        ["ServerStorage"] = game:GetService("ServerStorage"),
        ["ReplicatedStorage"] = game:GetService("ReplicatedStorage"),
        ["StarterPlayerScripts"] = starterPlayerScripts,
        ["StarterCharacterScripts"] = starterCharacterScripts,
        ["StarterGui"] = game:GetService("StarterGui"),
        ["Workspace"] = game:GetService("Workspace"),
    }
end

local function resolveParent(pathString)
    local serviceMap = buildServiceMap()
    pathString = pathString or ""

    if serviceMap[pathString] then
        return serviceMap[pathString], nil
    end

    -- Templates sometimes describe a path in prose, e.g.
    -- "Inside a Tool in StarterPack/ServerStorage" - match on substring.
    for key, service in pairs(serviceMap) do
        if service and pathString:find(key, 1, true) then
            return service, nil
        end
    end

    return game:GetService("ServerScriptService"), pathString
end

-- ---------------------------------------------------------------------------
-- Insert a queued script command as a real Instance
-- ---------------------------------------------------------------------------
local VALID_SCRIPT_TYPES = { Script = true, LocalScript = true, ModuleScript = true }

local function insertScript(command)
    local scriptType = command.scriptType
    if not VALID_SCRIPT_TYPES[scriptType] then
        scriptType = "Script"
    end

    local parent, unmatchedPath = resolveParent(command.path)
    if not parent then
        parent = game:GetService("ServerScriptService")
        unmatchedPath = command.path
    end

    local instance = Instance.new(scriptType)
    instance.Name = command.name or "ForgeAIScript"

    if unmatchedPath then
        instance.Source = "-- Forge AI intended location: " .. tostring(unmatchedPath)
            .. "\n-- (auto-placement couldn't match that path, so this landed in ServerScriptService - move it manually)\n\n"
            .. (command.body or "")
    else
        instance.Source = command.body or ""
    end

    instance.Parent = parent
    return instance
end

-- ---------------------------------------------------------------------------
-- Networking
-- ---------------------------------------------------------------------------
local function reportResult(success, message)
    pcall(function()
        HttpService:RequestAsync({
            Url = BACKEND_URL .. "/api/report",
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode({ token = STUDIO_TOKEN, success = success, message = message }),
        })
    end)
end

local function pollOnce()
    local ok, response = pcall(function()
        return HttpService:RequestAsync({
            Url = BACKEND_URL .. "/api/ping/" .. STUDIO_TOKEN,
            Method = "GET",
        })
    end)

    if not ok or not response or not response.Success then
        return false
    end

    local decodeOk, data = pcall(function()
        return HttpService:JSONDecode(response.Body)
    end)
    if not decodeOk or not data or not data.command then
        return true -- reached the server, just nothing queued right now
    end

    local command = data.command
    if command.type == "script" then
        local insertOk, result = pcall(insertScript, command)
        if insertOk then
            print("[Forge AI] Inserted '" .. tostring(command.name) .. "' -> " .. tostring(command.path))
            reportResult(true, "Inserted " .. tostring(command.name))
        else
            warn("[Forge AI] Failed to insert script:", result)
            reportResult(false, tostring(result))
        end
    end

    return true
end

-- ---------------------------------------------------------------------------
-- Poll loop
-- ---------------------------------------------------------------------------
local function startPolling()
    connected = true
    toggleButton:SetActive(true)
    print("[Forge AI] Connected - polling every " .. POLL_INTERVAL .. "s for token '" .. STUDIO_TOKEN .. "'")

    task.spawn(function()
        local warnedThisOutage = false
        while connected do
            local reachedServer = pollOnce()
            if not reachedServer and not warnedThisOutage then
                warn("[Forge AI] Couldn't reach " .. BACKEND_URL .. " (will keep retrying)")
                warnedThisOutage = true
            elseif reachedServer then
                warnedThisOutage = false
            end
            task.wait(POLL_INTERVAL)
        end
    end)
end

local function stopPolling()
    connected = false
    toggleButton:SetActive(false)
    print("[Forge AI] Disconnected")
end

toggleButton.Click:Connect(function()
    if connected then
        stopPolling()
    else
        startPolling()
    end
end)
