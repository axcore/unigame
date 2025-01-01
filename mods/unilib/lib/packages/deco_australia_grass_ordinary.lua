---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_grass_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_deco(biome, place_on, y_max, y_min, offset, scale, length)

    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = "unilib:grass_ordinary_" .. tostring(length),

        biomes = biome,
        noise_params = {
            octaves = 3,
            offset = offset,
            persist = 0.6,
            scale = scale,
            seed = 329,
            spread = {x = 200, y = 200, z = 200},
        },
        place_on = place_on,
        sidelen = 16,
        y_max = y_max,
        y_min = y_min,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_grass_ordinary.init()

    return {
        description = "Ordinary grass as decoration",
        depends = "grass_ordinary",
        optional = {
            "biome_australia_arnhem_land",
            "biome_australia_eastern_coasts",
            "biome_australia_far_north_queensland",
            "biome_australia_flinders_lofty",
            "biome_australia_great_dividing_range",
            "biome_australia_gulf_of_carpentaria",
            "biome_australia_indian_ocean",
            "biome_australia_jarrah_karri_forests",
            "biome_australia_kimberley",
            "biome_australia_murray_darling_basin",
            "biome_australia_tasmania",
            "biome_australia_tasman_sea",
            "biome_australia_timor_sea",
            "biome_australia_victorian_forests",
            "dirt_custom_antipodean",
            "dirt_ordinary",
            "dirt_red_antipodean",
            "sand_ordinary",
        },
    }

end

