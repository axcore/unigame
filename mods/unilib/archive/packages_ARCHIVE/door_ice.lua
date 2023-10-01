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
doors.register("door_ice", {
	tiles = {{ name = "mtg_plus_door_ice.png", backface_culling = true }},
	description = S("Ice Door"),
	_doc_items_longdesc = S("Ice doors can be opened and closed. They are solid, but some of the light hitting ice doors can still go through, making them an interesting decoration in icy areas."),
	_doc_items_usagehelp = door_simple_use,
	_doc_items_image = "mtg_plus_door_ice_item.png",
	inventory_image = "mtg_plus_door_ice_item.png",
	groups = { cracky = 3, slippery = 3, },
	sounds = default.node_sound_glass_defaults(),
	sound_open = "mtg_plus_door_ice_open",
	sound_close = "mtg_plus_door_ice_close",
	recipe = {
		{"default:ice", "default:ice"},
		{"default:ice", "default:ice"},
		{"default:ice", "default:ice"},
	}
})

]]--
