---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    scaffolding
-- Code:    CC-BY-SA-4.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("scaffolding:scaffolding_wrench", {
	description = "Scaffolding Wrench",
	inventory_image = "scaffolding_wrench.png",
})
minetest.register_craft({
    output = 'scaffolding:scaffolding_wrench',
    recipe = {
        {'', 'default:steel_ingot', ''},
        {'', 'default:steel_ingot', 'default:steel_ingot'},
        {'default:steel_ingot', '', ''},
    }
})
]]--
