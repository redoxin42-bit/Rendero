local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "WellonHub_Final_Clean"
ScreenGui.ResetOnSpawn = false

-- Функция перетаскивания (для меню и верхней кнопки)
local function MakeDraggable(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true dragStart = input.Position startPos = obj.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    obj.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- 1. ВЕРХНЯЯ КНОПКА (Wellon CLOSE)
local TopToggle = Instance.new("Frame", ScreenGui)
TopToggle.Size = UDim2.new(0, 140, 0, 35)
TopToggle.Position = UDim2.new(0.5, -70, 0, 15)
TopToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TopToggle.BackgroundTransparency = 0.2
Instance.new("UICorner", TopToggle).CornerRadius = UDim.new(0, 8)
local TopStroke = Instance.new("UIStroke", TopToggle)
TopStroke.Color = Color3.fromRGB(80, 80, 100)
TopStroke.Thickness = 1.2
MakeDraggable(TopToggle)

local TopBtn = Instance.new("TextButton", TopToggle)
TopBtn.Size = UDim2.new(1, 0, 1, 0)
TopBtn.BackgroundTransparency = 1
TopBtn.Text = "Wellon CLOSE" --
TopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TopBtn.Font = Enum.Font.GothamBold
TopBtn.TextSize = 13

-- 2. ГЛАВНОЕ ОКНО (Точно как на скрине)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 620, 0, 390)
Main.Position = UDim2.new(0.5, -310, 0.5, -195)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(40, 40, 50)
MakeDraggable(Main)

-- Вертикальный сайдбар (Левая панель)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 60, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
Instance.new("UICorner", Sidebar)

local SidebarIcons = Instance.new("UIListLayout", Sidebar)
SidebarIcons.Padding = UDim.new(0, 15)
SidebarIcons.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Заголовок игры (Справа сверху)
local GameTag = Instance.new("TextLabel", Main)
GameTag.Size = UDim2.new(0, 120, 0, 25)
GameTag.Position = UDim2.new(1, -135, 0, 10)
GameTag.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
GameTag.Text = "Bizarre Lineage"
GameTag.TextColor3 = Color3.fromRGB(180, 180, 180)
GameTag.Font = Enum.Font.Gotham
GameTag.TextSize = 11
Instance.new("UICorner", GameTag)

-- Область контента
local ContentScroll = Instance.new("ScrollingFrame", Main)
ContentScroll.Size = UDim2.new(1, -90, 1, -70)
ContentScroll.Position = UDim2.new(0, 75, 0, 45)
ContentScroll.BackgroundTransparency = 1
ContentScroll.ScrollBarThickness = 2
local ContentList = Instance.new("UIListLayout", ContentScroll)
ContentList.Padding = UDim.new(0, 10)

-- Пример раздела (Changelog/Automation)
local function AddSection(title, info)
    local Sec = Instance.new("Frame", ContentScroll)
    Sec.Size = UDim2.new(1, -10, 0, 100)
    Sec.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Instance.new("UICorner", Sec)
    
    local T = Instance.new("TextLabel", Sec)
    T.Size = UDim2.new(1, -20, 0, 30)
    T.Position = UDim2.new(0, 10, 0, 5)
    T.Text = title
    T.TextColor3 = Color3.fromRGB(255, 255, 255)
    T.TextXAlignment = Enum.TextXAlignment.Left
    T.BackgroundTransparency = 1
    T.Font = Enum.Font.GothamBold
end

AddSection("Changelog", "") --

-- Нижняя плашка
local Bottom = Instance.new("TextLabel", Main)
Bottom.Size = UDim2.new(0, 200, 0, 20)
Bottom.Position = UDim2.new(1, -210, 1, -25)
Bottom.Text = "Wellon | Build 2.0 | 60 FPS" --
Bottom.TextColor3 = Color3.fromRGB(100, 100, 120)
Bottom.BackgroundTransparency = 1
Bottom.Font = Enum.Font.Gotham
Bottom.TextXAlignment = Enum.TextXAlignment.Right

-- Логика кнопки
TopBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    TopBtn.Text = Main.Visible and "Wellon CLOSE" or "Wellon OPEN"
end)
