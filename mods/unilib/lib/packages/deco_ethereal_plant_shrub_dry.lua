---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_plant_shrub_dry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

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
            "biome_ethereal_sandstone",
            "biome_ethereal_savanna",
            "clay_baked_ethereal",
            "dirt_dried",
            "sand_desert",
            "sand_ordinary",
            "stone_sandstone_ordinary",
        },
    }

end

function unilib.pkg.deco_ethereal_plant_shrub_dry.exec()

    unilib.register_decoration("ethereal_plant_shrub_dry", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:plant_shrub_dry",

        fill_ratio = 0.015,
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_plant_shrub_dry.post()

    if unilib.pkg_executed_table["biome_ethereal_savanna"] ~= nil and
            unilib.pkg_executed_table["dirt_dried"] ~= nil then

        unilib.register_decoration_now("ethereal_plant_shrub_dry", "ethereal_plant_shrub_dry_1", {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_plains",
            place_on = "unilib:dirt_dried",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_forest_deciduous"] ~= nil and
            unilib.pkg_executed_table["sand_ordinary"] ~= nil then

        unilib.register_decoration_now("ethereal_plant_shrub_dry", "ethereal_plant_shrub_dry_2", {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_forest_deciduous_ocean",
            place_on = "unilib:sand_ordinary",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_desert"] ~= nil and
            unilib.pkg_executed_table["sand_desert"] ~= nil then

        unilib.register_decoration_now("ethereal_plant_shrub_dry", "ethereal_plant_shrub_dry_3", {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_desert",
            place_on = "unilib:sand_desert",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_sandstone"] ~= nil and
            unilib.pkg_executed_table["stone_sandstone_ordinary"] ~= nil then

        unilib.register_decoration_now("ethereal_plant_shrub_dry", "ethereal_plant_shrub_dry_4", {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_sandstone",
            place_on = "unilib:stone_sandstone_ordinary",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_mesa"] ~= nil and
            unilib.pkg_executed_table["clay_baked_ethereal"] ~= nil then

        unilib.register_decoration_now("ethereal_plant_shrub_dry", "ethereal_plant_shrub_dry_5", {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_mesa",
            place_on = {"unilib:clay_baked_orange", "unilib:clay_baked_red"},
            y_max = 100,
            y_min = 1,
        })

    end

end

