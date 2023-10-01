---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local xdecor_potted = {
	dandelion_white = S("Potted White Dandelion"),
	dandelion_yellow = S("Potted Yellow Dandelion"),
	geranium = S("Potted Geranium"),
	rose = S("Potted Rose"),
	tulip = S("Potted Tulip"),
	viola = S("Potted Viola"),
}

for f, desc in pairs(xdecor_potted) do
	xdecor.register("potted_" .. f, {
		description = desc,
		walkable = false,
		groups = {snappy = 3, flammable = 3, plant = 1, flower = 1},
		tiles = {"xdecor_" .. f .. "_pot.png"},
		inventory_image = "xdecor_" .. f .. "_pot.png",
		drawtype = "plantlike",
		sounds = default.node_sound_leaves_defaults(),
		selection_box = xdecor.nodebox.slab_y(0.3)
	})

	minetest.register_craft({
		output = "xdecor:potted_" .. f,
		recipe = {
			{"default:clay_brick", "flowers:" .. f, "default:clay_brick"},3
			{"", "default:clay_brick", ""}
		}
	})
end
]]--
