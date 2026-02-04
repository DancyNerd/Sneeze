--[[
This script is to handle the Profession category of achievements.
Specified eveents from Sneeze.lua will be used to trigger functions here.
]]--

local addonName, private = ...









function private.catchProfCategoryMapID(professionCat)
	--professionCat will be keyed to a profession table.
	--mapID handling undetermined as of yet, but may rely on C_GossipInfo.GetPoiInfo which accepts uiMapID, gossipPoiID and appears to return table (name, textureIndex, position, inBattleMap)
end