---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_grass_dry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_deco(biome, place_on, y_max, y_min, offset, scale, length)

    minetest.register_decoration({
        deco_type = "simple",
        decoration = "unilib:grass_dry_" .. tostring(length),

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

function unilib.pkg.deco_australia_grass_dry.init()

    return {
        description = "Dry grass as decoration",
        depends = "grass_dry",
        optional = {
            "biome_australia_central_australia",
            "biome_australia_far_north_queensland",
            "biome_australia_flinders_lofty",
            "biome_australia_goldfields_esperance",
            "biome_australia_gulf_of_carpentaria",
            "biome_australia_indian_ocean",
            "biome_australia_jarrah_karri_forests",
            "biome_australia_kimberley",
            "biome_australia_mulga_lands",
            "biome_australia_murray_darling_basin",
            "biome_australia_pilbara",
            "biome_australia_tasman_sea",
            "dirt_ordinary",
            "dirt_red_antipodean",
            "gravel_red_antipodean",
            "sand_desert",
            "sand_ordinary",
        },
    }

end

function unilib.pkg.deco_australia_grass_dry.exec()

    if unilib.pkg_executed_table["biome_australia_central_australia"] ~= nil and
            unilib.pkg_executed_table["dirt_red_antipodean"] ~= nil then

        local biome = "australia_central_australia"
        local place_on = "unilib:dirt_red_antipodean"
        local y_max = 190
        local y_min = 36

        register_deco(biome, place_on, y_max, y_min, 0.05, 0.01, 3)
        register_deco(biome, place_on, y_max, y_min, 0.07, -0.01, 2)
        register_deco(biome, place_on, y_max, y_min, 0.09, -0.03, 1)

    end

    if unilib.pkg_executed_table["biome_australia_far_north_queensland"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        local biome = "australia_far_north_queensland"
        local place_on = "unilib:dirt_ordinary_with_turf"
        local y_max = 35
        local y_min = 22

        register_deco(biome, place_on, y_max, y_min, 0.01, 0.05, 5)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 4)

    end

    if unilib.pkg_executed_table["biome_australia_flinders_lofty"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        local biome = "australia_flinders_lofty"
        local place_on = "unilib:dirt_ordinary_with_turf_dry"
        local y_max = 200
        local y_min = 36

        register_deco(biome, place_on, y_max, y_min, 0.01, 0.05, 5)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 4)
        register_deco(biome, place_on, y_max, y_min, 0.05, 0.01, 3)
        register_deco(biome, place_on, y_max, y_min, 0.07, -0.01, 2)
        register_deco(biome, place_on, y_max, y_min, 0.09, -0.03, 1)

    end

    if unilib.pkg_executed_table["biome_australia_goldfields_esperance"] ~= nil and
            unilib.pkg_executed_table["sand_desert"] ~= nil then

        local biome = "australia_goldfields_esperance"
        local place_on = "unilib:sand_desert"
        local y_max = 35
        local y_min = 5

        register_deco(biome, place_on, y_max, y_min, 0.01, 0.05, 5)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 4)
        register_deco(biome, place_on, y_max, y_min, 0.05, 0.01, 3)
        register_deco(biome, place_on, y_max, y_min, 0.07, -0.01, 2)
        register_deco(biome, place_on, y_max, y_min, 0.09, -0.03, 1)

    end

    if unilib.pkg_executed_table["biome_australia_gulf_of_carpentaria"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        local biome = "australia_gulf_of_carpentaria"
        local place_on = "unilib:dirt_ordinary_with_turf_dry"
        local y_max = 35
        local y_min = 7

        register_deco(biome, place_on, y_max, y_min, 0.01, 0.05, 5)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 4)
        register_deco(biome, place_on, y_max, y_min, 0.05, 0.01, 3)
        register_deco(biome, place_on, y_max, y_min, 0.07, -0.01, 2)
        register_deco(biome, place_on, y_max, y_min, 0.09, -0.03, 1)

    end

    if unilib.pkg_executed_table["biome_australia_indian_ocean"] ~= nil and
            unilib.pkg_executed_table["sand_ordinary"] ~= nil then

        local biome = "australia_indian_ocean"
        local place_on = "unilib:sand_ordinary"
        local y_max = 3
        local y_min = 3

        register_deco(biome, place_on, y_max, y_min, 0.01, 0.05, 5)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 4)
        register_deco(biome, place_on, y_max, y_min, 0.05, 0.01, 3)

    end

    if unilib.pkg_executed_table["biome_australia_jarrah_karri_forests"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        local biome = "australia_jarrah_karri_forests"
        local place_on = "unilib:dirt_ordinary_with_turf"
        local y_max = unilib.y_max
        local y_min = 5

        register_deco(biome, place_on, y_max, y_min, 0.01, 0.05, 5)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 4)
        register_deco(biome, place_on, y_max, y_min, 0.05, 0.01, 3)
        register_deco(biome, place_on, y_max, y_min, 0.07, -0.01, 2)
        register_deco(biome, place_on, y_max, y_min, 0.09, -0.03, 1)

    end

    if unilib.pkg_executed_table["biome_australia_kimberley"] ~= nil and
            unilib.pkg_executed_table["dirt_red_antipodean"] ~= nil then

        local biome = "australia_kimberley"
        local place_on = "unilib:dirt_red_antipodean"
        local y_max = 35
        local y_min = 7

        register_deco(biome, place_on, y_max, y_min, 0.01, 0.05, 5)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 4)
        register_deco(biome, place_on, y_max, y_min, 0.05, 0.01, 3)
        register_deco(biome, place_on, y_max, y_min, 0.07, -0.01, 2)
        register_deco(biome, place_on, y_max, y_min, 0.09, -0.03, 1)

    end

    if unilib.pkg_executed_table["biome_australia_mulga_lands"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        local biome = "australia_mulga_lands"
        local place_on = "unilib:dirt_ordinary_with_turf_dry"
        local y_max = 190
        local y_min = 36

        register_deco(biome, place_on, y_max, y_min, 0.01, 0.05, 5)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 4)
        register_deco(biome, place_on, y_max, y_min, 0.05, 0.01, 3)
        register_deco(biome, place_on, y_max, y_min, 0.07, -0.01, 2)
        register_deco(biome, place_on, y_max, y_min, 0.09, -0.03, 1)

    end

    if unilib.pkg_executed_table["biome_australia_murray_darling_basin"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        local biome = "australia_murray_darling_basin"
        local place_on = "unilib:dirt_ordinary_with_turf_dry"
        local y_max = 200
        local y_min = 36

        register_deco(biome, place_on, y_max, y_min, 0.01, 0.05, 5)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 4)
        register_deco(biome, place_on, y_max, y_min, 0.05, 0.01, 3)
        register_deco(biome, place_on, y_max, y_min, 0.07, -0.01, 2)
        register_deco(biome, place_on, y_max, y_min, 0.09, -0.03, 1)

    end

    if unilib.pkg_executed_table["biome_australia_pilbara"] ~= nil and
            unilib.pkg_executed_table["gravel_red_antipodean"] ~= nil then

        local biome = "australia_pilbara"
        local place_on = "unilib:gravel_red_antipodean"
        local y_max = unilib.y_max
        local y_min = 5

        register_deco(biome, place_on, y_max, y_min, 0.07, -0.01, 2)
        register_deco(biome, place_on, y_max, y_min, 0.09, -0.03, 1)

    end

    if unilib.pkg_executed_table["biome_australia_tasman_sea"] ~= nil and
            unilib.pkg_executed_table["sand_ordinary"] ~= nil then

        local biome = "australia_tasman_sea"
        local place_on = "unilib:sand_ordinary"
        local y_max = 3
        local y_min = 3

        register_deco(biome, place_on, y_max, y_min, 0.01, 0.05, 5)
        register_deco(biome, place_on, y_max, y_min, 0.03, 0.03, 4)
        register_deco(biome, place_on, y_max, y_min, 0.05, 0.01, 3)

    end

end
