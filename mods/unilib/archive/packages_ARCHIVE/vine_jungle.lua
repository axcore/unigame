---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("mapgen:vine", {
	description = "Vine",
	drawtype = "nodebox",
	tiles = {
	"mapgen_trans.png",
	"mapgen_trans.png",
	"mapgen_trans.png",
	"mapgen_trans.png",
	"mapgen_vine.png",
	"mapgen_vine.png",
	},
	use_texture_alpha = "clip",
	inventory_image = "mapgen_vine.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = false,
	walkable = false,
	climbable = true,
	drop = "mapgen:vine",
	node_box = {
		type = "fixed",
		fixed = {{-0.5, -0.5, 0.5, 0.5, 0.5, 0.48}}
	},
	groups = {cracky=3, oddly_breakable_by_hand=1},
})
]]--
