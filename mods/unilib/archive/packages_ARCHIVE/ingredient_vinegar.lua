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
minetest.register_node("bbq:vinegar", {
	description = ("Vinegar"),
	inventory_image = "bbq_vinegar.png",
	wield_image = "bbq_vinegar.png",
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "plantlike",
	tiles = {"bbq_vinegar.png"},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "bbq:vinegar",
	type = "shapeless",
	recipe = {"group:food_vinegarmother", "group:food_sugar", "bucket:bucket_water"},
	replacements = {{"bucket:bucket_water","bucket:bucket_empty"}},
})

minetest.register_node("bbq:vinegar_mother", {
	description = ("Vinegar Mother"),
	inventory_image = "bbq_vinegar_mother.png",
	wield_image = "bbq_vinegar_mother.png",
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"bbq_vinegar_mother.png"},
	groups = {food_vinegarmother=1, vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})
]]--
