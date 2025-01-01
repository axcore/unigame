---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_gaia_ice_thin = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_gaia_ice_thin.init()

    return {
        description = "Thin ice for the \"gaia\" remix",
        notes = "Thin ice can't be added to the decorations CSV, because they don't support" ..
                " .place_offset_y",
        depends = {"biome_gaia", "ice_thin"},
        at_least_one = {"dirt_permafrost_blue", "dirt_permafrost_ordinary", "sand_silver"},
    }

end

function unilib.pkg.deco_gaia_ice_thin.post()

    -- Higher concentrations of ice close to the shore, lower concentrations a bit further out
    for _, mini_list in ipairs({
        -- fill_ratio, place_offset_y, y_max/y_min
        {1, 1, 0},
        {0.33, 2, -1},
        {0.1, 3, -2},
    }) do

        unilib.register_decoration_simple({
            deco_type = "simple",
            decoration = "unilib:ice_thin",

            biomes = {
                "gaia_cold_semiarid_beach",
                "gaia_cold_semiarid_ocean",
                "gaia_cold_arid_beach",
                "gaia_cold_arid_ocean",
            },
            fill_ratio = mini_list[1],
            place_offset_y = mini_list[2],
            place_on = {
                "unilib:dirt_permafrost_ordinary_with_litter_stone",
                "unilib:dirt_permafrost_blue_with_litter_stone",
                "unilib:sand_silver",
            },
            y_max = mini_list[3],
            y_min = mini_list[3],
        })

    end

end
