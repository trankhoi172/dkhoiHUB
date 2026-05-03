--[[
    dkoiHUB - Blox Fruits Script (Working Version)
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
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")

-- Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Managers
local SaveManager = Fluent.SaveManager
local InterfaceManager = Fluent.InterfaceManager
local FloatingButtonManager = Fluent.FloatingButtonManager

-- Settings
local Settings = {
    AutoFarm = false,
    AutoQuest = false,
    AutoAttack = false,
    FastAttack = false,
    AutoHaki = false,
    AutoSkillZ = false,
    AutoSkillX = false,
    AutoSkillC = false,
    AutoSkillV = false,
    AutoBossFarm = false,
    AutoEliteHunter = false,
    AimbotTarget = false,
    HitboxExpand = false,
    HitboxSize = 10,
    NoStun = false,
    InfiniteEnergy = false,
    KillAura = false,
    KillAuraRange = 50,
    SelectedSea = "First Sea",
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
    AutoFruitSniper = false,
    AutoEatFruit = false,
    StoreFruit = false,
    DropFruit = false,
    AutoStats = false,
    WalkSpeed = 16,
    JumpPower = 50,
    Fly = false,
    NoClip = false,
    InfiniteJump = false,
    AntiAFK = false,
    FPSBoost = false,
}

-- ESP Storage
local ESPObjects = {}

-- Utility Functions
local function getNearestEnemy(range)
    local nearest = nil
    local minDist = range or math.huge
    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
            local dist = (HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
            if dist < minDist then
                minDist = dist
                nearest = enemy
            end
        end
    end
    return nearest
end

local function getNearestPlayer(range)
    local nearest = nil
    local minDist = range or math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
            if dist < minDist then
                minDist = dist
                nearest = plr.Character
            end
        end
    end
    return nearest
end

local function tweenTo(position)
    local tween = TweenService:Create(HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear), {
        CFrame = CFrame.new(position)
    })
    tween:Play()
    tween.Completed:Wait()
end

local function getBosses()
    local bosses = {}
    for _, v in pairs(Workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
            if string.find(v.Name:lower(), "boss") or v.Humanoid.MaxHealth > 5000 then
                table.insert(bosses, v)
            end
        end
    end
    return bosses
end

local function getFruits()
    local fruits = {}
    for _, v in pairs(Workspace:GetChildren()) do
        if string.find(v.Name, "Fruit") and v:IsA("Tool") then
            table.insert(fruits, v)
        end
    end
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Tool") and string.find(v.Name, "Fruit") then
            table.insert(fruits, v)
        end
    end
    return fruits
end

local function clearESP()
    for _, obj in pairs(ESPObjects) do
        pcall(function() obj:Destroy() end)
    end
    ESPObjects = {}
end

local function createESP(target, color, name)
    if not target or not target:IsA("BasePart") then return end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_" .. name
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = color
    textLabel.TextStrokeTransparency = 0
    textLabel.Text = name
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 14
    textLabel.Parent = billboard
    
    billboard.Parent = target
    table.insert(ESPObjects, billboard)
    return billboard
end

-- CREATE MAIN WINDOW
local Window = Fluent:CreateWindow({
    Title = "dkoiHUB 🏴‍☠️",
    SubTitle = "Blox Fruits Premium",
    TabWidth = 160,
    Size = UDim2.fromOffset(600, 500),
    Acrylic = true,
    Theme = "Blood Red",
    MinimizeKey = Enum.KeyCode.RightControl,
    UserInfoTop = true,
    UserInfoTitle = Player.DisplayName,
    UserInfoSubtitle = "🏆 Premium User",
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
local MainSection = MainTab:AddSection("⚔️ Auto Farm")

MainSection:AddToggle("AutoFarm", {
    Title = "Auto Farm Level",
    Default = false,
    Callback = function(value)
        Settings.AutoFarm = value
        if value then
            Fluent:Notify({ Title = "Auto Farm", Content = "Started farming!", Duration = 2 })
            spawn(function()
                while Settings.AutoFarm do
                    task.wait()
                    pcall(function()
                        if not Character or not HumanoidRootPart then return end
                        
                        -- Auto equip melee
                        if Character:FindFirstChildOfClass("Tool") then
                            local tool = Character:FindFirstChildOfClass("Tool")
                            if tool:FindFirstChild("RemoteFunctionShoot") then
                                -- Use gun if equipped
                            end
                        end
                        
                        local enemy = getNearestEnemy(300)
                        if enemy and enemy:FindFirstChild("HumanoidRootPart") then
                            -- Move to enemy
                            local pos = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame:Lerp(pos, 0.5)
                            
                            -- Attack
                            if Settings.AutoAttack then
                                local args = {
                                    [1] = "M1",
                                    [2] = enemy.HumanoidRootPart.Position
                                }
                                pcall(function()
                                    ReplicatedStorage.Remotes.Communication.M1:FireServer(unpack(args))
                                end)
                                task.wait(0.15)
                            end
                            
                            -- Skills
                            if Settings.AutoSkillZ then
                                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
                                task.wait(0.1)
                                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
                            end
                            if Settings.AutoSkillX then
                                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.X, false, game)
                                task.wait(0.1)
                                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.X, false, game)
                            end
                            if Settings.AutoSkillC then
                                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.C, false, game)
                                task.wait(0.1)
                                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.C, false, game)
                            end
                            if Settings.AutoSkillV then
                                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.V, false, game)
                                task.wait(0.1)
                                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.V, false, game)
                            end
                        end
                    end)
                end
            end)
        else
            Fluent:Notify({ Title = "Auto Farm", Content = "Stopped farming!", Duration = 2 })
        end
    end,
})

