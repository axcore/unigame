---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_flower_with_strawberry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_flower_with_strawberry.init()

    return {
        description = "Flowers and strawberries as decoration",
        depends = {
            "flower_dandelion_white",
            "flower_dandelion_yellow",
            "flower_geranium_blue",
            "flower_rose_red",
            "flower_tulip_orange",
            "flower_viola_purple",
            "produce_strawberry_normal",
        },
        optional = {
            "biome_ethereal_forest_deciduous",
            "biome_ethereal_grassy",
            "biome_ethereal_prairie",
            "dirt_ordinary",
            "dirt_ordinary_with_turf_prairie",
            "flower_chrysanthemum_green",
            "flower_tulip_black",
        },
    }

end

function unilib.pkg.deco_ethereal_flower_with_strawberry.exec()

    local flower_list = {
        "unilib:flower_dandelion_white",
        "unilib:flower_dandelion_yellow",
        "unilib:flower_geranium_blue",
        "unilib:flower_rose_red",
        "unilib:flower_tulip_orange",
        "unilib:flower_viola_purple",
        "unilib:produce_strawberry_normal_grow_7",
    }

    if unilib.pkg_executed_table["biome_ethereal_forest_deciduous"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration("ethereal_flower_with_strawberry_1", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = flower_list,

            fill_ratio = 0.025,
            sidelen = 80,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_grassy"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration("ethereal_flower_with_strawberry_2", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = flower_list,

            fill_ratio = 0.025,
            sidelen = 80,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_prairie"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_prairie"] ~= nil and
            unilib.pkg_executed_table["flower_chrysanthemum_green"] ~= nil and
            unilib.pkg_executed_table["flower_tulip_black"] ~= nil then

        table.insert(flower_list, "unilib:flower_chrysanthemum_green")
        table.insert(flower_list, "unilib:flower_tulip_black")

        unilib.register_decoration("ethereal_flower_with_strawberry_3", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = flower_list,

            fill_ratio = 0.025,
            sidelen = 80,
        })

    end

end

function unilib.pkg.deco_ethereal_flower_with_strawberry.post()

    if unilib.pkg_executed_table["biome_ethereal_forest_deciduous"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration_now("ethereal_flower_with_strawberry_1", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_forest_deciduous",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_grassy"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration_now("ethereal_flower_with_strawberry_2", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_grassy",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_prairie"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_prairie"] ~= nil and
            unilib.pkg_executed_table["flower_chrysanthemum_green"] ~= nil and
            unilib.pkg_executed_table["flower_tulip_black"] ~= nil then

        unilib.register_decoration_now("ethereal_flower_with_strawberry_3", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_prairie",
            place_on = "unilib:dirt_ordinary_with_turf_prairie",
            y_max = 100,
            y_min = 1,
        })

    end

end
