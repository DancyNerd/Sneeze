--[[
This script is to handle instance-oriented categories of achievements.
Specified eveents from Sneeze.lua will be used to trigger functions here.
]]--

local addonName, private = ...
print("Yes, this is empty right now.")

private.instanceTypeMap = {
    ["Uldaman: Legacy of Tyr"] = "Dungeon",
    ["Halls of Infusion"] = "Dungeon",
    ["Algeth'ar Academy"] = "Dungeon",
    ["Brackenhide Hollow"] = "Dungeon",
    ["Mists of Tirna Scithe"] = "Dungeon",
    ["The Azure Vault"] = "Dungeon",
    ["The Nokhud Offensive"] = "Dungeon",
    ["Ruby Life Pools"] = "Dungeon",
    ["The Vortex Pinnacle"] = "Dungeon",
    ["Black Rook Hold"] = "Dungeon",
    ["Court of Stars"] = "Dungeon",
    ["Darkheart Thicket"] = "Dungeon",
    ["Eye of Azshara"] = "Dungeon",
    ["Halls of Valor"] = "Dungeon",
    ["Maw of Souls"] = "Dungeon",
    ["Neltharion's Lair"] = "Dungeon",
    ["The Arcway"] = "Dungeon",
    ["The Black Temple"] = "Raid",
    ["The Nighthold"] = "Raid",
    ["Tomb of Sargeras"] = "Raid",
    ["Antorus, the Burning Throne"] = "Raid",
    ["Uldir"] = "Raid",
    ["Battle of Dazar'alor"] = "Raid",
    ["Crucible of Storms"] = "Raid",
    ["Ny'alotha, the Waking City"] = "Raid",
    ["Tak-Rethan Abyss"] = "Delve"
}



local function delveStory(storyInfo)
    print(storyInfo)
end

function private.instanceType(typeOfInstance)
    local fromMapping = private.catchMappingNeeds(typeOfInstance)
    if typeOfInstance == "Delve" then
        delveStory(fromMapping)
    end
end
