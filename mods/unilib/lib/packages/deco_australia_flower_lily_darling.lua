---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_flower_lily_darling = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_flower_lily_darling.init()

    return {
        description = "Darling lily as decoration",
        depends = {"biome_australia_murray_darling_basin", "flower_lily_darling"},
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_australia_flower_lily_darling.post()

    unilib.register_decoration_complete("australia_flower_lily_darling", nil, {
        -- From australia:darling_lily
        biomes = "australia_murray_darling_basin",
        place_on = {
            "unilib:dirt_ordinary_with_turf_dry",
            "unilib:dirt_ordinary_with_turf_murray_darling_basin",
        },
        y_max = 200,
        y_min = 36,
    })

end
