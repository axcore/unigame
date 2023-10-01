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
-- Jungle log
minetest.register_decoration({
    name = "default:jungle_log",
    deco_type = "schematic",
    place_on = {"default:dirt_with_rainforest_litter"},
    place_offset_y = 1,
    sidelen = 80,
    fill_ratio = 0.005,
    biomes = {"rainforest"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("default") .. "/schematics/jungle_log.mts",
    flags = "place_center_x",
    rotation = "random",
    spawn_by = "default:dirt_with_rainforest_litter",
    num_spawn_by = 8,
})
]]--
