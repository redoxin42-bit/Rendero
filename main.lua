local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "WellonHub_Final_TikTok"
ScreenGui.ResetOnSpawn = false

-- Функция для перетаскивания (сделает всё подвижным)
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

-- 1. ВЕРХНЯЯ КНОПКА (Wellon CLOSE / OPEN)
local TopToggle = Instance.new("TextButton", ScreenGui)
TopToggle.Size = UDim2.new(0, 130, 0, 32)
TopToggle.Position = UDim2.new(0.5, -65, 0, 15)
TopToggle.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
TopToggle.Text = "Wellon CLOSE"
TopToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
TopToggle.Font = Enum.Font.GothamBold
TopToggle.TextSize = 12
Instance.new("UICorner", TopToggle).CornerRadius = UDim.new(0, 6)
local TopStroke = Instance.new("UIStroke", TopToggle)
TopStroke.Color = Color3.fromRGB(80, 50, 150) -- Фиолетовая обводка
TopStroke.Thickness = 1.5
MakeDraggable(TopToggle)

-- 2. ГЛАВНОЕ МЕНЮ (Фиолетовая тема)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 580, 0, 390)
Main.Position = UDim2.new(0.5, -290, 0.5, -195)
Main.BackgroundColor3 = Color3.fromRGB(13, 13, 17)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(45, 45, 55)
MakeDraggable(Main)

-- Сайдбар с иконками
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 55, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

-- Список вкладок (Иконки как на видео)
local TabContainer = Instance.new("Frame", Sidebar)
TabContainer.Size = UDim2.new(1, 0, 1, -20)
TabContainer.BackgroundTransparency = 1
local TabList = Instance.new("UIListLayout", TabContainer)
TabList.Padding = UDim.new(0, 15)
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Заголовок
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -70, 0, 35)
Title.Position = UDim2.new(0, 65, 0, 5)
Title.Text = "Main | Bizarre Lineage"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

-- Контейнер для скроллинга функций
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -80, 1, -70)
Scroll.Position = UDim2.new(0, 70, 0, 45)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
Scroll.ScrollBarImageColor3 = Color3.fromRGB(80, 50, 150)
local ContentList = Instance.new("UIListLayout", Scroll)
ContentList.Padding = UDim.new(0, 10)

-- 3. СОЗДАНИЕ СЕКЦИЙ (АККОРДЕОНЫ)
local function NewAccordion(name, items)
    local AccFrame = Instance.new("Frame", Scroll)
    AccFrame.Size = UDim2.new(1, -10, 0, 40)
    AccFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    AccFrame.ClipsDescendants = true
    Instance.new("UICorner", AccFrame)

    local Head = Instance.new("TextButton", AccFrame)
    Head.Size = UDim2.new(1, 0, 0, 40)
    Head.BackgroundTransparency = 1
    Head.Text = "  " .. name .. "  ▼"
    Head.TextColor3 = Color3.fromRGB(255, 255, 255)
    Head.Font = Enum.Font.GothamBold
    Head.TextXAlignment = Enum.TextXAlignment.Left

    local IsOpen = false
    Head.MouseButton1Click:Connect(function()
        IsOpen = not IsOpen
        AccFrame:TweenSize(IsOpen and UDim2.new(1, -10, 0, 40 + (#items * 35)) or UDim2.new(1, -10, 0, 40), "Out", "Quad", 0.3, true)
    end)

    for i, itemText in ipairs(items) do
        local Row = Instance.new("Frame", AccFrame)
        Row.Size = UDim2.new(1, -10, 0, 30)
        Row.Position = UDim2.new(0, 5, 0, 40 + (i-1)*35)
        Row.BackgroundTransparency = 1
        
        local Label = Instance.new("TextLabel", Row)
        Label.Size = UDim2.new(0.8, 0, 1, 0)
        Label.Text = itemText
        Label.TextColor3 = Color3.fromRGB(180, 180, 190)
        Label.BackgroundTransparency = 1
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Font = Enum.Font.Gotham

        local Toggle = Instance.new("TextButton", Row)
        Toggle.Size = UDim2.new(0, 35, 0, 18)
        Toggle.Position = UDim2.new(0.85, 0, 0.2, 0)
        Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        Toggle.Text = ""
        Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)

        local State = false
        Toggle.MouseButton1Click:Connect(function()
            State = not State
            Toggle.BackgroundColor3 = State and Color3.fromRGB(80, 50, 150) or Color3.fromRGB(40, 40, 50)
            print(itemText .. " is now " .. (State and "ON" or "OFF"))
        end)
    end
end

-- 4. ВСЕ ФУНКЦИИ VELLURE HUB
NewAccordion("Automation", {
    "Auto Mission", "Auto-PVP Mission [MAIN]", "Auto-PVP Mission [ALT]", 
    "Auto Meditation", "Auto Gang Contract", "Auto Prestige", "Auto World Event"
})

NewAccordion("Skills", {
    "Auto Skills (R,Z,X,C,V,E)", "Main Skills", "Sub Abilities", "Fighting Ability"
})

NewAccordion("Raids & Bosses", {
    "Auto Raid (UnderMap)", "Auto Raid (Above)", "Auto Play Again", "Auto Boss Farm"
})

NewAccordion("Misc & Settings", {
    "Anti-AFK", "Hide UI", "FPS Cap", "Join Discord"
})

-- Нижняя инфо-панель
local BottomInfo = Instance.new("TextLabel", Main)
BottomInfo.Size = UDim2.new(0, 200, 0, 20)
BottomInfo.Position = UDim2.new(1, -210, 1, -25)
BottomInfo.Text = "Wellon | Build 1.8 | 61 FPS"
BottomInfo.TextColor3 = Color3.fromRGB(80, 80, 100)
BottomInfo.BackgroundTransparency = 1
BottomInfo.Font = Enum.Font.Gotham

-- Кнопка закрытия/открытия
TopToggle.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    TopToggle.Text = Main.Visible and "Wellon CLOSE" or "Wellon OPEN"
end)
