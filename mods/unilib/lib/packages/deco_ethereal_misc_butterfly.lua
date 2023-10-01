---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_misc_butterfly = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_misc_butterfly.init()

    return {
        description = "Butterflies as decoration",
        depends = "misc_butterfly",
        at_least_one = {
            {
                "biome_ethereal_forest_deciduous",
                "biome_ethereal_grassy",
                "biome_ethereal_jumble",
                "biome_ethereal_prairie",
            },
            {"dirt_ordinary", "dirt_ordinary_with_turf_prairie"},
        },
    }

end

function unilib.pkg.deco_ethereal_misc_butterfly.exec()

    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil or
            unilib.pkg_executed_table["dirt_ordinary_with_turf_prairie"] ~= nil then

        unilib.register_decoration("ethereal_misc_butterfly", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = {
                "unilib:misc_butterfly_red",
                "unilib:misc_butterfly_violet",
                "unilib:misc_butterfly_white",
            },

            fill_ratio = 0.005,
            place_offset_y = 2,
            sidelen = 80,
        })

    end

end

function unilib.pkg.deco_ethereal_misc_butterfly.post()

    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil or
            unilib.pkg_executed_table["dirt_ordinary_with_turf_prairie"] ~= nil then

        unilib.register_decoration_now("ethereal_misc_butterfly", nil, {
            -- From ethereal-ng/decor.lua
            biomes = {
                "ethereal_forest_deciduous",
                "ethereal_grassy",
                "ethereal_jumble",
                "ethereal_prairie",
            },
            num_spawn_by = 1,
            place_on = {
                "unilib:dirt_ordinary_with_turf",
                "unilib:dirt_ordinary_with_turf_prairie",
            },
            spawn_by = "group:flower",
            y_max = unilib.y_max,
            y_min = 1,
        })

    end

end
