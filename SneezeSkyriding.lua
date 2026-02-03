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


local TIME_INTERVAL = 0.5






local function runTimer()
    if not continueRunning then
        print("stopped")
        elapsed = 0
    elseif continueRunning then
        elapsed = elapsed + TIME_INTERVAL
        C_Timer.After(TIME_INTERVAL, function() print(elapsed) runTimer() end)

    end
end


function private.startTimer()
    print("we made it")
    continueRunning = true
    runTimer()
end

local eventTable = {
    ["PLAYER_IS_GLIDING_CHANGED"] = function(self, event, ...)
        local playerIsGliding = ...
        if not playerIsGliding then
            continueRunning = false
            runTimer()
        end
    end
}

for eventName in pairs(eventTable) do
    regulatingEvents:RegisterEvent(eventName)
end