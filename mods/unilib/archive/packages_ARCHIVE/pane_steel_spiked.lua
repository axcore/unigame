---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
xpanes.register_pane("bar_top", {
	description = "Spiked Steel Railing",
	textures = {"glass_stained_bar_fancy.png", "xpanes_pane_half.png", "default_glass_detail.png"},
	inventory_image = "glass_stained_bar_fancy.png",
	wield_image = "glass_stained_bar_fancy.png",
	groups = {cracky = 2},
	sounds = default.node_sound_metal_defaults(),
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
	}
})
]]--
