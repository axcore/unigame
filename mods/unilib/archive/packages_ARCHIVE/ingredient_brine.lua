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
minetest.register_node("bbq:brine", {
	description = ("Brine"),
	inventory_image = "bbq_brine.png",
	wield_image = "bbq_brine.png",
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "plantlike",
	tiles = {"bbq_brine.png"},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "bbq:brine",
	type = "shapeless",
	recipe = {"group:food_salt", "group:food_sugar", "bucket:bucket_water", "vessels:drinking_glass"},
	replacements = {{"bucket:bucket_water","bucket:bucket_empty"}},
})
]]--
