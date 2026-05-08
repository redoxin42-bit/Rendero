-- // Wellon Hub | Official Loader
-- // Исправлено специально для redoxin42-bit

local cloneref = (cloneref or clonereference or function(instance) return instance end)
local Players = cloneref(game:GetService("Players"))
local VirtualUser = cloneref(game:GetService("VirtualUser"))
local LPlayer = Players.LocalPlayer

repeat task.wait() until game:IsLoaded() and LPlayer

-- Анти-АФК
LPlayer.Idled:Connect(function()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

-- ЭТОТ БЛОК МЕНЯЕТ ТЕКСТ В КРАСНЫХ КРУЖОЧКАХ
local function ForceWellonBranding()
    task.spawn(function()
        while task.wait(0.5) do -- Проверяем каждые полсекунды
            for _, v in pairs(game:GetService("CoreGui"):GetDescendants()) do
                if v:IsA("TextLabel") or v:IsA("TextButton") then
                    -- Если находим старое название, заменяем на Wellon
                    if v.Text:find("Vellure") then
                        v.Text = v.Text:gsub("Vellure", "Wellon")
                    end
                end
            end
        end
    end)
end

local Wellon = {}

Wellon.Files = {
    ["Bizzare Lineage"] = { File = "BA/Main.lua", CreatorId = 33161040 },
    ["A Universal Time"] = { File = "AUT/Main.lua", CreatorId = 6556072 },
    ["Sailor Piece"] = { File = "SP/Main.lua", CreatorId = 1002185259 }
}

function Wellon:LoadByCreatorId(CreatorId)
    for GameName, Data in pairs(self.Files) do
        if Data.CreatorId == CreatorId then
            local Url = "https://raw.githubusercontent.com/NyxaSylph/Vellure/main/" .. Data.File
            
            local Success, Result = pcall(function()
                return loadstring(game:HttpGet(Url))()
            end)

            if Success then
                print("✅ Wellon Hub: Успешно загружено!") --
                ForceWellonBranding() -- ЗАПУСКАЕМ ИСПРАВЛЕНИЕ НАЗВАНИЙ
            else
                warn("❌ Wellon Hub: Ошибка загрузки")
            end
            return
        end
    end
end

Wellon:LoadByCreatorId(game.CreatorId)
return Wellon
