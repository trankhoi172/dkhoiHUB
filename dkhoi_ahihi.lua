--[[
    dkoiHUB - Blox Fruits Premium Script
    Credits: Panda Hub functions adapted
    Mobile optimized UI
]]

loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/refs/heads/main/attack-module.lua"))()

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
local Stats = game:GetService("Stats")

-- Player Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Managers
local SaveManager = Fluent.SaveManager
local InterfaceManager = Fluent.InterfaceManager
local FloatingButtonManager = Fluent.FloatingButtonManager

-- ==================== PANDA HUB FUNCTIONS ====================
local function EquipWeapon(name)
    if not name then return end
    if Player.Backpack:FindFirstChild(name) then
        Player.Character.Humanoid:EquipTool(Player.Backpack:FindFirstChild(name))
    end
end

local function weaponSc(toolTip)
    for _, tool in pairs(Player.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.ToolTip == toolTip then
            EquipWeapon(tool.Name)
        end
    end
end

local function UsesKills(category, key)
    if category == "Melee" then
        weaponSc("Melee")
    elseif category == "Sword" then
        weaponSc("Sword")
    elseif category == "Blox Fruit" then
        weaponSc("Blox Fruit")
    elseif category == "Gun" then
        weaponSc("Gun")
    end
    VirtualInputManager:SendKeyEvent(true, key, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end

local function GetConnectionEnemies(name)
    for _, v in pairs(ReplicatedStorage:GetChildren()) do
        if v:IsA("Model") and v.Name == name and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            return v
        end
    end
    for _, v in pairs(Workspace.Enemies:GetChildren()) do
        if v:IsA("Model") and v.Name == name and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            return v
        end
    end
end

local function CheckQuest()
    local MyLevel = Player.Data.Level.Value
    local questData = {
        NameQuest = "",
        LevelQuest = 1,
        NameMon = "",
        CFrameQuest = CFrame.new(),
        CFrameMon = CFrame.new(),
    }
    
    if game.PlaceId == 2753915549 or game.PlaceId == 85211729168715 then -- First Sea
        if MyLevel >= 1 and MyLevel <= 9 then
            questData.NameQuest = "BanditQuest1"
            questData.NameMon = "Bandit"
            questData.CFrameQuest = CFrame.new(1059.37, 15.45, 1550.42)
            questData.CFrameMon = CFrame.new(1045.96, 27.00, 1560.82)
        elseif MyLevel >= 10 and MyLevel <= 14 then
            questData.NameQuest = "JungleQuest"
            questData.NameMon = "Monkey"
            questData.CFrameQuest = CFrame.new(-1598.09, 35.55, 153.38)
            questData.CFrameMon = CFrame.new(-1448.52, 67.85, 11.47)
        elseif MyLevel >= 15 and MyLevel <= 29 then
            questData.NameQuest = "JungleQuest"
            questData.NameMon = "Gorilla"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-1598.09, 35.55, 153.38)
            questData.CFrameMon = CFrame.new(-1129.88, 40.46, -525.42)
        elseif MyLevel >= 30 and MyLevel <= 39 then
            questData.NameQuest = "BuggyQuest1"
            questData.NameMon = "Pirate"
            questData.CFrameQuest = CFrame.new(-1141.07, 4.10, 3831.55)
            questData.CFrameMon = CFrame.new(-1103.51, 13.75, 3896.09)
        elseif MyLevel >= 40 and MyLevel <= 59 then
            questData.NameQuest = "BuggyQuest1"
            questData.NameMon = "Brute"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-1141.07, 4.10, 3831.55)
            questData.CFrameMon = CFrame.new(-1140.08, 14.81, 4322.92)
        elseif MyLevel >= 60 and MyLevel <= 74 then
            questData.NameQuest = "DesertQuest"
            questData.NameMon = "Desert Bandit"
            questData.CFrameQuest = CFrame.new(894.49, 5.14, 4392.43)
            questData.CFrameMon = CFrame.new(924.80, 6.45, 4481.59)
        elseif MyLevel >= 75 and MyLevel <= 89 then
            questData.NameQuest = "DesertQuest"
            questData.NameMon = "Desert Officer"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(894.49, 5.14, 4392.43)
            questData.CFrameMon = CFrame.new(1608.28, 8.61, 4371.01)
        elseif MyLevel >= 90 and MyLevel <= 99 then
            questData.NameQuest = "SnowQuest"
            questData.NameMon = "Snow Bandit"
            questData.CFrameQuest = CFrame.new(1389.74, 88.15, -1298.91)
            questData.CFrameMon = CFrame.new(1354.35, 87.27, -1393.95)
        elseif MyLevel >= 100 and MyLevel <= 119 then
            questData.NameQuest = "SnowQuest"
            questData.NameMon = "Snowman"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(1389.74, 88.15, -1298.91)
            questData.CFrameMon = CFrame.new(1201.64, 144.58, -1550.07)
        elseif MyLevel >= 120 and MyLevel <= 149 then
            questData.NameQuest = "MarineQuest2"
            questData.NameMon = "Chief Petty Officer"
            questData.CFrameQuest = CFrame.new(-5039.59, 27.35, 4324.68)
            questData.CFrameMon = CFrame.new(-4881.23, 22.65, 4273.75)
        elseif MyLevel >= 150 and MyLevel <= 174 then
            questData.NameQuest = "SkyQuest"
            questData.NameMon = "Sky Bandit"
            questData.CFrameQuest = CFrame.new(-4839.53, 716.37, -2619.44)
            questData.CFrameMon = CFrame.new(-4953.21, 295.74, -2899.23)
        elseif MyLevel >= 175 and MyLevel <= 189 then
            questData.NameQuest = "SkyQuest"
            questData.NameMon = "Dark Master"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-4839.53, 716.37, -2619.44)
            questData.CFrameMon = CFrame.new(-5259.84, 391.40, -2229.04)
        elseif MyLevel >= 190 and MyLevel <= 209 then
            questData.NameQuest = "PrisonerQuest"
            questData.NameMon = "Prisoner"
            questData.CFrameQuest = CFrame.new(5308.93, 1.66, 475.12)
            questData.CFrameMon = CFrame.new(5098.97, -0.32, 474.24)
        elseif MyLevel >= 210 and MyLevel <= 249 then
            questData.NameQuest = "PrisonerQuest"
            questData.NameMon = "Dangerous Prisoner"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(5308.93, 1.66, 475.12)
            questData.CFrameMon = CFrame.new(5654.56, 15.63, 866.30)
        elseif MyLevel >= 250 and MyLevel <= 274 then
            questData.NameQuest = "ColosseumQuest"
            questData.NameMon = "Toga Warrior"
            questData.CFrameQuest = CFrame.new(-1580.05, 6.35, -2986.48)
            questData.CFrameMon = CFrame.new(-1820.21, 51.68, -2740.67)
        elseif MyLevel >= 275 and MyLevel <= 299 then
            questData.NameQuest = "ColosseumQuest"
            questData.NameMon = "Gladiator"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-1580.05, 6.35, -2986.48)
            questData.CFrameMon = CFrame.new(-1292.84, 56.38, -3339.03)
        elseif MyLevel >= 300 and MyLevel <= 324 then
            questData.NameQuest = "MagmaQuest"
            questData.NameMon = "Military Soldier"
            questData.CFrameQuest = CFrame.new(-5313.37, 10.95, 8515.29)
            questData.CFrameMon = CFrame.new(-5411.16, 11.08, 8454.29)
        elseif MyLevel >= 325 and MyLevel <= 374 then
            questData.NameQuest = "MagmaQuest"
            questData.NameMon = "Military Spy"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-5313.37, 10.95, 8515.29)
            questData.CFrameMon = CFrame.new(-5802.87, 86.26, 8828.86)
        elseif MyLevel >= 375 and MyLevel <= 399 then
            questData.NameQuest = "FishmanQuest"
            questData.NameMon = "Fishman Warrior"
            questData.CFrameQuest = CFrame.new(61122.65, 18.50, 1569.40)
            questData.CFrameMon = CFrame.new(60878.30, 18.48, 1543.76)
        elseif MyLevel >= 400 and MyLevel <= 449 then
            questData.NameQuest = "FishmanQuest"
            questData.NameMon = "Fishman Commando"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(61122.65, 18.50, 1569.40)
            questData.CFrameMon = CFrame.new(61922.63, 18.48, 1493.93)
        elseif MyLevel >= 450 and MyLevel <= 474 then
            questData.NameQuest = "SkyExp1Quest"
            questData.NameMon = "God's Guard"
            questData.CFrameQuest = CFrame.new(-4721.89, 843.87, -1949.97)
            questData.CFrameMon = CFrame.new(-4710.04, 845.28, -1927.31)
        elseif MyLevel >= 475 and MyLevel <= 524 then
            questData.NameQuest = "SkyExp1Quest"
            questData.NameMon = "Shanda"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-7859.10, 5544.19, -381.48)
            questData.CFrameMon = CFrame.new(-7678.49, 5566.40, -497.22)
        elseif MyLevel >= 525 and MyLevel <= 549 then
            questData.NameQuest = "SkyExp2Quest"
            questData.NameMon = "Royal Squad"
            questData.CFrameQuest = CFrame.new(-7906.82, 5634.66, -1411.99)
            questData.CFrameMon = CFrame.new(-7624.25, 5658.13, -1467.35)
        elseif MyLevel >= 550 and MyLevel <= 624 then
            questData.NameQuest = "SkyExp2Quest"
            questData.NameMon = "Royal Soldier"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-7906.82, 5634.66, -1411.99)
            questData.CFrameMon = CFrame.new(-7836.75, 5645.66, -1790.62)
        elseif MyLevel >= 625 and MyLevel <= 649 then
            questData.NameQuest = "FountainQuest"
            questData.NameMon = "Galley Pirate"
            questData.CFrameQuest = CFrame.new(5259.82, 37.35, 4050.03)
            questData.CFrameMon = CFrame.new(5551.02, 78.90, 3930.41)
        elseif MyLevel >= 650 then
            questData.NameQuest = "FountainQuest"
            questData.NameMon = "Galley Captain"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(5259.82, 37.35, 4050.03)
            questData.CFrameMon = CFrame.new(5441.95, 42.50, 4950.09)
        end
    elseif game.PlaceId == 4442272183 or game.PlaceId == 79091703265657 then -- Second Sea
        if MyLevel >= 700 and MyLevel <= 724 then
            questData.NameQuest = "Area1Quest"
            questData.NameMon = "Raider"
            questData.CFrameQuest = CFrame.new(-429.54, 71.77, 1836.18)
            questData.CFrameMon = CFrame.new(-728.33, 52.78, 2345.77)
        elseif MyLevel >= 725 and MyLevel <= 774 then
            questData.NameQuest = "Area1Quest"
            questData.NameMon = "Mercenary"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-429.54, 71.77, 1836.18)
            questData.CFrameMon = CFrame.new(-1004.32, 80.16, 1424.62)
        elseif MyLevel >= 775 and MyLevel <= 799 then
            questData.NameQuest = "Area2Quest"
            questData.NameMon = "Swan Pirate"
            questData.CFrameQuest = CFrame.new(638.44, 71.77, 918.28)
            questData.CFrameMon = CFrame.new(1068.66, 137.61, 1322.11)
        elseif MyLevel >= 800 and MyLevel <= 874 then
            questData.NameQuest = "Area2Quest"
            questData.NameMon = "Factory Staff"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(632.70, 73.11, 918.67)
            questData.CFrameMon = CFrame.new(73.08, 81.86, -27.47)
        elseif MyLevel >= 875 and MyLevel <= 899 then
            questData.NameQuest = "MarineQuest3"
            questData.NameMon = "Marine Lieutenant"
            questData.CFrameQuest = CFrame.new(-2440.80, 71.71, -3216.07)
            questData.CFrameMon = CFrame.new(-2821.37, 75.90, -3070.09)
        elseif MyLevel >= 900 and MyLevel <= 949 then
            questData.NameQuest = "MarineQuest3"
            questData.NameMon = "Marine Captain"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-2440.80, 71.71, -3216.07)
            questData.CFrameMon = CFrame.new(-1861.23, 80.18, -3254.70)
        elseif MyLevel >= 950 and MyLevel <= 974 then
            questData.NameQuest = "ZombieQuest"
            questData.NameMon = "Zombie"
            questData.CFrameQuest = CFrame.new(-5497.06, 47.59, -795.24)
            questData.CFrameMon = CFrame.new(-5657.78, 78.97, -928.69)
        elseif MyLevel >= 975 and MyLevel <= 999 then
            questData.NameQuest = "ZombieQuest"
            questData.NameMon = "Vampire"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-5497.06, 47.59, -795.24)
            questData.CFrameMon = CFrame.new(-6037.67, 32.18, -1340.66)
        elseif MyLevel >= 1000 and MyLevel <= 1049 then
            questData.NameQuest = "SnowMountainQuest"
            questData.NameMon = "Snow Trooper"
            questData.CFrameQuest = CFrame.new(609.86, 400.12, -5372.26)
            questData.CFrameMon = CFrame.new(549.15, 427.39, -5563.70)
        elseif MyLevel >= 1050 and MyLevel <= 1099 then
            questData.NameQuest = "SnowMountainQuest"
            questData.NameMon = "Winter Warrior"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(609.86, 400.12, -5372.26)
            questData.CFrameMon = CFrame.new(1142.75, 475.64, -5199.42)
        elseif MyLevel >= 1100 and MyLevel <= 1124 then
            questData.NameQuest = "IceSideQuest"
            questData.NameMon = "Lab Subordinate"
            questData.CFrameQuest = CFrame.new(-6064.07, 15.24, -4902.98)
            questData.CFrameMon = CFrame.new(-5707.47, 15.95, -4513.39)
        elseif MyLevel >= 1125 and MyLevel <= 1174 then
            questData.NameQuest = "IceSideQuest"
            questData.NameMon = "Horned Warrior"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-6064.07, 15.24, -4902.98)
            questData.CFrameMon = CFrame.new(-6341.37, 15.95, -5723.16)
        elseif MyLevel >= 1175 and MyLevel <= 1199 then
            questData.NameQuest = "FireSideQuest"
            questData.NameMon = "Magma Ninja"
            questData.CFrameQuest = CFrame.new(-5428.03, 15.06, -5299.43)
            questData.CFrameMon = CFrame.new(-5449.67, 76.66, -5808.20)
        elseif MyLevel >= 1200 and MyLevel <= 1249 then
            questData.NameQuest = "FireSideQuest"
            questData.NameMon = "Lava Pirate"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-5428.03, 15.06, -5299.43)
            questData.CFrameMon = CFrame.new(-5213.33, 49.74, -4701.45)
        elseif MyLevel >= 1250 and MyLevel <= 1274 then
            questData.NameQuest = "ShipQuest1"
            questData.NameMon = "Ship Deckhand"
            questData.CFrameQuest = CFrame.new(1037.80, 125.09, 32911.60)
            questData.CFrameMon = CFrame.new(1212.01, 150.79, 33059.25)
        elseif MyLevel >= 1275 and MyLevel <= 1299 then
            questData.NameQuest = "ShipQuest1"
            questData.NameMon = "Ship Engineer"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(1037.80, 125.09, 32911.60)
            questData.CFrameMon = CFrame.new(919.48, 43.54, 32779.97)
        elseif MyLevel >= 1300 and MyLevel <= 1324 then
            questData.NameQuest = "ShipQuest2"
            questData.NameMon = "Ship Steward"
            questData.CFrameQuest = CFrame.new(968.81, 125.09, 33244.13)
            questData.CFrameMon = CFrame.new(919.44, 129.56, 33436.04)
        elseif MyLevel >= 1325 and MyLevel <= 1349 then
            questData.NameQuest = "ShipQuest2"
            questData.NameMon = "Ship Officer"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(968.81, 125.09, 33244.13)
            questData.CFrameMon = CFrame.new(1036.02, 181.44, 33315.73)
        elseif MyLevel >= 1350 and MyLevel <= 1374 then
            questData.NameQuest = "FrostQuest"
            questData.NameMon = "Arctic Warrior"
            questData.CFrameQuest = CFrame.new(5667.66, 26.80, -6486.09)
            questData.CFrameMon = CFrame.new(5966.25, 62.97, -6179.38)
        elseif MyLevel >= 1375 and MyLevel <= 1424 then
            questData.NameQuest = "FrostQuest"
            questData.NameMon = "Snow Lurker"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(5667.66, 26.80, -6486.09)
            questData.CFrameMon = CFrame.new(5407.07, 69.19, -6880.88)
        elseif MyLevel >= 1425 and MyLevel <= 1449 then
            questData.NameQuest = "ForgottenQuest"
            questData.NameMon = "Sea Soldier"
            questData.CFrameQuest = CFrame.new(-3054.44, 235.54, -10142.82)
            questData.CFrameMon = CFrame.new(-3028.22, 64.67, -9775.43)
        elseif MyLevel >= 1450 then
            questData.NameQuest = "ForgottenQuest"
            questData.NameMon = "Water Fighter"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-3054, 240, -10146)
            questData.CFrameMon = CFrame.new(-3291, 252, -10501)
        end
    elseif game.PlaceId == 7449423635 or game.PlaceId == 100117331123089 then -- Third Sea
        if MyLevel >= 1500 and MyLevel <= 1524 then
            questData.NameQuest = "PiratePortQuest"
            questData.NameMon = "Pirate Millionaire"
            questData.CFrameQuest = CFrame.new(-290.07, 42.90, 5581.59)
            questData.CFrameMon = CFrame.new(-246.00, 47.31, 5584.10)
        elseif MyLevel >= 1525 and MyLevel <= 1574 then
            questData.NameQuest = "PiratePortQuest"
            questData.NameMon = "Pistol Billionaire"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-290.07, 42.90, 5581.59)
            questData.CFrameMon = CFrame.new(-187.33, 86.24, 6013.51)
        elseif MyLevel >= 1575 and MyLevel <= 1599 then
            questData.NameQuest = "DragonCrewQuest"
            questData.NameMon = "Dragon Crew Warrior"
            questData.CFrameQuest = CFrame.new(6738.96, 127.82, -713.51)
            questData.CFrameMon = CFrame.new(6920.71, 56.16, -942.50)
        elseif MyLevel >= 1600 and MyLevel <= 1624 then
            questData.NameQuest = "DragonCrewQuest"
            questData.NameMon = "Dragon Crew Archer"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(6738.96, 127.82, -713.51)
            questData.CFrameMon = CFrame.new(6817.91, 484.80, 513.41)
        elseif MyLevel >= 1625 and MyLevel <= 1649 then
            questData.NameQuest = "VenomCrewQuest"
            questData.NameMon = "Hydra Enforcer"
            questData.CFrameQuest = CFrame.new(5213.87, 1004.50, 758.69)
            questData.CFrameMon = CFrame.new(4584.69, 1002.64, 705.80)
        elseif MyLevel >= 1650 and MyLevel <= 1699 then
            questData.NameQuest = "VenomCrewQuest"
            questData.NameMon = "Venomous Assailant"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(5213.87, 1004.50, 758.69)
            questData.CFrameMon = CFrame.new(4638.79, 1078.94, 881.80)
        elseif MyLevel >= 1700 and MyLevel <= 1724 then
            questData.NameQuest = "MarineTreeIsland"
            questData.NameMon = "Marine Commodore"
            questData.CFrameQuest = CFrame.new(2180.54, 27.82, -6741.55)
            questData.CFrameMon = CFrame.new(2286.01, 73.13, -7159.81)
        elseif MyLevel >= 1725 and MyLevel <= 1774 then
            questData.NameQuest = "MarineTreeIsland"
            questData.NameMon = "Marine Rear Admiral"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(2179.99, 28.73, -6740.06)
            questData.CFrameMon = CFrame.new(3656.77, 160.52, -7001.60)
        elseif MyLevel >= 1775 and MyLevel <= 1799 then
            questData.NameQuest = "DeepForestIsland3"
            questData.NameMon = "Fishman Raider"
            questData.CFrameQuest = CFrame.new(-10581.66, 330.87, -8761.19)
            questData.CFrameMon = CFrame.new(-10407.53, 331.76, -8368.52)
        elseif MyLevel >= 1800 and MyLevel <= 1824 then
            questData.NameQuest = "DeepForestIsland3"
            questData.NameMon = "Fishman Captain"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-10581.66, 330.87, -8761.19)
            questData.CFrameMon = CFrame.new(-10994.70, 352.38, -9002.11)
        elseif MyLevel >= 1825 and MyLevel <= 1849 then
            questData.NameQuest = "DeepForestIsland"
            questData.NameMon = "Forest Pirate"
            questData.CFrameQuest = CFrame.new(-13234.04, 331.49, -7625.40)
            questData.CFrameMon = CFrame.new(-13274.48, 332.38, -7769.58)
        elseif MyLevel >= 1850 and MyLevel <= 1899 then
            questData.NameQuest = "DeepForestIsland"
            questData.NameMon = "Mythological Pirate"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-13234.04, 331.49, -7625.40)
            questData.CFrameMon = CFrame.new(-13680.61, 501.08, -6991.19)
        elseif MyLevel >= 1900 and MyLevel <= 1924 then
            questData.NameQuest = "DeepForestIsland2"
            questData.NameMon = "Jungle Pirate"
            questData.CFrameQuest = CFrame.new(-12680.38, 389.97, -9902.02)
            questData.CFrameMon = CFrame.new(-12256.16, 331.74, -10485.84)
        elseif MyLevel >= 1925 and MyLevel <= 1974 then
            questData.NameQuest = "DeepForestIsland2"
            questData.NameMon = "Musketeer Pirate"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-12680.38, 389.97, -9902.02)
            questData.CFrameMon = CFrame.new(-13457.90, 391.55, -9859.18)
        elseif MyLevel >= 1975 and MyLevel <= 1999 then
            questData.NameQuest = "HauntedQuest1"
            questData.NameMon = "Reborn Skeleton"
            questData.CFrameQuest = CFrame.new(-9479.22, 141.22, 5566.09)
            questData.CFrameMon = CFrame.new(-8763.72, 165.72, 6159.86)
        elseif MyLevel >= 2000 and MyLevel <= 2024 then
            questData.NameQuest = "HauntedQuest1"
            questData.NameMon = "Living Zombie"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-9479.22, 141.22, 5566.09)
            questData.CFrameMon = CFrame.new(-10144.13, 138.63, 5838.09)
        elseif MyLevel >= 2025 and MyLevel <= 2049 then
            questData.NameQuest = "HauntedQuest2"
            questData.NameMon = "Demonic Soul"
            questData.CFrameQuest = CFrame.new(-9516.99, 172.02, 6078.47)
            questData.CFrameMon = CFrame.new(-9505.87, 172.10, 6158.99)
        elseif MyLevel >= 2050 and MyLevel <= 2074 then
            questData.NameQuest = "HauntedQuest2"
            questData.NameMon = "Posessed Mummy"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-9516.99, 172.02, 6078.47)
            questData.CFrameMon = CFrame.new(-9582.02, 6.25, 6205.48)
        elseif MyLevel >= 2075 and MyLevel <= 2099 then
            questData.NameQuest = "NutsIslandQuest"
            questData.NameMon = "Peanut Scout"
            questData.CFrameQuest = CFrame.new(-2104.39, 38.10, -10194.22)
            questData.CFrameMon = CFrame.new(-2143.24, 47.72, -10030.00)
        elseif MyLevel >= 2100 and MyLevel <= 2124 then
            questData.NameQuest = "NutsIslandQuest"
            questData.NameMon = "Peanut President"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-2104.39, 38.10, -10194.22)
            questData.CFrameMon = CFrame.new(-1859.35, 38.10, -10422.43)
        elseif MyLevel >= 2125 and MyLevel <= 2149 then
            questData.NameQuest = "IceCreamIslandQuest"
            questData.NameMon = "Ice Cream Chef"
            questData.CFrameQuest = CFrame.new(-820.65, 65.82, -10965.80)
            questData.CFrameMon = CFrame.new(-872.25, 65.82, -10919.96)
        elseif MyLevel >= 2150 and MyLevel <= 2199 then
            questData.NameQuest = "IceCreamIslandQuest"
            questData.NameMon = "Ice Cream Commander"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-820.65, 65.82, -10965.80)
            questData.CFrameMon = CFrame.new(-558.06, 112.05, -11290.77)
        elseif MyLevel >= 2200 and MyLevel <= 2224 then
            questData.NameQuest = "CakeQuest1"
            questData.NameMon = "Cookie Crafter"
            questData.CFrameQuest = CFrame.new(-2021.32, 37.80, -12028.73)
            questData.CFrameMon = CFrame.new(-2374.14, 37.80, -12125.31)
        elseif MyLevel >= 2225 and MyLevel <= 2249 then
            questData.NameQuest = "CakeQuest1"
            questData.NameMon = "Cake Guard"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-2021.32, 37.80, -12028.73)
            questData.CFrameMon = CFrame.new(-1598.31, 43.77, -12244.58)
        elseif MyLevel >= 2250 and MyLevel <= 2274 then
            questData.NameQuest = "CakeQuest2"
            questData.NameMon = "Baking Staff"
            questData.CFrameQuest = CFrame.new(-1927.92, 37.80, -12842.54)
            questData.CFrameMon = CFrame.new(-1887.81, 77.62, -12998.35)
        elseif MyLevel >= 2275 and MyLevel <= 2299 then
            questData.NameQuest = "CakeQuest2"
            questData.NameMon = "Head Baker"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-1927.92, 37.80, -12842.54)
            questData.CFrameMon = CFrame.new(-2216.19, 82.88, -12869.29)
        elseif MyLevel >= 2300 and MyLevel <= 2324 then
            questData.NameQuest = "ChocQuest1"
            questData.NameMon = "Cocoa Warrior"
            questData.CFrameQuest = CFrame.new(233.23, 29.88, -12201.23)
            questData.CFrameMon = CFrame.new(-21.55, 80.57, -12352.39)
        elseif MyLevel >= 2325 and MyLevel <= 2349 then
            questData.NameQuest = "ChocQuest1"
            questData.NameMon = "Chocolate Bar Battler"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(233.23, 29.88, -12201.23)
            questData.CFrameMon = CFrame.new(582.59, 77.19, -12463.16)
        elseif MyLevel >= 2350 and MyLevel <= 2374 then
            questData.NameQuest = "ChocQuest2"
            questData.NameMon = "Sweet Thief"
            questData.CFrameQuest = CFrame.new(150.51, 30.69, -12774.50)
            questData.CFrameMon = CFrame.new(165.19, 76.06, -12600.84)
        elseif MyLevel >= 2375 and MyLevel <= 2399 then
            questData.NameQuest = "ChocQuest2"
            questData.NameMon = "Candy Rebel"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(150.51, 30.69, -12774.50)
            questData.CFrameMon = CFrame.new(134.87, 77.25, -12876.55)
        elseif MyLevel >= 2400 and MyLevel <= 2424 then
            questData.NameQuest = "CandyQuest1"
            questData.NameMon = "Candy Pirate"
            questData.CFrameQuest = CFrame.new(-1150.04, 20.38, -14446.33)
            questData.CFrameMon = CFrame.new(-1310.50, 26.02, -14562.40)
        elseif MyLevel >= 2425 and MyLevel <= 2449 then
            questData.NameQuest = "CandyQuest1"
            questData.NameMon = "Snow Demon"
            questData.LevelQuest = 2
            questData.CFrameQuest = CFrame.new(-1150.04, 20.38, -14446.33)
            questData.CFrameMon = CFrame.new(-880.20, 71.25, -14538.61)
        end
    end
    
    return questData
