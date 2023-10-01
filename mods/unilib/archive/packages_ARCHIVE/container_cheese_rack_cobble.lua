---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local rack_types = { --moslty redundant data, but i dont feel like changing it..
	--craft material				tiles				rack name			name	 aging time (MIN 3!)
	{"default:wood", 				"wood", 			"wooden",	"Wooden",	55.0},
	{"default:stone", 			"stone", 			"stone",	"Stone", 	45.0},
	{"default:mossycobble", "mossycobble","mossy",	"Mossy",	30.0},
}

local producable = { --remember, only cow milk
	["wooden"] 	= {"parmesan",		"fontal",			"gruyere",	"emmental"}, 	--long time, hard
	["stone"] 	= {"asiago",		"monteray_jack",	"toma",		"gouda"}, 		-- medium time, semi soft or medium
	["mossy"] 	= {"gorgonzola",	"stilton",			"brie", 	"stracchino"}, 	-- short time, soft and creamy
}
]]--
