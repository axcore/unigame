---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("farming:hemp_fibre", {
	description = S("Hemp Fibre"),
	inventory_image = "farming_hemp_fibre.png"
})
minetest.register_craft( {
	output = "farming:hemp_fibre 8",
	recipe = {
		{"farming:hemp_leaf", "farming:hemp_leaf", "farming:hemp_leaf"},
		{"farming:hemp_leaf", "group:water_bucket", "farming:hemp_leaf"},
		{"farming:hemp_leaf", "farming:hemp_leaf", "farming:hemp_leaf"}
	},
	replacements = {{"group:water_bucket", "bucket:bucket_empty"}}
})
if minetest.get_modpath("bucket_wooden") then
	minetest.register_craft( {
		output = "farming:hemp_fibre 8",
		recipe = {
			{"farming:hemp_leaf", "farming:hemp_leaf", "farming:hemp_leaf"},
			{"farming:hemp_leaf", "group:water_bucket_wooden", "farming:hemp_leaf"},
			{"farming:hemp_leaf", "farming:hemp_leaf", "farming:hemp_leaf"}
		},
		replacements = {{"group:water_bucket_wooden", "bucket_wooden:bucket_empty"}}
	})
end
minetest.register_craft( {
	output = "default:paper 3",
	recipe = {
		{"farming:hemp_fibre", "farming:hemp_fibre", "farming:hemp_fibre"}
	}
})
minetest.register_craft( {
	output = "farming:cotton 3",
	recipe = {
		{"farming:hemp_fibre"},
		{"farming:hemp_fibre"},
		{"farming:hemp_fibre"}
	}
})
minetest.register_craft({
	output = "bucket:bucket_river_water",
	recipe = {
		{"farming:hemp_fibre"},
		{"farming:hemp_fibre"},
		{"bucket:bucket_water"}
	}
})

minetest.register_node("farming:hemp_block", {
	description = S("Hemp Block"),
	tiles = {"farming_hemp_block.png"},
	paramtype = "light",
	groups = {snappy = 1, oddly_breakable_by_hand = 1, flammable = 2}
})
minetest.register_craft( {
	output = "farming:hemp_block",
	recipe = {
		{"farming:hemp_fibre", "farming:hemp_fibre", "farming:hemp_fibre"},
		{"farming:hemp_fibre", "farming:hemp_fibre", "farming:hemp_fibre"},
		{"farming:hemp_fibre", "farming:hemp_fibre", "farming:hemp_fibre"}
	}
})
if minetest.global_exists("stairs") then

	if stairs.mod and stairs.mod == "redo" then

		stairs.register_all("hemp_block", "farming:hemp_block",
			{snappy = 1, flammable = 2},
			{"farming_hemp_block.png"},
			"Hemp Block",
			default.node_sound_leaves_defaults())
	else

		stairs.register_stair_and_slab("hemp_block", "farming:hemp_block",
			{snappy = 1, flammable = 2},
			{"farming_hemp_block.png"},
			"Hemp Block Stair",
			"Hemp Block Slab",
			default.node_sound_leaves_defaults())
	end
end
]]--
