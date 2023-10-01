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
minetest.register_node("underch:mossy_gravel", {
	description = "Mossy Gravel",
	tiles = {"underch_mossy_gravel.png"},
	groups = {crumbly = 2, falling_node = 1},
	is_ground_content = true,
	sounds = default.node_sound_gravel_defaults(),
})
minetest.register_craft({
	type = "shapeless",
	output = "underch:mossy_gravel 2",
	recipe = {"group:leaves", "group:leaves", "default:dirt", "default:gravel"},
})
]]--
