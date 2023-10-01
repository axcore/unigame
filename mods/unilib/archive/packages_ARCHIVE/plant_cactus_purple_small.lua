---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
	minetest.register_node("lib_ecology:plant_cactus_04", { -- deco NEW
		description = S("Cactus - Purple Small"),
		drawtype = "nodebox",
		tiles = {"lib_ecology_plant_cactus_02_trunk_top.png", "lib_ecology_plant_cactus_02_trunk_top.png", "lib_ecology_plant_cactus_02_trunk.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = true,
		is_ground_content = false,
		groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
		sounds = default.node_sound_wood_defaults(),

			node_box = {
				type = "fixed",
				fixed = {
					{-0.25, -0.5, -0.25, 0.25, 0.0, 0.25}, -- Trunk
				}
			},
			selection_box = {
				type = "fixed",
				fixed = {
					{-0.25, -0.5, -0.25, 0.25, 0.0, 0.25}, -- Trunk
				}
			},

			on_place = minetest.rotate_node
	})
]]--
