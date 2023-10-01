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
minetest.register_node("bbq:bbq_sauce", {
	description = ("BBQ Sauce"),
	inventory_image = "bbq_bbq_sauce.png",
	wield_image = "bbq_bbq_sauce.png",
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "plantlike",
	tiles = {"bbq_bbq_sauce.png"},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "bbq:bbq_sauce",
	type = "shapeless",
	recipe = {"bbq:molasses", "group:food_sugar", "group:food_tomato_sauce", "bbq:liquid_smoke", "bbq:vinegar"},
	replacements = {{"bbq:vinegar","bbq:vinegar_mother"}},
})
]]--
