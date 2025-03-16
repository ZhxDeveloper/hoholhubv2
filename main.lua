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

-- Flight functionality
local function enableFlight()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local camera = game.Workspace.CurrentCamera

    local flying = false
    local speed = 50  -- Horizontal flight speed
    local verticalSpeed = 25  -- Vertical speed
    local movement = Vector3.new(0, 0, 0)
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(500000, 500000, 500000)  -- Make sure the force is large enough for movement
    bodyVelocity.P = 10000  -- Adjust for smoothness

    local userInputService = game:GetService("UserInputService")

    -- Flight function
    game:GetService("RunService").Heartbeat:Connect(function(_, dt)
        if _G.flytoggle then
            if not flying then
                flying = true
                humanoidRootPart.Anchored = false
                bodyVelocity.Parent = humanoidRootPart
            end

            -- Movement controls
            local forwardDirection = camera.CFrame.LookVector * movement.Z * speed
            local rightDirection = camera.CFrame.RightVector * movement.X * speed
            local upDirection = Vector3.new(0, movement.Y * verticalSpeed, 0)

            -- Apply velocity based on movement
            bodyVelocity.Velocity = forwardDirection + rightDirection + upDirection
        else
            if flying then
                flying = false
                humanoidRootPart.Anchored = false
                bodyVelocity.Parent = nil
            end
        end
    end)

    -- Movement Input
    userInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed then
            if _G.flytoggle then
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
                    end
                end
            end
        end
    end)

    userInputService.InputEnded:Connect(function(input)
        if _G.flytoggle then
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
        end
    end)
end

-- Respawn listener to re-enable flight after death
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    -- Reset flight state after death
    _G.flytoggle = false
    enableFlight()  -- Re-enable flight controls after respawn
end)

-- Call the flight function to activate it when the script runs
enableFlight()

-- Settings Tab
local Tab = Window:CreateTab("Settings", 4483362458)

Rayfield:LoadConfiguration{}
