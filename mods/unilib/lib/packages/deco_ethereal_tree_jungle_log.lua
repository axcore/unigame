---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_jungle_log = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_jungle_log.init()

    return {
        description = "Jungle tree log as decoration",
        depends = {"biome_ethereal_rainforest", "dirt_ordinary", "tree_jungle"},
    }

end

function unilib.pkg.deco_ethereal_tree_jungle_log.exec()

    unilib.register_decoration_generic("ethereal_tree_jungle_log", {
        -- From ethereal-ng/decor.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_jungle_log.mts",

        fill_ratio = 0.005,
        flags = "place_center_x",
        place_offset_y = 1,
        rotation = "random",
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_tree_jungle_log.post()

    unilib.register_decoration_complete("ethereal_tree_jungle_log", nil, {
        -- From ethereal-ng/schems.lua
        biomes = "ethereal_rainforest",
        num_spawn_by = 8,
        place_on = "unilib:dirt_ordinary_with_litter_rainforest",
        spawn_by = "unilib:dirt_ordinary_with_litter_rainforest",
        y_max = 100,
        y_min = 1,
    })

end