MainSection:AddToggle("AutoAttack", {
    Title = "Auto Attack (M1)",
    Default = false,
    Callback = function(value)
        Settings.AutoAttack = value
    end,
})

MainSection:AddToggle("AutoHaki", {
    Title = "Auto Haki (Buso)",
    Default = false,
    Callback = function(value)
        Settings.AutoHaki = value
        if value then
            spawn(function()
                while Settings.AutoHaki do
                    task.wait(10)
                    pcall(function()
                        local args = { [1] = "Buso" }
                        ReplicatedStorage.Remotes.Communication.Aura:InvokeServer(unpack(args))
                    end)
                end
            end)
        end
    end,
})

MainSection:AddToggle("AutoSkillZ", {
    Title = "Auto Skill Z",
    Default = false,
    Callback = function(value) Settings.AutoSkillZ = value end,
})

MainSection:AddToggle("AutoSkillX", {
    Title = "Auto Skill X",
    Default = false,
    Callback = function(value) Settings.AutoSkillX = value end,
})

MainSection:AddToggle("AutoSkillC", {
    Title = "Auto Skill C", 
    Default = false,
    Callback = function(value) Settings.AutoSkillC = value end,
})

MainSection:AddToggle("AutoSkillV", {
    Title = "Auto Skill V",
    Default = false,
    Callback = function(value) Settings.AutoSkillV = value end,
})

local BossSection = MainTab:AddSection("👹 Boss Farm")

