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
minetest.register_node("bbq:sea_salt", {
	description = ("Sea Salt"),
	inventory_image = "bbq_sea_salt.png",
	wield_image = "bbq_sea_salt.png",
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "plantlike",
	tiles = {"bbq_sea_salt.png"},
	groups = {food_salt=1, vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:sea_salt",
	recipe = "bucket:bucket_water",
	replacements = {{"bucket:bucket_water","bucket:bucket_empty"}},
	cooktime = 8,
})
]]--
