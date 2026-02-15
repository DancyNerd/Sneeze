--[[
This script is to handle instance-oriented categories of achievements.
Specified events from Sneeze.lua will be used to trigger functions here.
]]--

local addonName, private = ...

--[[
This may need to function very differently from how I originally imagined. The delve stories are only visible as an XML element when viewing the difficulty picker.
Instead af trying to catch the delves and return whether it is missing story mid-delve, we can pre-empt that by catching the GOSSIP_SHOW trigger with "delves-difficulty-picker" as the trigger.
We should be able to get the achievement data from the achievement, but we might have to key delves to achievement IDs rather than their item IDs for the map.
Since both might be helpful, we can leave the tables as they are and just add the new one for now.
]]--


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
    ["Tak-Rethan Abyss"] = "Delve",
    ["Skittering Breach"] = "Delve",
    ["The Sinkhole"] = "Delve",
    ["Nightfall Sanctum"] = "Delve",
    ["Mycomancer Cavern"] = "Delve",
    ["Fungal Folly"] = "Delve",
    ["Earthcrawl Mines"] = "Delve",
    ["Kriegval's Rest"] = "Delve",
    ["The Spiral Weave"] = "Delve",
    ["The Underkeep"] = "Delve",
    ["The Dread Pit"] = "Delve",
    ["The Waterworks"] = "Delve",
    ["Excavation Site 9"] = "Delve",
    ["Sidestreet Sluice"] = "Delve",
    ["Demolition Dome"] = "Delve"
}

private.delveIDMap = {
    ["Mycomancer Cavern"] = 7869,
    ["Nightfall Sanctum"] = 7868,
    ["The Sinkhole"] = 7870,
    ["Skittering Breach"] = 7871,
    ["Tak-Rethan Abyss"] = 7873,
    ["Fungal Folly"] = 7864,
    ["Earthcrawl Mines"] = 7863,
    ["Kriegval's Rest"] = 7865,
    ["The Spiral Weave"] = 7874,
    ["The Underkeep"] = 7872,
    ["The Dread Pit"] = 7867,
    ["The Waterworks"] = 7866,
    ["Excavation Site 9"] = 8143,
    ["Sidestreet Sluice"] = 8140,
    ["Demolotion Dome"] = 8142
}

private.bountifulDelveIDMap = {
    ["Mycomancer Cavern"] = 7780,
    ["Nightfall Sanctum"] = 7785,
    ["The Sinkhole"] = 7783,
    ["Skittering Breach"] = 7789,
    ["Tak-Rethan Abyss"] = 7784,
    ["Fungal Folly"] = 7779,
    ["Earthcrawl Mines"] = 7787,
    ["Kriegval's Rest"] = 7781,
    ["The Spiral Weave"] = 7790,
    ["The Underkeep"] = 7786,
    ["The Dread Pit"] = 7788,
    ["The Waterworks"] = 7782,
    ["Excavation Site 9"] = 8181,
    ["Sidestreet Sluice"] = 8246
}

--

--delve achievement category ID for The War Within is 15523

--We might be able to use the tooltipWidgetSet id/number return to determine if user has completed the corresponding delve story. This is a big if as I have no idea what it actually corresponds to.
local function delveStory(playerMapID)
    local delveInfo
    local delveUnbountiful = private.delveIDMap[private.majorZone]
    local delveBountiful = private.bountifulDelveIDMap[private.majorZone]
    if C_AreaPoiInfo.GetAreaPOIInfo(playerMapID, delveUnbountiful) then
        local delveInfo = C_AreaPoiInfo.GetAreaPOIInfo(playerMapID, delveUnbountiful)
        print(delveInfo.tooltipWidgetSet)
    else
        delveInfo = C_AreaPoiInfo.GetAreaPOIInfo(playerMapID, delveBountiful)
        print("Delve is bountiful and " .. delveInfo.tooltipWidgetSet)
    end
end

function private.instanceType(typeOfInstance)
    print(private.majorZone)
    local fromMapping = private.catchMappingNeeds(typeOfInstance)
    if typeOfInstance == "Delve" then
        delveStory(fromMapping)
    end
end

--CVAR_UPDATE "lastSelectedDelvesTier", "8"