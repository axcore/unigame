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
minetest.override_item("default:clay", {
	description = "Clay",
	tiles = {"aotearoa_clay.png"},
	groups = {crumbly = 3, soil = 1},
	drop = 'default:clay',--'default:clay_lump 4',
	sounds = default.node_sound_dirt_defaults(),
})

--slabs for clay
stairs.register_stair_and_slab(
	"default_clay",
	"default:clay",
	{crumbly = 3},
	{"aotearoa_clay.png" },
	"Clay Stair",
	"Clay Slab",
	default.node_sound_dirt_defaults()
)

minetest.register_craft({
	type = "cooking",
	output = "dye:white 4",
	recipe = "default:clay",
})
]]--
