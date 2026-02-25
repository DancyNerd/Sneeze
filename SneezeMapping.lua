--[[
This will be used by various Sneeze scripts to determine things like location, distance, and nearby landmarks/POIs.
]]--

local addonName, private = ...
private.constMapID = C_Map.GetBestMapForUnit("player")

private.mappingNeeds = {
	["Delve"] = "Delve",
	["Dungeon"] = "Dungeon",
	["Raid"] = "Raid",
	["City"] = "City",
	["Major Landmark"] = "Major Landmark",
	["Quest"] = "Quest",
	["Profession Trainer"] = "Profession Trainer",
}






function private.catchMappingNeeds(mappingNeed)
	--This should catch and distribute complex mapping needs, but we don't have any as of yet.
end


local function getNearestCity()
	--Determine nearest major city to player after narrowing for zone.
end

local function getMajorCities()
	--Determine major cities for that zone.
end