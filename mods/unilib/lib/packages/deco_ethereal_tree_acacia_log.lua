---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_acacia_log = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_acacia_log.init()

    return {
        description = "Acacia tree log as decoration",
        depends = {"biome_ethereal_savanna", "dirt_dry", "tree_acacia"},
    }

end

function unilib.pkg.deco_ethereal_tree_acacia_log.exec()

    unilib.register_decoration_generic("ethereal_tree_acacia_log", {
        -- From ethereal-ng/decor.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_acacia_log.mts",

        flags = "place_center_x",
        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.001,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        place_offset_y = 1,
        rotation = "random",
        sidelen = 16,
    })

end

function unilib.pkg.deco_ethereal_tree_acacia_log.post()

    unilib.register_decoration_complete("ethereal_tree_acacia_log", nil, {
        -- From ethereal-ng/schems.lua
        biomes = "ethereal_savanna",
        num_spawn_by = 8,
        place_on = "unilib:dirt_dry_with_turf_dry",
        spawn_by = "unilib:dirt_dry_with_turf_dry",
        y_max = 100,
        y_min = 1,
    })

end
