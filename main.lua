local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "GHOUL://RE (Hohol Hub)",
    Icon = 0,
    LoadingTitle = "hohol hub",
    LoadingSubtitle = "by z_hx",
    Theme = "default",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,

    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil,
       FileName = "Ghoul:Re"
    },

    KeySystem = false,
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "hoholhubkeysystem",
       SaveKey = true,
       GrabKeyFromSite = false,
       Key = {"slavaukraini"} 
    }
})

Rayfield:Notify({
   Title = "Message",
   Content = "Script Loaded",
   Duration = 6.5,
   Image = 4483362458,
})

local Tab = Window:CreateTab("Universal", 4483362458)

-- Speed Toggle Keybind
local KeybindSpeed = Tab:CreateKeybind({
   Name = "Toggle Speed",
   CurrentKeybind = "T",
   HoldToInteract = false,
   Flag = "SpeedKeybind",
   Callback = function()
       _G.wlkspeedtoggle = not _G.wlkspeedtoggle
       Rayfield:Notify({
           Title = "Speed Toggle",
           Content = "Speed is now " .. (_G.wlkspeedtoggle and "ON" or "OFF"),
           Duration = 2,
           Image = 4483362458,
           Actions = {}
       })
   end
})

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera

_G.flytoggle = false
local flying = false
local speed = 5
local flightConnection
local movement = Vector3.new(0, 0, 0)

local function startFlight()
    if flying then return end
    flying = true

    -- Disable gravity for smooth flight
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.PlatformStand = true
    end

    flightConnection = RunService.RenderStepped:Connect(function()
        if not _G.flytoggle then
            if flightConnection then flightConnection:Disconnect() end
            flying = false
            if humanoid then humanoid.PlatformStand = false end
            return
        end

        -- Move based on camera direction
        local moveDirection = (camera.CFrame.LookVector * movement.Z)
            + (camera.CFrame.RightVector * movement.X)
            + (Vector3.new(0, movement.Y, 0))

        humanoidRootPart.CFrame = humanoidRootPart.CFrame + (moveDirection * speed * 0.1)
    end)
end

-- Toggle Flight
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.F then -- Toggle Flight
        _G.flytoggle = not _G.flytoggle

        if _G.flytoggle then
            startFlight()
        end
    elseif input.KeyCode == Enum.KeyCode.W then
        movement = movement + Vector3.new(0, 0, 1)
    elseif input.KeyCode == Enum.KeyCode.S then
        movement = movement + Vector3.new(0, 0, -1)
    elseif input.KeyCode == Enum.KeyCode.A then
        movement = movement + Vector3.new(-1, 0, 0)
    elseif input.KeyCode == Enum.KeyCode.D then
        movement = movement + Vector3.new(1, 0, 0)
    elseif input.KeyCode == Enum.KeyCode.Space then
        movement = movement + Vector3.new(0, 1, 0)
    elseif input.KeyCode == Enum.KeyCode.LeftShift then
        movement = movement + Vector3.new(0, -1, 0)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then
        movement = movement - Vector3.new(0, 0, 1)
    elseif input.KeyCode == Enum.KeyCode.S then
        movement = movement - Vector3.new(0, 0, -1)
    elseif input.KeyCode == Enum.KeyCode.A then
        movement = movement - Vector3.new(-1, 0, 0)
    elseif input.KeyCode == Enum.KeyCode.D then
        movement = movement - Vector3.new(1, 0, 0)
    elseif input.KeyCode == Enum.KeyCode.Space then
        movement = movement - Vector3.new(0, 1, 0)
    elseif input.KeyCode == Enum.KeyCode.LeftShift then
        movement = movement - Vector3.new(0, -1, 0)
    end
end)

-- Reset Flight on Respawn
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    _G.flytoggle = false
    flying = false
end)


-- Settings Tab
local Tab = Window:CreateTab("Settings", 4483362458)

Rayfield:LoadConfiguration{}
