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


--private.constMapID comes from SneezeMapping.
local function delveStory()
    if private.instanceName then
        local delveInfo
        if C_AreaPoiInfo.GetAreaPOIInfo(private.constMapID, private.instanceID) then
            delveInfo = C_AreaPoiInfo.GetAreaPOIInfo(private.constMapID, private.instanceID)
            --print("Delve is not bountiful and " .. private.instanceName)
        else
            delveInfo = C_AreaPoiInfo.GetAreaPOIInfo(private.constMapID, private.bountifulID)
            --print("Delve is bountiful and " .. private.instanceName)
        end
    end
end

private.instanceTypeMap = {
    ["Ahn'kahet: The Old Kingdom"] = function() --Wrath of the Lich King
        private.instanceType = "Dungeon"
        private.instanceID = 6704
        private.instanceName = "Ahn'kahet: The Old Kingdom"
    end,
    ["Azjol-Nerub"] = function() --Wrath of the Lich King
        private.instanceType = "Dungeon"
        private.instanceID = 6703
        private.instanceName = "Azjol-Nerub"
    end,
    ["Drak'Tharon Keep"] = function() --Wrath of the Lich King
        private.instanceType = "Dungeon"
        private.instanceID = 6702
        private.instanceName = "Drak'Tharon Keep"
    end,
    ["Gundrak"] = function() --Wrath of the Lich King
        private.instanceType = "Dungeon"
        private.instanceID = 7699
        private.instanceName = "Gundrak"
    end,
    ["Halls of Lightning"] = function() --Wrath of the Lich King
        private.instanceType = "Dungeon"
        private.instanceID = 6699
        private.instanceName = "Halls of Lightning"
    end,
    ["Halls of Reflection"] = function() --Wrath of the Lich King
        private.instanceType = "Dungeon"
        private.instanceID = 6698
        private.instanceName = "Halls of Reflection"
    end,
    ["Halls of Stone"] = function() --Wrath of the Lich King
        private.instanceType = "Dungeon"
        private.instanceID = 6700
        private.instanceName = "Halls of Stone"
    end,
    ["Pit of Saron"] = function() --Wrath of the Lich King
        private.instanceType = "Dungeon"
        private.instanceID = 6697
        private.instanceName = "Pit of Saron"
    end,
    ["The Forge of Souls"] = function() --Wrath of the Lich King
        private.instanceType = "Dungeon"
        private.instanceID = 6696
        private.instanceName = "The Forge of Souls"
    end,
    ["The Nexus"] = function() --Wrath of the Lich King
        private.instanceType = "Dungeon"
        private.instanceID = 6695
        private.instanceName = "The Nexus"
    end,
    ["The Oculus"] = function() --Wrath of the Lich King
        private.instanceType = "Dungeon"
        private.instanceID = 6694
        private.instanceName = "The Oculus"
    end,
    ["The Violet Hold"] = function() --This may be tricky due to Legion/Wrath overlap
        private.instanceType = "Dungeon"
        private.instanceID = 5098
        private.instanceName = "The Violet Hold"
    end,
    ["Trial of the Champion"] = function() --Wrath of the Lich King
        private.instanceType = "Dungeon"
        private.instanceID = 6692
        private.instanceName = "Trial of the Champion"
    end,
    ["Utgarde Keep"] = function() --Wrath of the Lich King
        private.instanceType = "Dungeon"
        private.instanceID = 6691
        private.instanceName = "Utgarde Keep"
    end,
    ["Utgarde Pinnacle"] = function() --Wrath of the Lich King
        private.instanceType = "Dungeon"
        private.instanceID = 6690
        private.instanceName = "Utgarde Pinnacle"
    end,
    ["Uldaman: Legacy of Tyr"] = function() --Dragonflight
        private.instanceType = "Dungeon"
        private.instanceID = 7216
        private.instanceName = "Uldaman: Legacy of Tyr"
    end,
    ["Halls of Infusion"] = function() --Dragonflight
        private.instanceType = "Dungeon"
        private.instanceID = 7210
        private.instanceName = "Halls of Infusion"
    end,
    ["Algeth'ar Academy"] = function() --Dragonflight
        private.instanceType = "Dungeon"
        private.instanceID = 7213
        private.instanceName = "Algeth'ar Academy"
    end,
    ["Brackenhide Hollow"] = function() --Dragonflight
        private.instanceType = "Dungeon"
        private.instanceID = 7209
        private.instanceName = "Brackenhide Hollow"
    end,
    ["Mists of Tirna Scithe"] = function() --Shadowlands
        private.instanceType = "Dungeon"
        private.instanceID = 6586
        private.instanceName = "Mists of Tirna Scithe"
    end,
    ["The Azure Vault"] = function() --Dragonflight
        private.instanceType = "Dungeon"
        private.instanceID = 7214
        private.instanceName = "The Azure Vault"
    end,
    ["The Nokhud Offensive"] = function() --Dragonflight
        private.instanceType = "Dungeon"
        private.instanceID = 7215
        private.instanceName = "The Nokhud Offensive"
    end,
    ["Ruby Life Pools"] = function() --Dragonflight
        private.instanceType = "Dungeon"
        private.instanceID = 7212
        private.instanceName = "Ruby Life Pools"
    end,
    ["The Vortex Pinnacle"] = function() --Cataclysm
        private.instanceType = "Dungeon"
        private.instanceID = 6685
        private.instanceName = "The Vortex Pinnacle"
    end,
    ["Black Rook Hold"] = function() --Legion
        private.instanceType = "Dungeon"
        private.instanceID = 5093
        private.instanceName = "Black Rook Hold"
    end,
    ["Court of Stars"] = function() --Legion
        private.instanceType = "Dungeon"
        private.instanceID = 5100
        private.instanceName = "Court of Stars"
    end,
    ["Darkheart Thicket"] = function() --Legion
        private.instanceType = "Dungeon"
        private.instanceID = 5094
        private.instanceName = "Darkheart Thicket"
    end,
    ["Eye of Azshara"] = function() --Legion
        private.instanceType = "Dungeon"
        private.instanceID = 5091
        private.instanceName = "Eye of Azshara"
    end,
    ["Halls of Valor"] = function() --Legion
        private.instanceType = "Dungeon"
        private.instanceID = 6091
        private.instanceName = "Halls of Valor"
    end,
    ["Maw of Souls"] = function() --Legion
        private.instanceType = "Dungeon"
        private.instanceID = 5097
        private.instanceName = "Maw of Souls"
    end,
    ["Neltharion's Lair"] = function() --Legion
        private.instanceType = "Dungeon"
        private.instanceID = 5103
        private.instanceName = "Neltharion's Lair"
    end,
    ["The Arcway"] = function() --Legion
        private.instanceType = "Dungeon"
        private.instanceID = 5099
        private.instanceName = "The Arcway"
    end,
    ["The Dawnbreaker"] = function() --The War Within
        private.instanceType = "Dungeon"
        private.instanceID =  7892
        private.instanceName = "The Dawnbreaker"
    end,
    ["Priory of the Sacred Flame"] = function() --The War Within
        private.instanceType = "Dungeon"
        private.instanceID = 7858
        private.instanceName = "Priory of the Sacred Flame"
    end,
    ["Operation: Floodgate"] = function() --The War Within
        private.instanceType = "Dungeon"
        private.instanceID = 8162
        private.instanceName = "Operation: Floodgate"
    end,
    ["Darkflame Cleft"] = function() --The War Within
        private.instanceType = "Dungeon"
        private.instanceID = 7821
        private.instanceName = "Darkflame Cleft"
    end,
    ["The Stonevault"] = function() --The War Within
        private.instanceType = "Dungeon"
        private.instanceID = 7820
        private.instanceName = "The Stonevault"
    end,
    ["City of Threads"] = function() --The War Within
        private.instanceType = "Dungeon"
        private.instanceID = 7862
        private.instanceName = "City of Threads"
    end,
    ["Ara-Kara, City of Echoes"] = function() --The War Within
        private.instanceType = "Dungeon"
        private.instanceID = 7545
        private.instanceName = "Ara-Kara, City of Echoes"
    end,
    ["Cinderbrew Meadery"] = function() --The War Within
        private.instanceType = "Dungeon"
        private.instanceID = 7857
        private.instanceName = "Cinderbrew Meadery"
    end,
    ["Tazavesh, the Veiled Market"] = function() --The War Within
        private.instanceType = "Dungeon"
        private.instanceID = 8374
        private.instanceName = "Tazavesh, the Veiled Market"
    end,
    ["The Rookery"] = function() --The War Within
        private.instanceType = "Dungeon"
        private.instanceID = 7655
        private.instanceName = "The Rookery"
    end,
    ["Eco-Dome Al'Dani"] = function() --The War Within
        private.instanceType = "Dungeon"
        private.instanceID = 8321
        private.instanceName = "Eco-Dome Al'Dani"
    end,
    ["Black Temple"] = function() --Burning Crusades
        private.instanceType = "Raid"
        private.instanceID = 6532
        private.instanceName = "Black Temple"
    end,
    ["Icecrown Citadel"] = function() --Wrath of the Lich King
        private.instanceType = "Raid"
        private.instanceID = 6521
        private.instanceName = "Icecrown Citadel"
    end,
    ["Naxxramas"] = function() --Wrath of the Lich King
        private.instanceType = "Raid"
        private.instanceID = 6524
        private.instanceName = "Naxxramas"
    end,
    ["The Eye of Eternity"] = function() --Wrath of the Lich King
        private.instanceType = "Raid"
        private.instanceID = 6525
        private.instanceName = "The Eye of Eternity"
    end,
    ["The Obsidian Sanctum"] = function() --Wrath of the Lich King
        private.instanceType = "Raid"
        private.instanceID = 6520
        private.instanceName = "The Obsidian Sanctum"
    end,
    ["The Ruby Sanctum"] = function() --Wrath of the Lich King
        private.instanceType = "Raid"
        private.instanceID = 6519
        private.instanceName = "The Ruby Sanctum"
    end,
    ["Trial of the Crusader"] = function() --Wrath of the Lich King
        private.instanceType = "Raid"
        private.instanceID = 6522
        private.instanceName = "Trial of the Crusader"
    end,
    ["Ulduar"] = function() --Wrath of the Lich King
        private.instanceType = "Raid"
        private.instanceID = 6523
        private.instanceName = "Ulduar"
    end,
    ["Vault of the Archavon"] = function() --Wrath of the Lich King
        private.instanceType = "Raid"
        private.instanceID = 6526
        private.instanceName = "Vault of the Archavon"
    end,
   ["The Nighthold"] = function() --Legion
        private.instanceType = "Raid"
        private.instanceID = 5101
        private.instanceName = "The Nighthold"
    end,
    ["Tomb of Sargeras"] = function() --Legion
        private.instanceType = "Raid"
        private.instanceID = 5250
        private.instanceName = "Tomb of Sargeras"
    end,
    ["Antorus, the Burning Throne"] = function() --Legion
        private.instanceType = "Raid"
        private.instanceID = 5440
        private.instanceName = "Antorus, the Burning Throne"
    end,
    ["Uldir"] = function() --Battle for Azeroth
        private.instanceType = "Raid"
        private.instanceID = 5842
        private.instanceName = "Uldir"
    end,
    ["Battle of Dazar'alor"] = function() --Battle for Azeroth
        private.instanceType = "Raid"
        private.instanceID = 6013
        private.instanceName = "Battle of Dazar'alor"
    end,
    ["Crucible of Storms"] = function() --Battle for Azeroth
        private.instanceType = "Raid"
        private.instanceID = 6116
        private.instanceName = "Crucible of Storms"
    end,
    ["Ny'alotha, the Waking City"] = function() --Battle for Azeroth
        private.instanceType = "Raid"
        private.instanceID = 6539
        private.instanceName = "Ny'alotha, the Waking City"
    end,
    ["Serpentshrine Cavern"] = function() --Burning Crusades
        private.instanceType = "Raid"
        private.instanceID = 6530
        private.instanceName = "Serpentshrine Cavern"
    end,
    ["Tak-Rethan Abyss"] = function() --The War Within
        private.instanceType = "Delve"
        private.instanceID = 7873
        private.bountifulID = 7784
        private.instanceName = "Tak-Rethan Abyss"
        delveStory()
    end,
    ["Skittering Breach"] = function() --The War Within
        private.instanceType = "Delve"
        private.instanceID = 7871
        private.bountifulID = 7789
        private.instanceName = "Skittering Breach"
        delveStory()
    end,
    ["The Sinkhole"] = function() --The War Within
        private.instanceType = "Delve"
        private.instanceID = 7870
        private.bountifulID = 7783
        private.instanceName = "The Sinkhole"
        delveStory()
    end,
    ["Nightfall Sanctum"] = function() --The War Within
        private.instanceType = "Delve"
        private.instanceID = 7868
        private.bountifulID = 7785
        private.instanceName = "Nightfall Sanctum"
        delveStory()
    end,
    ["Mycomancer Cavern"] = function() --The War Within
        private.instanceType = "Delve"
        private.instanceID = 7869
        private.bountifulID = 7780
        private.instanceName = "Mycomancer Cavern"
        delveStory()
    end,
    ["Fungal Folly"] = function() --The War Within
        private.instanceType = "Delve"
        private.instanceID = 7864
        private.bountifulID = 7779
        private.instanceName = "Fungal Folly"
        delveStory()
    end,
    ["Earthcrawl Mines"] = function() --The War Within
        private.instanceType = "Delve"
        private.instanceID = 7863
        private.bountifulID = 7787
        private.instanceName = "Earthcrawl Mines"
        delveStory()
    end,
    ["Kriegval's Rest"] = function() --The War Within
        private.instanceType = "Delve"
        private.instanceID = 7865
        private.bountifulID = 7781
        private.instanceName = "Kriegval's Rest"
        delveStory()
    end,
    ["The Spiral Weave"] = function() --The War Within
        private.instanceType = "Delve"
        private.instanceID = 7874
        private.bountifulID = 7790
        private.instanceName = "The Spiral Weave"
        delveStory()
    end,
    ["The Underkeep"] = function() --The War Within
        private.instanceType = "Delve"
        private.instanceID = 7872
        private.bountifulID = 7786
        private.instanceName = "The Underkeep"
        delveStory()
    end,
    ["The Dread Pit"] = function() --The War Within
        private.instanceType = "Delve"
        private.instanceID = 7867
        private.bountifulID = 7788
        private.instanceName = "The Dread Pit"
        delveStory()
    end,
    ["The Waterworks"] = function() --The War Within
        private.instanceType = "Delve"
        private.instanceID = 7866
        private.bountifulID = 7782
        private.instanceName = "The Waterworks"
        delveStory()
    end,
    ["Excavation Site 9"] = function() --The War Within
        private.instanceType = "Delve"
        private.instanceID = 7870
        private.bountifulID = 7783
        private.instanceName = "Excavation Site 9"
        delveStory()
    end,
    ["Sidestreet Sluice"] = function() --The War Within
        private.instanceType = "Delve"
        private.instanceID = 7871
        private.bountifulID = 7789
        private.instanceName = "Sidestreet Sluice"
        delveStory()
    end,
    ["Demolition Dome"] = function() --The War Within
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
