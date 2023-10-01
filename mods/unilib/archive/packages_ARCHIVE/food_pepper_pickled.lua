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
minetest.register_node("bbq:pickled_peppers", {
	description = ("Pickled Peppers"),
	inventory_image = "bbq_pickled_peppers.png",
	wield_image = "bbq_pickled_peppers.png",
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "plantlike",
	tiles = {"bbq_pickled_peppers.png"},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
	on_use = minetest.item_eat(5),
})
minetest.register_craft({
	output = "bbq:pickled_peppers",
	type = "shapeless",
	recipe = {"group:food_peppercorn", "group:food_pepper", "bbq:brine"}
})
]]--
