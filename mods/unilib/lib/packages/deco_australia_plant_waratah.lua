---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_plant_waratah = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_plant_waratah.init()

    return {
        description = "Waratah as decoration",
        depends = {"biome_australia_eastern_coasts", "plant_waratah"},
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_australia_plant_waratah.post()

    unilib.register_decoration_complete("australia_plant_waratah", nil, {
        -- From australia:waratah
        biomes = "australia_eastern_coasts",
        place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_antipodean_with_turf_eastern_coasts",
        },
        y_max = 35,
        y_min = 6,
    })

end
