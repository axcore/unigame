---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_fern_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_fern_ordinary.init()

    return {
        description = "Ordinary fern as decoration",
        depends = "fern_ordinary",
        at_least_one = {"dirt_ordinary", "dirt_ordinary_with_turf_cold"},
    }

end

function unilib.pkg.deco_ethereal_fern_ordinary.post()

    for i = 1, 3 do

        unilib.register_decoration_now(
            -- From ethereal-ng/decor.lua
            -- Completes decoration in package "fern_ordinary"
            "default_fern_ordinary_" .. tostring(i),
            "ethereal_fern_ordinary_" .. tostring(i),
            {
                place_on = {
                    "unilib:dirt_ordinary_with_litter_coniferous",
                    "unilib:dirt_ordinary_with_turf_cold",
                },
                y_max = unilib.y_max,
                y_min = 6,
            }
        )

    end

end
