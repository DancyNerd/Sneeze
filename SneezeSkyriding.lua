--[[
This script is to handle the Dragonrace and Glyph Hunter categories of achievements.
Specified events from Sneeze.lua will be used to trigger functions here.
]]--

local addonName, private = ...

--Pulling out timer variable because recursion woo.
local elapsed = 0

--This frame is for events that regulate processes initiated by controlling script.
local regulatingEvents = CreateFrame("FRAME")
local continueRunning = false


local TIME_INTERVAL = 0.25




local eventHandlers = {
    ["CHAT_MSG_MONSTER_SAY"] = function(self, event, ...)
        if private.playerInCombat then
            return
        else
            local monsterSays, monsterType = ...
            local startCue = "GO!"
            if monsterSays ~= startCue then
            if string.find(monsterType, "Timekeeper") then
                    continueRunning = false
                end
            end
        end
    end,
    ["LOADING_SCREEN_ENABLED"] = function(self, event, ...)
        continueRunning = false
    end,
}

for eventName in pairs(eventHandlers) do
    regulatingEvents:RegisterEvent(eventName)
end

regulatingEvents:SetScript("OnEvent", function(self, event, ...)
	local handler = eventHandlers[event]
	if not handler then
		return
	end
--	print("handler found for event: "..event)
	handler(self, event, ...)
end)

local function runTimer()
    --We use 68 to manually bound recursion where necessary, because gold finishes are typically much less.
    local highTime = 68
    if not continueRunning or elapsed>highTime then
        print("stopped at " ..elapsed)
        elapsed = 0
        continueRunning = false
    elseif continueRunning then
        elapsed = elapsed + TIME_INTERVAL
        C_Timer.After(TIME_INTERVAL, function() print(elapsed) runTimer() end)
    end
end

--This will need to catch the name of the monster from the trigger event in Sneeze.lua.
--Add if/elseif logic to change how timer operates.
local function startTimer()
    --print("we made it")
    continueRunning = true
    runTimer()
end

--Handling for which skyriding type we're being called for.
function private.sneezeSkyriding(skyridingType)
	if skyridingType == "dragonrace" then
		startTimer()
	end
end

