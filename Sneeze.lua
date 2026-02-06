
--[[
Lightweight achievement assist addon.
Detects nearby tracked achievement objectives (150yd) and places a discreet arrow next to the tracking section on the screen.
Hovering over the tracked achievement objective will result in a yes/no menu asking if user wishes to navigate to objective (distance independent).
--]]

local addonName, private = ...
local playerName = UnitName("player")
local playerLevel = UnitLevel("player")
local cFrame = CreateFrame("Frame")
private.majorZone = GetRealZoneText()
private.minorZone = GetSubZoneText()


--SneezeSkyriding -> dragon races can cue on CHAT_MSG_MONSTER_SAY first return value "GO!"
--TRACKED_ACHIEVEMENT_UPDATE
--RECEIVED_ACHIEVEMENT_LIST - this might actually be a useless event. I can't find it anywhere in the interface dump.
--RECEIVED_ACHIEVEMENT_MEMBER_LIST
--ACHIEVEMENT_SEARCH_UPDATED
--C_Map.GetMapInfo() accepts "id"
--CONTENT_TRACKING_UPDATE
--ITEM_TEXT_READY, BEGIN, CLOSED show up when interacting with achievement tracked criterion
--Fix scaffolding for validateCatId - make tables for different achievement types/expansions.
--SCENARIO_POI_UPDATE might be helpful for finding appropriate delve stories.

--Create table with event name as the key and entire function as the value.



--This function handles catching criteria for achievements that have criteria.
local function getCriteria(trackID)
--GetAchievementNumCriteria() is necessary to iterate through the various criteria for the achievement.
	local criteriaNum = GetAchievementNumCriteria(trackID)
	--print(criteriaNum)
	local catchCriteria = {}
	for i=1, criteriaNum do
		local criteriaInfo, _toss1, criteriaCompleted, _toss2, _toss3, _toss4, _toss5, _toss6, _toss7, criterID = GetAchievementCriteriaInfo(trackID, i)
		if not criteriaCompleted then
			catchCriteria[i] = criteriaInfo
			local xLoc, yLoc, dist = ClosestGameObjectPosition(criterID)
			--print(dist)
			--print(criteriaInfo)
		end
	end
	--catchCriteria needs to go to a place where its values are evaluated for distance to player.
end

--On event ZONE_CHANGED_NEW_AREA, we update script-wide variables for zone and subzone.
local function playerZoneGen(subZone)
	if minorZone ~= subZone then
		minorZone = subZone
		majorZone = GetRealZoneText()
	end
end

--[[local function mapInfo(mapID)
	local whatIs = C_Map.GetMapInfo(mapID)
	--print(whatIs.name)
end]]--


--Table of event triggers.
local eventHandlers = {
	["CHAT_MSG_MONSTER_SAY"] = function (self, event,...)
		local msg = ...
		if msg == "GO!" then
			local skyridingType = "dragonrace"
			private.sneezeSkyriding(skyridingType)
		end
	end,
	["CONTENT_TRACKING_UPDATE"] = function (self, event, ...)
		local var1, trackID = ...
		getCriteria(trackID)
	 end,
	["ZONE_CHANGED_NEW_AREA"] = function (...)
		local subZone = GetSubZoneText()
		print(subZone)
		if subZone then
			playerZoneGen(subZone)
		end
	end,
}

--Declare that ZONE_CHANGED and ZONE_CHANGED_NEW_AREA can be used interchangeably.
eventHandlers.ZONE_CHANGED=eventHandlers.ZONE_CHANGED_NEW_AREA


local function validateCatID(achieveCat)
	--Categories of achievements can be nested. We need to ensure we are only tracking certain categories.
	if private.professionCatTable[achieveCat] then
		private.catchProfCategory(achieveCat)
	end
end

local function catchAchievementOnEnter(_self, ...)
	--var2 is the achievementID that we need to catch
	local _var1, achieveID = ...
	local achieveCat = GetAchievementCategory(achieveID)
	validateCatID(achieveCat)
	--print(achieveID)
	--print(achieveCat)
	--Send achieveID to be evaluated for distance.
end

EventRegistry:RegisterCallback("AchievementFrameAchievement.OnEnter", catchAchievementOnEnter)

for eventName in pairs(eventHandlers) do
	cFrame:RegisterEvent(eventName)
end
cFrame:SetScript("OnEvent", function(self, event, ...)
	local handler = eventHandlers[event]
	if not handler then
		return
	end
--	print("handler found for event: "..event)
	handler(self, event, ...)
end)
--cFrame:RegisterEvent("AREA_POIS_UPDATED")
--cFrame:RegisterEvent("ZONE_CHANGED")
