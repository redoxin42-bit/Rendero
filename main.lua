-- // Wellon Hub | Made by @redoxin42-bit
-- // Based on Vellure Technology

local cloneref = (cloneref or clonereference or function(instance)
    return instance
end)

local Players = cloneref(game:GetService("Players"))
local VirtualUser = cloneref(game:GetService("VirtualUser"))
local LPlayer = Players.LocalPlayer

repeat task.wait() until game:IsLoaded() and LPlayer

-- Анти-АФК система
LPlayer.Idled:Connect(function()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

-- Создание твоей круглой иконки Wellon
local ScreenGui = Instance.new("ScreenGui", LPlayer.PlayerGui)
ScreenGui.Name = "Wellon_Loader_UI"

local Icon = Instance.new("TextButton", ScreenGui)
Icon.Size = UDim2.new(0, 60, 0, 60)
Icon.Position = UDim2.new(0, 20, 0.5, -30)
Icon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Icon.Text = "Wellon"
Icon.TextColor3 = Color3.fromRGB(255, 255, 255)
Icon.Font = Enum.Font.GothamBold
Icon.TextSize = 12
Instance.new("UICorner", Icon).CornerRadius = UDim.new(1, 0)
local Stroke = Instance.new("UIStroke", Icon)
Stroke.Color = Color3.fromRGB(255, 255, 255)
Stroke.Thickness = 2

local WellonLoader = {}

-- Список поддерживаемых игр и пути к ним
WellonLoader.Files = {
    ["Bizzare Lineage"] = {
        File = "BA/Main.lua",
        CreatorId = 33161040
    },
    ["A Universal Time"] = {
        File = "AUT/Main.lua",
        CreatorId = 6556072
    },
    ["Sailor Piece"] = {
        File = "SP/Main.lua",
        CreatorId = 1002185259
    }
}

function WellonLoader:LoadByCreatorId(CreatorId)
    for GameName, Data in pairs(self.Files) do
        if Data.CreatorId == CreatorId then
            -- Используем оригинальный источник, но под брендом Wellon
            local Url = "https://raw.githubusercontent.com/NyxaSylph/Vellure/main/" .. Data.File
            
            local Success, Result = pcall(function()
                return loadstring(game:HttpGet(Url))()
            end)

            if Success then
                print("✅ Wellon Hub Loaded:", GameName)
                -- Уведомление в игре
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Wellon Hub",
                    Text = GameName .. " успешно загружен!",
                    Duration = 5
                })
            else
                warn("❌ Wellon Load failed:", Result)
            end
            return
        end
    end
    warn("WELLON HUB: UNSUPPORTED GAME")
end

-- Запуск загрузки
WellonLoader:LoadByCreatorId(game.CreatorId)

return WellonLoader
