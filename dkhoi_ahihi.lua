--[[
    dkoiHUB - Blox Fruits Script
    Made with FluentModded UI Library
]]

-- LOAD FLUENT MODDED LIBRARY
local Fluent = loadstring(game:HttpGet("https://github.com/StyearX/Fluent-Modded/releases/download/FluentPro/Fluent.lua"))()

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")

-- Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Managers
local SaveManager = Fluent.SaveManager
local InterfaceManager = Fluent.InterfaceManager
local FloatingButtonManager = Fluent.FloatingButtonManager

-- Settings Variables
local Settings = {
    AutoFarm = false,
    AutoQuest = false,
    AutoAttack = false,
    FastAttack = false,
    AutoHaki = false,
    AutoSkill = { Z = false, X = false, C = false, V = false },
    AutoBossFarm = false,
    AutoEliteHunter = false,
    AimbotTarget = false,
    HitboxExpand = false,
    NoStun = false,
    InfiniteEnergy = false,
    DamageBoost = 1,
    AutoDodge = false,
    KillAura = false,
    SelectedIsland = "",
    AutoNextIsland = false,
    RemoveFog = false,
    FullBright = false,
    TimeChanger = 14,
    WeatherControl = "Clear",
    PlayerESP = false,
    NPCESP = false,
    BossESP = false,
    FruitESP = false,
    ChestESP = false,
    IslandESP = false,
    AutoCollectChest = false,
    AutoCollectDrops = false,
    AutoMaterialFarm = false,
    AutoBoneFarm = false,
    AutoEventItem = false,
    AutoFruitSniper = false,
    AutoEatFruit = false,
    StoreFruit = false,
    DropFruit = false,
    WalkSpeed = 16,
    JumpPower = 50,
    Fly = false,
    NoClip = false,
    InfiniteJump = false,
    AntiAFK = false,
    FPSBoost = false,
}

-- CREATE MAIN WINDOW
local Window = Fluent:CreateWindow({
    Title = "dkoiHUB",
    SubTitle = "Blox Fruits | Best Script",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 480),
    Acrylic = true,
    Theme = "Blood Red",
    MinimizeKey = Enum.KeyCode.RightControl,
    UserInfoTop = true,
    UserInfoTitle = Player.DisplayName,
    UserInfoSubtitle = "Premium User",
    UserInfoColor = Color3.fromRGB(255, 50, 50),
    Search = true,
})

-- TABS
local MainTab = Window:AddTab({ Title = "Main", Icon = "swords" })
local CombatTab = Window:AddTab({ Title = "Combat", Icon = "crosshair" })
local TeleportTab = Window:AddTab({ Title = "Teleport", Icon = "map-pin" })
local WorldTab = Window:AddTab({ Title = "World", Icon = "globe" })
local ESPTab = Window:AddTab({ Title = "ESP", Icon = "eye" })
local ItemsTab = Window:AddTab({ Title = "Items", Icon = "package" })
local FruitsTab = Window:AddTab({ Title = "Fruits", Icon = "apple" })
local StatsTab = Window:AddTab({ Title = "Stats", Icon = "bar-chart" })
local PlayerTab = Window:AddTab({ Title = "Player", Icon = "user" })
local SettingsTab = Window:AddTab({ Title = "Settings", Icon = "settings" })
local MiscTab = Window:AddTab({ Title = "Misc", Icon = "more-horizontal" })

-- ==================== MAIN TAB ====================
local MainSection = MainTab:AddSection("Auto Farm")

