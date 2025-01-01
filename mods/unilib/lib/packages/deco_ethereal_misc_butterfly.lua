---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_misc_butterfly = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

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
            {
                "dirt_ordinary",
                "dirt_ordinary_with_turf_prairie",
            },
        },
    }

end

function unilib.pkg.deco_ethereal_misc_butterfly.exec()

    unilib.register_decoration_generic("ethereal_misc_butterfly", {
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

function unilib.pkg.deco_ethereal_misc_butterfly.post()

    unilib.register_decoration_complete("ethereal_misc_butterfly", nil, {
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
        y_max = 200,
        y_min = 1,
    })

    -- Set up the nodetimers
    core.register_on_mods_loaded(function()
        unilib.pkg.misc_butterfly.setup_node_timers("unilib:ethereal_misc_butterfly")
    end)

end
