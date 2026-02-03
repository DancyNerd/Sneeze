--[[
This script is to handle the Dragonrace and Glyph Hunter categories of achievements.
Specified eveents from Sneeze.lua will be used to trigger functions here.
]]--

local addonName, private = ...
local timerData = nil --This is populated later.

local function cbTimer(payload)
    if not payload then return end

    timerData = payload
    payload:Invoke()
    print(payload)
end

function private.startTimer()
    print("we made it")
    C_Timer.NewTimer(0.5, cbTimer)
end

--[[local function startTimer()
    local raceTimer = C_Timer.NewTimer( 0.5, function() print(GetTime()) end)
    print(raceTimer)
    local raceFrame = CreateFrame("Frame")
    raceFrame:RegisterEvent("PLAYER_IS_GLIDING_CHANGED")
    raceFrame:SetScript("OnEvent", function(self, event, ...)
        local playerGliding = ...
        if not playerGliding then
            raceTimer:Cancel()
            print("Timer Ended")
        end
    end
    
    --local boxCreated = createTimerBox()
    --if boxCreated then
        -- Logic to start and update the timer display
    --end
end]]--

--private.startTimer = startTimer

local raceFrame = CreateFrame("Frame")
raceFrame:RegisterEvent("PLAYER_IS_GLIDING_CHANGED")
raceFrame:SetScript("OnEvent", function(self, event, ...)
    local playerGliding = ...
    if not playerGliding then
        if timerData then
            timerData:Cancel()
            timerData = nil
            print("Timer Ended")
        end
    end
end)