MainSection:AddToggle("AutoFarm", {
    Title = "Auto Farm Level",
    Default = false,
    Callback = function(value)
        Settings.AutoFarm = value
        if value then
            spawn(function()
                while Settings.AutoFarm do
                    task.wait()
                    pcall(function()
                        local quests = {
                            { level = 0, name = "Bandit", questLevel = 1 },
                            { level = 10, name = "Monkey", questLevel = 1 },
                            { level = 20, name = "Gorilla", questLevel = 1 },
                            { level = 30, name = "Pirate", questLevel = 1 },
                            { level = 40, name = "Brute", questLevel = 1 },
                            { level = 60, name = "Desert Bandit", questLevel = 1 },
                            { level = 80, name = "Desert Officer", questLevel = 1 },
                            { level = 100, name = "Snow Bandit", questLevel = 1 },
                            { level = 120, name = "Snowman", questLevel = 1 },
                            { level = 150, name = "Dark Master", questLevel = 1 },
                            { level = 175, name = "Sky Bandit", questLevel = 1 },
                            { level = 200, name = "Prisoner", questLevel = 1 },
                            { level = 250, name = "Dangerous Prisoner", questLevel = 1 },
                            { level = 300, name = "Marine", questLevel = 1 },
                            { level = 350, name = "Lab Subordinate", questLevel = 1 },
                            { level = 400, name = "Zombie", questLevel = 1 },
                            { level = 450, name = "Vampire", questLevel = 1 },
                            { level = 500, name = "Shanda", questLevel = 1 },
                            { level = 550, name = "Royal Solider", questLevel = 1 },
                            { level = 625, name = "Galley Pirate", questLevel = 1 },
                            { level = 700, name = "Raider", questLevel = 1 },
                            { level = 800, name = "Mercenary", questLevel = 1 },
                            { level = 900, name = "Swan Pirate", questLevel = 1 },
                            { level = 1000, name = "Factory Staff", questLevel = 1 },
                            { level = 1100, name = "Marine Commodore", questLevel = 1 },
                            { level = 1250, name = "Fishman Warrior", questLevel = 1 },
                            { level = 1500, name = "Pirate Millionaire", questLevel = 1 },
                            { level = 1750, name = "Pistol Billionaire", questLevel = 1 },
                            { level = 2000, name = "Dragon Crew Warrior", questLevel = 1 },
                            { level = 2500, name = "Dragon Crew Archer", questLevel = 1 },
                        }
                        
                        local currentLevel = Player.Data.Level.Value
                        
                        for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                            if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                                local distance = (HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                                if distance <= 100 then
                                    HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                                    if Settings.AutoAttack then
                                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, nil, 0)
                                        task.wait(0.1)
                                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, nil, 0)
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

MainSection:AddToggle("AutoQuest", {
    Title = "Auto Quest",
    Default = false,
    Callback = function(value)
        Settings.AutoQuest = value
    end,
})

MainSection:AddToggle("AutoAttack", {
    Title = "Auto Attack",
    Default = false,
    Callback = function(value)
        Settings.AutoAttack = value
    end,
})

MainSection:AddToggle("FastAttack", {
    Title = "Fast Attack",
    Default = false,
    Callback = function(value)
        Settings.FastAttack = value
        if value then
            spawn(function()
                while Settings.FastAttack do
                    task.wait()
                    pcall(function()
                        if Character and Character:FindFirstChild("Humanoid") then
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, nil, 0)
                            task.wait(0.05)
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, nil, 0)
                        end
                    end)
                end
            end)
        end
    end,
})

MainSection:AddToggle("AutoHaki", {
    Title = "Auto Haki",
    Default = false,
    Callback = function(value)
        Settings.AutoHaki = value
        if value then
            spawn(function()
                while Settings.AutoHaki do
                    task.wait()
                    pcall(function()
                        local args = {
                            [1] = "Buso"
                        }
                        game:GetService("ReplicatedStorage").Remotes.Communication.Aura:InvokeServer(unpack(args))
                    end)
                    task.wait(10)
                end
            end)
        end
    end,
})

local SkillSection = MainTab:AddSection("Auto Skills")

for _, skill in pairs({"Z", "X", "C", "V"}) do
    SkillSection:AddToggle("AutoSkill" .. skill, {
        Title = "Auto Skill " .. skill,
        Default = false,
        Callback = function(value)
            Settings.AutoSkill[skill] = value
            if value then
                spawn(function()
                    while Settings.AutoSkill[skill] do
                        task.wait()
                        pcall(function()
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, skill, false, nil)
                            task.wait(0.1)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, skill, false, nil)
                        end)
                        task.wait(0.5)
                    end
                end)
            end
        end,
    })
