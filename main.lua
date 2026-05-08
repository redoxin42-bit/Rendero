-- // Wellon Hub | Private Version
-- // Made for redoxin42-bit

local cloneref = (cloneref or clonereference or function(instance) return instance end)
local Players = cloneref(game:GetService("Players"))
local UIS = game:GetService("UserInputService")
local LPlayer = Players.LocalPlayer

repeat task.wait() until game:IsLoaded() and LPlayer

-- 1. АНТИ-АФК (Как в оригинале)
LPlayer.Idled:Connect(function()
    pcall(function()
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

-- 2. ИНТЕРФЕЙС (Wellon Style)
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "WellonHub"

-- Функция перетаскивания (Draggable)
local function Drag(obj)
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

-- Верхняя кнопка управления (Wellon CLOSE)
local TopBar = Instance.new("Frame", ScreenGui)
TopBar.Size = UDim2.new(0, 150, 0, 35)
TopBar.Position = UDim2.new(0.5, -75, 0, 15)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)
local Stroke = Instance.new("UIStroke", TopBar)
Stroke.Color = Color3.fromRGB(85, 55, 160) -- Фиолетовый акцент
Drag(TopBar)

local TopBtn = Instance.new("TextButton", TopBar)
TopBtn.Size = UDim2.new(1, 0, 1, 0)
TopBtn.BackgroundTransparency = 1
TopBtn.Text = "Wellon CLOSE"
TopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TopBtn.Font = Enum.Font.GothamBold
TopBtn.TextSize = 13

-- Главное Окно
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 600, 0, 380)
Main.Position = UDim2.new(0.5, -300, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
Drag(Main)

-- Сайдбар с иконками
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 60, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Instance.new("UICorner", Sidebar)

local SidebarIcons = Instance.new("UIListLayout", Sidebar)
SidebarIcons.Padding = UDim.new(0, 15)
SidebarIcons.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Область контента
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -90, 1, -80)
Scroll.Position = UDim2.new(0, 80, 0, 50)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
local List = Instance.new("UIListLayout", Scroll)
List.Padding = UDim.new(0, 10)

-- 3. ЛОГИКА ЗАГРУЗЧИКА И ФУНКЦИЙ
local CurrentGame = "Unsupported"
if game.CreatorId == 33161040 then CurrentGame = "Bizarre Lineage"
elseif game.CreatorId == 6556072 then CurrentGame = "A Universal Time"
elseif game.CreatorId == 1002185259 then CurrentGame = "Sailor Piece" end

-- Заголовок игры сверху справа
local GameTitle = Instance.new("TextLabel", Main)
GameTitle.Size = UDim2.new(0, 150, 0, 30)
GameTitle.Position = UDim2.new(1, -160, 0, 10)
GameTitle.Text = CurrentGame
GameTitle.TextColor3 = Color3.fromRGB(150, 150, 170)
GameTitle.BackgroundTransparency = 1
GameTitle.Font = Enum.Font.Gotham
GameTitle.TextXAlignment = Enum.TextXAlignment.Right

-- ФУНКЦИЯ ДЛЯ ДОБАВЛЕНИЯ КНОПОК (Toggles)
local function AddToggle(name, callback)
    local Frame = Instance.new("Frame", Scroll)
    Frame.Size = UDim2.new(1, -10, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    Instance.new("UICorner", Frame)

    local L = Instance.new("TextLabel", Frame)
    L.Size = UDim2.new(0.7, 0, 1, 0)
    L.Position = UDim2.new(0, 15, 0, 0)
    L.Text = name
    L.TextColor3 = Color3.fromRGB(200, 200, 210)
    L.BackgroundTransparency = 1
    L.TextXAlignment = Enum.TextXAlignment.Left
    L.Font = Enum.Font.Gotham

    local T = Instance.new("TextButton", Frame)
    T.Size = UDim2.new(0, 40, 0, 20)
    T.Position = UDim2.new(0.85, 0, 0.25, 0)
    T.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    T.Text = ""
    Instance.new("UICorner", T).CornerRadius = UDim.new(1, 0)

    local state = false
    T.MouseButton1Click:Connect(function()
        state = not state
        T.BackgroundColor3 = state and Color3.fromRGB(85, 55, 160) or Color3.fromRGB(45, 45, 55)
        callback(state)
    end)
end

-- 4. НАПОЛНЕНИЕ (РАБОЧИЕ ФУНКЦИИ)
if CurrentGame == "Bizarre Lineage" then
    AddToggle("Auto Farm Mission", function(v) 
        _G.AutoFarm = v
        while _G.AutoFarm do
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.Communicate:FireServer("AcceptMission")
            end)
            task.wait(1)
        end
    end)
    AddToggle("Auto Meditation", function(v)
        _G.Meditation = v
        while _G.Meditation do
            pcall(function() game:GetService("ReplicatedStorage").Remotes.Meditation:FireServer(true) end)
            task.wait(0.5)
        end
    end)
end

-- Нижняя плашка
local Info = Instance.new("TextLabel", Main)
Info.Size = UDim2.new(0, 200, 0, 20)
Info.Position = UDim2.new(1, -210, 1, -25)
Info.Text = "Wellon | Build 2.0 | FPS: 60"
Info.TextColor3 = Color3.fromRGB(80, 80, 100)
Info.BackgroundTransparency = 1
Info.Font = Enum.Font.Gotham
Info.TextXAlignment = Enum.TextXAlignment.Right

-- Логика CLOSE / OPEN
TopBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    TopBtn.Text = Main.Visible and "Wellon CLOSE" or "Wellon OPEN"
end)

print("✅ Wellon Hub успешно загружен!")
