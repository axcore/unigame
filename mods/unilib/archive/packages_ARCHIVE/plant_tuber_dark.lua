---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("underch:dark_tuber", {
	description = "Dark Tuber",
	tiles = {"underch_dark_tuber.png"},
	drawtype = "mesh",
	mesh = "underch_dark_tuber.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(2),
})
]]--