end

-- ==================== MAIN WINDOW (Mobile Optimized) ====================
local Window = Fluent:CreateWindow({
    Title = "dkoiHUB 🏴‍☠️",
    SubTitle = "One Piece | Premium",
    TabWidth = 120,
    Size = UDim2.fromOffset(420, 400),
    Acrylic = true,
    Theme = "Blood Red",
    MinimizeKey = Enum.KeyCode.RightControl,
    UserInfoTop = true,
    UserInfoTitle = Player.DisplayName,
    UserInfoSubtitle = "⚡ Premium User",
    UserInfoColor = Color3.fromRGB(255, 50, 50),
    Search = true,
})

-- ==================== TABS ====================
local MainTab = Window:AddTab({ Title = "🏠 Main", Icon = "home" })
local CombatTab = Window:AddTab({ Title = "⚔️ Combat", Icon = "swords" })
local TeleportTab = Window:AddTab({ Title = "🌍 TP", Icon = "map-pin" })
local PlayerTab = Window:AddTab({ Title = "🏃 Player", Icon = "user" })
local SettingsTab = Window:AddTab({ Title = "⚙️ Settings", Icon = "settings" })

-- ==================== MAIN TAB ====================
local MainSection = MainTab:AddSection("Auto Farm")

MainSection:AddToggle("AutoFarm", {
    Title = "Auto Farm Level",
    Default = false,
    Callback = function(value)
        _G.Level = value
        if value then
            Fluent:Notify({ Title = "Farm", Content = "Auto Farm Started!", Duration = 2 })
        end
    end,
})