BossSection:AddToggle("AutoBossFarm", {
    Title = "Auto Boss Farm",
    Default = false,
    Callback = function(value)
        Settings.AutoBossFarm = value
        if value then
            spawn(function()
                while Settings.AutoBossFarm do
                    task.wait()
                    pcall(function()
                        local bosses = getBosses()
                        if #bosses > 0 then
                            local boss = bosses[1]
                            if boss:FindFirstChild("HumanoidRootPart") then
                                local pos = boss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                                HumanoidRootPart.CFrame = HumanoidRootPart.CFrame:Lerp(pos, 0.5)
                                
                                local args = {
                                    [1] = "M1",
                                    [2] = boss.HumanoidRootPart.Position
                                }
                                ReplicatedStorage.Remotes.Communication.M1:FireServer(unpack(args))
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

BossSection:AddToggle("AutoEliteHunter", {
    Title = "Auto Elite Hunter",
    Default = false,
    Callback = function(value)
        Settings.AutoEliteHunter = value
        if value then
            spawn(function()
                while Settings.AutoEliteHunter do
                    task.wait()
                    pcall(function()
                        for _, v in pairs(Workspace.Enemies:GetChildren()) do
                            if v.Name == "Elite Hunter" and v:FindFirstChild("HumanoidRootPart") then
                                local pos = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                                HumanoidRootPart.CFrame = pos
                                
                                local args = { [1] = "M1", [2] = v.HumanoidRootPart.Position }
                                ReplicatedStorage.Remotes.Communication.M1:FireServer(unpack(args))
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

-- ==================== COMBAT TAB ====================
local CombatSection = CombatTab:AddSection("🎯 Combat")

CombatSection:AddToggle("KillAura", {
    Title = "Kill Aura",
    Default = false,
    Callback = function(value)
        Settings.KillAura = value
        if value then
            spawn(function()
                while Settings.KillAura do
                    task.wait(0.1)
                    pcall(function()
                        for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                            if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
                                local dist = (HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                                if dist <= Settings.KillAuraRange then
                                    local args = {
                                        [1] = "M1",
                                        [2] = enemy.HumanoidRootPart.Position
                                    }
                                    ReplicatedStorage.Remotes.Communication.M1:FireServer(unpack(args))
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

CombatSection:AddSlider("KillAuraRange", {
    Title = "Kill Aura Range",
    Default = 50,
    Min = 10,
    Max = 200,
    Rounding = 0,
    Callback = function(value)
        Settings.KillAuraRange = value
    end,
})

CombatSection:AddToggle("HitboxExpand", {
    Title = "Hitbox Expand",
    Default = false,
    Callback = function(value)
        Settings.HitboxExpand = value
        if value then
            spawn(function()
                while Settings.HitboxExpand do
                    task.wait(0.5)
                    pcall(function()
                        for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                            if enemy:FindFirstChild("HumanoidRootPart") then
                                enemy.HumanoidRootPart.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                                enemy.HumanoidRootPart.Transparency = 0.7
                                enemy.HumanoidRootPart.CanCollide = false
                            end
                        end
                    end)
                end
            end)
        else
            -- Reset hitboxes
            pcall(function()
                for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") then
                        enemy.HumanoidRootPart.Size = Vector3.new(2, 2, 2)
                        enemy.HumanoidRootPart.Transparency = 1
                        enemy.HumanoidRootPart.CanCollide = true
                    end
                end
            end)
        end
    end,
})

CombatSection:AddSlider("HitboxSize", {
    Title = "Hitbox Size",
    Default = 10,
    Min = 3,
    Max = 50,
    Rounding = 0,
    Callback = function(value)
        Settings.HitboxSize = value
    end,
})

CombatSection:AddToggle("NoStun", {
    Title = "No Stun",
    Default = false,
    Callback = function(value)
        Settings.NoStun = value
        if value then
            spawn(function()
                while Settings.NoStun do
                    task.wait()
                    pcall(function()
                        if Humanoid then
                            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
                            Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                            Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
                        end
                    end)
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
                    task.wait(5)
                    pcall(function()
                        ReplicatedStorage.Remotes.Communication.Energy:FireServer("Energy")
                    end)
                end
            end)
        end
    end,
})

-- ==================== TELEPORT TAB ====================
local TeleportSection = TeleportTab:AddSection("🌍 Teleport")

-- Island coordinates
local IslandCoords = {
    ["Start Island"] = Vector3.new(1074, 128, 1414),
    ["Marine Start"] = Vector3.new(2565, 125, 2065),
    ["Middle Town"] = Vector3.new(-690, 189, 1218),
    ["Jungle"] = Vector3.new(-1550, 128, 25),
    ["Pirate Village"] = Vector3.new(-1122, 128, 3845),
    ["Desert"] = Vector3.new(870, 127, 4347),
    ["Frozen Village"] = Vector3.new(1175, 360, -5268),
    ["Marine Fortress"] = Vector3.new(-4800, 179, 4322),
    ["Skylands"] = Vector3.new(-4875, 7170, -4425),
    ["Prison"] = Vector3.new(4746, 64, 289),
    ["Colosseum"] = Vector3.new(-1389, 503, -9990),
    ["Magma Village"] = Vector3.new(-5271, 120, 8501),
    ["Underwater City"] = Vector3.new(4100, 64, 1400),
    ["Fountain City"] = Vector3.new(5267, 57, 1656),
    ["Kingdom of Rose"] = Vector3.new(-385, 240, 425),
    ["Green Zone"] = Vector3.new(-2396, 240, 437),
    ["Graveyard"] = Vector3.new(-1948, 458, 5439),
    ["Snow Mountain"] = Vector3.new(2583, 462, 5255),
    ["Hot and Cold"] = Vector3.new(-574, 486, 5754),
    ["Cursed Ship"] = Vector3.new(3623, 534, 4140),
    ["Ice Castle"] = Vector3.new(5252, 549, 5563),
    ["Forgotten Island"] = Vector3.new(-5059, 260, 5183),
    ["Port Town"] = Vector3.new(-269, 249, 5682),
    ["Hydra Island"] = Vector3.new(5492, 388, 4514),
    ["Great Tree"] = Vector3.new(2101, 425, 4784),
    ["Castle on the Sea"] = Vector3.new(-5011, 314, 4419),
    ["Floating Turtle"] = Vector3.new(-1178, 1085, -7599),
    ["Haunted Castle"] = Vector3.new(-7897, 4214, 2127),
    ["Sea of Treats"] = Vector3.new(-2784, 2345, 6753),
}

TeleportSection:AddDropdown("IslandSelect", {
    Title = "Select Island",
    Values = {
        "Start Island", "Marine Start", "Middle Town", "Jungle", "Pirate Village",
        "Desert", "Frozen Village", "Marine Fortress", "Skylands", "Prison",
        "Colosseum", "Magma Village", "Underwater City", "Fountain City",
        "Kingdom of Rose", "Green Zone", "Graveyard", "Snow Mountain",
        "Hot and Cold", "Cursed Ship", "Ice Castle", "Forgotten Island",
        "Port Town", "Hydra Island", "Great Tree", "Castle on the Sea",
        "Floating Turtle", "Haunted Castle", "Sea of Treats"
    },
    Default = "Start Island",
    Multi = false,
    Callback = function(value)
        Settings.SelectedIsland = value
    end,
})

TeleportSection:AddButton({
    Title = "🌴 Tween to Selected Island",
    Callback = function()
        local pos = IslandCoords[Settings.SelectedIsland]
        if pos then
            Fluent:Notify({ Title = "Teleport", Content = "Teleporting to " .. Settings.SelectedIsland, Duration = 2 })
            tweenTo(pos)
        end
    end,
})

TeleportSection:AddButton({
    Title = "👹 Tween to Nearest Boss",
    Callback = function()
        local bosses = getBosses()
        if #bosses > 0 then
            local boss = bosses[1]
            if boss:FindFirstChild("HumanoidRootPart") then
                Fluent:Notify({ Title = "Teleport", Content = "Teleporting to " .. boss.Name, Duration = 2 })
                tweenTo(boss.HumanoidRootPart.Position)
            end
        else
            Fluent:Notify({ Title = "Teleport", Content = "No bosses found!", Duration = 2 })
        end
    end,
})

TeleportSection:AddButton({
    Title = "🍎 Tween to Nearest Fruit",
    Callback = function()
        local fruits = getFruits()
        if #fruits > 0 then
            local fruit = fruits[1]
            local pos = fruit.Handle.Position
            Fluent:Notify({ Title = "Teleport", Content = "Teleporting to " .. fruit.Name, Duration = 2 })
            tweenTo(pos)
        else
            Fluent:Notify({ Title = "Teleport", Content = "No fruits found!", Duration = 2 })
        end
    end,
})

TeleportSection:AddButton({
    Title = "🎁 Tween to Nearest Chest",
    Callback = function()
        local nearest = nil
        local minDist = math.huge
        for _, v in pairs(Workspace:GetDescendants()) do
            if v.Name == "Chest" and v:IsA("BasePart") then
                local dist = (HumanoidRootPart.Position - v.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    nearest = v
                end
            end
        end
        if nearest then
            Fluent:Notify({ Title = "Teleport", Content = "Teleporting to chest!", Duration = 2 })
            tweenTo(nearest.Position)
        else
            Fluent:Notify({ Title = "Teleport", Content = "No chests found!", Duration = 2 })
        end
    end,
})

TeleportSection:AddButton({
    Title = "👤 Tween to Random Player",
    Callback = function()
        local target = getNearestPlayer(math.huge)
        if target then
            Fluent:Notify({ Title = "Teleport", Content = "Teleporting to player!", Duration = 2 })
            tweenTo(target.HumanoidRootPart.Position)
        else
            Fluent:Notify({ Title = "Teleport", Content = "No players found!", Duration = 2 })
        end
    end,
})

-- ==================== WORLD TAB ====================
local WorldSection = WorldTab:AddSection("🌅 World Settings")

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
            Lighting.GlobalShadows = false
        else
            Lighting.Brightness = 2
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

-- ==================== ESP TAB ====================
local ESPSection = ESPTab:AddSection("👁️ ESP Settings")

local function updateESP()
    clearESP()
    
    if Settings.PlayerESP then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= Player and plr.Character and plr.Character:FindFirstChild("Head") then
                createESP(plr.Character.Head, Color3.fromRGB(0, 255, 255), "[Player] " .. plr.Name)
            end
        end
    end
    
    if Settings.NPCESP then
        for _, npc in pairs(Workspace.Enemies:GetChildren()) do
            if npc:FindFirstChild("Head") and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                createESP(npc.Head, Color3.fromRGB(255, 255, 0), "[NPC] " .. npc.Name)
            end
        end
    end
    
    if Settings.BossESP then
        for _, boss in pairs(getBosses()) do
            if boss:FindFirstChild("Head") then
                createESP(boss.Head, Color3.fromRGB(255, 0, 0), "👹 [BOSS] " .. boss.Name)
            end
        end
    end
    
    if Settings.FruitESP then
        for _, fruit in pairs(getFruits()) do
            if fruit:FindFirstChild("Handle") then
                createESP(fruit.Handle, Color3.fromRGB(255, 0, 255), "🍎 " .. fruit.Name)
            end
        end
    end
    
    if Settings.ChestESP then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v.Name == "Chest" and v:IsA("BasePart") then
                createESP(v, Color3.fromRGB(255, 215, 0), "🎁 Chest")
            end
        end
    end
end

ESPSection:AddToggle("PlayerESP", {
    Title = "Player ESP",
    Default = false,
    Callback = function(value)
        Settings.PlayerESP = value
        updateESP()
    end,
})

ESPSection:AddToggle("NPCESP", {
    Title = "NPC ESP",
    Default = false,
    Callback = function(value)
        Settings.NPCESP = value
        updateESP()
    end,
})

ESPSection:AddToggle("BossESP", {
    Title = "Boss ESP",
    Default = false,
    Callback = function(value)
        Settings.BossESP = value
        updateESP()
    end,
})

ESPSection:AddToggle("FruitESP", {
    Title = "Fruit ESP",
    Default = false,
    Callback = function(value)
        Settings.FruitESP = value
        updateESP()
    end,
})

ESPSection:AddToggle("ChestESP", {
    Title = "Chest ESP",
    Default = false,
    Callback = function(value)
        Settings.ChestESP = value
        updateESP()
    end,
})

-- ==================== ITEMS TAB ====================
local ItemsSection = ItemsTab:AddSection("📦 Auto Collect")

ItemsSection:AddToggle("AutoCollectChest", {
    Title = "Auto Collect Chest",
    Default = false,
    Callback = function(value)
        Settings.AutoCollectChest = value
        if value then
            spawn(function()
                while Settings.AutoCollectChest do
                    task.wait(1)
                    pcall(function()
                        for _, v in pairs(Workspace:GetDescendants()) do
                            if v.Name == "Chest" and v:IsA("BasePart") then
                                local dist = (HumanoidRootPart.Position - v.Position).Magnitude
                                if dist < 10 then
                                    fireproximityprompt(v)
                                elseif dist < 500 then
                                    tweenTo(v.Position)
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

ItemsSection:AddToggle("AutoCollectDrops", {
    Title = "Auto Collect Drops",
    Default = false,
    Callback = function(value)
        Settings.AutoCollectDrops = value
        if value then
            spawn(function()
                while Settings.AutoCollectDrops do
                    task.wait(0.5)
                    pcall(function()
                        for _, v in pairs(Workspace:GetDescendants()) do
                            if v:IsA("Tool") and v:FindFirstChild("Handle") then
                                local dist = (HumanoidRootPart.Position - v.Handle.Position).Magnitude
                                if dist < 300 then
                                    tweenTo(v.Handle.Position)
                                    task.wait(0.5)
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

ItemsSection:AddToggle("AutoBoneFarm", {
    Title = "Auto Bone Farm",
    Default = false,
    Callback = function(value)
        Settings.AutoBoneFarm = value
        if value then
            spawn(function()
                while Settings.AutoBoneFarm do
                    task.wait()
                    pcall(function()
                        for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                            if string.find(enemy.Name:lower(), "skeleton") and enemy:FindFirstChild("HumanoidRootPart") then
                                local pos = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                                HumanoidRootPart.CFrame = pos
                                
                                local args = { [1] = "M1", [2] = enemy.HumanoidRootPart.Position }
                                ReplicatedStorage.Remotes.Communication.M1:FireServer(unpack(args))
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

-- ==================== FRUITS TAB ====================
local FruitsSection = FruitsTab:AddSection("🍎 Fruit Options")

FruitsSection:AddToggle("AutoFruitSniper", {
    Title = "Auto Fruit Sniper",
    Default = false,
    Callback = function(value)
        Settings.AutoFruitSniper = value
        if value then
            spawn(function()
                while Settings.AutoFruitSniper do
                    task.wait(2)
                    pcall(function()
                        local fruits = getFruits()
                        for _, fruit in pairs(fruits) do
                            if fruit:FindFirstChild("Handle") then
                                local dist = (HumanoidRootPart.Position - fruit.Handle.Position).Magnitude
                                if dist < 500 then
                                    tweenTo(fruit.Handle.Position)
                                    task.wait(0.3)
                                    -- Pick up fruit
                                    firetouchinterest(HumanoidRootPart, fruit.Handle, 0)
                                    firetouchinterest(HumanoidRootPart, fruit.Handle, 1)
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

FruitsSection:AddToggle("AutoEatFruit", {
    Title = "Auto Eat Fruit",
    Default = false,
    Callback = function(value)
        Settings.AutoEatFruit = value
        if value then
            spawn(function()
                while Settings.AutoEatFruit do
                    task.wait(1)
                    pcall(function()
                        for _, v in pairs(Player.Backpack:GetChildren()) do
                            if v:IsA("Tool") and string.find(v.Name, "Fruit") then
                                Humanoid:EquipTool(v)
                                task.wait(0.5)
                                -- Click to eat
                                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                                task.wait(0.1)
                                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

-- ==================== STATS TAB ====================
local StatsSection = StatsTab:AddSection("📊 Auto Stats")

StatsSection:AddToggle("AutoStats", {
    Title = "Auto Stats (Balanced)",
    Default = false,
    Callback = function(value)
        Settings.AutoStats = value
        if value then
            spawn(function()
                while Settings.AutoStats do
                    task.wait(30)
                    pcall(function()
                        -- Put 3 points in each stat
                        for _, stat in pairs({"Melee", "Defense", "Sword", "Gun", "Demon Fruit"}) do
                            for i = 1, 3 do
                                ReplicatedStorage.Remotes.Communication.Stats:FireServer(stat)
                                task.wait(0.1)
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

for _, stat in pairs({"Melee", "Defense", "Sword", "Gun", "Demon Fruit"}) do
    StatsSection:AddButton({
        Title = "+100 " .. stat .. " Stats",
        Callback = function()
            spawn(function()
                for i = 1, 100 do
                    pcall(function()
                        ReplicatedStorage.Remotes.Communication.Stats:FireServer(stat)
                    end)
                    task.wait(0.01)
                end
                Fluent:Notify({ Title = "Stats", Content = "Added 100 " .. stat .. " points!", Duration = 2 })
            end)
        end,
    })
end

StatsSection:AddButton({
    Title = "🔄 Reset Stats",
    Callback = function()
        Fluent:Notify({ Title = "Stats", Content = "Use in-game code for reset!", Duration = 2 })
    end,
})

-- ==================== PLAYER TAB ====================
local PlayerSection = PlayerTab:AddSection("🏃 Player")

PlayerSection:AddSlider("WalkSpeed", {
    Title = "WalkSpeed",
    Default = 16,
    Min = 16,
    Max = 500,
    Rounding = 0,
    Callback = function(value)
        Settings.WalkSpeed = value
        pcall(function() Humanoid.WalkSpeed = value end)
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
        pcall(function() Humanoid.JumpPower = value end)
    end,
})

PlayerSection:AddToggle("Fly", {
    Title = "Fly (Press E)",
    Default = false,
    Callback = function(value)
        Settings.Fly = value
        if value then
            spawn(function()
                local flySpeed = 50
                local keys = { W = false, S = false, A = false, D = false, E = false, Q = false }
                
                UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if gameProcessed then return end
                    if input.KeyCode == Enum.KeyCode.W then keys.W = true
                    elseif input.KeyCode == Enum.KeyCode.S then keys.S = true
                    elseif input.KeyCode == Enum.KeyCode.A then keys.A = true
                    elseif input.KeyCode == Enum.KeyCode.D then keys.D = true
                    elseif input.KeyCode == Enum.KeyCode.E then keys.E = true
                    elseif input.KeyCode == Enum.KeyCode.Q then keys.Q = true
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.KeyCode == Enum.KeyCode.W then keys.W = false
                    elseif input.KeyCode == Enum.KeyCode.S then keys.S = false
                    elseif input.KeyCode == Enum.KeyCode.A then keys.A = false
                    elseif input.KeyCode == Enum.KeyCode.D then keys.D = false
                    elseif input.KeyCode == Enum.KeyCode.E then keys.E = false
                    elseif input.KeyCode == Enum.KeyCode.Q then keys.Q = false
                    end
                end)
                
                while Settings.Fly do
                    task.wait()
                    pcall(function()
                        if not Character or not HumanoidRootPart then return end
                        Humanoid.PlatformStand = true
                        
                        local direction = Vector3.new(0, 0, 0)
                        if keys.W then direction = direction + workspace.CurrentCamera.CFrame.LookVector
                        elseif keys.S then direction = direction - workspace.CurrentCamera.CFrame.LookVector end
                        if keys.A then direction = direction - workspace.CurrentCamera.CFrame.RightVector
                        elseif keys.D then direction = direction + workspace.CurrentCamera.CFrame.RightVector end
                        if keys.E then direction = direction + Vector3.new(0, 1, 0)
                        elseif keys.Q then direction = direction - Vector3.new(0, 1, 0) end
                        
                        if direction.Magnitude > 0 then
                            HumanoidRootPart.Velocity = direction.Unit * flySpeed
                        else
                            HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                        end
                    end)
                end
                Humanoid.PlatformStand = false
            end)
        end
    end,
})

PlayerSection:AddToggle("NoClip", {
    Title = "No Clip",
    Default = false,
    Callback = function(value)
        Settings.NoClip = value
        spawn(function()
            while Settings.NoClip do
                task.wait()
                pcall(function()
                    if Character then
                        for _, v in pairs(Character:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                    end
                end)
            end
        end)
    end,
})

PlayerSection:AddToggle("InfiniteJump", {
    Title = "Infinite Jump",
    Default = false,
    Callback = function(value)
        Settings.InfiniteJump = value
        if value then
            UserInputService.JumpRequest:Connect(function()
                if Settings.InfiniteJump and Humanoid then
                    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end,
})

PlayerSection:AddToggle("AntiAFK", {
    Title = "Anti AFK (20 min)",
    Default = true,
    Callback = function(value)
        Settings.AntiAFK = value
        if value then
            spawn(function()
                while Settings.AntiAFK do
                    task.wait(600) -- 10 minutes
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end
            end)
        end
    end,
})

-- ==================== SETTINGS TAB ====================
local SettingsSection = SettingsTab:AddSection("⚙️ Performance")

SettingsSection:AddToggle("FPSBoost", {
    Title = "FPS Boost",
    Default = false,
    Callback = function(value)
        Settings.FPSBoost = value
        if value then
            pcall(function()
                settings().Rendering.QualityLevel = 1
                Lighting.GlobalShadows = false
                Lighting.Brightness = 1
                
                for _, v in pairs(Workspace:GetDescendants()) do
                    if v:IsA("Part") or v:IsA("MeshPart") then
                        v.Material = Enum.Material.SmoothPlastic
                        v.Reflectance = 0
                    end
                    if v:IsA("Texture") or v:IsA("Decal") then
                        v:Destroy()
                    end
                end
            end)
        end
    end,
})

-- ==================== MISC TAB ====================
local MiscSection = MiscTab:AddSection("🔧 Utilities")

MiscSection:AddButton({
    Title = "🔄 Server Hop",
    Callback = function()
        Fluent:Notify({ Title = "Server", Content = "Searching for new server...", Duration = 2 })
        spawn(function()
            pcall(function()
                local servers = HttpService:JSONDecode(
                    game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100")
                )
                for _, server in pairs(servers.data) do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, Player)
                        return
                    end
                end
                Fluent:Notify({ Title = "Server", Content = "No available servers found!", Duration = 2 })
            end)
        end)
    end,
})

MiscSection:AddButton({
    Title = "🔁 Rejoin Server",
    Callback = function()
        Fluent:Notify({ Title = "Server", Content = "Rejoining...", Duration = 2 })
        task.wait(1)
        TeleportService:Teleport(game.PlaceId, Player)
    end,
})

MiscSection:AddButton({
    Title = "👻 Rejoin (Low Player Server)",
    Callback = function()
        Fluent:Notify({ Title = "Server", Content = "Searching for empty server...", Duration = 2 })
        spawn(function()
            pcall(function()
                local servers = HttpService:JSONDecode(
                    game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100&sortOrder=1")
                )
                for _, server in pairs(servers.data) do
                    if server.playing < 5 and server.id ~= game.JobId then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, Player)
                        return
                    end
                end
                Fluent:Notify({ Title = "Server", Content = "No low player servers found!", Duration = 2 })
            end)
        end)
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
OpenBtn.Size = UDim2.fromOffset(60, 60)
OpenBtn.Position = UDim2.new(0.85, 0, 0.85, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(180, 10, 20)
OpenBtn.BackgroundTransparency = 0.15
OpenBtn.Text = "dkoi\nHUB"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.TextScaled = true
OpenBtn.Font = Enum.Font.GothamBlack
OpenBtn.Parent = OpenGui
OpenBtn.BorderSizePixel = 0
OpenBtn.ZIndex = 10

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0.5, 0)
Corner.Parent = OpenBtn

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(255, 255, 255)
Stroke.Thickness = 2
Stroke.Parent = OpenBtn

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
    Title = "🏴‍☠️ dkoiHUB",
    Content = "Script loaded! Press Right CTRL to toggle UI",
    Duration = 5,
})

Window:SelectTab(1)

-- Character respawn handler
Player.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
    
    -- Reapply settings
    task.wait(1)
    if Settings.WalkSpeed ~= 16 then
        Humanoid.WalkSpeed = Settings.WalkSpeed
    end
    if Settings.JumpPower ~= 50 then
        Humanoid.JumpPower = Settings.JumpPower
    end
    
    Fluent:Notify({ Title = "dkoiHUB", Content = "Character respawned! Settings reapplied.", Duration = 2 })
end)

-- ESP Update Loop
spawn(function()
    while task.wait(5) do
        if Settings.PlayerESP or Settings.NPCESP or Settings.BossESP or Settings.FruitESP or Settings.ChestESP then
            updateESP()
        end
    end
end)

print("✅ dkoiHUB v2 - Working Version Loaded!")
