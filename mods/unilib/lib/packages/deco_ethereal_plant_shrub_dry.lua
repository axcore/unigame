---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_plant_shrub_dry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_plant_shrub_dry.init()

    return {
        description = "Dry shrub as decoration",
        depends = "plant_shrub_dry",
        optional = {
            "biome_ethereal_desert",
            "biome_ethereal_forest_deciduous",
            "biome_ethereal_mesa",
            "biome_ethereal_plains",
            "biome_ethereal_sandstone_desert",
            "clay_baked_ethereal",
            "dirt_dried",
            "dirt_ordinary",
            "sand_desert",
            "sand_ordinary",
            "stone_sandstone_ordinary",
        },
    }

end

function unilib.pkg.deco_ethereal_plant_shrub_dry.exec()

    unilib.register_decoration_generic("ethereal_plant_shrub_dry", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:plant_shrub_dry",

        fill_ratio = 0.015,
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_plant_shrub_dry.post()

    -- N.B. Too many optional packages to check individually; let the engine handle it

    unilib.register_decoration_complete(
        -- From ethereal-ng/decor.lua
        "ethereal_plant_shrub_dry",
        "ethereal_plant_shrub_dry_1",
        {
            biomes = {
                "ethereal_desert",
                "ethereal_forest_deciduous_ocean",
                "ethereal_mesa",
                "ethereal_plains",
                "ethereal_sandstone_desert",
            },
            place_on = {
                "unilib:dirt_dried",
                "unilib:dirt_ordinary_with_turf_dry",
                "unilib:sand_desert",
                "unilib:sand_ordinary",
                "unilib:stone_sandstone_ordinary",
            },
            y_max = 100,
            y_min = 1,
        }
    )

    unilib.register_decoration_complete(
        -- From ethereal-ng/decor.lua
        "ethereal_plant_shrub_dry",
        "ethereal_plant_shrub_dry_2",
        {
            biomes = {
                "ethereal_mesa",
                "ethereal_mesa_beach",
                "ethereal_mesa_redwood",
            },
            place_on = {
                "unilib:clay_baked_brown",
                "unilib:clay_baked_grey",
                "unilib:clay_baked_orange",
                "unilib:clay_baked_red",
                "unilib:dirt_ordinary_with_turf_dry",
                "unilib:sand_desert",
            },
            y_max = 100,
            y_min = 1,
        }
    )

end

