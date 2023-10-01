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
xpanes.register_pane("goldglass", {
	description = S("Goldglass Pane"),
	inventory_image = "mtg_plus_goldglass.png",
	wield_image = "mtg_plus_goldglass.png",
	textures = {"mtg_plus_goldglass.png","mtg_plus_goldglass_pane_half.png","mtg_plus_goldglass_pane_top.png",},
	groups = {cracky=3,oddly_breakable_by_hand=2,pane=1},
	sounds = default.node_sound_glass_defaults(),
	recipe = {
		{ "mtg_plus:goldglass","mtg_plus:goldglass","mtg_plus:goldglass", },
		{ "mtg_plus:goldglass","mtg_plus:goldglass","mtg_plus:goldglass", },
	}
})

xpanes.register_pane("goldglass2", {
	description = S("Golden Window"),
	inventory_image = "mtg_plus_goldglass2.png",
	wield_image = "mtg_plus_goldglass2.png",
	textures = {"mtg_plus_goldglass2.png","mtg_plus_goldglass_pane_half.png","mtg_plus_goldglass_pane_top.png",},
	groups = {cracky=3,oddly_breakable_by_hand=3,pane=1},
	sounds = default.node_sound_glass_defaults(),
	recipe = {
		{ "default:gold_ingot","default:gold_ingot","default:gold_ingot", },
		{ "default:gold_ingot","default:glass","default:gold_ingot", },
		{ "default:gold_ingot","default:gold_ingot","default:gold_ingot", },
	}
})
]]--
