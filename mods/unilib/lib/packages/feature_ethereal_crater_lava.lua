---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.feature_ethereal_crater_lava = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.feature_ethereal_crater_lava.init()

    return {
        description = "Lava crater feature",
        depends = {
            "biome_ethereal_fiery",
            "dirt_ordinary_with_turf_fiery",
            -- (From schematic)
            "liquid_lava_ordinary",
            "stone_obsidian",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.feature_ethereal_crater_lava.exec()

    unilib.register_decoration_generic("ethereal_crater_lava_large", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_feature_crater_lava_large.mts",

        fill_ratio = 0.003,
        flags = "place_center_x, place_center_z",
        rotation = "random",
        sidelen = 80,
    })

    unilib.register_decoration_generic("ethereal_crater_lava_small", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_feature_crater_lava_small.mts",

        fill_ratio = 0.01,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end

function unilib.pkg.feature_ethereal_crater_lava.post()

    unilib.register_decoration_complete("ethereal_crater_lava_large", nil, {
        -- From ethereal-ng/decor.lua
        biomes = "ethereal_fiery",
        num_spawn_by = 4,
        place_on = "unilib:dirt_ordinary_with_turf_fiery",
        spawn_by = "unilib:dirt_ordinary_with_turf_fiery",
        y_max = 100,
        y_min = 1,
    })

    unilib.register_decoration_complete("ethereal_crater_lava_small", nil, {
        -- From ethereal-ng/decor.lua
        biomes = "ethereal_fiery",
        num_spawn_by = 6,
        place_on = "unilib:dirt_ordinary_with_turf_fiery",
        spawn_by = "unilib:dirt_ordinary_with_turf_fiery",
        y_max = 100,
        y_min = 1,
    })

end
