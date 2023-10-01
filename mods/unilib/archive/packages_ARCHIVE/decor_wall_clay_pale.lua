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
minetest.register_node("abriglass:oneway_wall_pale", {
	description = "Pale Block",
	tiles = {"abriglass_oneway_wall.png^[colorize:#E6E6FA:200"},
	groups = {cracky = 3},
	paramtype2 = "facedir",
})
minetest.register_craft({
	output = 'abriglass:oneway_wall_pale 2',
	recipe = {
		{'default:clay_lump', 'default:clay_lump', 'default:clay_lump'},
		{'default:clay_lump', 'dye:white', 'default:clay_lump'},
		{'default:clay_lump', 'default:clay_lump', 'default:clay_lump'},
	}
})
]]--
