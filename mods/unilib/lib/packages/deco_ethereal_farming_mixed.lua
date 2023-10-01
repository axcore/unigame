---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_farming_mixed = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_farming_mixed.init()

    return {
        description = "Mixed crops/produce as decoration, sorted by biome",
        notes = "See also the \"deco_ethereal_farming_mixed_dirt\" package",
        depends = "dirt_ordinary",
        at_least_one = {
            {
                "crop_sunflower_giant",
                "produce_beetroot_normal",
                "produce_blackberry",
                "produce_blueberry_highbush",
                "produce_cabbage_normal",
                "produce_carrot_normal",
                "produce_coffee",
                "produce_corn_normal",
                "produce_cucumber_normal",
                "produce_lettuce",
                "produce_parsley_flatleaf",
                "produce_pea",
                "produce_potato_normal",
                "produce_raspberry",
                "produce_rhubarb",
                "produce_tomato_salad",
                "produce_vanilla",
            },
            {
                "biome_ethereal_grassy",
                "biome_ethereal_forest_deciduous",
                "biome_ethereal_jumble",
                "biome_ethereal_prairie",
                "dirt_ordinary_with_turf_prairie",
            },
        },
    }

end

function unilib.pkg.deco_ethereal_farming_mixed.exec()

    -- N.B. Crop/produce lists are slightly different for each biome, so a common list is not used

    if unilib.pkg_executed_table["biome_ethereal_grassy"] ~= nil then

        unilib.register_decoration("ethereal_farming_mixed_1", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = {
                "unilib:crop_sunflower_giant_grow_8",
                "unilib:produce_blackberry_grow_4",
                "unilib:produce_blueberry_highbush_grow_4",
                "unilib:produce_cabbage_normal_grow_6",
                "unilib:produce_carrot_normal_grow_7",
                "unilib:produce_coffee_grow_5",
                "unilib:produce_corn_normal_grow_8",
                "unilib:produce_cucumber_normal_grow_4",
                "unilib:produce_lettuce_grow_5",
                "unilib:produce_potato_normal_grow_3",
                "unilib:produce_raspberry_grow_4",
                "unilib:produce_rhubarb_grow_3",
                "unilib:produce_tomato_salad_grow_7",
                "unilib:produce_vanilla_grow_7",
            },

            fill_ratio = 0.05,
            sidelen = 80,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_forest_deciduous"] ~= nil then

        unilib.register_decoration("ethereal_farming_mixed_2", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = {
                "unilib:crop_sunflower_giant_grow_8",
                "unilib:produce_beetroot_normal_grow_5",
                "unilib:produce_blackberry_grow_4",
                "unilib:produce_blueberry_highbush_grow_4",
                "unilib:produce_carrot_normal_grow_7",
                "unilib:produce_coffee_grow_5",
                "unilib:produce_corn_normal_grow_8",
                "unilib:produce_cucumber_normal_grow_4",
                "unilib:produce_potato_normal_grow_3",
                "unilib:produce_raspberry_grow_4",
                "unilib:produce_rhubarb_grow_3",
                "unilib:produce_tomato_salad_grow_7",
                "unilib:produce_vanilla_grow_7",
            },

            fill_ratio = 0.05,
            sidelen = 80,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_jumble"] ~= nil then

        unilib.register_decoration("ethereal_farming_mixed_3", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = {
                "unilib:produce_blackberry_grow_4",
                "unilib:produce_blueberry_highbush_grow_4",
                "unilib:produce_cabbage_normal_grow_6",
                "unilib:produce_carrot_normal_grow_7",
                "unilib:produce_coffee_grow_5",
                "unilib:produce_corn_normal_grow_8",
                "unilib:produce_cucumber_normal_grow_4",
                "unilib:produce_lettuce_grow_5",
                "unilib:produce_potato_normal_grow_3",
                "unilib:produce_raspberry_grow_4",
                "unilib:produce_rhubarb_grow_3",
                "unilib:produce_tomato_salad_grow_7",
                "unilib:produce_vanilla_grow_7",
            },

            fill_ratio = 0.05,
            sidelen = 80,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_prairie"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_prairie"] ~= nil then

        unilib.register_decoration("ethereal_farming_mixed_4", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = {
                "unilib:crop_sunflower_giant_grow_8",
                "unilib:produce_beetroot_normal_grow_5",
                "unilib:produce_blackberry_grow_4",
                "unilib:produce_blueberry_highbush_grow_4",
                "unilib:produce_carrot_normal_grow_7",
                "unilib:produce_coffee_grow_5",
                "unilib:produce_corn_normal_grow_8",
                "unilib:produce_cucumber_normal_grow_4",
                "unilib:produce_parsley_flatleaf_grow_3",
                "unilib:produce_pea_grow_3",
                "unilib:produce_potato_normal_grow_3",
                "unilib:produce_raspberry_grow_4",
                "unilib:produce_rhubarb_grow_3",
                "unilib:produce_tomato_salad_grow_7",
            },

            fill_ratio = 0.05,
            sidelen = 80,
        })

    end

end

function unilib.pkg.deco_ethereal_farming_mixed.post()

    if unilib.pkg_executed_table["biome_ethereal_grassy"] ~= nil then

        unilib.register_decoration_now("ethereal_farming_mixed_1", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_grassy",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_forest_deciduous"] ~= nil then

        unilib.register_decoration_now("ethereal_farming_mixed_2", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_forest_deciduous",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_jumble"] ~= nil then

        unilib.register_decoration_now("ethereal_farming_mixed_3", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_jumble",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_prairie"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_prairie"] ~= nil then

        unilib.register_decoration_now("ethereal_farming_mixed_4", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_prairie",
            place_on = "unilib:dirt_ordinary_with_turf_prairie",
            y_max = 100,
            y_min = 1,
        })

    end

end