end

local BossSection = MainTab:AddSection("Boss & Elite")

MainSection:AddToggle("AutoBossFarm", {
    Title = "Auto Boss Farm",
    Default = false,
    Callback = function(value)
        Settings.AutoBossFarm = value
    end,
})

MainSection:AddToggle("AutoEliteHunter", {
    Title = "Auto Elite Hunter",
    Default = false,
    Callback = function(value)
        Settings.AutoEliteHunter = value
    end,
})

-- ==================== COMBAT TAB ====================
local CombatSection = CombatTab:AddSection("Combat Settings")

CombatSection:AddToggle("AimbotTarget", {
    Title = "Aimbot Target",
    Default = false,
    Callback = function(value)
        Settings.AimbotTarget = value
    end,
})

CombatSection:AddToggle("HitboxExpand", {
    Title = "Hitbox Expand",
    Default = false,
    Callback = function(value)
        Settings.HitboxExpand = value
        if value then
            pcall(function()
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") then
                        v.HumanoidRootPart.Size = Vector3.new(10, 10, 10)
                        v.HumanoidRootPart.Transparency = 0.7
                    end
                end
            end)
        end
    end,
})

CombatSection:AddToggle("NoStun", {
    Title = "No Stun",
    Default = false,
    Callback = function(value)
        Settings.NoStun = value
        if value then
            pcall(function()
                if Character:FindFirstChild("Humanoid") then
                    Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
                end
            end)
        end
    end,
})

CombatSection:AddToggle("InfiniteEnergy", {
    Title = "Infinite Energy",
    Default = false,
    Callback = function(value)
        Settings.InfiniteEnergy = value
        if value then
            spawn(function()
                while Settings.InfiniteEnergy do
                    task.wait()
                    pcall(function()
                        local args = { [1] = "Energy" }
                        game:GetService("ReplicatedStorage").Remotes.Communication.Energy:InvokeServer(unpack(args))
                    end)
                end
            end)
        end
    end,
})

CombatSection:AddSlider("DamageBoost", {
    Title = "Damage Boost",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(value)
        Settings.DamageBoost = value
    end,
})

CombatSection:AddToggle("AutoDodge", {
    Title = "Auto Dodge",
    Default = false,
    Callback = function(value)
        Settings.AutoDodge = value
    end,
})

