---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_farming_mixed_dirt = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_farming_mixed_dirt.init()

    return {
        description = "Mixed crops/produce as decoration, sorted by dirt",
        notes = "See also the \"deco_ethereal_farming_mixed\" package",
        at_least_one = {
            {
                "crop_hemp",
                "produce_artichoke",
                "produce_chilli_normal",
                "produce_garlic_normal",
                "produce_onion_normal",
                "produce_pepper",
                "produce_pineapple",
                "produce_soy_normal",
            },
            {
                "dirt_ordinary",
                "dirt_ordinary_with_turf_grove",
                "dirt_ordinary_with_turf_prairie",
            },
        },
    }

end

function unilib.pkg.deco_ethereal_farming_mixed_dirt.exec()

    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil or
            unilib.pkg_executed_table["dirt_ordinary_with_turf_prairie"] ~= nil then

        unilib.register_decoration("ethereal_farming_mixed_dirt_1", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = {
                "unilib:crop_hemp_grow_7",
                "unilib:produce_chilli_normal_grow_8",
                "unilib:produce_garlic_normal_grow_5",
                "unilib:produce_onion_normal_grow_5",
                "unilib:produce_pepper_grow_5",
                "unilib:produce_pepper_grow_6",
                "unilib:produce_pepper_grow_7",
                "unilib:produce_soy_normal_grow_5",
            },

            noise_params = {
                octaves = 3,
                offset = 0,
                persist = 0.6,
                scale = 0.09,
                seed = 760,
                spread = {x = 100, y = 100, z = 100},
            },
            sidelen = 16,
        })

    end

    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration("ethereal_farming_mixed_dirt_2", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = {
                "unilib:produce_pineapple_grow_8",
                "unilib:produce_soy_normal_grow_5",
            },

            noise_params = {
                octaves = 3,
                offset = 0,
                persist = 0.6,
                scale = 0.06,
                seed = 917,
                spread = {x = 100, y = 100, z = 100},
            },
            sidelen = 16,
        })

    end

    if unilib.pkg_executed_table["dirt_ordinary_with_turf_grove"] ~= nil then

        unilib.register_decoration("ethereal_farming_mixed_dirt_3", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = {
                "unilib:produce_artichoke_grow_5",
            },

            noise_params = {
                octaves = 3,
                offset = 0,
                persist = 0.6,
                scale = 0.06,
                seed = 448,
                spread = {x = 100, y = 100, z = 100},
            },
            sidelen = 16,
        })

    end

end

function unilib.pkg.deco_ethereal_farming_mixed_dirt.post()

    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil or
            unilib.pkg_executed_table["dirt_ordinary_with_turf_prairie"] ~= nil then

        unilib.register_decoration_now("ethereal_farming_mixed_dirt_1", nil, {
            -- From ethereal-ng/decor.lua
            num_spawn_by = 1,
            place_on = {
                "unilib:dirt_ordinary_with_litter_rainforest",
                "unilib:dirt_ordinary_with_turf",
                "unilib:dirt_ordinary_with_turf_prairie",
            },
            spawn_by = "group:tree",
            y_max = 35,
            y_min = 5,
        })

    end

    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration_now("ethereal_farming_mixed_dirt_2", nil, {
            -- From ethereal-ng/decor.lua
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 30,
            y_min = 18,
        })

    end

    if unilib.pkg_executed_table["dirt_ordinary_with_turf_grove"] ~= nil then

        unilib.register_decoration_now("ethereal_farming_mixed_dirt_3", nil, {
            -- From ethereal-ng/decor.lua
            num_spawn_by = 1,
            place_on = "unilib:dirt_ordinary_with_turf_grove",
            spawn_by = "group:tree",
            y_max = 40,
            y_min = 15,
        })

    end

end

