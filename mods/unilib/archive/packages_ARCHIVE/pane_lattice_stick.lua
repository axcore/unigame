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
xpanes.register_pane("lattice", {t
	description = "Lattice",
	textures = {"xpanes_lattice.png","xpanes_trans.png","xpanes_trans.png"},
	inventory_image = "xpanes_lattice.png",
	wield_image = "xpanes_lattice.png",
	sounds = default.node_sound_glass_defaults(),
	groups = {snappy=2, cracky=3, oddly_breakable_by_hand=3},
	recipe = {
		{"default:stick", "", "default:stick"},
		{"", "default:stick", ""},
		{"default:stick", "", "default:stick"}
	}
})
]]--
