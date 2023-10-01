---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/pl_sunflowers
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local box = {
	type="fixed",
	fixed = { { -0.2, -0.5, -0.2, 0.2, 0.5, 0.2 } },
}

local sunflower_drop = "farming:seed_wheat"
if minetest.registered_items["farming:seed_spelt"] then
	sunflower_drop = "farming:seed_spelt"
end

minetest.register_node(":flowers:sunflower", {
	description = S("Sunflower"),
	drawtype = "mesh",
	paramtype = "light",
	paramtype2 = "facedir",
	inventory_image = "flowers_sunflower_inv.png",
	mesh = "flowers_sunflower.obj",
	tiles = { "flowers_sunflower.png" },
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = { dig_immediate=3, flora=1, flammable=3, attached_node=1 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = box,
	collision_box = box,
	drop = {
		max_items = 1,
		items = {
			{items = {sunflower_drop}, rarity = 8},
			{items = {"flowers:sunflower"}},
		}
	}
})

biome_lib.register_on_generate({
	surface = {"default:dirt_with_grass"},
	avoid_nodes = { "flowers:sunflower" },
	max_count = sunflowers_max_count,
	rarity = sunflowers_rarity,
	min_elevation = 0,
	plantlife_limit = -0.9,
	temp_max = -0.1,
	random_facedir = {0,3},
	},
	"flowers:sunflower"
)
]]--
