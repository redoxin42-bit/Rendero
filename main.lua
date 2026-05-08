local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")

local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "WellonPremium"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999

-- 1. КНОПКА ОТКРЫТИЯ (Bizarre Lineage)
local Island = Instance.new("TextButton", ScreenGui)
Island.Size = UDim2.new(0, 160, 0, 28)
Island.Position = UDim2.new(0.5, -80, 0, -2) -- Выше некуда
Island.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Island.BackgroundTransparency = 0.5
Island.Text = "Bizarre Lineage"
Island.TextColor3 = Color3.fromRGB(255, 255, 255)
Island.Font = Enum.Font.GothamBold
Island.TextSize = 12
Instance.new("UICorner", Island).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", Island).Color = Color3.fromRGB(255, 90, 25)

-- 2. ОСНОВНОЕ МЕНЮ
local Main = Instance.new("Frame", ScreenGui)
Main.Visible = false
Main.Size = UDim2.new(0, 500, 0, 350)
Main.Position = UDim2.new(0.5, -250, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Instance.new("UICorner", Main)

-- Сайдбар (Слева)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 120, 1, -10)
Sidebar.Position = UDim2.new(0, 5, 0, 5)
Sidebar.BackgroundTransparency = 1
local SidebarLayout = Instance.new("UIListLayout", Sidebar)
SidebarLayout.Padding = UDim.new(0, 5)

-- Контейнер для функций (Справа)
local Container = Instance.new("ScrollingFrame", Main)
Container.Size = UDim2.new(1, -135, 1, -20)
Container.Position = UDim2.new(0, 130, 0, 10)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 2, 0)
local ContentLayout = Instance.new("UIListLayout", Container)
ContentLayout.Padding = UDim.new(0, 8)

-- Функция создания вкладок
local function CreateTab(name)
    local b = Instance.new("TextButton", Sidebar)
    b.Size = UDim2.new(1, 0, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    b.Text = name
    b.TextColor3 = Color3.fromRGB(200, 200, 200)
    b.Font = Enum.Font.GothamBold
    Instance.new("UICorner", b)
    return b
end

-- Функция добавления кнопок (Toggle)
local function AddToggle(name, callback)
    local t = Instance.new("TextButton", Container)
    t.Size = UDim2.new(1, -10, 0, 40)
    t.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    t.Text = "[ OFF ] " .. name
    t.TextColor3 = Color3.fromRGB(255, 255, 255)
    t.Font = Enum.Font.Gotham
    Instance.new("UICorner", t)
    
    local enabled = false
    t.MouseButton1Click:Connect(function()
        enabled = not enabled
        t.Text = enabled and "[ ON ] " .. name or "[ OFF ] " .. name
        t.TextColor3 = enabled and Color3.fromRGB(255, 90, 25) or Color3.fromRGB(255, 255, 255)
        callback(enabled)
    end)
end

-- --- ЛОГИКА ВКЛАДОК ---

-- [ RAID ]
local RaidTab = CreateTab("Raid")
RaidTab.MouseButton1Click:Connect(function()
    for _, v in pairs(Container:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    AddToggle("Play Again (Raid)", function(v) _G.PlayAgain = v end)
    AddToggle("Auto Raid (UnderMap)", function(v) _G.UnderRaid = v end)
    AddToggle("Auto Raid (Above)", function(v) _G.AboveRaid = v end)
end)

-- [ AUTO ]
local AutoTab = CreateTab("Auto")
AutoTab.MouseButton1Click:Connect(function()
    for _, v in pairs(Container:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    AddToggle("Auto Skills (R, Z, X, C, V)", function(v) _G.AutoSkills = v end)
    AddToggle("Auto Quest", function(v) _G.AutoQuest = v end)
    AddToggle("Auto Box & Arrows", function(v) _G.AutoLoot = v end)
end)

-- [ MODE ]
local ModeTab = CreateTab("Mode")
ModeTab.MouseButton1Click:Connect(function()
    for _, v in pairs(Container:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    AddToggle("GodMode (Invis)", function(v) _G.God = v end)
    AddToggle("Fly (Risk)", function(v) _G.Fly = v end)
end)

-- [ PVP ]
local PvpTab = CreateTab("PvP")
PvpTab.MouseButton1Click:Connect(function()
    for _, v in pairs(Container:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    AddToggle("Reach (Long Attack)", function(v) _G.Reach = v end)
    AddToggle("No Stun", function(v) _G.NoStun = v end)
end)

Island.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
