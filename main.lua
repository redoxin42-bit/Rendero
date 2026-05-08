local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")

local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "Wellonh_Menu"
ScreenGui.ResetOnSpawn = false

-- 1. КРУГЛАЯ ИКОНКА (Wellonh)
local Icon = Instance.new("TextButton", ScreenGui)
Icon.Size = UDim2.new(0, 55, 0, 55)
Icon.Position = UDim2.new(0, 20, 0.5, -27)
Icon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Icon.Text = "Wellonh"
Icon.TextColor3 = Color3.fromRGB(255, 90, 25)
Icon.Font = Enum.Font.GothamBold
Icon.TextSize = 10
Icon.ClipsDescendants = true
Instance.new("UICorner", Icon).CornerRadius = UDim.new(1, 0)
local Stroke = Instance.new("UIStroke", Icon)
Stroke.Color = Color3.fromRGB(255, 255, 255)
Stroke.Thickness = 1.5

-- Перетаскивание иконки
local drag, dStart, sPos
Icon.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = true dStart = i.Position sPos = Icon.Position end end)
UIS.InputChanged:Connect(function(i) if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local delta = i.Position - dStart Icon.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + delta.X, sPos.Y.Scale, sPos.Y.Offset + delta.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = false end end)

-- 2. ГЛАВНОЕ МЕНЮ (Стиль TikTok)
local Main = Instance.new("Frame", ScreenGui)
Main.Visible = false
Main.Size = UDim2.new(0, 480, 0, 320)
Main.Position = UDim2.new(0.5, -240, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- Сайдбар
local Tabs = Instance.new("Frame", Main)
Tabs.Size = UDim2.new(0, 120, 1, 0)
Tabs.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
Instance.new("UICorner", Tabs).CornerRadius = UDim.new(0, 10)

local TabList = Instance.new("UIListLayout", Tabs)
TabList.Padding = UDim.new(0, 5)
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Контейнер для функций
local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -130, 1, -20)
Content.Position = UDim2.new(0, 125, 0, 10)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 0
local ContentList = Instance.new("UIListLayout", Content)
ContentList.Padding = UDim.new(0, 10)

-- ФУНКЦИИ ВЫЛЕТОВ (Dropdown)
local function Dropdown(name, options, callback)
    local dropFrame = Instance.new("Frame", Content)
    dropFrame.Size = UDim2.new(1, -10, 0, 35)
    dropFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 27)
    Instance.new("UICorner", dropFrame)
    
    local label = Instance.new("TextButton", dropFrame)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = "  " .. name .. " >"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left

    local open = false
    label.MouseButton1Click:Connect(function()
        open = not open
        dropFrame.Size = open and UDim2.new(1, -10, 0, 35 + (#options * 30)) or UDim2.new(1, -10, 0, 35)
        for _, opt in pairs(dropFrame:GetChildren()) do
            if opt:IsA("TextButton") and opt ~= label then opt.Visible = open end
        end
    end)

    for i, optName in ipairs(options) do
        local optBtn = Instance.new("TextButton", dropFrame)
        optBtn.Size = UDim2.new(1, -20, 0, 25)
        optBtn.Position = UDim2.new(0, 10, 0, 35 + (i-1)*30)
        optBtn.Visible = false
        optBtn.Text = optName
        optBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 37)
        optBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        Instance.new("UICorner", optBtn)
        optBtn.MouseButton1Click:Connect(function() callback(optName) end)
    end
end

-- --- НАПОЛНЕНИЕ ---

-- Категория RAID
Dropdown("Raid Select", {"Jotaro", "DIO", "Pucci", "Diavolo", "Kira"}, function(val)
    print("Auto Raid started for: " .. val)
end)

-- Категория AUTO SKILLS (с выбором кнопок)
Dropdown("Select Skills", {"R", "Z", "X", "C", "V", "E"}, function(key)
    print("Skill toggled: " .. key)
end)

-- Переключатель
Icon.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
