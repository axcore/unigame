---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_coral_mixed = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_coral_mixed.init()

    return {
        description = "Mixed coral as decoration",
        depends = {"biome_ethereal_desert", "sand_ordinary"},
        at_least_one = {
            {
                "coral_block_brown",
                "coral_block_orange",
                "coral_block_skeleton",
                "coral_rooted_cyan",
                "coral_rooted_green",
                "coral_rooted_pink",
            },
            {
                "biome_ethereal_grove",
                "biome_ethereal_rainforest",
                "biome_ethereal_savanna",
            },
        },
    }

end

function unilib.pkg.deco_ethereal_coral_mixed.exec()


    if unilib.pkg_executed_table["biome_ethereal_rainforest"] ~= nil or
            unilib.pkg_executed_table["biome_ethereal_savanna"] ~= nil then
        unilib.register_mixed_coral_as_decoration("ethereal_coral_mixed_1")
    end

    if unilib.pkg_executed_table["biome_ethereal_grove"] ~= nil then

        unilib.register_decoration("ethereal_coral_mixed_2", {
            -- From ethereal-ng/schems.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_coral_mixed.mts",

            flags = "place_center_x, place_center_z",
            noise_params = {
                octaves = 3,
                offset = -0.15,
                persist = 1,
                scale = 0.1,
                seed = 7013,
                spread = {x = 100, y = 100, z = 100},
            },
            rotation = "random",
        })

    end

end

function unilib.pkg.deco_ethereal_coral_mixed.post()

    if unilib.pkg_executed_table["biome_ethereal_rainforest"] ~= nil or
            unilib.pkg_executed_table["biome_ethereal_savanna"] ~= nil then

        unilib.register_decoration_now("ethereal_coral_mixed_1", nil, {
            -- From ethereal-ng/decor.lua
            biomes = {
                "ethereal_desert_ocean",
                "ethereal_rainforest_ocean",
                "ethereal_savanna_ocean",
            },
            place_on = "unilib:sand_ordinary",
            y_max = -2,
            y_min = -8,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_grove"] ~= nil then

        unilib.register_decoration_now("ethereal_coral_mixed_2", nil, {
            -- From ethereal-ng/schems.lua
            biomes = {"ethereal_desert_ocean", "ethereal_grove_ocean"},
            place_on = {"unilib:sand_ordinary"},
            y_max = -2,
            y_min = -8,
        })

    end

end
