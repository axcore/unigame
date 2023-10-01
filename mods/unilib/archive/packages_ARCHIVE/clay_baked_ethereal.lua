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
-- If Baked Clay mod not active, make Red, Orange and Grey nodes
if not minetest.get_modpath("bakedclay") then

	minetest.register_node(":bakedclay:red", {
		description = S("Red Baked Clay"),
		tiles = {"baked_clay_red.png"},
		groups = {cracky = 3},
		is_ground_content = ethereal.cavedirt,
		sounds = default.node_sound_stone_defaults()
	})

	minetest.register_node(":bakedclay:orange", {
		description = S("Orange Baked Clay"),
		tiles = {"baked_clay_orange.png"},
		groups = {cracky = 3},
		is_ground_content = ethereal.cavedirt,
		sounds = default.node_sound_stone_defaults()
	})

	minetest.register_node(":bakedclay:grey", {
		description = S("Grey Baked Clay"),
		tiles = {"baked_clay_grey.png"},
		groups = {cracky = 3},
		is_ground_content = ethereal.cavedirt,
		sounds = default.node_sound_stone_defaults()
	})
end
]]--
