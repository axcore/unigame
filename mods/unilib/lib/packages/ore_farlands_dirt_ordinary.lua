---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_farlands_dirt_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_farlands_dirt_ordinary.init()

    return {
        description = "Ordinary dirt as ore",
        depends = {"dirt_ordinary", "stone_ordinary"},
        at_least_one = {
            "biome_farlands_forest_coniferous",
            "biome_farlands_forest_deciduous",
            "biome_farlands_grassland",
            "biome_farlands_grassland_snowy",
            "biome_farlands_rainforest",
            "biome_farlands_savanna",
            "biome_farlands_taiga",
        },
    }

end

function unilib.pkg.ore_farlands_dirt_ordinary.post()

    unilib.register_ore({
        -- From farlands, mapgen/mapgen.lua
        ore_type                = "blob",
        ore                     = "unilib:dirt_ordinary",
        wherein                 = "unilib:stone_ordinary",

        biomes                  = {
            "farlands_forest_coniferous",
            "farlands_forest_deciduous",
            "farlands_grassland",
            "farlands_grassland_snowy",
            "farlands_rainforest",
            "farlands_savanna",
            "farlands_taiga",
        },
        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 5,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.0,
            scale = 0.2,
            seed = 17676,
            spread = {x = 5, y = 5, z = 5},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.y_max,
        y_min                   = -31,
    })

end
