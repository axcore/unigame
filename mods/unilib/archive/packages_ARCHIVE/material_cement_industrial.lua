---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("basic_materials:wet_cement", {
	description = S("Wet Cement"),
	inventory_image = "basic_materials_wet_cement.png",
})
minetest.register_craft({
	type = "shapeless",
	output = "basic_materials:wet_cement 3",
	recipe = {
		"default:dirt",
		"dye:dark_grey",
		"dye:dark_grey",
		"dye:dark_grey",
		"bucket:bucket_water"
	},
	replacements = {{'bucket:bucket_water', 'bucket:bucket_empty'},},
})

minetest.register_node("basic_materials:cement_block", {
	description = S("Cement"),
	tiles = {"basic_materials_cement_block.png"},
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	type = "cooking",
	output = "basic_materials:cement_block",
	recipe = "basic_materials:wet_cement",
	cooktime = 8
})

minetest.register_node("basic_materials:concrete_block", {
	description = S("Concrete Block"),
	tiles = {"basic_materials_concrete_block.png",},
	groups = {cracky=1, level=2, concrete=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'basic_materials:concrete_block 6',
	recipe = {
		{'group:sand',                'basic_materials:wet_cement', 'default:gravel'},
		{'basic_materials:steel_bar', 'basic_materials:wet_cement', 'basic_materials:steel_bar'},
		{'default:gravel',            'basic_materials:wet_cement', 'group:sand'},
	}
})
]]--
