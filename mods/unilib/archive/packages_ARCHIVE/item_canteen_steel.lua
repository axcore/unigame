---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    thirsty
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if minetest.get_modpath("default") and thirsty.config.register_canteens then

    minetest.register_tool('thirsty:steel_canteen', {
        description = 'Steel canteen',
        inventory_image = "thirsty_steel_canteen_16.png",
        liquids_pointable = true,
        stack_max = 1,
        on_use = thirsty.on_use(nil),
    })
    minetest.register_craft({
        output = "thirsty:steel_canteen",
        recipe = {
            { "group:wood", ""},
            { "default:steel_ingot", "default:steel_ingot"},
            { "default:steel_ingot", "default:steel_ingot"}
        }
    })

end
]]--
