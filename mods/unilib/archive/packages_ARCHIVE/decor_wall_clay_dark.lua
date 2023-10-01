---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriglass
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("abriglass:oneway_wall_dark", {
	description = "Dark Block",
	tiles = {"abriglass_oneway_wall.png"},
	groups = {cracky = 3},
	paramtype2 = "facedir",
})
minetest.register_craft({
	output = 'abriglass:oneway_wall_dark 2',
	recipe = {
		{'default:clay_lump', 'default:clay_lump', 'default:clay_lump'},
		{'default:clay_lump', 'dye:black', 'default:clay_lump'},
		{'default:clay_lump', 'default:clay_lump', 'default:clay_lump'},
	}
})
]]--
