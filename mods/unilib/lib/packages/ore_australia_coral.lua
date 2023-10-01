---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_australia_coral = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_australia_coral.init()

    return {
        description = "Australian coral as ore",
        depends = {"sand_ordinary", "stone_ordinary_with_coral"},
        notes = "Corals from many different pacakges were grouped together in one ore package," ..
                " because they only apply to one biome",
        optional = {
            "biome_australia_great_barrier_reef",
            "coral_brain",
            "coral_cauliflower_brown",
            "coral_cauliflower_green",
            "coral_cauliflower_pink",
            "coral_cluster_green",
            "coral_cluster_orange",
            "coral_cluster_purple",
            "coral_hammer",
            "coral_staghorn_blue",
            "coral_staghorn_pink",
            "coral_staghorn_purple",
            "coral_staghorn_yellow",
        },
    }

end

function unilib.pkg.ore_australia_coral.post()

    if unilib.pkg_executed_table["biome_australia_great_barrier_reef"] ~= nil then

        if unilib.pkg_executed_table["coral_brain"] ~= nil then

            unilib.register_ore({
                -- From australia/biome_great_barrier_reef.lua
                ore_type            = "scatter",
                ore                 = "unilib:stone_ordinary_with_coral_brain",
                wherein             = "unilib:sand_ordinary",

                biomes              = "australia_great_barrier_reef",
                clust_num_ores      = 8,
                clust_scarcity      = 20 * 20 * 20,
                clust_size          = 3,
                y_max               = -3,
                y_min               = -12,
            })

        end

        if unilib.pkg_executed_table["coral_cauliflower_brown"] ~= nil then

            unilib.register_ore({
                -- From australia/biome_great_barrier_reef.lua
                ore_type            = "scatter",
                ore                 = "unilib:stone_ordinary_with_coral_cauliflower_brown",
                wherein             = "unilib:sand_ordinary",

                biomes              = "australia_great_barrier_reef",
                clust_num_ores      = 25,
                clust_scarcity      = 11 * 11 * 11,
                clust_size          = 8,
                y_max               = -4,
                y_min               = -12,
            })

        end

        if unilib.pkg_executed_table["coral_cauliflower_green"] ~= nil then

            unilib.register_ore({
                -- From australia/biome_great_barrier_reef.lua
                ore_type            = "scatter",
                ore                 = "unilib:stone_ordinary_with_coral_cauliflower_green",
                wherein             = "unilib:sand_ordinary",

                biomes              = "australia_great_barrier_reef",
                clust_num_ores      = 25,
                clust_scarcity      = 11 * 11 * 11,
                clust_size          = 8,
                y_max               = -4,
                y_min               = -12,
            })

        end

        if unilib.pkg_executed_table["coral_cauliflower_pink"] ~= nil then

            unilib.register_ore({
                -- From australia/biome_great_barrier_reef.lua
                ore_type            = "scatter",
                ore                 = "unilib:stone_ordinary_with_coral_cauliflower_pink",
                wherein             = "unilib:sand_ordinary",

                biomes              = "australia_great_barrier_reef",
                clust_num_ores      = 25,
                clust_scarcity      = 11 * 11 * 11,
                clust_size          = 8,
                y_max               = -4,
                y_min               = -12,
            })

        end

        if unilib.pkg_executed_table["coral_cluster_green"] ~= nil then

            unilib.register_ore({
                -- From australia/biome_great_barrier_reef.lua
                ore_type            = "scatter",
                ore                 = "unilib:stone_ordinary_with_coral_cluster_green",
                wherein             = "unilib:sand_ordinary",

                biomes              = "australia_great_barrier_reef",
                clust_num_ores      = 20,
                clust_scarcity      = 15 * 15 * 15,
                clust_size          = 4,
                y_max               = -2,
                y_min               = -8,
            })

        end

        if unilib.pkg_executed_table["coral_cluster_orange"] ~= nil then

            unilib.register_ore({
                -- From australia/biome_great_barrier_reef.lua
                ore_type            = "scatter",
                ore                 = "unilib:stone_ordinary_with_coral_cluster_orange",
                wherein             = "unilib:sand_ordinary",

                biomes              = "australia_great_barrier_reef",
                clust_num_ores      = 20,
                clust_scarcity      = 15 * 15 * 15,
                clust_size          = 4,
                y_max               = -2,
                y_min               = -8,
            })

        end

        if unilib.pkg_executed_table["coral_cluster_purple"] ~= nil then

            unilib.register_ore({
                -- From australia/biome_great_barrier_reef.lua
                ore_type            = "scatter",
                ore                 = "unilib:stone_ordinary_with_coral_cluster_purple",
                wherein             = "unilib:sand_ordinary",

                biomes              = "australia_great_barrier_reef",
                clust_num_ores      = 20,
                clust_scarcity      = 15 * 15 * 15,
                clust_size          = 4,
                y_max               = -2,
                y_min               = -8,
            })

        end

        if unilib.pkg_executed_table["coral_hammer"] ~= nil then

            unilib.register_ore({
                -- From australia/biome_great_barrier_reef.lua
                ore_type            = "scatter",
                ore                 = "unilib:stone_ordinary_with_coral_hammer",
                wherein             = "unilib:sand_ordinary",

                biomes              = "australia_great_barrier_reef",
                clust_num_ores      = 20,
                clust_scarcity      = 64 * 64 * 64,
                clust_size          = 12,
                y_max               = -2,
                y_min               = -10,
            })

        end

        if unilib.pkg_executed_table["coral_staghorn_blue"] ~= nil then

            unilib.register_ore({
                -- From australia/biome_great_barrier_reef.lua
                ore_type            = "scatter",
                ore                 = "unilib:stone_ordinary_with_coral_staghorn_blue",
                wherein             = "unilib:sand_ordinary",

                biomes              = "australia_great_barrier_reef",
                clust_num_ores      = 24,
                clust_scarcity      = 10 * 10 * 10,
                clust_size          = 4,
                y_max               = -2,
                y_min               = -6,
            })

        end

        if unilib.pkg_executed_table["coral_staghorn_pink"] ~= nil then

            unilib.register_ore({
                -- From australia/biome_great_barrier_reef.lua
                ore_type            = "scatter",
                ore                 = "unilib:stone_ordinary_with_coral_staghorn_pink",
                wherein             = "unilib:sand_ordinary",

                biomes              = "australia_great_barrier_reef",
                clust_num_ores      = 25,
                clust_scarcity      = 9 * 9 * 9,
                clust_size          = 5,
                y_max               = -2,
                y_min               = -6,
            })

        end

        if unilib.pkg_executed_table["coral_staghorn_purple"] ~= nil then

            unilib.register_ore({
                -- From australia/biome_great_barrier_reef.lua
                ore_type            = "scatter",
                ore                 = "unilib:stone_ordinary_with_coral_staghorn_purple",
                wherein             = "unilib:sand_ordinary",

                biomes              = "australia_great_barrier_reef",
                clust_num_ores      = 20,
                clust_scarcity      = 13 * 13 * 13,
                clust_size          = 4,
                y_max               = -2,
                y_min               = -6,
            })

        end

        if unilib.pkg_executed_table["coral_staghorn_yellow"] ~= nil then

            unilib.register_ore({
                -- From australia/biome_great_barrier_reef.lua
                ore_type            = "scatter",
                ore                 = "unilib:stone_ordinary_with_coral_staghorn_yellow",
                wherein             = "unilib:sand_ordinary",

                biomes              = "australia_great_barrier_reef",
                clust_num_ores      = 22,
                clust_scarcity      = 12 * 12 * 12,
                clust_size          = 4,
                y_max               = -2,
                y_min               = -6,
            })

        end

        if unilib.pkg_executed_table["stone_ordinary_with_coral"] ~= nil then

            unilib.register_ore({
                -- From australia/biome_great_barrier_reef.lua
                ore_type            = "scatter",
                ore                 = "unilib:stone_ordinary_with_coral_seafan",
                wherein             = "unilib:sand_ordinary",

                biomes              = "australia_great_barrier_reef",
                clust_num_ores      = 9,
                clust_scarcity      = 24 * 24 * 24,
                clust_size          = 3,
                y_max               = -5,
                y_min               = -10,
            })

            unilib.register_ore({
                -- From australia/biome_great_barrier_reef.lua
                ore_type            = "scatter",
                ore                 = "unilib:stone_ordinary_with_coral_tube_sponge",
                wherein             = "unilib:sand_ordinary",

                biomes              = "australia_great_barrier_reef",
                clust_num_ores      = 10,
                clust_scarcity      = 21 * 21 * 21,
                clust_size          = 2,
                y_max               = -3,
                y_min               = -15,
            })

        end

    end

end