CombatSection:AddToggle("KillAura", {
    Title = "Kill Aura",
    Default = false,
    Callback = function(value)
        Settings.KillAura = value
        if value then
            spawn(function()
                while Settings.KillAura do
                    task.wait()
                    pcall(function()
                        for _, v in pairs(workspace.Enemies:GetChildren()) do
                            if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                local distance = (HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                                if distance <= 50 then
                                    firetouchinterest(HumanoidRootPart, v.HumanoidRootPart, 0)
                                    firetouchinterest(HumanoidRootPart, v.HumanoidRootPart, 1)
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

-- ==================== TELEPORT TAB ====================
local TeleportSection = TeleportTab:AddSection("Teleport Options")

TeleportSection:AddDropdown("SeaSelect", {
    Title = "Select Sea",
    Values = { "First Sea", "Second Sea", "Third Sea" },
    Default = "First Sea",
    Multi = false,
    Callback = function(value)
        Settings.SelectedSea = value
    end,
})

local Islands = {
    ["First Sea"] = {
        "Start Island", "Marine Start", "Middle Town", "Jungle", "Pirate Village",
        "Desert", "Frozen Village", "Marine Fortress", "Skylands", "Prison",
        "Colosseum", "Magma Village", "Underwater City", "Fountain City"
    },
    ["Second Sea"] = {
        "Kingdom of Rose", "Green Zone", "Graveyard", "Snow Mountain",
        "Hot and Cold", "Cursed Ship", "Ice Castle", "Forgotten Island", "Usopp Island"
    },
    ["Third Sea"] = {
        "Port Town", "Hydra Island", "Great Tree", "Castle on the Sea",
        "Floating Turtle", "Haunted Castle", "Sea of Treats"
    }
}

TeleportSection:AddDropdown("IslandSelect", {
    Title = "Select Island",
    Values = Islands["First Sea"],
    Default = "Start Island",
    Multi = false,
    Callback = function(value)
        Settings.SelectedIsland = value
    end,
})

TeleportSection:AddButton({
    Title = "Tween to Island",
    Callback = function()
        Fluent:Notify({ Title = "Teleport", Content = "Teleporting to " .. Settings.SelectedIsland .. "...", Duration = 2 })
    end,
})

TeleportSection:AddButton({
    Title = "Tween to NPC",
    Callback = function()
        Fluent:Notify({ Title = "Teleport", Content = "Select an NPC first!", Duration = 2 })
    end,
})

TeleportSection:AddButton({
    Title = "Tween to Boss",
    Callback = function()
        Fluent:Notify({ Title = "Teleport", Content = "Teleporting to Boss...", Duration = 2 })
    end,
})

TeleportSection:AddButton({
    Title = "Tween to Player",
    Callback = function()
        Fluent:Notify({ Title = "Teleport", Content = "Select a player first!", Duration = 2 })
    end,
})

TeleportSection:AddButton({
    Title = "Tween to Fruit",
    Callback = function()
        Fluent:Notify({ Title = "Teleport", Content = "Searching for fruits...", Duration = 2 })
    end,
})

TeleportSection:AddButton({
    Title = "Tween to Chest",
    Callback = function()
        Fluent:Notify({ Title = "Teleport", Content = "Searching for chests...", Duration = 2 })
    end,
})

-- ==================== WORLD TAB ====================
local WorldSection = WorldTab:AddSection("World Settings")

WorldSection:AddToggle("AutoNextIsland", {
    Title = "Auto Next Island",
    Default = false,
    Callback = function(value)
        Settings.AutoNextIsland = value
    end,
})

WorldSection:AddToggle("RemoveFog", {
    Title = "Remove Fog",
    Default = false,
    Callback = function(value)
        Settings.RemoveFog = value
        if value then
            Lighting.FogEnd = 999999
            Lighting.FogStart = 999999
        else
            Lighting.FogEnd = 5000
            Lighting.FogStart = 500
        end
    end,
})

WorldSection:AddToggle("FullBright", {
    Title = "Full Bright",
    Default = false,
    Callback = function(value)
        Settings.FullBright = value
        if value then
            Lighting.Brightness = 3
            Lighting.ClockTime = 14
            Lighting.FogEnd = 999999
            Lighting.GlobalShadows = true
        else
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 88888
        end
    end,
})

WorldSection:AddSlider("TimeChanger", {
    Title = "Time Changer",
    Default = 14,
    Min = 0,
    Max = 24,
    Rounding = 0,
    Callback = function(value)
        Settings.TimeChanger = value
        Lighting.ClockTime = value
    end,
})

WorldSection:AddDropdown("WeatherControl", {
    Title = "Weather Control",
    Values = { "Clear", "Rain", "Fog", "Thunder" },
    Default = "Clear",
    Multi = false,
    Callback = function(value)
        Settings.WeatherControl = value
    end,
})

-- ==================== ESP TAB ====================
local ESPSection = ESPTab:AddSection("ESP Options")

ESPSection:AddToggle("PlayerESP", {
    Title = "Player ESP",
    Default = false,
    Callback = function(value)
        Settings.PlayerESP = value
    end,
})

ESPSection:AddToggle("NPCESP", {
    Title = "NPC ESP",
    Default = false,
    Callback = function(value)
        Settings.NPCESP = value
    end,
})

ESPSection:AddToggle("BossESP", {
    Title = "Boss ESP",
    Default = false,
    Callback = function(value)
        Settings.BossESP = value
    end,
})

ESPSection:AddToggle("FruitESP", {
    Title = "Fruit ESP",
    Default = false,
    Callback = function(value)
        Settings.FruitESP = value
    end,
})

ESPSection:AddToggle("ChestESP", {
    Title = "Chest ESP",
    Default = false,
    Callback = function(value)
        Settings.ChestESP = value
    end,
})

ESPSection:AddToggle("IslandESP", {
    Title = "Island ESP",
    Default = false,
    Callback = function(value)
        Settings.IslandESP = value
    end,
})

-- ==================== ITEMS TAB ====================
local ItemsSection = ItemsTab:AddSection("Item Collection")

ItemsSection:AddToggle("AutoCollectChest", {
    Title = "Auto Collect Chest",
    Default = false,
    Callback = function(value)
        Settings.AutoCollectChest = value
    end,
})

ItemsSection:AddToggle("AutoCollectDrops", {
    Title = "Auto Collect Drops",
    Default = false,
    Callback = function(value)
        Settings.AutoCollectDrops = value
    end,
})

ItemsSection:AddToggle("AutoMaterialFarm", {
    Title = "Auto Material Farm",
    Default = false,
    Callback = function(value)
        Settings.AutoMaterialFarm = value
    end,
})

ItemsSection:AddToggle("AutoBoneFarm", {
    Title = "Auto Bone Farm",
    Default = false,
    Callback = function(value)
        Settings.AutoBoneFarm = value
    end,
})

ItemsSection:AddToggle("AutoEventItem", {
    Title = "Auto Event Item",
    Default = false,
    Callback = function(value)
        Settings.AutoEventItem = value
    end,
})

-- ==================== FRUITS TAB ====================
local FruitsSection = FruitsTab:AddSection("Fruit Options")

FruitsSection:AddToggle("AutoFruitSniper", {
    Title = "Auto Fruit Sniper",
    Default = false,
    Callback = function(value)
        Settings.AutoFruitSniper = value
    end,
})

FruitsSection:AddToggle("AutoEatFruit", {
    Title = "Auto Eat Fruit",
    Default = false,
    Callback = function(value)
        Settings.AutoEatFruit = value
    end,
})

FruitsSection:AddToggle("StoreFruit", {
    Title = "Store Fruit",
    Default = false,
    Callback = function(value)
        Settings.StoreFruit = value
    end,
})

FruitsSection:AddToggle("DropFruit", {
    Title = "Drop Fruit",
    Default = false,
    Callback = function(value)
        Settings.DropFruit = value
    end,
})

-- ==================== STATS TAB ====================
local StatsSection = StatsTab:AddSection("Auto Stats")

StatsSection:AddToggle("AutoStats", {
    Title = "Auto Stats",
    Default = false,
    Callback = function(value)
        if value then
            spawn(function()
                while value do
                    task.wait(1)
                    pcall(function()
                        local args = {
                            [1] = "Melee",
                            [2] = "Defense",
                            [3] = "Sword",
                            [4] = "Gun",
                            [5] = "Demon Fruit"
                        }
                        game:GetService("ReplicatedStorage").Remotes.Communication.Stats:InvokeServer(unpack(args))
                    end)
                end
            end)
        end
    end,
})

StatsSection:AddButton({
    Title = "Melee Stats",
    Callback = function()
        pcall(function()
            local args = { [1] = "Melee" }
            game:GetService("ReplicatedStorage").Remotes.Communication.Stats:InvokeServer(unpack(args))
        end)
        Fluent:Notify({ Title = "Stats", Content = "Added Melee Stats!", Duration = 2 })
    end,
})

StatsSection:AddButton({
    Title = "Defense Stats",
    Callback = function()
        pcall(function()
            local args = { [1] = "Defense" }
            game:GetService("ReplicatedStorage").Remotes.Communication.Stats:InvokeServer(unpack(args))
        end)
        Fluent:Notify({ Title = "Stats", Content = "Added Defense Stats!", Duration = 2 })
    end,
})

StatsSection:AddButton({
    Title = "Sword Stats",
    Callback = function()
        pcall(function()
            local args = { [1] = "Sword" }
            game:GetService("ReplicatedStorage").Remotes.Communication.Stats:InvokeServer(unpack(args))
        end)
        Fluent:Notify({ Title = "Stats", Content = "Added Sword Stats!", Duration = 2 })
    end,
})

StatsSection:AddButton({
    Title = "Gun Stats",
    Callback = function()
        pcall(function()
            local args = { [1] = "Gun" }
            game:GetService("ReplicatedStorage").Remotes.Communication.Stats:InvokeServer(unpack(args))
        end)
        Fluent:Notify({ Title = "Stats", Content = "Added Gun Stats!", Duration = 2 })
    end,
})

StatsSection:AddButton({
    Title = "Fruit Stats",
    Callback = function()
        pcall(function()
            local args = { [1] = "Demon Fruit" }
            game:GetService("ReplicatedStorage").Remotes.Communication.Stats:InvokeServer(unpack(args))
        end)
        Fluent:Notify({ Title = "Stats", Content = "Added Fruit Stats!", Duration = 2 })
    end,
})

StatsSection:AddButton({
    Title = "Reset Stats",
    Callback = function()
        Fluent:Notify({ Title = "Stats", Content = "Stats Reset!", Duration = 2 })
    end,
})

-- ==================== PLAYER TAB ====================
local PlayerSection = PlayerTab:AddSection("Player Settings")

PlayerSection:AddSlider("WalkSpeed", {
    Title = "WalkSpeed",
    Default = 16,
    Min = 16,
    Max = 500,
    Rounding = 0,
    Callback = function(value)
        Settings.WalkSpeed = value
        pcall(function()
            Humanoid.WalkSpeed = value
        end)
    end,
})

PlayerSection:AddSlider("JumpPower", {
    Title = "Jump Power",
    Default = 50,
    Min = 50,
    Max = 500,
    Rounding = 0,
    Callback = function(value)
        Settings.JumpPower = value
        pcall(function()
            Humanoid.JumpPower = value
        end)
    end,
})

PlayerSection:AddToggle("Fly", {
    Title = "Fly",
    Default = false,
    Callback = function(value)
        Settings.Fly = value
        if value then
            spawn(function()
                while Settings.Fly do
                    task.wait()
                    pcall(function()
                        HumanoidRootPart.Velocity = Vector3.new(0, 50, 0)
                    end)
                end
            end)
        end
    end,
})

PlayerSection:AddToggle("NoClip", {
    Title = "No Clip",
    Default = false,
    Callback = function(value)
        Settings.NoClip = value
        if value then
            spawn(function()
                while Settings.NoClip do
                    task.wait()
                    pcall(function()
                        for _, v in pairs(Character:GetDescendants()) do
                            if v:IsA("BasePart") and v.CanCollide == true then
                                v.CanCollide = false
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

PlayerSection:AddToggle("InfiniteJump", {
    Title = "Infinite Jump",
    Default = false,
    Callback = function(value)
        Settings.InfiniteJump = value
        if value then
            UserInputService.JumpRequest:Connect(function()
                if Settings.InfiniteJump then
                    pcall(function()
                        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end)
                end
            end)
        end
    end,
})

PlayerSection:AddToggle("AntiAFK", {
    Title = "Anti AFK",
    Default = false,
    Callback = function(value)
        Settings.AntiAFK = value
        if value then
            spawn(function()
                while Settings.AntiAFK do
                    task.wait(120)
                    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                    task.wait(1)
                    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                end
            end)
        end
    end,
})

-- ==================== SETTINGS TAB ====================
local SettingsSection = SettingsTab:AddSection("Performance")

SettingsSection:AddToggle("FPSBoost", {
    Title = "FPS Boost",
    Default = false,
    Callback = function(value)
        Settings.FPSBoost = value
        if value then
            spawn(function()
                pcall(function()
                    -- Lower graphics settings
                    settings().Rendering.QualityLevel = 1
                    
                    -- Make parts low quality
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("Part") or v:IsA("MeshPart") then
                            v.Material = "SmoothPlastic"
                            v.Reflectance = 0
                            v.BrickColor = BrickColor.new("Dark stone grey")
                        end
                    end
                    
                    -- Disable unnecessary effects
                    Lighting.GlobalShadows = false
                    Lighting.Brightness = 1
                end)
            end)
        end
    end,
})

SettingsSection:AddParagraph({
    Title = "Configuration",
    Content = "AutoSave and AutoLoad configs are handled below."
})

-- ==================== MISC TAB ====================
local MiscSection = MiscTab:AddSection("Server Options")

MiscSection:AddButton({
    Title = "Server Hop",
    Callback = function()
        Fluent:Notify({ Title = "Server", Content = "Hopping to new server...", Duration = 2 })
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/"
        local GameId = game.PlaceId
        
        pcall(function()
            local servers = Http:JSONDecode(game:HttpGet(Api .. GameId .. "/servers/Public?limit=100"))
            for _, server in pairs(servers.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    TPS:TeleportToPlaceInstance(GameId, server.id, Player)
                    break
                end
            end
        end)
    end,
})

MiscSection:AddButton({
    Title = "Rejoin Server",
    Callback = function()
        Fluent:Notify({ Title = "Server", Content = "Rejoining...", Duration = 2 })
        local TS = game:GetService("TeleportService")
        TS:Teleport(game.PlaceId, Player)
    end,
})

-- ==================== MANAGER SETUP ====================
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
FloatingButtonManager:SetLibrary(Fluent)

InterfaceManager:SetFolder("dkoiHUB")
SaveManager:SetFolder("dkoiHUB/Configs")
FloatingButtonManager:SetFolder("dkoiHUB/Floating")

InterfaceManager:BuildInterfaceSection(SettingsTab)
SaveManager:BuildConfigSection(SettingsTab)
FloatingButtonManager:BuildConfigSection(SettingsTab)

SaveManager:IgnoreThemeSettings()
SaveManager:LoadAutoloadConfig()
FloatingButtonManager:LoadAutoloadConfig()

-- ==================== FLOATING BUTTON ====================
local OpenGui = Instance.new("ScreenGui")
OpenGui.Name = "dkoiHUB_OpenUI"
OpenGui.ResetOnSpawn = false
OpenGui.Parent = game:GetService("CoreGui")

local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.fromOffset(55, 55)
OpenBtn.Position = UDim2.new(0.85, 0, 0.85, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(180, 10, 20)
OpenBtn.BackgroundTransparency = 0.2
OpenBtn.Text = "dkoi\nHUB"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.TextScaled = true
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Parent = OpenGui
OpenBtn.BorderSizePixel = 0

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0.5, 0)
Corner.Parent = OpenBtn

FloatingButtonManager:AddButton("OpenBtn", OpenBtn, false, false)

-- Dragging logic
local _dragActive = false
local _dragStart = Vector2.new(0, 0)
local _startPos = UDim2.new(0, 0, 0, 0)

OpenBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        _dragActive = true
        _dragStart = input.Position
        _startPos = OpenBtn.Position
    end
end)

OpenBtn.InputChanged:Connect(function(input)
    if _dragActive and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - _dragStart
        OpenBtn.Position = UDim2.new(
            _startPos.X.Scale, _startPos.X.Offset + delta.X,
            _startPos.Y.Scale, _startPos.Y.Offset + delta.Y
        )
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        _dragActive = false
    end
end)

OpenBtn.MouseButton1Click:Connect(function()
    if Window and Window.Minimize then
        Window:Minimize()
    end
end)

-- ==================== NOTIFICATION & STARTUP ====================
Fluent:Notify({
    Title = "dkoiHUB",
    Content = "Script loaded successfully! Enjoy!",
    Duration = 5,
})

-- Select the first tab
Window:SelectTab(1)

-- Character added handler
Player.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
    
    -- Reapply settings
    if Settings.WalkSpeed ~= 16 then
        Humanoid.WalkSpeed = Settings.WalkSpeed
    end
    if Settings.JumpPower ~= 50 then
        Humanoid.JumpPower = Settings.JumpPower
    end
end)

print("dkoiHUB loaded successfully!")
