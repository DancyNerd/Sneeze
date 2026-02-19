--[[
This script is to handle instance-oriented categories of achievements.
Specified events from Sneeze.lua will be used to trigger functions here.
]]--

local addonName, private = ...
private.instanceType = ""
private.instanceName = ""
private.bountifulID = 0
private.instanceID = 0

--[[
This may need to function very differently from how I originally imagined. The delve stories are only visible as an XML element when viewing the difficulty picker.
Instead af trying to catch the delves and return whether it is missing story mid-delve, we can pre-empt that by catching the GOSSIP_SHOW trigger with "delves-difficulty-picker" as the trigger.
We should be able to get the achievement data from the achievement, but we might have to key delves to achievement IDs rather than their item IDs for the map.
Since both might be helpful, we can leave the tables as they are and just add the new one for now.
]]--



local function delveStory()
    if private.instanceName then
        local delveInfo
        local playerMapID = C_Map.GetBestMapForUnit("player")
        if C_AreaPoiInfo.GetAreaPOIInfo(playerMapID, private.instanceID) then
            local delveInfo = C_AreaPoiInfo.GetAreaPOIInfo(playerMapID, private.instanceID)
            --print("Delve is not bountiful and " .. private.instanceName)
        else
            delveInfo = C_AreaPoiInfo.GetAreaPOIInfo(playerMapID, private.bountifulID)
            --print("Delve is bountiful and " .. private.instanceName)
        end
    end
end

