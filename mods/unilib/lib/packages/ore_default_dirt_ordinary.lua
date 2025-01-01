---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_default_dirt_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_default_dirt_ordinary.init()

    return {
        description = "Ordinary dirt as ore",
        depends = {"dirt_ordinary", "stone_ordinary"},
        at_least_one = {
            "biome_default_forest_coniferous",
            "biome_default_forest_deciduous",
            "biome_default_grassland",
            "biome_default_rainforest",
            "biome_default_taiga",
        },
    }

end

function unilib.pkg.ore_default_dirt_ordinary.post()

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "blob",
        ore                     = "unilib:dirt_ordinary",
        wherein                 = "unilib:stone_ordinary",

        -- Only where unilib:dirt_ordinary is present as surface material
        biomes                  = {
            "default_forest_coniferous",
            "default_forest_deciduous",
            "default_forest_deciduous_shore",
            "default_grassland",
            "default_grassland_snowy",
            "default_rainforest",
            "default_rainforest_swamp",
            "default_taiga",
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
        y_max                   = unilib.constant.y_max,
        y_min                   = -31,
    })

end
