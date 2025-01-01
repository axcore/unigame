---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_australia_stone_ordinary_with_kelp = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_australia_stone_ordinary_with_kelp.init()

    return {
        description = "Ordinary stone with kelp as ore",
        depends = "stone_ordinary_with_kelp",
        at_least_one = {
            "biome_australia_great_australian_bight",
            "biome_australia_indian_ocean",
            "biome_australia_tasman_sea",
            "sand_ordinary",
            "stone_sandstone_ordinary",
        },
    }

end

function unilib.pkg.ore_australia_stone_ordinary_with_kelp.post()

    if unilib.global.pkg_executed_table["biome_australia_great_australian_bight"] ~= nil and
            unilib.global.pkg_executed_table["stone_sandstone_ordinary"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_great_australian_bight.lua
            ore_type            = "scatter",
            ore                 = "unilib:stone_ordinary_with_kelp_spiny",
            wherein             = "unilib:stone_sandstone_ordinary",

            biomes              = "australia_great_australian_bight",
            clust_num_ores      = 25,
            clust_scarcity      = 9 * 9 * 9,
            clust_size          = 6,
            y_max               = -3,
            y_min               = -10,
        })

    end

    if unilib.global.pkg_executed_table["biome_australia_indian_ocean"] ~= nil and
            unilib.global.pkg_executed_table["sand_ordinary"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_indian_ocean.lua
            ore_type            = "scatter",
            ore                 = "unilib:stone_ordinary_with_kelp_spiny",
            wherein             = "unilib:sand_ordinary",

            biomes              = "australia_indian_ocean",
            clust_num_ores      = 25,
            clust_scarcity      = 9 * 9 * 9,
            clust_size          = 6,
            y_max               = -3,
            y_min               = -10,
        })

    end

    if unilib.global.pkg_executed_table["biome_australia_tasman_sea"] ~= nil and
            unilib.global.pkg_executed_table["sand_ordinary"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_tasman_sea.lua
            ore_type            = "scatter",
            ore                 = "unilib:stone_ordinary_with_kelp_spiny",
            wherein             = "unilib:sand_ordinary",

            biomes              = "australia_tasman_sea",
            clust_num_ores      = 25,
            clust_scarcity      = 9 * 9 * 9,
            clust_size          = 6,
            y_max               = -3,
            y_min               = -10,
        })

        unilib.register_ore({
            -- From australia/biome_tasman_sea.lua
            ore_type            = "scatter",
            ore                 = "unilib:stone_ordinary_with_kelp_giant",
            wherein             = "unilib:sand_ordinary",

            biomes              = "australia_tasman_sea",
            clust_num_ores      = 24,
            clust_scarcity      = 10 * 10 * 10,
            clust_size          = 8,
            y_max               = -8,
            y_min               = -64,
        })

    end

end
