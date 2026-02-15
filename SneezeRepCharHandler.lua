--[[
This script is to handle reputation and character-oriented categories of achievements.
Specified events from Sneeze.lua will be used to trigger functions here.
]]--

local addonName, private = ...

private.repCharCatTable = {
    [92] = "General Character",
    [201] = "General Reputation",
    [14864] = "Classic",
    [14865] = "The Burning Crusade",
    [14866] = "Wrath of the Lich King",
    [15072] = "Cataclysm",
    [15114] = "Pandaria",
    [15232] = "Draenor",
    [15258] = "Legion",
    [15305] = "Battle for Azeroth",
    [15439] = "Shadowlands",
    [15466] = "Dragonflight",
    [15530] = "War Within",
    [15600] = "Midnight"
}




function private.catchRepCharCategory(achieveCat)
    
end