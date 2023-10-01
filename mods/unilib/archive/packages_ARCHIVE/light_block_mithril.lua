---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelamps
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("morelamps:mithril_lamp", {
	description = "Mithril Lamp",
	drawtype = "glasslike",
	tiles = {"morelamps_mithrillamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
	light_source = default.LIGHT_MAX,
})
minetest.register_craft({
	output = 'morelamps:mithril_lamp',
	recipe = {
		{'defaut:glass'},
		{'moreores:mithril_ingot'},
	}
})
]]--
