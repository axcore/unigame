---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("valleys_c:sand_with_rocks", {
	description = "Sand and rocks",
	tiles = {"vmg_sand_with_rocks.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = default.node_sound_sand_defaults(),
	drop = {max_items=2, items={{items={"valleys_c:small_rocks"}, rarity=1}, {items={"default:sand"}, rarity=1}}},
})
]]--
