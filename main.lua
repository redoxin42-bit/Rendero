-- // Made by @Flames9925 | Edited by @NyxaSylph
-- // Wellon Hub Official Loader

local cloneref = (cloneref or clonereference or function(instance)
    return instance
end)

local Players = cloneref(game:GetService("Players"))
local VirtualUser = cloneref(game:GetService("VirtualUser"))
local LPlayer = Players.LocalPlayer

repeat task.wait() until game:IsLoaded() and LPlayer

LPlayer.Idled:Connect(function()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

local Wellon = {}

Wellon.Files = {
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

function Wellon:LoadByCreatorId(CreatorId)
    for GameName, Data in pairs(self.Files) do
        if Data.CreatorId == CreatorId then
            
            -- Ссылка теперь ведет на твой репозиторий Rendero
            local Url = "https://raw.githubusercontent.com/Redoxin42-bit/Rendero/main/" .. Data.File
            
            local Success, Result = pcall(function()
                return loadstring(game:HttpGet(Url))()
            end)

            if Success then
                print("✅ Wellon Hub Loaded:", GameName)
            else
                warn("❌ Wellon Load failed:", Result)
            end

            return
        end
    end

    warn("WELLON HUB: UNSUPPORTED GAME 🤡")
end

Wellon:LoadByCreatorId(game.CreatorId)
return Wellon
