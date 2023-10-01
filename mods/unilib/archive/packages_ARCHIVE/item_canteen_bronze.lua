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

    minetest.register_tool('thirsty:bronze_canteen', {
        description = 'Bronze canteen',
        inventory_image = "thirsty_bronze_canteen_16.png",
        liquids_pointable = true,
        stack_max = 1,
        on_use = thirsty.on_use(nil),
    })
    minetest.register_craft({
        output = "thirsty:bronze_canteen",
        recipe = {
            { "group:wood", ""},
            { "default:bronze_ingot", "default:bronze_ingot"},
            { "default:bronze_ingot", "default:bronze_ingot"}
        }
    })

end
]]--