-- ==================== COMBAT TAB ====================
local CombatSection = CombatTab:AddSection("Combat")

CombatSection:AddToggle("FastAttack", {
    Title = "Fast Attack",
    Default = false,
    Callback = function(value)
        if value then
            spawn(function()
                while value do
                    task.wait(0.05)
                    pcall(function()
                        ReplicatedStorage.Remotes.Communication.M1:FireServer("M1", Player.Character.HumanoidRootPart.Position)
                    end)
                end
            end)
        end
    end,
})

CombatSection:AddToggle("AutoHaki", {
    Title = "Auto Buso Haki",
    Default = false,
    Callback = function(value)
        if value then
            spawn(function()
                while value do
                    task.wait(10)
                    pcall(function()
                        ReplicatedStorage.Remotes.Communication.Aura:InvokeServer("Buso")
                    end)
                end
            end)
        end
    end,
})

-- ==================== TELEPORT TAB ====================
local TPSection = TeleportTab:AddSection("Teleports")

TPSection:AddButton({
    Title = "TP to Quest",
    Callback = function()
        local questData = CheckQuest()
        if questData.CFrameQuest then
            Player.Character.HumanoidRootPart.CFrame = questData.CFrameQuest
            Fluent:Notify({ Title = "TP", Content = "Teleported to Quest NPC!", Duration = 2 })
        end
    end,
})

