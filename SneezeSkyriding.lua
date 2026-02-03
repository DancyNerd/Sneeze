--[[
This script is to handle the Dragonrace and Glyph Hunter categories of achievements.
Specified eveents from Sneeze.lua will be used to trigger functions here.
]]--

local addonName, private = ...

--Pulling out timer variable because recursion woo.
local elapsed = 0

--This frame is for events that regulate processes initiated by controlling script.
local regulatingEvents = CreateFrame("FRAME")
local continueRunning = false


local TIME_INTERVAL = 0.25




local eventHandlers = {
    ["PLAYER_IS_GLIDING_CHANGED"] = function(self, event, ...)
        local playerIsGliding = ...
        if not playerIsGliding then
            continueRunning = false
        end
    end
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


function private.startTimer()
    --print("we made it")
    continueRunning = true
    runTimer()
end

