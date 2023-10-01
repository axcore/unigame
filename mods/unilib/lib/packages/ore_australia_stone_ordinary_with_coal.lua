---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_australia_stone_ordinary_with_coal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_australia_stone_ordinary_with_coal.init()

    return {
        description = "Ordinary stone with coal as ore",
        notes = "Additional ores are provided by the \"ore_default_stone_ordinary_with_coal\"" ..
                " package. If you want to emulate the original mod as closely as possible, then" ..
                " both this package and that one should added to your remix",
        depends = {"stone_ordinary", "stone_ordinary_with_coal"},
        optional = "ore_default_stone_ordinary_with_coal",
        at_least_one = {
            "biome_australia_eastern_coasts",
            "biome_australia_great_dividing_range",
            "biome_australia_victorian_forests",
        },
    }

end

function unilib.pkg.ore_australia_stone_ordinary_with_coal.post()

    if unilib.pkg_executed_table["biome_australia_eastern_coasts"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_eastern_coasts.lua
            ore_type            = "scatter",
            ore                 = "unilib:stone_ordinary_with_coal",
            wherein             = "unilib:stone_ordinary",

            biomes              = "australia_eastern_coasts",
            clust_num_ores      = 24,
            clust_scarcity      = 24 * 24 * 24,
            clust_size          = 5,
            y_max               = 35,
            y_min               = -64,
        })

    end

    if unilib.pkg_executed_table["biome_australia_great_dividing_range"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_great_dividing_range.lua
            ore_type            = "scatter",
            ore                 = "unilib:stone_ordinary_with_coal",
            wherein             = "unilib:stone_ordinary",

            biomes              = "australia_great_dividing_range",
            clust_num_ores      = 24,
            clust_scarcity      = 24 * 24 * 24,
            clust_size          = 5,
            y_max               = 64,
            y_min               = -64,
        })

    end

    if unilib.pkg_executed_table["biome_australia_victorian_forests"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_victorian_forests.lua
            ore_type            = "scatter",
            ore                 = "unilib:stone_ordinary_with_coal",
            wherein             = "unilib:stone_ordinary",

            biomes              = "australia_victorian_forests",
            clust_num_ores      = 24,
            clust_scarcity      = 24 * 24 * 24,
            clust_size          = 5,
            y_max               = 64,
            y_min               = -64,
        })

    end

end
