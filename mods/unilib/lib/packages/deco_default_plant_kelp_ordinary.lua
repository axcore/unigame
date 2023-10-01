---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_plant_kelp_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_plant_kelp_ordinary.init()

    return {
        description = "Ordinary sand with kelp as decoration",
        depends = {"plant_kelp_ordinary", "sand_ordinary"},
        at_least_one = {
            "biome_default_desert_cold",
            "biome_default_desert_sandstone",
            "biome_default_forest_coniferous",
            "biome_default_forest_deciduous",
            "biome_default_grassland",
            "biome_default_grassland_snowy",
            "biome_default_taiga",
        },
    }

end

function unilib.pkg.deco_default_plant_kelp_ordinary.post()

    unilib.register_decoration_now("default_plant_kelp_ordinary", nil, {
        -- From default/mapgen.lua
        -- Completes decoration in package "plant_kelp_ordinary"
        biomes = {
            "default_desert_cold_ocean",
            "default_desert_sandstone_ocean",
            "default_forest_coniferous_ocean",
            "default_forest_deciduous_ocean",
            "default_grassland_ocean",
            "default_grassland_snowy_ocean",
            "default_taiga_ocean",
        },
        place_on = "unilib:sand_ordinary",
        y_max = -5,
        y_min = -10,
    })

end
