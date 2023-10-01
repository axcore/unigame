---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    thirsty
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA-4.0
--
-- From:    vessels
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("vessels:steel_bottle", {
	description = S("Empty Heavy Steel Bottle"),
	drawtype = "plantlike",
	tiles = {"vessels_steel_bottle.png"},
	inventory_image = "vessels_steel_bottle.png",
	wield_image = "vessels_steel_bottle.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_defaults(),
})
minetest.register_craft( {
	output = "vessels:steel_bottle 5",
	recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"", "default:steel_ingot", ""}
	}
})
minetest.register_craft( {
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "vessels:steel_bottle",
})

if minetest.get_modpath("vessels") and thirsty.config.register_vessels then
    thirsty.augment_item_for_drinking('vessels:steel_bottle', 26)
end
]]--
