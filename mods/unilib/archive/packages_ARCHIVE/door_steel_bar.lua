---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xpanes
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
	doors.register("xpanes:door_steel_bar", {
		tiles = {{name = "xpanes_door_steel_bar.png", backface_culling = true}},
		description = S("Steel Bar Door"),
		inventory_image = "xpanes_item_steel_bar.png",
		protected = true,
		groups = {node = 1, cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "xpanes_steel_bar_door_open",
		sound_close = "xpanes_steel_bar_door_close",
		gain_open = 0.15,
		gain_close = 0.13,
		recipe = {
			{"xpanes:bar_flat", "xpanes:bar_flat"},
			{"xpanes:bar_flat", "xpanes:bar_flat"},
			{"xpanes:bar_flat", "xpanes:bar_flat"},
		},
	})
]]--
