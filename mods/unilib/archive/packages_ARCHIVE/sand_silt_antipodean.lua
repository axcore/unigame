---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("aotearoa:silt", {
	description = "Silt",
	tiles = {
		"aotearoa_silt.png",
	},
	groups = {crumbly = 3, soil = 1,},
	sounds = default.node_sound_dirt_defaults({
	}),
})
stairs.register_stair_and_slab(
	"aotearoa_silt",
	"aotearoa:silt",
	{crumbly = 3},
	{"aotearoa_silt.png" },
	"Silt Stair",
	"Silt Slab",
	default.node_sound_dirt_defaults()
)
minetest.register_craft({
	output = 'default:dirt 4',
	recipe = {
		{'group:sand', 'default:clay'},
		{'aotearoa:silt', 'aotearoa:peat'},
	}
})
minetest.register_craft({
	output = 'default:dirt 4',
	recipe = {
		{'group:sand', 'default:clay'},
		{'aotearoa:silt', 'aotearoa:rotten_wood'},
	}
})
]]--
