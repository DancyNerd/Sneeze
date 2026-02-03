
--[[
Lightweight achievement assist addon.
Detects nearby tracked achievement objectives (150yd) and places a discreet arrow next to the tracking section on the screen.
Hovering over the tracked achievement objective will result in a yes/no menu asking if user wishes to navigate to objective (distance independent).
--]]

local playerName = UnitName("player")
local playerLevel = UnitLevel("player")
local cFrame = CreateFrame("Frame")
local majorZone
local minorZone
local addonName, private = ...

--SneezeSkyriding -> dragon races can cue on CHAT_MSG_MONSTER_SAY first return value "GO!"
--TRACKED_ACHIEVEMENT_UPDATE
--RECEIVED_ACHIEVEMENT_LIST - this might actually be a useless event. I can't find it anywhere in the interface dump.
--RECEIVED_ACHIEVEMENT_MEMBER_LIST
--ACHIEVEMENT_SEARCH_UPDATED
--C_Map.GetMapInfo() accepts "id"
--CONTENT_TRACKING_UPDATE
--ITEM_TEXT_READY, BEGIN, CLOSED show up when interacting with achievement tracked criterion
--Fix scaffolding for validateCatId - make tables for different achievement types/expansions.

--Create table with event name as the key and entire function as the value.




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

local function getNearestCity()
	--Determine nearest major city to player after narrowing for zone.
end

local function getMajorCities()
	--Determine major cities for that zone.
end

--On event ZONE_CHANGED_NEW_AREA, we update script-wide variables for zone and subzone.
local function playerZoneGen(subZone)
	minorZone = subZone
	majorZone = GetRealZoneText()
	print(majorZone)
end

--[[local function mapInfo(mapID)
	local whatIs = C_Map.GetMapInfo(mapID)
	--print(whatIs.name)
end]]--

local function sneezeSkyriding(skyridingType)
	if skyridingType == "dragonrace" then
		private.startTimer()
	end
	--This should track time and display a timer.
end

local eventHandlers = {
	["CHAT_MSG_MONSTER_SAY"] = function (self, event,...)
		local msg = ...
		if msg == "GO!" then
			local skyridingType = "dragonrace"
			sneezeSkyriding(skyridingType)
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

eventHandlers.ZONE_CHANGED=eventHandlers.ZONE_CHANGED_NEW_AREA


local function validateCatId(catID)
	--Categories of achievements can be nested. We need to ensure we are only tracking certain categories.
	if catID == 15071 then
		private.professionTextGen()
	elseif catID < 15500 and catID > 15488 then
		private.professionTextGen()
	elseif catID < 172 and catID > 168 then
		private.professionTextGen()
	else
		--function call to evaluate if same zone.
	end
end

local function catchAchievementOnEnter(_self, ...)
	--var2 is the achievementID that we need to catch
	local _var1, achieveID = ...
	local achieveCat = GetAchievementCategory(achieveID)
	validateCatId(achieveCat)
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