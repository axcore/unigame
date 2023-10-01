---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Pine Needles
local nodedef = {
	description = "Pine Needles",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"snow_needles.png"},
	waving = 1,
	paramtype = "light",
	groups = {snappy=3},
	furnace_burntime = 1,
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'snow:sapling_pine'},
				rarity = 20,
			},
			{
				items = {'snow:needles'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
}

if snow.christmas_content then
	table.insert(nodedef.drop.items, 1, {
		-- player will get xmas tree with 1/120 chance
		items = {"snow:xmas_tree"},
		rarity = 120,
	})
end

minetest.register_node("snow:needles", table.copy(nodedef))

default.register_leafdecay{
	trunks = {"default:pine_tree"},
	leaves = {"snow:needles"},
	radius = 2,
}

snow.register_on_configuring(function(name, v)
	if name == "christmas_content" then
		local drop = minetest.registered_nodes["snow:needles"].drop
		if v then
			table.insert(drop.items, 1, {
				items = {"snow:xmas_tree"},
				rarity = 120,
			})
		else
			table.remove(drop.items, 1)
		end
		minetest.override_item("snow:needles", {drop = drop})
	end
end)
-- Saplings

nodedef = {
	description = "Pine Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"snow_sapling_pine.png"},
	inventory_image = "snow_sapling_pine.png",
	wield_image = "snow_sapling_pine.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3},
	furnace_burntime = 10,
	sounds = default.node_sound_defaults(),
}

-- Pine Sapling
minetest.register_node("snow:sapling_pine", table.copy(nodedef))

--Pine tree.
minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 0.005,
	biomes = {"snow_biome_default"},
	schematic = minetest.get_modpath("snow").."/schematics/pine.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 0.05,
	biomes = {"snow_biome_forest"},
	schematic = minetest.get_modpath("snow").."/schematics/pine.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 0.1,
	biomes = {"snow_biome_lush"},
	schematic = minetest.get_modpath("snow").."/schematics/pine.mts",
	flags = "place_center_x, place_center_z",
})
]]--
