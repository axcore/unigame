---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_plant_waratah = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_plant_waratah.init()

    return {
        description = "Waratah as decoration",
        depends = {"biome_australia_eastern_coasts", "dirt_ordinary", "plant_waratah"},
    }

end

function unilib.pkg.deco_australia_plant_waratah.exec()

    unilib.register_decoration_now("australia_plant_waratah", nil, {
        -- From australia:waratah
        biomes = "australia_eastern_coasts",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 35,
        y_min = 6,
    })

end
