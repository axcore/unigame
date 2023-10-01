---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.feature_farlands_stone_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.feature_farlands_stone_ordinary.init()

    return {
        description = "Ordinary stone rock formations",
        depends = {
            "biome_farlands_forest_deciduous",
            "biome_farlands_grassland",
            "dirt_ordinary",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.feature_farlands_stone_ordinary.exec()

    -- N.B. In original code, only schematics 1-3 are used; here we use all of them
    for i = 1, 5 do

        unilib.register_decoration("farlands_feature_stone_ordinary_" .. i, {
            -- From farlands, mapgen/mapgen.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_feature_stone_ordinary_" .. i .. ".mts",

            flags = "place_center_x, place_center_z",
            noise_params = {
                octaves = 3,
                offset = 0.0005,
                persist = 0.66,
                scale = 0.0005,
                seed = 2,
                spread = {x = 250, y = 250, z = 250},
            },
            sidelen = 16,
        })

    end

end

function unilib.pkg.feature_farlands_stone_ordinary.post()

    for i = 1, 5 do

        unilib.register_decoration_now("farlands_feature_stone_ordinary_" .. i, nil, {
            -- From farlands, mapgen/mapgen.lua
            biomes = {"farlands_forest_deciduous_tall", "farlands_grassland"},
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = unilib.y_max,
            y_min = 1,
        })

    end

end

