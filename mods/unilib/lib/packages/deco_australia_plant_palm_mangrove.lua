---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_plant_palm_mangrove = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_plant_palm_mangrove.init()

    return {
        description = "Mangrove palm as decoration",
        depends = {"biome_australia_mangroves", "plant_palm_mangrove"},
        at_least_one = {"dirt_mud_mangrove", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_australia_plant_palm_mangrove.post()

    unilib.register_decoration_complete("australia_plant_palm_mangrove", nil, {
        -- From australia/biome_mangroves.lua
        biomes = "australia_mangroves",
        place_on = {"unilib:dirt_mud_mangrove", "unilib:dirt_ordinary"},
        y_max = 3,
        y_min = 1,
    })

end
