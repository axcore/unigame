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
minetest.register_node("underch:leafstone", {
	description = "Leafstone",
	tiles = {"underch_leafstone.png"},
	groups = {cracky = 3, stone = 1},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	type = "cooking",
	output = "underch:leafstone",
	recipe = "underch:mossy_gravel",
})

minetest.register_node("underch:light_leafstone", {
	description = "Light Leafstone",
	tiles = {"underch_light_leafstone.png"},
	groups = {cracky = 3, stone = 1},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
})
if minetest.get_modpath("moreores") ~= nil then
	minetest.register_craft({
		type = "shapeless",
		output = "underch:light_leafstone 5",
		recipe = {"moreores:tin_ingot", "moreores:tin_ingot", "moreores:tin_ingot", "moreores:tin_ingot", "underch:leafstone", "underch:leafstone", "underch:leafstone", "underch:leafstone"},
	})
end
]]--