TPSection:AddButton({
    Title = "TP to Enemy",
    Callback = function()
        local questData = CheckQuest()
        if questData.CFrameMon then
            Player.Character.HumanoidRootPart.CFrame = questData.CFrameMon
            Fluent:Notify({ Title = "TP", Content = "Teleported to Enemy!", Duration = 2 })
        end
    end,
})

-- ==================== PLAYER TAB ====================
local PlayerSection = PlayerTab:AddSection("Player")

PlayerSection:AddSlider("WalkSpeed", {
    Title = "WalkSpeed",
    Default = 16,
    Min = 16,
    Max = 350,
    Rounding = 0,
    Callback = function(value)
        pcall(function() Humanoid.WalkSpeed = value end)
    end,
})

PlayerSection:AddSlider("JumpPower", {
    Title = "Jump Power",
    Default = 50,
    Min = 50,
    Max = 350,
    Rounding = 0,
    Callback = function(value)
        pcall(function() Humanoid.JumpPower = value end)
    end,
})

PlayerSection:AddToggle("AntiAFK", {
    Title = "Anti AFK",
    Default = true,
    Callback = function(value)
        if value then
            spawn(function()
                while value do
                    task.wait(300)
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end
            end)
        end
    end,
})

-- ==================== SETTINGS TAB ====================
local SettingsSection = SettingsTab:AddSection("Config")

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

