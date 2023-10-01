---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_australia_stone_ordinary_with_gold = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_australia_stone_ordinary_with_gold.init()

    return {
        description = "Ordinary stone with gold as ore",
        notes = "Additional ores are provided by the \"ore_default_stone_ordinary_with_gold\"" ..
                " package. If you want to emulate the original mod as closely as possible, then" ..
                " both this package and that one should added to your remix",
        depends = {"stone_ordinary", "stone_ordinary_with_gold"},
        optional = "ore_default_stone_ordinary_with_gold",
        at_least_one = {
            "biome_australia_goldfields_esperance",
            "biome_australia_victorian_forests",
        },
    }

end

function unilib.pkg.ore_australia_stone_ordinary_with_gold.post()

    if unilib.pkg_executed_table["biome_australia_goldfields_esperance"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_goldfields_esperence.lua
            ore_type            = "blob",
            ore                 = "unilib:stone_ordinary_with_gold",
            wherein             = "unilib:stone_ordinary",

            biomes              = "australia_goldfields_esperance",
            clust_scarcity      = 36 * 36 * 36,
            clust_size          = 8,
            noise_params        = {
                octaves = 3,
                offset = 0,
                persist = 0.6,
                scale = 3,
                seed = 891,
                spread = {x = 16, y = 16, z = 16},
            },
            noise_threshold     = 0.8,
            y_max               = 0,
            y_min               = -64,
        })

    end

    if unilib.pkg_executed_table["biome_australia_victorian_forests"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_victorian_forests.lua
            ore_type            = "blob",
            ore                 = "unilib:stone_ordinary_with_gold",
            wherein             = "unilib:stone_ordinary",

            biomes              = "australia_victorian_forests",
            clust_scarcity      = 50 * 50 * 50,
            clust_size          = 8,
            noise_params        = {
                octaves = 3,
                offset = 0,
                persist = 0.6,
                scale = 3,
                seed = 890,
                spread = {x = 16, y = 16, z = 16},
            },
            noise_threshold     = 1,
            y_max               = 64,
            y_min               = -64,
        })

    end

end
