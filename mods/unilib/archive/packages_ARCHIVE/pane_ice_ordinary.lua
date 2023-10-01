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
xpanes.register_pane("ice", {
	description = "ice pane",
	textures = {"xpanes_ice.png","xpanes_ice_half.png","xpanes_ice_half.png"},
	use_texture_alpha = "blend",
	inventory_image = "xpanes_ice.png",
	wield_image = "xpanes_ice.png",
	sounds = default.node_sound_glass_defaults(),
	groups = {snappy=2, cracky=3, oddly_breakable_by_hand=3},
	recipe = {
		{"default:ice", "default:ice", "default:ice"},
		{"default:ice", "default:ice", "default:ice"}

	}
})
]]--
