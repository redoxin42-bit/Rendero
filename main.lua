-- // Wellon Hub | redoxin42-bit Edition
-- // Made by @Flames9925 | Edited by @NyxaSylph

local cloneref = (cloneref or clonereference or function(instance) return instance end)
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

-- ФУНКЦИЯ ДЛЯ ЗАМЕНЫ ТЕКСТА В МЕНЮ (WELLON)
local function ApplyWellonBranding()
    task.spawn(function()
        while task.wait(1) do
            -- Ищем все объекты, где может быть написано Vellure
            for _, v in pairs(game:GetService("CoreGui"):GetDescendants()) do
                if v:IsA("TextLabel") or v:IsA("TextButton") then
                    -- Меняем Vellure на Wellon в верхней кнопке и внизу
                    if v.Text:find("Vellure") then
                        v.Text = v.Text:gsub("Vellure", "Wellon")
                    end
                end
            end
        end
    end)
end

local WellonHub = {}

WellonHub.Files = {
    ["Bizzare Lineage"] = { File = "BA/Main.lua", CreatorId = 33161040 },
    ["A Universal Time"] = { File = "AUT/Main.lua", CreatorId = 6556072 },
    ["Sailor Piece"] = { File = "SP/Main.lua", CreatorId = 1002185259 }
}

function WellonHub:LoadByCreatorId(CreatorId)
    for GameName, Data in pairs(self.Files) do
        if Data.CreatorId == CreatorId then
            local Url = "https://raw.githubusercontent.com/NyxaSylph/Vellure/main/" .. Data.File
            
            local Success, Result = pcall(function()
                return loadstring(game:HttpGet(Url))()
            end)

            if Success then
                print("✅ Wellon Hub Loaded:", GameName)
                ApplyWellonBranding() -- Запускаем подмену текста после загрузки
            else
                warn("❌ Wellon Load failed:", Result)
            end
            return
        end
    end
    warn("WELLON HUB: UNSUPPORTED GAME")
end

WellonHub:LoadByCreatorId(game.CreatorId)
return WellonHub
