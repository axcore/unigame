---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("bbq:hot_sauce", {
	description = ("Hot Sauce"),
	inventory_image = "bbq_hot_sauce.png",
	wield_image = "bbq_hot_sauce.png",
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "plantlike",
	tiles = {"bbq_hot_sauce.png"},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "bbq:hot_sauce",
	type = "shapeless",
	recipe = {"group:food_pepper_ground", "bucket:bucket_water", "bbq:paprika", "vessels:glass_bottle"},
	replacements = {{"bucket:bucket_water","bucket:bucket_empty"}},
})
]]--
