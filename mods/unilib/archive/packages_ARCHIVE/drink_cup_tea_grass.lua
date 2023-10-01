---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tea
-- Code:    LGPL v2.1
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("tea:grass", {
    description = "grass tea",
    inventory_image = "grass_tea.png"
})

minetest.register_craft({
    type = "shapeless",
    output = "tea:grass",
    recipe = {
        "default:grass_1",
        "default:grass_1",
        "default:grass_1",
	"default:grass_1",
	"default:grass_1",
	"default:grass_1",
	"default:torch",
	"bucket:bucket_water",
	"vessels:drinking_glass",
    },
})
]]--