InterfaceManager:SetFolder("dkoiHUB")
SaveManager:SetFolder("dkoiHUB/Configs")

InterfaceManager:BuildInterfaceSection(SettingsTab)
SaveManager:BuildConfigSection(SettingsTab)

SaveManager:IgnoreThemeSettings()

SettingsSection:AddButton({
    Title = "Low CPU Mode",
    Callback = function()
        pcall(function()
            settings().Rendering.QualityLevel = 1
            Lighting.GlobalShadows = false
            Lighting.Brightness = 1
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("Part") or v:IsA("MeshPart") then
                    v.Material = Enum.Material.SmoothPlastic
                end
            end
            Fluent:Notify({ Title = "FPS", Content = "Low CPU Mode Enabled!", Duration = 2 })
        end)
    end,
})

SettingsSection:AddButton({
    Title = "Server Hop",
    Callback = function()
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
            end)
        end)
    end,
})

SettingsSection:AddButton({
    Title = "Rejoin Server",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, Player)
    end,
})

-- ==================== FLOATING BUTTON ====================
local OpenGui = Instance.new("ScreenGui")
OpenGui.Name = "dkoiHUB_OpenUI"
OpenGui.ResetOnSpawn = false
OpenGui.Parent = game:GetService("CoreGui")

local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.fromOffset(52, 52)
OpenBtn.Position = UDim2.new(0.82, 0, 0.82, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(180, 10, 20)
OpenBtn.BackgroundTransparency = 0.1
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
Stroke.Thickness = 1.5
Stroke.Parent = OpenBtn

-- Dragging
local dragging = false
local dragStart = Vector2.new(0, 0)
local startPos = UDim2.new(0, 0, 0, 0)

OpenBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = OpenBtn.Position
    end
end)

OpenBtn.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        OpenBtn.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

OpenBtn.MouseButton1Click:Connect(function()
    if Window and Window.Minimize then
        Window:Minimize()
    end
end)

-- ==================== STARTUP ====================
Fluent:Notify({
    Title = "🏴‍☠️ dkoiHUB",
    Content = "Script loaded! Press Right CTRL to toggle UI",
    Duration = 4,
})

Window:SelectTab(1)

-- Character respawn handler
Player.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
    Fluent:Notify({ Title = "dkoiHUB", Content = "Character respawned!", Duration = 2 })
end)

print("✅ dkoiHUB Mobile - Loaded Successfully!")
