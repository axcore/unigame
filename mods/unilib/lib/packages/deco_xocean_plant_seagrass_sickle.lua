---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_xocean_plant_seagrass_sickle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_xocean_plant_seagrass_sickle.init()

    return {
        description = "Seagrass as decoration",
        depends = {"plant_seagrass_sickle", "sand_ordinary"},
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

function unilib.pkg.deco_xocean_plant_seagrass_sickle.post()

    unilib.register_decoration_now("xocean_plant_seagrass_sickle", nil, {
        -- From xocean/init.lua
        -- Completes decoration in package "plant_seagrass_sickle"
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
        y_min = -50,
    })

end
