---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_australia_mineral_coal_block = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_australia_mineral_coal_block.init()

    return {
        description = "Coal block as ore",
        depends = {"mineral_coal", "stone_ordinary"},
        at_least_one = {
            "biome_australia_eastern_coasts",
            "biome_australia_great_dividing_range",
            "biome_australia_victorian_forests",
        },
    }

end

function unilib.pkg.ore_australia_mineral_coal_block.post()

    if unilib.global.pkg_executed_table["biome_australia_eastern_coasts"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_eastern_coasts.lua
            ore_type            = "scatter",
            ore                 = "unilib:mineral_coal_block",
            wherein             = "unilib:stone_ordinary",

            biomes              = "australia_eastern_coasts",
            clust_num_ores      = 8,
            clust_scarcity      = 48 * 48 * 48,
            clust_size          = 3,
            y_max               = 35,
            y_min               = -64,
        })

    end

    if unilib.global.pkg_executed_table["biome_australia_great_dividing_range"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_great_dividing_range.lua
            ore_type            = "scatter",
            ore                 = "unilib:mineral_coal_block",
            wherein             = "unilib:stone_ordinary",

            biomes              = "australia_great_dividing_range",
            clust_num_ores      = 8,
            clust_scarcity      = 48 * 48 * 48,
            clust_size          = 3,
            y_max               = 64,
            y_min               = -64,
        })

    end

    if unilib.global.pkg_executed_table["biome_australia_victorian_forests"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_victorian_forests.lua
            ore_type            = "scatter",
            ore                 = "unilib:mineral_coal_block",
            wherein             = "unilib:stone_ordinary",

            biomes              = "australia_victorian_forests",
            clust_num_ores      = 8,
            clust_scarcity      = 48 * 48 * 48,
            clust_size          = 3,
            y_max               = 64,
            y_min               = -64,
        })

    end

end
