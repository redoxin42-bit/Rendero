--[[
    Wellon Bizarre Lineage | GitHub Edition
    Features: Fixed UnderMap, Auto Raid, Statistics, Zenin Watermark
]]

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

-- Статистика
_G.RaidsDone = 0

local ScreenGui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
ScreenGui.Name = "WellonFinal_V2"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999

-- 1. ZENIN WATERMARK (По коду из .h файла)
local wm = Instance.new("Frame", ScreenGui)
wm.Size = UDim2.new(0, 260, 0, 28)
wm.Position = UDim2.new(0, 12, 0, 12)
wm.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
wm.BackgroundTransparency = 0.05
Instance.new("UICorner", wm).CornerRadius = UDim.new(0, 4)

-- Реализация оранжевой полоски с градиентом
local line = Instance.new("Frame", wm)
line.Size = UDim2.new(1, 0, 0, 3)
line.Position = UDim2.new(0, 0, 1, -3)
line.BackgroundColor3 = Color3.fromRGB(255, 90, 25)

local wmt = Instance.new("TextLabel", wm)
wmt.Size = UDim2.new(1, -20, 1, 0)
wmt.Position = UDim2.new(0, 10, 0, 0)
wmt.BackgroundTransparency = 1
wmt.TextColor3 = Color3.fromRGB(255, 255, 255)
wmt.Text = "wellon | t.me/wellonproject | beta | v2.0"
wmt.Font = Enum.Font.Code
wmt.TextSize = 13
wmt.TextXAlignment = Enum.TextXAlignment.Left

-- 2. ISLAND (Перенесен выше по запросу)
local Island = Instance.new("TextButton", ScreenGui)
Island.Size = UDim2.new(0, 150, 0, 28)
Island.Position = UDim2.new(0.5, -75, 0, 0) -- Самый верх
Island.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Island.BackgroundTransparency = 0.85
Island.Text = "Open Menu"
Island.TextColor3 = Color3.fromRGB(255, 255, 255)
Island.Font = Enum.Font.GothamBold
Island.TextSize = 12
Instance.new("UICorner", Island).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", Island).Color = Color3.fromRGB(255, 255, 255)

-- 3. ОСНОВНОЕ МЕНЮ (Исправленное заполнение)
local Main = Instance.new("Frame", ScreenGui)
Main.Visible = false
Main.Size = UDim2.new(0, 450, 0, 320)
Main.Position = UDim2.new(0.5, -225, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
Instance.new("UICorner", Main)

-- Сайдбар для вкладок
local Tabs = Instance.new("Frame", Main)
Tabs.Size = UDim2.new(0, 110, 1, -10)
Tabs.Position = UDim2.new(0, 5, 0, 5)
Tabs.BackgroundTransparency = 1
local TabList = Instance.new("UIListLayout", Tabs)
TabList.Padding = UDim.new(0, 5)

-- Контейнер для контента
local Container = Instance.new("ScrollingFrame", Main)
Container.Size = UDim2.new(1, -125, 1, -20)
Container.Position = UDim2.new(0, 120, 0, 10)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 2
local ContentList = Instance.new("UIListLayout", Container)
ContentList.Padding = UDim.new(0, 8) -- Кнопки строго вниз

-- ФУНКЦИЯ ДОБАВЛЕНИЯ КНОПОК
local function AddToggle(name, callback)
    local b = Instance.new("TextButton", Container)
    b.Size = UDim2.new(1, -10, 0, 38)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    b.Text = "  [ OFF ]  " .. name
    b.TextColor3 = Color3.fromRGB(200, 200, 200)
    b.Font = Enum.Font.Gotham
    b.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", b)
    
    local state = false
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = state and "  [ ON ]   " .. name or "  [ OFF ]  " .. name
        b.TextColor3 = state and Color3.fromRGB(255, 90, 25) or Color3.fromRGB(200, 200, 200)
        callback(state)
    end)
end

-- --- НАПОЛНЕНИЕ МЕНЮ ---

-- Вкладка: Фарм
AddToggle("Quest Farm (Fixed UnderMap)", function(v)
    _G.Farm = v
    if v then
        local pos = Player.Character.HumanoidRootPart.Position - Vector3.new(0, 14, 0)
        RunService:BindToRenderStep("WellonFarm", 1, function()
            if _G.Farm and Player.Character then
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
                Player.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            else
                RunService:UnbindFromRenderStep("WellonFarm")
            end
        end)
    end
end)

-- Вкладка: Рейды
AddToggle("Auto Play Again (Raid)", function(v)
    _G.AutoRaid = v
    task.spawn(function()
        while _G.AutoRaid do
            local btn = Player.PlayerGui:FindFirstChild("Play Again", true)
            if btn and btn.Visible then 
                VIM:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                _G.RaidsDone = _G.RaidsDone + 1
            end
            task.wait(2)
        end
    end)
end)

AddToggle("Auto Teleport Back", function(v)
    _G.AutoTele = v
    task.spawn(function()
        while _G.AutoTele do
            local btn = Player.PlayerGui:FindFirstChild("Teleport Back", true)
            if btn and btn.Visible then 
                VIM:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
            end
            task.wait(2)
        end
    end)
end)

-- Вкладка: PVP
AddToggle("Auto Skills (R, Z, X, C, V, E)", function(v)
    _G.Skills = v
    task.spawn(function()
        local keys = {Enum.KeyCode.R, Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C, Enum.KeyCode.V, Enum.KeyCode.E}
        while _G.Skills do
            for _, k in ipairs(keys) do
                VIM:SendKeyEvent(true, k, false, game)
                task.wait(0.15)
            end
            task.wait(0.5)
        end
    end)
end)

-- Вкладка: Статистика
local StatLabel = Instance.new("TextLabel", Container)
StatLabel.Size = UDim2.new(1, 0, 0, 40)
StatLabel.BackgroundTransparency = 1
StatLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatLabel.Font = Enum.Font.Code
task.spawn(function()
    while task.wait(1) do
        StatLabel.Text = "Raids Completed: " .. _G.RaidsDone .. "\nCash: " .. (Player.leaderstats:FindFirstChild("Cash") and Player.leaderstats.Cash.Value or 0)
    end
end)

-- Переключатель меню
Island.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
