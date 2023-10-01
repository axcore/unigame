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
minetest.register_node("aotearoa:peat", {
	description = "Peat",
	tiles = {
		"aotearoa_peat.png",
	},
	groups = {crumbly = 3},
	drop = {
		max_items = 1,
		items = {
			{items = {"default:iron_lump"}, rarity = 200 },
			{items = {"aotearoa:peat"} }
		}
	},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "aotearoa_mud", gain = 0.4},
		dug = {name = "aotearoa_mud", gain = 0.4},
	}),
})
minetest.register_craft({
	type = "fuel",
	recipe = "aotearoa:peat",
	burntime = 30,
})
]]--
