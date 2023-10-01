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
doors.register_trapdoor("mtg_plus:trapdoor_icesteel", {
	description = S("Icy Steel Trapdoor"),
	_doc_items_longdesc = S("An icy steel trapdoor is a combination of an ice trapdoor and a steel trapdoor. It covers the floor and can only be opened and closed by its placer. Icy steel trapdoors are solid, but some light can pass through nonetheless."),
	_doc_items_usagehelp = S("Point the icy steel trapdoor to see who owns it. Use the use key on it to open or close it (if you own it)."),
	protected = true,
	tile_front = "mtg_plus_trapdoor_icesteel.png",
	tile_side = "mtg_plus_trapdoor_icesteel_side.png",
	inventory_image = "mtg_plus_trapdoor_icesteel.png",
	wield_image = "mtg_plus_trapdoor_icesteel.png",
	sound_open = "mtg_plus_door_icesteel_open",
	sound_close = "mtg_plus_door_icesteel_close",
	sounds = metal_sounds,
	groups = { snappy = 1, bendy = 2, cracky = 3, melty = 3, level = 2, slippery = 1, door = 1 },
})
minetest.register_craft({
	type = "shapeless",
	output = "mtg_plus:trapdoor_icesteel 2",
	recipe = { "mtg_plus:trapdoor_ice", "doors:trapdoor_steel" },
})
]]--
