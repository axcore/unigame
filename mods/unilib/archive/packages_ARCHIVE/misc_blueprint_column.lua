---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    columnia
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("columnia:blueprint", {
	description = "Column Blueprint",
	inventory_image = "columnia_blueprint.png",
})
minetest.register_craft({
	output = 'columnia:blueprint',
	recipe = {
		{'default:paper', 'group:stick', 'default:paper'},
		{'default:paper', 'default:coal_lump', 'default:paper'},
		{'default:paper', 'group:stick', 'default:paper'},
	}
})
]]--
