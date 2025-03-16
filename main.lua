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


local Tab = Window:CreateTab("Misc", 4483362458) 

local Keybind = Tab:CreateKeybind({
   Name = "Toggle Speed",
   CurrentKeybind = "T", -- Default key
   HoldToInteract = false, -- Press once to toggle
   Flag = "SpeedKeybind",
   Callback = function()
       _G.wlkspeedtoggle = not _G.wlkspeedtoggle -- Toggles the speed setting
       Rayfield:Notify({
           Title = "Speed Toggle",
           Content = "Speed is now " .. (_G.wlkspeedtoggle and "ON" or "OFF"),
           Duration = 2,
           Image = 4483362458,
           Actions = {}
       })
   end
})

game:GetService("RunService").Heartbeat:Connect(function()
   if _G.wlkspeedtoggle then
       local player = game.Players.LocalPlayer
       if player.Character and player.Character:FindFirstChild("Humanoid") then
           local humanoid = player.Character.Humanoid
           local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
           if humanoid.MoveDirection.Magnitude > 0 and rootPart then
               rootPart.CFrame = rootPart.CFrame * CFrame.new(0, 0, -1.1)
           end
       end
   end
end)

local Tab = Window:CreateTab("Settings", 4483362458) 

Rayfield:LoadConfiguration{}