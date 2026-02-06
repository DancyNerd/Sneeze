--[[
This will be used by various Sneeze scripts to determine things like location, distance, and nearby landmarks/POIs.
]]--

local addonName, private = ...
local constMapID = C_Map.GetBestMapForUnit("player")

private.mappingNeeds = {
	["Delve"] = C_QuestLog.GetZoneStoryInfo(constMapID),
	["Dungeon"] = "Dungeon",
	["Raid"] = "Raid",
	["City"] = "City",
	["Major Landmark"] = "Major Landmark",
	["Quest"] = "Quest",
	["Profession Trainer"] = "Profession Trainer",
}






function private.catchMappingNeeds(mappingNeed)
	return private.mappingNeeds[mappingNeed]
end


local function getNearestCity()
	--Determine nearest major city to player after narrowing for zone.
end

local function getMajorCities()
	--Determine major cities for that zone.
end