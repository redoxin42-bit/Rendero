local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "WellonHub_Final"
ScreenGui.ResetOnSpawn = false

-- Функция для перетаскивания основного меню и кнопки
local function MakeDraggable(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    obj.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- 1. ВЕРХНЯЯ ПАНЕЛЬ (Wellon CLOSE)
local TopBar = Instance.new("Frame", ScreenGui)
TopBar.Size = UDim2.new(0, 160, 0, 35)
TopBar.Position = UDim2.new(0.5, -80, 0, 10)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 6)
local TopStroke = Instance.new("UIStroke", TopBar)
TopStroke.Color = Color3.fromRGB(60, 60, 75)
MakeDraggable(TopBar)

local TopBtn = Instance.new("TextButton", TopBar)
TopBtn.Size = UDim2.new(1, 0, 1, 0)
TopBtn.BackgroundTransparency = 1
TopBtn.Text = "Wellon CLOSE" --
TopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TopBtn.Font = Enum.Font.GothamBold
TopBtn.TextSize = 13

-- 2. ГЛАВНОЕ ОКНО
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 600, 0, 380)
Main.Position = UDim2.new(0.5, -300, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
MakeDraggable(Main)

-- Сайдбар (Слева)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 50, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", Sidebar)

-- Контент (Справа)
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -70, 1, -60)
Scroll.Position = UDim2.new(0, 60, 0, 40)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
local List = Instance.new("UIListLayout", Scroll)
List.Padding = UDim.new(0, 8)

-- Функция для разделов (Dropdowns)
local function NewSection(name, items)
    local Frame = Instance.new("Frame", Scroll)
    Frame.Size = UDim2.new(1, -10, 0, 35)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Frame.ClipsDescendants = true
    Instance.new("UICorner", Frame)

    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundTransparency = 1
    btn.Text = "  " .. name .. "  ▼"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Font = Enum.Font.GothamBold

    local open = false
    btn.MouseButton1Click:Connect(function()
        open = not open
        Frame:TweenSize(open and UDim2.new(1, -10, 0, 35 + (#items * 35)) or UDim2.new(1, -10, 0, 35), "Out", "Quad", 0.3, true)
    end)

    for i, text in ipairs(items) do
        local opt = Instance.new("TextButton", Frame)
        opt.Size = UDim2.new(1, -10, 0, 30)
        opt.Position = UDim2.new(0, 5, 0, 35 + (i-1)*35)
        opt.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        opt.Text = text
        opt.TextColor3 = Color3.fromRGB(180, 180, 180)
        Instance.new("UICorner", opt)
    end
end

-- Наполнение секций
NewSection("Automation", {"Auto Mission", "Auto Meditation", "Auto Prestige", "Auto World Event"})
NewSection("Skills", {"Auto Skills (R,Z,X,C,V,E)", "Main Skills", "Sub Abilities"})
NewSection("Raids", {"Auto Raid (UnderMap)", "Auto Raid (Above)", "Auto Play Again"})
NewSection("Player ESP", {"Enable ESP", "Healthbar", "Boxes", "Name", "Distance"}) --

-- Инфо панель внизу
local BottomInfo = Instance.new("TextLabel", Main)
BottomInfo.Size = UDim2.new(1, -20, 0, 20)
BottomInfo.Position = UDim2.new(0, 10, 1, -25)
BottomInfo.Text = "Wellon | Build 2.0 | 60 FPS" --
BottomInfo.TextColor3 = Color3.fromRGB(100, 100, 110)
BottomInfo.TextXAlignment = Enum.TextXAlignment.Right
BottomInfo.BackgroundTransparency = 1

-- Логика кнопки Wellon CLOSE / OPEN
TopBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    TopBtn.Text = Main.Visible and "Wellon CLOSE" or "Wellon OPEN"
end)
