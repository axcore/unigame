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
if minetest.get_modpath("default") and minetest.get_modpath("bucket") and thirsty.config.register_fountains then

    minetest.register_node('thirsty:water_fountain', {
        description = 'Water fountain',
        tiles = {
            -- top, bottom, right, left, front, back
            'thirsty_waterfountain_top.png',
            'thirsty_waterfountain_top.png',
            'thirsty_waterfountain_side.png',
            'thirsty_waterfountain_side.png',
            'thirsty_waterfountain_side.png',
            'thirsty_waterfountain_side.png',
        },t
        paramtype = 'light',
        groups = { cracky = 2 },
    })
    minetest.register_craft({
        output = "thirsty:water_fountain",
        recipe = {
            { "default:copper_ingot", "bucket:bucket_water", "default:copper_ingot"},
            { "", "default:copper_ingot", ""},
            { "default:copper_ingot", "default:mese_crystal", "default:copper_ingot"}
        }
    })
    
    minetest.register_node('thirsty:water_extender', {
        description = 'Water fountain extender',
        tiles = {
            'thirsty_waterextender_top.png',
            'thirsty_waterextender_top.png',
            'thirsty_waterextender_side.png',
            'thirsty_waterextender_side.png',
            'thirsty_waterextender_side.png',
            'thirsty_waterextender_side.png',
        },
        paramtype = 'light',
        groups = { cracky = 2 },
    })
    minetest.register_craft({
        output = "thirsty:water_extender",
        recipe = {
            { "", "bucket:bucket_water", ""},
            { "", "default:copper_ingot", ""},
            { "default:copper_ingot", "default:mese_crystal", "default:copper_ingot"}
        }
    })

    minetest.register_abm({
        nodenames = {'thirsty:water_fountain'},
        interval = 2,
        chance = 5,
        action = thirsty.fountain_abm,
    })

end
]]--
