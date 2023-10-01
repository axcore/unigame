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
xpanes.register_pane("framed_pane", {
	description = "Glass Pane With Wood Frame",
	textures = {"decoblocks_framed_glass.png","xpanes_wood_frame_half.png","xpanes_wood_frame_half_top.png"},
	inventory_image = "decoblocks_framed_glass.png",
	wield_image = "decoblocks_framed_glass.png",
	sounds = default.node_sound_glass_defaults(),
	groups = {snappy=2, cracky=3, oddly_breakable_by_hand=3},
	recipe = {
		{"decoblocks:framed_glass", "decoblocks:framed_glass", "decoblocks:framed_glass"},
		{"decoblocks:framed_glass", "decoblocks:framed_glass", "decoblocks:framed_glass"},
	}
})
]]--