function unilib.pkg.deco_australia_grass_ordinary.post()

    if unilib.global.pkg_executed_table["biome_australia_arnhem_land"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        local biome = "australia_arnhem_land"
        local place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_antipodean_with_turf_arnhem_land",
        }
        local y_max = 35
        local y_min = 4

        register_deco(biome, place_on, y_max, y_min, -0.03, 0.09, 5)
        register_deco(biome, place_on, y_max, y_min, -0.015, 0.075, 4)
        register_deco(biome, place_on, y_max, y_min, 0, 0.06, 3)
        register_deco(biome, place_on, y_max, y_min, 0.015, 0.045, 2)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 1)

    end

    if unilib.global.pkg_executed_table["biome_australia_eastern_coasts"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        local biome = "australia_eastern_coasts"
        local place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_antipodean_with_turf_eastern_coasts",
        }
        local y_max = 35
        local y_min = 4

        register_deco(biome, place_on, y_max, y_min, -0.03, 0.09, 5)
        register_deco(biome, place_on, y_max, y_min, -0.015, 0.075, 4)
        register_deco(biome, place_on, y_max, y_min, 0, 0.06, 3)
        register_deco(biome, place_on, y_max, y_min, 0.015, 0.045, 2)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 1)

    end

    if unilib.global.pkg_executed_table["biome_australia_far_north_queensland"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        local biome = "australia_far_north_queensland"
        local place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_antipodean_with_turf_far_north_queensland",
        }
        local y_max = 35
        local y_min = 22

        register_deco(biome, place_on, y_max, y_min, -0.03, 0.09, 5)
        register_deco(biome, place_on, y_max, y_min, -0.015, 0.075, 4)
        register_deco(biome, place_on, y_max, y_min, 0, 0.06, 3)
        register_deco(biome, place_on, y_max, y_min, 0.015, 0.045, 2)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 1)

    end

    if unilib.global.pkg_executed_table["biome_australia_flinders_lofty"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        local biome = "australia_flinders_lofty"
        local place_on = {
            "unilib:dirt_ordinary_with_turf_dry",
            "unilib:dirt_ordinary_with_turf_flinders_lofty",
        }
        local y_max = 200
        local y_min = 36

        register_deco(biome, place_on, y_max, y_min, 0.015, 0.045, 2)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 1)

    end

    if unilib.global.pkg_executed_table["biome_australia_great_dividing_range"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        local biome = "australia_great_dividing_range"
        local place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_antipodean_with_turf_great_dividing_range",
        }
        local y_max = unilib.constant.y_max
        local y_min = 36

        register_deco(biome, place_on, y_max, y_min, -0.03, 0.09, 5)
        register_deco(biome, place_on, y_max, y_min, -0.015, 0.075, 4)
        register_deco(biome, place_on, y_max, y_min, 0, 0.06, 3)
        register_deco(biome, place_on, y_max, y_min, 0.015, 0.045, 2)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 1)

    end

    if unilib.global.pkg_executed_table["biome_australia_gulf_of_carpentaria"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        local biome = "australia_gulf_of_carpentaria"
        local place_on = {
            "unilib:dirt_ordinary_with_turf_dry",
            "unilib:dirt_ordinary_with_turf_gulf_of_carpentaria",
        }
        local y_max = 9
        local y_min = 4

        register_deco(biome, place_on, y_max, y_min, 0, 0.06, 3)
        register_deco(biome, place_on, y_max, y_min, 0.015, 0.045, 2)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 1)

    end

    if unilib.global.pkg_executed_table["biome_australia_indian_ocean"] ~= nil and
            unilib.global.pkg_executed_table["sand_ordinary"] ~= nil then

        local biome = "australia_indian_ocean"
        local place_on = "unilib:sand_ordinary"
        local y_max = 3
        local y_min = 3

        register_deco(biome, place_on, y_max, y_min, 0.015, 0.045, 2)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 1)

    end

    if unilib.global.pkg_executed_table["biome_australia_jarrah_karri_forests"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        local biome = "australia_jarrah_karri_forests"
        local place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_antipodean_dark_with_turf_jarrah_karri_forests",
        }
        local y_max = unilib.constant.y_max
        local y_min = 5

        register_deco(biome, place_on, y_max, y_min, 0.015, 0.045, 2)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 1)

    end

    if unilib.global.pkg_executed_table["biome_australia_kimberley"] ~= nil and
            unilib.global.pkg_executed_table["dirt_red_antipodean"] ~= nil then

        local biome = "australia_kimberley"
        local place_on = "unilib:dirt_red_antipodean"
        local y_max = 30
        local y_min = 4

        register_deco(biome, place_on, y_max, y_min, 0.015, 0.045, 2)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 1)

    end

    if unilib.global.pkg_executed_table["biome_australia_murray_darling_basin"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        local biome = "australia_murray_darling_basin"
        local place_on = {
            "unilib:dirt_ordinary_with_turf_dry",
            "unilib:dirt_ordinary_with_turf_murray_darling_basin",
        }
        local y_max = 200
        local y_min = 36

        register_deco(biome, place_on, y_max, y_min, 0.015, 0.045, 2)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 1)

    end

    if unilib.global.pkg_executed_table["biome_australia_tasmania"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        local biome = "australia_tasmania"
        local place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_antipodean_dark_with_turf_tasmania",
        }
        local y_max = unilib.constant.y_max
        local y_min = 3

        register_deco(biome, place_on, y_max, y_min, -0.03, 0.09, 5)
        register_deco(biome, place_on, y_max, y_min, -0.015, 0.075, 4)
        register_deco(biome, place_on, y_max, y_min, 0, 0.06, 3)
        register_deco(biome, place_on, y_max, y_min, 0.015, 0.045, 2)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 1)

    end

    if unilib.global.pkg_executed_table["biome_australia_tasman_sea"] ~= nil and
            unilib.global.pkg_executed_table["sand_ordinary"] ~= nil then

        local biome = "australia_tasman_sea"
        local place_on = "unilib:sand_ordinary"
        local y_max = 3
        local y_min = 3

        register_deco(biome, place_on, y_max, y_min, 0.015,  0.045, 2)
        register_deco(biome, place_on, y_max, y_min, 0.03,   0.03,  1)

    end

    if unilib.global.pkg_executed_table["biome_australia_timor_sea"] ~= nil and
            unilib.global.pkg_executed_table["sand_ordinary"] ~= nil then

        local biome = "australia_timor_sea"
        local place_on = "unilib:sand_ordinary"
        local y_max = 3
        local y_min = 3

        register_deco(biome, place_on, y_max, y_min, -0.03, 0.09, 5)
        register_deco(biome, place_on, y_max, y_min, -0.015, 0.075, 4)
        register_deco(biome, place_on, y_max, y_min, 0, 0.06, 3)
        register_deco(biome, place_on, y_max, y_min, 0.015, 0.045, 2)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 1)

    end

    if unilib.global.pkg_executed_table["biome_australia_victorian_forests"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        local biome = "australia_victorian_forests"
        local place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_antipodean_dark_with_turf_victorian_forests",
        }
        local y_max = 190
        local y_min = 36

        register_deco(biome, place_on, y_max, y_min, -0.03, 0.09, 5)
        register_deco(biome, place_on, y_max, y_min, -0.015, 0.075, 4)
        register_deco(biome, place_on, y_max, y_min, 0, 0.06, 3)
        register_deco(biome, place_on, y_max, y_min, 0.015, 0.045, 2)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 1)

    end

end
