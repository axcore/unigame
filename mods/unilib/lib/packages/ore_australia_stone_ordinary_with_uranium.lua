---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_australia_stone_ordinary_with_uranium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_australia_stone_ordinary_with_uranium.init()

    return {
        description = "Ordinary stone with uranium as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_uranium"},
        at_least_one = {"biome_australia_arnhem_land", "biome_australia_central_australia"},
    }

end

function unilib.pkg.ore_australia_stone_ordinary_with_uranium.post()

    if unilib.pkg_executed_table["biome_australia_arnhem_land"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_arnhem_land.lua
            ore_type            = "scatter",
            ore                 = "unilib:stone_ordinary_with_uranium",
            wherein             = "unilib:stone_ordinary",

            biomes              = "australia_arnhem_land",
            clust_num_ores      = 4,
            clust_scarcity      = 24 * 24 * 24,
            clust_size          = 3,
            noise_params        = {
                octaves = 3,
                offset = 0,
                persist = 0.7,
                scale = 1,
                seed = 420,
                spread = {x = 100, y = 100, z = 100},
            },
            noise_threshold     = 0.6,
            y_max               = 35,
            y_min               = -64,
        })

    end

    if unilib.pkg_executed_table["biome_australia_central_australia"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_central_australia.lua
            ore_type            = "scatter",
            ore                 = "unilib:stone_ordinary_with_uranium",
            wherein             = "unilib:stone_ordinary",

            biomes              = "australia_central_australia",
            clust_num_ores      = 6,
            clust_scarcity      = 20 * 20 * 20,
            clust_size          = 4,
            noise_params        = {
                octaves = 3,
                offset = 0,
                persist = 0.7,
                scale = 1,
                seed = 421,
                spread = {x = 100, y = 100, z = 100},
            },
            noise_threshold     = 0.6,
            y_max               = 64,
            y_min               = -64,
        })

    end

end
