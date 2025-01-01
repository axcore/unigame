---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_australia_stone_slate_antipodean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_australia_stone_slate_antipodean.init()

    return {
        description = "Antipodean slate as ore",
        depends = {"stone_slate_antipodean", "stone_ordinary"},
        at_least_one = {
            "biome_australia_australian_alps",
            "biome_australia_eastern_coasts",
            "biome_australia_great_dividing_range",
            "biome_australia_jarrah_karri_forests",
            "biome_australia_underground",
            "biome_australia_victorian_forests",
            "stone_sandstone_ordinary",
        },
    }

end

function unilib.pkg.ore_australia_stone_slate_antipodean.post()

    if unilib.global.pkg_executed_table["biome_australia_australian_alps"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_australian_alps.lua
            ore_type            = "blob",
            ore                 = "unilib:stone_slate_antipodean",
            wherein             = "unilib:stone_ordinary",

            biomes              = "australia_australian_alps",
            clust_scarcity      = 16 * 16 * 16,
            clust_size          = 8,
            noise_params        = {
                octaves = 1,
                offset = 0.5,
                persist = 0.0,
                scale = 0.2,
                seed = 677,
                spread = {x = 5, y = 5, z = 5},
            },
            noise_threshold     = 0.0,
            y_max               = unilib.constant.y_max,
            y_min               = 150,
        })

    end

    if unilib.global.pkg_executed_table["biome_australia_eastern_coasts"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_eastern_coasts.lua
            ore_type            = "blob",
            ore                 = "unilib:stone_slate_antipodean",
            wherein             = "unilib:stone_ordinary",

            biomes              = "australia_eastern_coasts",
            clust_scarcity      = 16 * 16 * 16,
            clust_size          = 8,
            noise_params        = {
                octaves = 1,
                offset = 0.5,
                persist = 0.0,
                scale = 0.2,
                seed = 677,
                spread = {x = 5, y = 5, z = 5},
            },
            noise_threshold     = 0.0,
            y_max               = 35,
            y_min               = 4,

        })

    end

    if unilib.global.pkg_executed_table["biome_australia_great_dividing_range"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_great_dividing_range.lua
            ore_type            = "blob",
            ore                 = "unilib:stone_slate_antipodean",
            wherein             = "unilib:stone_ordinary",

            biomes              = "australia_great_dividing_range",
            clust_scarcity      = 16 * 16 * 16,
            clust_size          = 8,
            noise_params        = {
                octaves = 1,
                offset = 0.5,
                persist = 0.0,
                scale = 0.2,
                seed = 677,
                spread = {x = 5, y = 5, z = 5},
            },
            noise_threshold     = 0.0,
            y_max               = unilib.constant.y_max,
            y_min               = 36,
        })

    end

    if unilib.global.pkg_executed_table["biome_australia_jarrah_karri_forests"] ~= nil and
            unilib.global.pkg_executed_table["stone_sandstone_ordinary"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_jarrah_karri_forests.lua
            ore_type            = "blob",
            ore                 = "unilib:stone_slate_antipodean",
            wherein             = {"unilib:stone_ordinary", "unilib:stone_sandstone_ordinary"},

            biomes              = "australia_jarrah_karri_forests",
            clust_scarcity      = 16 * 16 * 16,
            clust_size          = 8,
            noise_params        = {
                octaves = 1,
                offset = 0.5,
                persist = 0.0,
                scale = 0.2,
                seed = 677,
                spread = {x = 5, y = 5, z = 5},
            },
            noise_threshold     = 0.0,
            y_max               = 35,
            y_min               = 4,
        })

    end

    if unilib.global.pkg_executed_table["biome_australia_underground"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_underground.lua
            ore_type            = "blob",
            ore                 = "unilib:stone_slate_antipodean",
            wherein             = "unilib:stone_ordinary",

            biomes              = "australia_underground",
            clust_scarcity      = 16 * 16 * 16,
            clust_size          = 8,
            noise_params        = {
                octaves = 1,
                offset = 0.5,
                persist = 0.0,
                scale = 0.2,
                seed = 677,
                spread = {x = 5, y = 5, z = 5},
            },
            noise_threshold     = 0.0,
            y_max               = -65,
            y_min               = unilib.constant.y_min,
        })

    end

    if unilib.global.pkg_executed_table["biome_australia_victorian_forests"] ~= nil then

        unilib.register_ore({
            -- From australia/biome_victorian_forests.lua
            ore_type            = "blob",
            ore                 = "unilib:stone_slate_antipodean",
            wherein             = "unilib:stone_ordinary",

            biomes              = "australia_victorian_forests",
            clust_scarcity      = 16 * 16 * 16,
            clust_size          = 8,
            noise_params        = {
                octaves = 1,
                offset = 0.5,
                persist = 0.0,
                scale = 0.2,
                seed = 677,
                spread = {x = 5, y = 5, z = 5},
            },
            noise_threshold     = 0.0,
            y_max               = unilib.constant.y_max,
            y_min               = 36,
        })

    end

end
