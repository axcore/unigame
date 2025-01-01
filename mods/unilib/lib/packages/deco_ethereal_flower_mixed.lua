---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_flower_mixed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_flower_mixed.init()

    return {
        description = "Various flowers as decorations",
        depends = {
            "flower_dandelion_white",
            "flower_dandelion_yellow",
            "flower_geranium_blue",
            "flower_rose_red",
            "flower_tulip_orange",
            "flower_viola_purple",
        },
        at_least_one = {
            {
                "biome_ethereal_forest_deciduous",
                "biome_ethereal_grassy",
                "biome_ethereal_mediterranean",
                "biome_ethereal_prairie",
            },
            {
                "dirt_ordinary",
                "dirt_ordinary_with_turf_grove",
                "dirt_ordinary_with_turf_prairie",
            },
        },
        optional = {
            "flower_chrysanthemum_green",
            "flower_tulip_black",
        },
    }

end

function unilib.pkg.deco_ethereal_flower_mixed.exec()

    -- N.B. Too many optional packages to check individually; let the engine handle it

    unilib.register_decoration_generic("ethereal_flowers_1", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = {
            "unilib:flower_dandelion_white",
            "unilib:flower_dandelion_yellow",
            "unilib:flower_geranium_blue",
            "unilib:flower_rose_red",
            "unilib:flower_tulip_orange",
            "unilib:flower_viola_purple",
        },

        fill_ratio = 0.025,
        sidelen = 80,
    })

    unilib.register_decoration_generic("ethereal_flowers_2", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = {
            "unilib:flower_chrysanthemum_green",
            "unilib:flower_dandelion_white",
            "unilib:flower_dandelion_yellow",
            "unilib:flower_geranium_blue",
            "unilib:flower_rose_red",
            "unilib:flower_tulip_black",
            "unilib:flower_tulip_orange",
            "unilib:flower_viola_purple",
        },

        fill_ratio = 0.035,
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_flower_mixed.post()

    unilib.register_decoration_complete("ethereal_flowers_1", nil, {
        -- From ethereal-ng/decor.lua
        biomes = {
            "ethereal_forest_deciduous",
            "ethereal_grassy",
            "ethereal_mediterranean",
        },
        place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_grove",
        },
        y_max = 100,
        y_min = 1,
    })

    unilib.register_decoration_complete("ethereal_flowers_2", nil, {
        -- From ethereal-ng/decor.lua
        biomes = "ethereal_prairie",
        place_on = "unilib:dirt_ordinary_with_turf_prairie",
        y_max = 100,
        y_min = 1,
    })

end
