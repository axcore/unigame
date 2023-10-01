---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_decoration({
    name = "default:pine_log",
    deco_type = "schematic",
    place_on = {"default:dirt_with_snow", "default:dirt_with_coniferous_litter"},
    place_offset_y = 1,
    sidelen = 80,
    fill_ratio = 0.0018,
    biomes = {"taiga", "coniferous_forest"},
    y_max = 31000,
    y_min = 4,
    schematic = minetest.get_modpath("default") .. "/schematics/pine_log.mts",
    flags = "place_center_x",
    rotation = "random",
    spawn_by = {"default:dirt_with_snow", "default:dirt_with_coniferous_litter"},
    num_spawn_by = 8,
})
]]--
