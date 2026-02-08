--[[
This will be used by various Sneeze scripts to determine things like location, distance, and nearby landmarks/POIs.
]]--

local addonName, private = ...
local constMapID = C_Map.GetBestMapForUnit("player")

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
	if mappingNeed == "Delve" then
		local delveID = private.delveIDMap[private.majorzone]
		print("attempting to retrieve POI info ")
		return C_AreaPoiInfo.GetAreaPOIInfo(constMapID, delveID)
	end
end


local function getNearestCity()
	--Determine nearest major city to player after narrowing for zone.
end

local function getMajorCities()
	--Determine major cities for that zone.
end