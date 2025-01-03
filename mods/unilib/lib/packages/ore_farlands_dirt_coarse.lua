---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_farlands_dirt_coarse = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_farlands_dirt_coarse.init()

    return {
        description = "Coarse dirt as ore",
        depends = "dirt_coarse",
        optional = {
            "biome_farlands_forest_coniferous",
            "biome_farlands_forest_deciduous",
            "biome_farlands_grassland",
            "biome_farlands_grassland_snowy",
            "biome_farlands_rainforest",
            "biome_farlands_savanna",
            "biome_farlands_taiga",
            "dirt_ordinary_with_litter_leafy",
            "dirt_ordinary_with_turf_forest",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.ore_farlands_dirt_coarse.post()

    if unilib.global.pkg_executed_table["stone_ordinary"] ~= nil then

        unilib.register_ore({
            -- From farlands, mapgen/mapgen.lua
            ore_type            = "blob",
            ore                 = "unilib:dirt_coarse",
            wherein             = "unilib:stone_ordinary",

            biomes              = {
                "farlands_forest_coniferous",
                "farlands_forest_deciduous",
                "farlands_grassland",
                "farlands_grassland_snowy",
                "farlands_rainforest",
                "farlands_savanna",
                "farlands_taiga",
            },
            clust_scarcity      = 8 * 8 * 8,
            clust_size          = 2,
            noise_params        = {
                octaves = 1,
                offset = 0.4,
                persist = 0.0,
                scale = 0.2,
                seed = 17676,
                spread = {x = 5, y = 5, z = 5},
            },
            noise_threshold     = 0.0,
            y_max               = -31,
            y_min               = unilib.constant.y_min,
        })

    end

    if unilib.global.pkg_executed_table["dirt_ordinary_with_turf_forest"] ~= nil then

        unilib.register_ore({
            -- From farlands, mapgen/mapgen.lua
            ore_type            = "blob",
            ore                 = "unilib:dirt_coarse",
            wherein             = "unilib:dirt_ordinary_with_turf_forest",

            clust_scarcity      = 16 * 16 * 16,
            clust_size          = 5,
            noise_params        = {
                octaves = 1,
                offset = 0.5,
                persist = 0.0,
                scale = 0.2,
                seed = 766,
                spread = {x = 5, y = 5, z = 5},
            },
            noise_threshold     = 0.0,
            y_max               = unilib.constant.y_max,
            y_min               = unilib.constant.y_min,
        })

    end

    if unilib.global.pkg_executed_table["biome_farlands_forest_coniferous"] ~= nil and
            unilib.global.pkg_executed_table["dirt_ordinary_with_litter_leafy"] ~= nil then

        unilib.register_ore({
            -- From farlands, mapgen/mapgen.lua
            ore_type            = "blob",
            ore                 = "unilib:dirt_coarse",
            wherein             = "unilib:dirt_ordinary_with_litter_leafy",

            biomes              = {"farlands_forest_coniferous_tall"},
            clust_scarcity      = 15 * 15 * 15,
            clust_size          = 3,
            noise_params        = {
                octaves = 1,
                offset = 0.55,
                persist = 0.0,
                scale = 0.2,
                seed = 766,
                spread = {x = 5, y = 5, z = 5},
            },
            noise_threshold     = 0.0,
            y_max               = unilib.constant.y_max,
            y_min               = unilib.constant.y_min,
        })

    end

end
