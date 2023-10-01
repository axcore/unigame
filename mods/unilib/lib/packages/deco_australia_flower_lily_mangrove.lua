---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_flower_lily_mangrove = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_flower_lily_mangrove.init()

    return {
        description = "Mangrove lily as decoration",
        depends = {"biome_australia_mangroves", "flower_lily_mangrove"},
        at_least_one = {"dirt_mud_mangrove", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_australia_flower_lily_mangrove.exec()

    unilib.register_decoration_now("australia_flower_lily_mangrove", nil, {
        -- From australia:mangrove_lily
        biomes = "australia_mangroves",
        place_on = {
            "unilib:dirt_mud_mangrove",
            "unilib:dirt_ordinary",
            "unilib:dirt_ordinary_with_turf",
        },
        y_max = 3,
        y_min = 2,
    })

end
