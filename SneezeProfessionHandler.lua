--[[
This script is to handle the Profession category of achievements.
Specified eveents from Sneeze.lua will be used to trigger functions here.
]]--

local addonName, private = ...

private.professionCatTable = {
	[169] = "General Professions",
	[15489] = "Alchemy",
	[15490] = "Blacksmithing",
	[15491] = "Enchanting",
	[15492] = "Engineering",
	[15493] = "Inscription",
	[15494] = "Jewelcrafting",
	[15495] = "Leatherworking",
	[15496] = "Tailoring",
	[15499] = "Herbalism",
	[15497] = "Mining",
	[15498] = "Skinning",
	[170] = "Cooking",
	[171] = "Fishing",
	[15071] = "Archaeology"
}







function private.catchProfCategory(achieveCat)
	print("Caught profession category: "..achieveCat)
	--professionCat will be keyed to a profession table.
	--mapID handling undetermined as of yet, but may rely on C_GossipInfo.GetPoiInfo which accepts uiMapID, gossipPoiID and appears to return table (name, textureIndex, position, inBattleMap)
end