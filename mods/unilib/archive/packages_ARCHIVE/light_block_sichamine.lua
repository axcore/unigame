---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("underch:sichamine_lamp", {
	description = "Sichamine Lamp",
	tiles = {"underch_sichamine_lamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
	light_source = default.LIGHT_MAX,
})
minetest.register_craft({
	output = "underch:sichamine_lamp",
	recipe = {
		{"","default:mese_crystal",""},
		{"default:mese_crystal","underch:sichamine","default:mese_crystal"},
	}
})
]]--
