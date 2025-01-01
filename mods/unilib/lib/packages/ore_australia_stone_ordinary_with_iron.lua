---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_australia_stone_ordinary_with_iron = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_australia_stone_ordinary_with_iron.init()

    return {
        description = "Ordinary stone with iron as ore",
        notes = "Additional ores are provided by the \"ore_default_stone_ordinary_with_iron\"" ..
                " package. If you want to emulate the original mod as closely as possible, then" ..
                " both this package and that one should added to your remix",
        depends = {"biome_australia_pilbara", "stone_ordinary", "stone_ordinary_with_iron"},
        optional = "ore_default_stone_ordinary_with_iron",
    }

end

function unilib.pkg.ore_australia_stone_ordinary_with_iron.post()

    unilib.register_ore({
        -- From australia/biome_pilbara.lua
        ore_type                = "blob",
        -- N.B. Original code uses "air" for the ore, which is almost certainly a mistake
        ore                     = "unilib:stone_ordinary_with_iron",
        wherein                 = "unilib:stone_ordinary",

        biomes                  = "australia_pilbara",
        clust_scarcity          = 24 * 24 * 24,
        clust_size              = 8,
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 3,
            seed = 895,
            spread = {x = 16, y = 16, z = 16},
        },
        noise_threshold         = 1,
        y_max                   = 35,
        y_min                   = -64,
    })

end

