---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("bushes:youngtree2_bottom", {
	description = S("Young Tree 2 (bottom)"),
	drawtype="nodebox",
	tiles = {"bushes_youngtree2trunk.png"},
	inventory_image = "bushes_youngtree2trunk_inv.png",
	wield_image = "bushes_youngtree2trunk_inv.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	node_box = {
		type = "fixed",
		fixed = {
			--{0.375000,-0.500000,-0.500000,0.500000,0.500000,-0.375000}, --NodeBox 1
			{-0.0612,-0.500000,-0.500000,0.0612,0.500000,-0.375000}, --NodeBox 1
		}
	},
	groups = {snappy=3,flammable=2,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	drop = 'default:stick'
})

biome_lib.register_on_generate({
		surface = {
			"default:dirt_with_grass",
			"stoneage:grass_with_silex",
			"sumpf:peat",
			"sumpf:sumpf"
		},
		rarity = bushes_youngtrees_rarity,
		rarity_fertility = bushes_youngtrees_rarity_fertility,
		plantlife_limit = bushes_youngtrees_fertility,
		min_elevation = 1, -- above sea level
	},
	abstract_bushes.grow_youngtree2
)
]]--
