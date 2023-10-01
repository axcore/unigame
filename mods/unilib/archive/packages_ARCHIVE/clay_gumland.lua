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
minetest.register_node("aotearoa:gumland_hardpan", {
	description = "Gumland Hardpan",
	tiles = {"aotearoa_gumland_hardpan.png"},
	groups = {crumbly = 2},
	drop = {
		max_items = 2,
		items = {
			{items = {"aotearoa:kauri_gum"}, rarity = 15 },
			{items = {'default:clay'} }
		}
	},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "aotearoa_mud", gain = 0.4},
		dug = {name = "aotearoa_mud", gain = 0.4},
	}),
})

minetest.register_node("aotearoa:gumland_soil", {
	description = "Gumland Soil",
	tiles = {"aotearoa_gumland_soil.png"},
	tiles = {
		"aotearoa_gumland_soil.png",
		"aotearoa_gumland_hardpan.png",
		{name ="aotearoa_gumland_hardpan.png".."^aotearoa_gumland_soil_side.png",
		tileable_vertical = false}
	},
	groups = {crumbly = 3},
	drop = {
		max_items = 2,
		items = {
			{items = {"aotearoa:kauri_gum"}, rarity = 20 },
			{items = {'default:clay'} }
		}
	},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "aotearoa_mud", gain = 0.4},
		dug = {name = "aotearoa_mud", gain = 0.4},
	}),
})
]]--
