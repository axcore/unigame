---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_australia_stone_ordinary_with_diamond = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_australia_stone_ordinary_with_diamond.init()

    return {
        description = "Ordinary stone with diamond as ore",
        notes = "Additional ores are provided by the" ..
                "\"ore_default_stone_ordinary_with_diamond\" package. If you want to emulate the" ..
                " original mod as closely as possible, then both this package and that one" ..
                " should added to your remix",
        depends = {"biome_australia_kimberley", "stone_ordinary", "stone_ordinary_with_diamond"},
        optional = "ore_default_stone_ordinary_with_diamond",
    }

end

function unilib.pkg.ore_australia_stone_ordinary_with_diamond.post()

    unilib.register_ore({
            -- From australia/biome_kimberley.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_diamond",
        wherein                 = "unilib:stone_ordinary",

        biomes                  = "australia_kimberley",
        clust_num_ores          = 12,
        clust_scarcity          = 40 * 40 * 40,
        clust_size              = 4,
        y_max                   = 35,
        y_min                   = -64,
    })

end