private.instanceTypeMap = {
    ["Uldaman: Legacy of Tyr"] = function()
        private.instanceType = "Dungeon"
        private.instanceID = 7216
        private.instanceName = "Uldaman: Legacy of Tyr"
    end,
    ["Halls of Infusion"] = function()
        private.instanceType = "Dungeon"
        private.instanceID = 7210
        private.instanceName = "Halls of Infusion"
    end,
    ["Algeth'ar Academy"] = function()
        private.instanceType = "Dungeon"
        private.instanceID = 7213
        private.instanceName = "Algeth'ar Academy"
    end,
    ["Brackenhide Hollow"] = function()
        private.instanceType = "Dungeon"
        private.instanceID = 7209
        private.instanceName = "Brackenhide Hollow"
    end,
    ["Mists of Tirna Scithe"] = function()
        private.instanceType = "Dungeon"
        private.instanceID = 6586
        private.instanceName = "Mists of Tirna Scithe"
    end,
    ["The Azure Vault"] = function()
        private.instanceType = "Dungeon"
        private.instanceID = 7214
        private.instanceName = "The Azure Vault"
    end,
    ["The Nokhud Offensive"] = function()
        private.instanceType = "Dungeon"
        private.instanceID = 7215
        private.instanceName = "The Nokhud Offensive"
    end,
    ["Ruby Life Pools"] = function()
        private.instanceType = "Dungeon"
        private.instanceID = 7212
        private.instanceName = "Ruby Life Pools"
    end,
    ["The Vortex Pinnacle"] = function()
        private.instanceType = "Dungeon"
        private.instanceID = 6685
        private.instanceName = "The Vortex Pinnacle"
    end,
    ["Black Rook Hold"] = function()
        private.instanceType = "Dungeon"
        private.instanceID = 5093
        private.instanceName = "Black Rook Hold"
    end,
    ["Court of Stars"] = function()
        private.instanceType = "Dungeon"
        private.instanceID = 5100
        private.instanceName = "Court of Stars"
    end,
    ["Darkheart Thicket"] = function()
        private.instanceType = "Dungeon"
        private.instanceID = 5094
        private.instanceName = "Darkheart Thicket"
    end,
    ["Eye of Azshara"] = function()
        private.instanceType = "Dungeon"
        private.instanceID = 5091
        private.instanceName = "Eye of Azshara"
    end,
    ["Halls of Valor"] = function()
        private.instanceType = "Dungeon"
        private.instanceID = 6091
        private.instanceName = "Halls of Valor"
    end,
    ["Maw of Souls"] = function()
        private.instanceType = "Dungeon"
        private.instanceID = 5097
        private.instanceName = "Maw of Souls"
    end,
    ["Neltharion's Lair"] = function()
        private.instanceType = "Dungeon"
        private.instanceID = 5103
        private.instanceName = "Neltharion's Lair"
    end,
    ["The Arcway"] = function()
        private.instanceType = "Dungeon"
        private.instanceID = 5099
        private.instanceName = "The Arcway"
    end,
    ["Black Temple"] = function()
        private.instanceType = "Raid"
        private.instanceID = 6532
        private.instanceName = "Black Temple"
    end,
    ["The Nighthold"] = function()
        private.instanceType = "Raid"
        private.instanceID = 5101
        private.instanceName = "The Nighthold"
    end,
    ["Tomb of Sargeras"] = function()
        private.instanceType = "Raid"
        private.instanceID = 5250
        private.instanceName = "Tomb of Sargeras"
    end,
    ["Antorus, the Burning Throne"] = function()
        private.instanceType = "Raid"
        private.instanceID = 5440
        private.instanceName = "Antorus, the Burning Throne"
    end,
    ["Uldir"] = function()
        private.instanceType = "Raid"
        private.instanceID = 5842
        private.instanceName = "Uldir"
    end,
    ["Battle of Dazar'alor"] = function()
        private.instanceType = "Raid"
        private.instanceID = 6013
        private.instanceName = "Battle of Dazar'alor"
    end,
    ["Crucible of Storms"] = function()
        private.instanceType = "Raid"
        private.instanceID = 6116
        private.instanceName = "Crucible of Storms"
    end,
    ["Ny'alotha, the Waking City"] = 6539,
    ["Serpentshrine Cavern"] = function()
        private.instanceType = "Raid"
        private.instanceID = 6530
        private.instanceName = "Serpentshrine Cavern"
    end,
    ["Tak-Rethan Abyss"] = function()
        private.instanceType = "Delve"
        private.instanceID = 7873
        private.bountifulID = 7784
        private.instanceName = "Tak-Rethan Abyss"
        delveStory()
    end,
    ["Skittering Breach"] = function()
        private.instanceType = "Delve"
        private.instanceID = 7871
        private.bountifulID = 7789
        private.instanceName = "Skittering Breach"
        delveStory()
    end,
    ["The Sinkhole"] = function()
        private.instanceType = "Delve"
        private.instanceID = 7870
        private.bountifulID = 7783
        private.instanceName = "The Sinkhole"
        delveStory()
    end,
    ["Nightfall Sanctum"] = function()
        private.instanceType = "Delve"
        private.instanceID = 7868
        private.bountifulID = 7785
        private.instanceName = "Nightfall Sanctum"
        delveStory()
    end,
    ["Mycomancer Cavern"] = function()
        private.instanceType = "Delve"
        private.instanceID = 7869
        private.bountifulID = 7780
        private.instanceName = "Mycomancer Cavern"
        delveStory()
    end,
    ["Fungal Folly"] = function()
        private.instanceType = "Delve"
        private.instanceID = 7864
        private.bountifulID = 7779
        private.instanceName = "Fungal Folly"
        delveStory()
    end,
    ["Earthcrawl Mines"] = function()
        private.instanceType = "Delve"
        private.instanceID = 7863
        private.bountifulID = 7787
        private.instanceName = "Earthcrawl Mines"
        delveStory()
    end,
    ["Kriegval's Rest"] = function()
        private.instanceType = "Delve"
        private.instanceID = 7865
        private.bountifulID = 7781
        private.instanceName = "Kriegval's Rest"
        delveStory()
    end,
    ["The Spiral Weave"] = function()
        private.instanceType = "Delve"
        private.instanceID = 7874
        private.bountifulID = 7790
        private.instanceName = "The Spiral Weave"
        delveStory()
    end,
    ["The Underkeep"] = function()
        private.instanceType = "Delve"
        private.instanceID = 7872
        private.bountifulID = 7786
        private.instanceName = "The Underkeep"
        delveStory()
    end,
    ["The Dread Pit"] = function()
        private.instanceType = "Delve"
        private.instanceID = 7867
        private.bountifulID = 7788
        private.instanceName = "The Dread Pit"
        delveStory()
    end,
    ["The Waterworks"] = function()
        private.instanceType = "Delve"
        private.instanceID = 7866
        private.bountifulID = 7782
        private.instanceName = "The Waterworks"
        delveStory()
    end,
    ["Excavation Site 9"] = function()
        private.instanceType = "Delve"
        private.instanceID = 7870
        private.bountifulID = 7783
        private.instanceName = "Excavation Site 9"
        delveStory()
    end,
    ["Sidestreet Sluice"] = function()
        private.instanceType = "Delve"
        private.instanceID = 7871
        private.bountifulID = 7789
        private.instanceName = "Sidestreet Sluice"
        delveStory()
    end,
    ["Demolition Dome"] = function()
        private.instanceType = "Delve"
        private.instanceID = 7873
        private.bountifulID = 7784
        private.instanceName = "Demolition Dome"
        delveStory()
    end
}


--

--delve achievement category ID for The War Within is 15523


--[[function private.instanceType(typeOfInstance, instanceName)
    local playerMapID = private.catchMappingNeeds(typeOfInstance)
    if typeOfInstance == "Delve" then
        delveStory(playerMapID, instanceName)
    end
end]]--

--CVAR_UPDATE "lastSelectedDelvesTier", "8"
--CHAT_MSG_SYSTEM when first return var set to "Dungeon Difficulty set to Delves." trigger instance type delves and search for active story from poi info.