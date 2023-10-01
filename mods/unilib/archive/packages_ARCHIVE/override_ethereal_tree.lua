---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.override_item("default:acacia_leaves", {
	drawtype = leaftype,
	inventory_image = "default_acacia_leaves.png",
	wield_image = "default_acacia_leaves.png",
	visual_scale = leafscale,
	walkable = ethereal.leafwalk
})

minetest.override_item("default:leaves", {
	drawtype = leaftype,
	visual_scale = leafscale,
	inventory_image = "default_leaves.png",
	wield_image = "default_leaves.png",
	walkable = ethereal.leafwalk
})

minetest.override_item("default:aspen_leaves", {
	drawtype = leaftype,
	inventory_image = "default_aspen_leaves.png",
	wield_image = "default_aspen_leaves.png",
	visual_scale = leafscale,
	walkable = ethereal.leafwalk
})

minetest.override_item("default:jungleleaves", {
	drawtype = leaftype,
	visual_scale = leafscale,
	inventory_image = "default_jungleleaves.png",
	wield_image = "default_jungleleaves.png",
	walkable = ethereal.leafwalk
})

minetest.override_item("default:pine_needles", {
	drawtype = leaftype,
	visual_scale = leafscale,
	inventory_image = "default_pine_needles.png",
	wield_image = "default_pine_needles.png",
	walkable = ethereal.leafwalk,
	drop = {
		max_items = 1,
		items = {
			{items = {"default:pine_sapling"}, rarity = 20},
			{items = {"ethereal:pine_nuts"}, rarity = 5},
			{items = {"default:pine_needles"}}
		}
	}
})

default.register_leafdecay({
	trunks = {"default:tree"},
	leaves = {
		"default:apple", "default:leaves",
		"ethereal:orange", "ethereal:orange_leaves",
		"ethereal:lemon", "ethereal:lemon_leaves",
		"ethereal:vine"
	},
	radius = 3
})
]]--
