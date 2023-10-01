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
doors.register_trapdoor("mtg_plus:trapdoor_ice", {
	description = S("Ice Trapdoor"),
	_doc_items_longdesc = S("An ice trapdoor covers the floor and can be opened and closed by anyone. Ice trapdoors are solid, but some light can pass through nonetheless."),
	_doc_items_usagehelp = door_simple_use,
	tile_front = "mtg_plus_trapdoor_ice.png",
	tile_side = "mtg_plus_trapdoor_ice_side.png",
	inventory_image = "mtg_plus_trapdoor_ice.png",
	wield_image = "mtg_plus_trapdoor_ice.png",
	sound_open = "mtg_plus_door_ice_open",
	sound_close = "mtg_plus_door_ice_close",
	sounds = default.node_sound_glass_defaults(),
	groups = { cracky = 3, slippery = 3, door = 1 },
})
minetest.register_craft({
	output = "mtg_plus:trapdoor_ice 2",
	recipe = { { "default:ice", "default:ice", "default:ice" },
	{ "default:ice", "default:ice", "default:ice" }, }
})
]]--
