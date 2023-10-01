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
doors.register("door_wood_bar", {
	tiles = {{ name = "mtg_plus_door_wood_bar.png", backface_culling = true }},
	description = S("Wooden Bar Door"),
	_doc_items_longdesc = door_simple,
	_doc_items_usagehelp = door_simple_use,
	_doc_items_image = "mtg_plus_door_wood_bar_item.png",
	inventory_image = "mtg_plus_door_wood_bar_item.png",
	sounds = default.node_sound_wood_defaults(),
	sound_open = "doors_fencegate_open",
	sound_close = "doors_fencegate_close",
	groups = { snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
	recipe = {
		{"xpanes:wood_flat",},
		{"xpanes:wood_flat",},
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "doors:door_wood_bar",
	burntime = 4,
})
]]--
