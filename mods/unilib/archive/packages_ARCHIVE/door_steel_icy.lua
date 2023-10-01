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
doors.register("door_icesteel", {
	tiles = {{ name = "mtg_plus_door_icesteel.png", backface_culling = true }},
	description = S("Icy Steel Door"),
	_doc_items_longdesc = S("Icy steel doors are a combination of ice doors and steel doors which can only be opened and closed by their owners. They are solid, but some of the light hitting icy steel doors can still go through."),
	_doc_items_usagehelp = S("Point the door to see who owns it. Use the use key on the door to open or close it (if you own it)."),
	_doc_items_image = "mtg_plus_door_icesteel_item.png",
	protected = true,
	sound_open = "mtg_plus_door_icesteel_open",
	sound_close = "mtg_plus_door_icesteel_close",
	inventory_image = "mtg_plus_door_icesteel_item.png",
	sounds = metal_sounds,
	groups = { snappy = 1, bendy = 2, cracky = 3, melty = 3, level = 2, slippery = 1, },
})
minetest.register_craft({
	output = "doors:door_icesteel 2",
	type = "shapeless",
	recipe = {"doors:door_ice", "doors:door_steel"},
})
]]--
