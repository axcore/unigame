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
minetest.register_node("bbq:steak_sauce", {
	description = ("Steak Sauce"),
	inventory_image = "bbq_steak_sauce.png",
	wield_image = "bbq_steak_sauce.png",
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "plantlike",
	tiles = {"bbq_steak_sauce.png"},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "bbq:steak_sauce",
	type = "shapeless",
	recipe = {"flowers:mushroom_brown", "bbq:vinegar", "bbq:hot_sauce", "vessels:glass_bottle"},
	replacements = {{"bbq:vinegar","bbq:vinegar_mother"}},
})
]]--
