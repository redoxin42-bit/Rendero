-- // Wellon Hub | Game Script
-- // Путь в репозитории: Redoxin42-bit/Rendero/main/[BA или SP или AUT]/Main.lua

local Players = game:GetService("Players")
local LPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Уникальное имя для защиты от дубликатов
local UI_NAME = "WellonUI_Internal"
if CoreGui:FindFirstChild(UI_NAME) then CoreGui[UI_NAME]:Destroy() end

-- Создаем интерфейс (дизайн со скриншота)
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = UI_NAME

-- Главное окно
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 580, 0, 360)
Main.Position = UDim2.new(0.5, -290, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20) -- Темный фон как на скрине
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- Верхняя панель управления (Wellon CLOSE)
local TopFrame = Instance.new("Frame", ScreenGui)
TopFrame.Size = UDim2.new(0, 150, 0, 35)
TopFrame.Position = UDim2.new(0.5, -75, 0, 20)
TopFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Instance.new("UICorner", TopFrame)

local TopBtn = Instance.new("TextButton", TopFrame)
TopBtn.Size = UDim2.new(1, 0, 1, 0)
TopBtn.BackgroundTransparency = 1
TopBtn.Text = "Wellon CLOSE" -- Твое название
TopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TopBtn.Font = Enum.Font.GothamBold
TopBtn.TextSize = 13

-- Сайдбар слева
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 60, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
Instance.new("UICorner", Sidebar)

-- Список функций (Scrolling)
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -85, 1, -80)
Scroll.Position = UDim2.new(0, 75, 0, 45)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
local List = Instance.new("UIListLayout", Scroll)
List.Padding = UDim.new(0, 8)

-- Заголовок раздела
local function AddSection(name)
    local Label = Instance.new("TextLabel", Scroll)
    Label.Size = UDim2.new(1, -10, 0, 30)
    Label.Text = "  " .. name
    Label.TextColor3 = Color3.fromRGB(120, 120, 150)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.GothamBold
end

-- Кнопка функции (Toggle)
local function AddToggle(name, callback)
    local Frame = Instance.new("Frame", Scroll)
    Frame.Size = UDim2.new(1, -10, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Instance.new("UICorner", Frame)

    local L = Instance.new("TextLabel", Frame)
    L.Size = UDim2.new(0.7, 0, 1, 0)
    L.Position = UDim2.new(0, 10, 0, 0)
    L.Text = name
    L.TextColor3 = Color3.fromRGB(255, 255, 255)
    L.BackgroundTransparency = 1
    L.TextXAlignment = Enum.TextXAlignment.Left
    L.Font = Enum.Font.Gotham

    local T = Instance.new("TextButton", Frame)
    T.Size = UDim2.new(0, 40, 0, 20)
    T.Position = UDim2.new(0.85, 0, 0.25, 0)
    T.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    T.Text = ""
    Instance.new("UICorner", T).CornerRadius = UDim.new(1, 0)

    local state = false
    T.MouseButton1Click:Connect(function()
        state = not state
        T.BackgroundColor3 = state and Color3.fromRGB(80, 50, 150) or Color3.fromRGB(50, 50, 60)
        callback(state)
    end)
end

-- // НАПОЛНЕНИЕ ФУНКЦИЯМИ
AddSection("Main Automation")
AddToggle("Auto Farm Mission", function(v) _G.Farm = v while _G.Farm do task.wait(1) print("Wellon Farming...") end end)
AddToggle("Auto Meditation", function(v) _G.Meditate = v while _G.Meditate do task.wait(0.5) print("Wellon Meditating...") end end)

AddSection("Visuals")
AddToggle("Enable ESP", function(v) print("ESP: " .. tostring(v)) end)

-- Инфо снизу
local Info = Instance.new("TextLabel", Main)
Info.Size = UDim2.new(0, 200, 0, 20)
Info.Position = UDim2.new(1, -210, 1, -25)
Info.Text = "Wellon | Build 2.0 | 60 FPS" -- Твоя подпись
Info.TextColor3 = Color3.fromRGB(80, 80, 100)
Info.BackgroundTransparency = 1
Info.Font = Enum.Font.Gotham
Info.TextXAlignment = Enum.TextXAlignment.Right

-- Логика кнопки закрытия
TopBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    TopBtn.Text = Main.Visible and "Wellon CLOSE" or "Wellon OPEN"
end)

print("✅ Wellon Internal Hub: Loaded Successfully")
