---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_fern_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

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

function unilib.pkg.deco_ethereal_fern_ordinary.exec()

    unilib.register_decoration_generic("ethereal_fern_ordinary", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = {"unilib:fern_ordinary_1", "unilib:fern_ordinary_2", "unilib:fern_ordinary_3"},

        fill_ratio = 0.2,
        sidelen = 16,
    })

end

function unilib.pkg.deco_ethereal_fern_ordinary.post()

    unilib.register_decoration_complete("ethereal_fern_ordinary", nil, {
        -- From ethereal-ng/decor.lua
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_turf_cold",
        },
        y_max = 100,
        y_min = 3,
    })

end
