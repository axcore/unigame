---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_plant_saltbush = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_plant_saltbush.init()

    return {
        description = "Saltbush as decoration",
        depends = {"biome_australia_murray_darling_basin", "dirt_ordinary", "plant_saltbush"},
    }

end

function unilib.pkg.deco_australia_plant_saltbush.exec()

    unilib.register_decoration_now("australia_plant_saltbush", nil, {
        -- From australia:saltbush
        biomes = "australia_murray_darling_basin",
        place_on = "unilib:dirt_ordinary_with_turf_dry",
        y_max = 200,
        y_min = 36,
    })

end
