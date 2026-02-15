--[[
This script is to handle Quest and PVP categories for achievemnts.
Specified events from Sneeze.lua will be used to trigger functions here.
]]--

local addonName, private = ...

private.questCatTable = {
    [96] = "General Quests",
    [14861] = "Eastern Kingdoms",
    [15081] = "Kalimdor",
    [14862] = "Outland",
    [14863] = "Northrend",
    [15070] = "Cataclysm",
    [15110] = "Pandaria",
    [15220] = "Draenor",
    [15252] = "Legion",
    [15284] = "Battle for Azeroth",
    [15422] = "Shadowlands",
    [15455] = "Dragonflight",
    [15506] = "War Within",
    [15547] = "Midnight"
}



function private.catchQuestPVPCategory(achieveCat)
    
end