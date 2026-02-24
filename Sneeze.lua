
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
private.playerInCombat = false
private.achieveCat = 0


--Shorthand table for generic achievement categories to expedite process where possible.
local generalAchieveCatShortTable = {
    [92] = private.catchRepCharCategory,
    [96] = private.catchQuestPVPCategory,
    [97] = private.catchExplorationCategory,
    [95] = private.catchQuestPVPCategory,
    [81] = private.catchFeatsCat
}

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
local function getCriteria(trackedAchievementID)
--GetAchievementNumCriteria() is necessary to iterate through the various criteria for the achievement.
	local criteriaNum = GetAchievementNumCriteria(trackedAchievementID)
	--print(criteriaNum)
	local catchCriteria = {}
	for i=1, criteriaNum do
		local criteriaInfo, _toss1, criteriaCompleted, _toss2, _toss3, _toss4, _toss5, _toss6, _toss7, criterID = GetAchievementCriteriaInfo(trackedAchievementID, i)
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
local function playerZoneGen(subZone, newZone)
	if private.minorZone ~= subZone or private.majorZone ~= newZone then
		private.minorZone = GetSubZoneText()
		private.majorZone = GetRealZoneText()
		if private.instanceTypeMap[private.majorZone] then
			private.instanceTypeMap[private.majorZone]()
		end
	end
end

--[[local function mapInfo(mapID)
	local whatIs = C_Map.GetMapInfo(mapID)
	--print(whatIs.name)
end]]--


--Table of event triggers.
local eventHandlers = {
	["PLAYER_REGEN_DISABLED"] = function(self, event, ...)
		private.playerInCombat = true
	end,
	["PLAYER_REGEN_ENABLED"] = function(self, event, ...)
		private.playerInCombat = false
	end,
	["PLAYER_ENTER_COMBAT"] = function (self, event, ...)
		private.playerInCombat = true
	end,
	["PLAYER_LEAVE_COMBAT"] = function(self, event, ...)
		private.playerInCombat = false
	end,
	["CHAT_MSG_MONSTER_SAY"] = function (self, event,...)
		if private.playerInCombat then
			return
		else
			local monsterSays = ...
			if monsterSays == "GO!" then
				local skyridingType = "dragonrace"
				private.sneezeSkyriding(skyridingType)
			end
		end
	end,
	["CONTENT_TRACKING_UPDATE"] = function (self, event, ...)
		local var1, trackID = ...
		getCriteria(trackID)
	 end,
	["ZONE_CHANGED_NEW_AREA"] = function (...)
		local subZone = GetSubZoneText()
		local newZone = GetRealZoneText()
		playerZoneGen(subZone, newZone)
	end,
}

--Declare that ZONE_CHANGED and ZONE_CHANGED_NEW_AREA can be used interchangeably.
eventHandlers.ZONE_CHANGED=eventHandlers.ZONE_CHANGED_NEW_AREA

--This function finds the appropriate handler for the achievement category.
local function validateCatID()
	if achieveCat < 100 and generalAchieveCatShortTable[achieveCat] then
		generalAchieveCatShortTable[private.achieveCat]()
	elseif private.professionCatTable[private.achieveCat] then
		private.catchProfCategory(private.achieveCat)
	end
end

local function catchAchievementOnEnter(_self, ...)
	--var2 is the achievementID that we need to catch
	local _var1, achieveID = ...
	private.achieveCat = GetAchievementCategory(achieveID) --using blizz function to get achieveCat from achieveID in the mouse over.
	validateCatID()
	--print(achieveID)
	--print(achieveCat)
	--Send achieveID to be evaluated for distance.
end

--Function for determining type of POI and sending to appropriate add-on handler section.
function private.findPoiType(poiName)
	if private.instanceTypeMap[poiName] then

		--local tooltipItem = C_TooltipInfo.GetMinimapMouseover()
		--print(tooltipItem.lines)
		private.instanceTypeMap[poiName]()
	end
	
end

--Table returned by AreaPOIPin.MouseOver .name will be equal to name of instance/poi IE "delve name", .description is type IE "delve".
local function catchPOIMouseOver(_self, ...)
	local mouseOver
	if ... then
		mouseOver = ...
		local poiName = mouseOver.name
		--local mouseTooltip = mouseOver.SetTexture and mouseOver:SetTexture()
		--print(mouseTooltip)
		--print(mouseOver.tooltipWidgetSet)
		--print(mouseOver.journalInstanceID)
		private.findPoiType(poiName)
	end
		
end

EventRegistry:RegisterCallback("AchievementFrameAchievement.OnEnter", catchAchievementOnEnter)
EventRegistry:RegisterCallback("AreaPOIPin.MouseOver", catchPOIMouseOver)
EventRegistry:RegisterCallback("MapLegendPinOnEnter", catchPOIMouseOver)

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
