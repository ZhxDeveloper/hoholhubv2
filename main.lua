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

local Tab = Window:CreateTab("Farm", 4483362458)

local Tab = Window:CreateTab("Esp", 4483362458)

local Toggle = Tab:CreateToggle({
   Name = "PlayerEsp",
   CurrentValue = false,
   Flag = "plyresp1", 
   Callback = function(v)
      _G.ESPToggle = v
   end,
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

-- Flight Toggle Keybind
local KeybindFlight = Tab:CreateKeybind({
   Name = "Toggle Flight",
   CurrentKeybind = "F",  -- You can change this to any key you like
   HoldToInteract = false,
   Flag = "FlightKeybind",
   Callback = function()
      _G.flytoggle = not _G.flytoggle
      Rayfield:Notify({
          Title = "Flight Toggle",
          Content = "Flight is now " .. (_G.flytoggle and "ON" or "OFF"),
          Duration = 2,
          Image = 4483362458,
          Actions = {}
      })
   end
})

-- Speed functionality (walk speed control)
game:GetService("RunService").Heartbeat:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            if _G.wlkspeedtoggle then
                humanoid.WalkSpeed = 75 -- Set speed when enabled
            else
                humanoid.WalkSpeed = 16  -- Default speed when disabled
            end
        end
    end
end)

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local camera = game.Workspace.CurrentCamera

_G.flytoggle = false
local flying = false
local flightConnection

local speed = 50  -- Horizontal speed
local verticalSpeed = 25  -- Vertical movement speed
local movement = Vector3.new(0, 0, 0)

local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.MaxForce = Vector3.new(500000, 500000, 500000)  -- Strong force for movement
bodyVelocity.P = 10000  -- Smooth movement control

local function enableFlight()
    if flying then return end  -- Prevent multiple loops

    flying = true
    humanoidRootPart.Anchored = false
    bodyVelocity.Parent = humanoidRootPart

    -- Create a stable loop for movement
    flightConnection = RunService.Heartbeat:Connect(function()
        if not _G.flytoggle then
            if flightConnection then flightConnection:Disconnect() end
            flying = false
            bodyVelocity.Parent = nil
            return
        end

        -- Apply movement direction
        local forwardDirection = camera.CFrame.LookVector * movement.Z * speed
        local rightDirection = camera.CFrame.RightVector * movement.X * speed
        local upDirection = Vector3.new(0, movement.Y * verticalSpeed, 0)

        bodyVelocity.Velocity = forwardDirection + rightDirection + upDirection
    end)
end

-- Toggle flight on key press
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == Enum.KeyCode.W then
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
            elseif input.KeyCode == Enum.KeyCode.F then  -- Toggle Flight Keybind
                _G.flytoggle = not _G.flytoggle
                if _G.flytoggle then
                    enableFlight()
                end
            end
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
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
    end
end)

-- Respawn listener to reset flight state
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    _G.flytoggle = false
    flying = false
end)


-- Settings Tab
local Tab = Window:CreateTab("Settings", 4483362458)

Rayfield:LoadConfiguration{}
