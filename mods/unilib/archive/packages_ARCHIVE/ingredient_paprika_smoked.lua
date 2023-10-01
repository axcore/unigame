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
minetest.register_node("bbq:paprika", {
	description = ("Smoked Paprika"),
	inventory_image = "bbq_paprika.png",
	wield_image = "bbq_paprika.png",
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"bbq_paprika.png"},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "bbq:paprika",
--	type = "shapeless",
	recipe = {
		{'bbq:smoked_pepper'},
	},
})
]]--
