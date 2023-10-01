---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_plant_shrub_dry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_plant_shrub_dry.init()

    return {
        description = "Dry shrub as decoration",
        depends = "plant_shrub_dry",
        at_least_one = {
            {
                "biome_default_desert",
                "biome_default_desert_cold",
                "biome_default_desert_sandstone",
            },
            {"sand_desert", "sand_ordinary", "sand_silver"},
        },
    }

end

function unilib.pkg.deco_default_plant_shrub_dry.post()

    unilib.register_decoration_now("default_plant_shrub_dry", nil, {
        -- From default/mapgen.lua
        -- Completes decoration in package "plant_shrub_dry"
        biomes = {"default_desert", "default_desert_cold", "default_desert_sandstone"},
        place_on = {
            "unilib:sand_ordinary",
            "unilib:sand_desert",
            "unilib:sand_silver",
        },
        y_max = unilib.y_max,
        y_min = 2,
    })

end
