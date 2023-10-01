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
doors.register("door_papyrus", {
	tiles = {{ name = "mtg_plus_door_papyrus.png", backface_culling = true }},
	description = S("Papyrus Door"),
	_doc_items_longdesc = door_simple,
	_doc_items_usagehelp = door_simple_use,
	_doc_items_image = "mtg_plus_door_papyrus_item.png",
	inventory_image = "mtg_plus_door_papyrus_item.png",
	sounds = default.node_sound_leaves_defaults(),
	sound_open = "doors_fencegate_open",
	sound_close = "doors_fencegate_close",
	groups = { snappy = 2, choppy = 1, flammable = 2 },
	recipe = {
		{"default:papyrus", "default:papyrus"},
		{"farming:string", "farming:string"},
		{"default:papyrus", "default:papyrus"},
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "doors:door_papyrus",
	burntime = 4,
})
]]--
