---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
xpanes.register_pane("ice", {
	description = S("Ice Window Pane"),
	inventory_image = "mtg_plus_ice_window.png",
	wield_image = "mtg_plus_ice_window.png",
	textures = {"mtg_plus_ice_window.png", "mtg_plus_ice_window.png", "mtg_plus_ice_window.png"},
	groups = {cracky=3, slippery = 3, pane=1},
	sounds = default.node_sound_glass_defaults(),
	recipe = {
		{ "mtg_plus:ice_window", "mtg_plus:ice_window", "mtg_plus:ice_window", },
		{ "mtg_plus:ice_window", "mtg_plus:ice_window", "mtg_plus:ice_window", }
	}
})
]]--
