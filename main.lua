-- // Made by @Flames9925 | Edited by @NyxaSylph
-- // Wellon Hub | redoxin42-bit Edition

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

local WellonHub = {}

-- Список поддерживаемых игр и пути к ним
WellonHub.Files = {
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

function WellonHub:LoadByCreatorId(CreatorId)
    for GameName, Data in pairs(self.Files) do
        if Data.CreatorId == CreatorId then
            -- Используем оригинальный источник, но под брендом Wellon
            local Url = "https://raw.githubusercontent.com/NyxaSylph/Vellure/main/" .. Data.File
            
            local Success, Result = pcall(function()
                return loadstring(game:HttpGet(Url))()
            end)

            if Success then
                -- Вывод в консоль уже с твоим названием
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

-- Запуск загрузчика по ID игры
WellonHub:LoadByCreatorId(game.CreatorId)

return WellonHub
