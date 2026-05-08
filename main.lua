local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Удаляем старые версии, если они есть
if game:GetService("CoreGui"):FindFirstChild("WellonHub") then
    game:GetService("CoreGui").WellonHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "WellonHub"

-- Функция перетаскивания
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
TopToggle.Size = UDim2.new(0, 140, 0, 32)
TopToggle.Position = UDim2.new(0.5, -70, 0, 15)
TopToggle.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Instance.new("UICorner", TopToggle).CornerRadius = UDim.new(0, 6)
local TopStroke = Instance.new("UIStroke", TopToggle)
TopStroke.Color = Color3.fromRGB(70, 70, 90)
MakeDraggable(TopToggle)

local TopBtn = Instance.new("TextButton", TopToggle)
TopBtn.Size = UDim2.new(1, 0, 1, 0)
TopBtn.BackgroundTransparency = 1
TopBtn.Text = "Wellon CLOSE"
TopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TopBtn.Font = Enum.Font.GothamBold
TopBtn.TextSize = 12

-- 2. ГЛАВНОЕ МЕНЮ
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 620, 0, 390)
Main.Position = UDim2.new(0.5, -310, 0.5, -195)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
MakeDraggable(Main)

-- Левый сайдбар (как на скрине)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 60, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
Instance.new("UICorner", Sidebar)

local SidebarList = Instance.new("UIListLayout", Sidebar)
SidebarList.Padding = UDim.new(0, 20)
SidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Заголовок игры (Справа сверху)
local GameTag = Instance.new("TextLabel", Main)
GameTag.Size = UDim2.new(0, 120, 0, 25)
GameTag.Position = UDim2.new(1, -135, 0, 10)
GameTag.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
GameTag.Text = "Bizarre Lineage"
GameTag.TextColor3 = Color3.fromRGB(180, 180, 180)
GameTag.Font = Enum.Font.Gotham
Instance.new("UICorner", GameTag)

-- Область для функций
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -90, 1, -80)
Scroll.Position = UDim2.new(0, 75, 0, 45)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
local List = Instance.new("UIListLayout", Scroll)
List.Padding = UDim.new(0, 10)

-- Функция создания раздела (Changelog / Automation)
local function AddSection(name, items)
    local Sec = Instance.new("Frame", Scroll)
    Sec.Size = UDim2.new(1, -10, 0, 40)
    Sec.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    Sec.ClipsDescendants = true
    Instance.new("UICorner", Sec)

    local Header = Instance.new("TextButton", Sec)
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundTransparency = 1
    Header.Text = "  " .. name .. "  ▼"
    Header.TextColor3 = Color3.fromRGB(255, 255, 255)
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Font = Enum.Font.GothamBold

    local Open = false
    Header.MouseButton1Click:Connect(function()
        Open = not Open
        Sec:TweenSize(Open and UDim2.new(1, -10, 0, 40 + (#items * 35)) or UDim2.new(1, -10, 0, 40), "Out", "Quad", 0.3, true)
    end)

    for i, txt in ipairs(items) do
        local Row = Instance.new("Frame", Sec)
        Row.Size = UDim2.new(1, -10, 0, 30)
        Row.Position = UDim2.new(0, 5, 0, 40 + (i-1)*35)
        Row.BackgroundTransparency = 1
        
        local L = Instance.new("TextLabel", Row)
        L.Size = UDim2.new(0.8, 0, 1, 0)
        L.Text = txt
        L.TextColor3 = Color3.fromRGB(180, 180, 180)
        L.BackgroundTransparency = 1
        L.TextXAlignment = Enum.TextXAlignment.Left

        local T = Instance.new("TextButton", Row)
        T.Size = UDim2.new(0, 35, 0, 18)
        T.Position = UDim2.new(0.85, 0, 0.2, 0)
        T.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        Instance.new("UICorner", T).CornerRadius = UDim.new(1, 0)
        
        local On = false
        T.MouseButton1Click:Connect(function()
            On = not On
            T.BackgroundColor3 = On and Color3.fromRGB(80, 50, 150) or Color3.fromRGB(45, 45, 55)
        end)
    end
end

-- Наполняем точно как на твоих скринах
AddSection("Changelog", {"[+] Added Auto Farm", "[+] Improved UI", "[+] Added ESP"})
AddSection("Automation", {"Auto Mission", "Auto Meditation", "Auto Prestige"})
AddSection("Player ESP", {"Enable ESP", "Healthbar", "Boxes", "Distance"})

-- Нижняя плашка (Wellon | Build 2.0 | FPS)
local Bottom = Instance.new("TextLabel", Main)
Bottom.Size = UDim2.new(0, 200, 0, 20)
Bottom.Position = UDim2.new(1, -210, 1, -25)
Bottom.Text = "Wellon | Build 2.0 | 60 FPS"
Bottom.TextColor3 = Color3.fromRGB(100, 100, 120)
Bottom.BackgroundTransparency = 1
Bottom.Font = Enum.Font.Gotham
Bottom.TextXAlignment = Enum.TextXAlignment.Right

-- Логика кнопки закрытия
TopBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    TopBtn.Text = Main.Visible and "Wellon CLOSE" or "Wellon OPEN"
end)
