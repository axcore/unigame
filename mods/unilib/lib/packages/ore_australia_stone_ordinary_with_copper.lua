---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_australia_stone_ordinary_with_copper = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_australia_stone_ordinary_with_copper.init()

    return {
        description = "Ordinary stone with copper as ore",
        notes = "Additional ores are provided by the \"ore_default_stone_ordinary_with_copper\"" ..
                " package. If you want to emulate the original mod as closely as possible, then" ..
                " both this package and that one should added to your remix",
        depends = {"metal_copper", "stone_ordinary", "stone_ordinary_with_copper"},
        optional = "ore_default_stone_ordinary_with_copper",
        at_least_one = {
            "biome_australia_flinders_lofty",
            "biome_australia_gulf_of_carpentaria",
        },
    }

end

function unilib.pkg.ore_australia_stone_ordinary_with_copper.post()

    if unilib.global.pkg_executed_table["biome_australia_flinders_lofty"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_flinders_lofty.lua
            ore_type            = "blob",
            ore                 = "unilib:stone_ordinary_with_copper",
            wherein             = "unilib:stone_ordinary",

            biomes              = "australia_flinders_lofty",
            clust_scarcity      = 48 * 48 * 48,
            clust_size          = 8,
            noise_params        = {
                octaves = 3,
                offset = 0,
                persist = 0.6,
                scale = 3,
                seed = 892,
                spread = {x = 16, y = 16, z = 16},
            },
            noise_threshold     = 1,
            y_max               = 64,
            y_min               = -64,
        })

    end

    if unilib.global.pkg_executed_table["biome_australia_gulf_of_carpentaria"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_gulf_of_carpentaria.lua
            ore_type            = "blob",
            ore                 = "unilib:stone_ordinary_with_copper",
            wherein             = "unilib:stone_ordinary",

            biomes              = "australia_gulf_of_carpentaria",
            clust_scarcity      = 44 * 44 * 44,
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
            y_max               = 0,
            y_min               = -64,
        })

    end

end
