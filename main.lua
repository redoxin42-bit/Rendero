local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "WellonHub_Elite"
ScreenGui.ResetOnSpawn = false

-- 1. ВЕРХНЯЯ ПАНЕЛЬ УПРАВЛЕНИЯ (Wellon CLOSE/OPEN)
local TopBar = Instance.new("Frame", ScreenGui)
TopBar.Size = UDim2.new(0, 150, 0, 30)
TopBar.Position = UDim2.new(0.85, 0, 0.05, 0) -- Справа сверху как на видео
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 5)

local TopBtn = Instance.new("TextButton", TopBar)
TopBtn.Size = UDim2.new(1, 0, 1, 0)
TopBtn.BackgroundTransparency = 1
TopBtn.Text = "Wellon CLOSE"
TopBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
TopBtn.Font = Enum.Font.GothamBold
TopBtn.TextSize = 12

-- 2. ГЛАВНОЕ ОКНО
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 600, 0, 400)
Main.Position = UDim2.new(0.5, -300, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

-- Боковое меню (С иконками разделов)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 50, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)
local SidebarList = Instance.new("UIListLayout", Sidebar)
SidebarList.Padding = UDim.new(0, 15)
SidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Заголовок в центре сверху (Main / Bizarre Lineage)
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -50, 0, 30)
Title.Position = UDim2.new(0, 50, 0, 5)
Title.Text = "Main | Bizarre Lineage"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1

-- Контейнер функций (Scrolling)
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -70, 1, -60)
Scroll.Position = UDim2.new(0, 60, 0, 40)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
local List = Instance.new("UIListLayout", Scroll)
List.Padding = UDim.new(0, 8)

-- 3. ФУНКЦИЯ СОЗДАНИЯ СЕКЦИЙ (АККОРДЕОНЫ)
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
        Frame:TweenSize(open and UDim2.new(1, -10, 0, 35 + (#items * 35)) or UDim2.new(1, -10, 0, 35), "Out", "Quad", 0.2, true)
    end)

    for i, data in ipairs(items) do
        local row = Instance.new("Frame", Frame)
        row.Size = UDim2.new(1, -10, 0, 30)
        row.Position = UDim2.new(0, 5, 0, 35 + (i-1)*35)
        row.BackgroundTransparency = 1
        
        local label = Instance.new("TextLabel", row)
        label.Size = UDim2.new(0.8, 0, 1, 0)
        label.Text = data.text
        label.TextColor3 = Color3.fromRGB(180, 180, 180)
        label.BackgroundTransparency = 1
        label.TextXAlignment = Enum.TextXAlignment.Left
        
        local toggle = Instance.new("TextButton", row)
        toggle.Size = UDim2.new(0, 40, 0, 20)
        toggle.Position = UDim2.new(0.85, 0, 0.2, 0)
        toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        toggle.Text = ""
        Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)
    end
end

-- 4. ПОЛНЫЙ СПИСОК ФУНКЦИЙ VELLURE

-- Раздел Automation
NewSection("Automation", {
    {text = "Auto Mission"},
    {text = "Auto-PVP Mission [MAIN]"},
    {text = "Auto-PVP Mission [ALT]"},
    {text = "Auto Meditation"},
    {text = "Auto Gang Contract"},
    {text = "Auto Prestige"},
    {text = "Auto World Event (Graveyard)"}
})

-- Раздел Skills
NewSection("Skills", {
    {text = "Auto Skills (R,Z,X,C,V,E)"},
    {text = "Main Skills"},
    {text = "Sub Abilities"},
    {text = "Fighting Ability"}
})

-- Раздел Raids & Bosses
NewSection("Raids", {
    {text = "Auto Raid (UnderMap)"},
    {text = "Auto Raid (Above)"},
    {text = "Auto Play Again (Raid)"},
    {text = "Auto Boss Farm"}
})

-- Раздел Misc (Настройки как на видео)
NewSection("Misc / Settings", {
    {text = "Anti-AFK"},
    {text = "Hide UI"},
    {text = "FPS Cap"},
    {text = "Join Discord"}
})

-- 5. ИНФОРМАЦИЯ О СЕРВЕРЕ (Снизу справа)
local Info = Instance.new("TextLabel", Main)
Info.Size = UDim2.new(0, 200, 0, 20)
Info.Position = UDim2.new(1, -210, 1, -25)
Info.Text = "Wellon | Build 1.7 | 61 FPS"
Info.TextColor3 = Color3.fromRGB(100, 100, 110)
Info.BackgroundTransparency = 1
Info.Font = Enum.Font.Gotham
Info.TextSize = 10

-- Логика кнопки переключения
TopBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    TopBtn.Text = Main.Visible and "Wellon CLOSE" or "Wellon OPEN"
end)
