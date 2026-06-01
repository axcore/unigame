---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_voyager_biomes = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Localise math functions (for speed)
local ceil = math.ceil

-- This package excludeds biomes by height; if you override it with your own custom package, you can
--      exclude whichever biomes you like
local max_height = 50
local min_height = -50

-- Table of biomes, populated below
local biome_table = {}
local total_count = 0
-- Table of excluded biomes (do not count towards achievements), in the form
--      BIOME_NAME = true
local biome_exclude_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function compile_biomes()

    for biome_name, defn_table in pairs(core.registered_biomes) do

        if biome_exclude_table[biome_name] == nil and
                (not defn_table.min_pos or defn_table.min_pos <= max_height) and
                (not defn_table.max_pos or defn_table.max_pos >= min_height) then

            biome_table[biome_name] = true
            total_count = total_count + 1

        end

    end

end

local function unlock_count_achievement(player, awards_table, achievement_name, count)

    -- This award is locked; unlock, if the target has been reached, otherwise store the ratio of
    --      visited biomes "ratio" as an indication of progress towards the target
    local target =
            unilib.global.awards_achievement_table[achievement_name]["trigger_table"]["target"]

    if count >= target then

        unilib.awards.unlock_achievement(player, achievement_name)

    else

        if awards_table["current_table"][achievement_name] == nil or
                awards_table["current_table"][achievement_name] < count then
            awards_table["current_table"][achievement_name] = count
        end

    end

end

local function unlock_ratio_achievement(player, awards_table, achievement_name, ratio)

    -- This award is locked; unlock, if the target has been reached, otherwise store the ratio of
    --      visited biomes "ratio" as an indication of progress towards the target
    local target =
            unilib.global.awards_achievement_table[achievement_name]["trigger_table"]["target"]

    if ratio >= target then

        unilib.awards.unlock_achievement(player, achievement_name)

    else

        if awards_table["current_table"][achievement_name] == nil or
                awards_table["current_table"][achievement_name] < ratio then
            awards_table["current_table"][achievement_name] = ratio
        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_voyager_biomes.init()

    return {
        description = "Additional achievements for the \"Voyager\" vocation",
        notes = "These achievements are in a separate package, so that remix writers can" ..
                " override with their own customised package, including or excluding biomes" ..
                " as apropriate. In this package, biomes above y=50 and below y=-50 are" ..
                " excluded, and we assume that there are at least 10 different biomes reachable" ..
                " by players. The \"award_voyager\" package assumes that this package provides" ..
                " 11 new achievements with a total score of 200; if you change that arrangement," ..
                " you should override the \"award_voyager\" package as well",
        depends = "award_voyager",
    }

end

function unilib.pkg.award_voyager_biomes.exec()

    -- Can't be sure, when this package has finished loading, that all biome packages have already
    --      been loaded
    core.after(0.1, function()
        compile_biomes()
    end)

end

function unilib.pkg.award_voyager_biomes.post()

    -- Sanity check -------------------------------------------------------------------------------

    -- All awards in this package depend on monitor callbacks, so don't both creating the awards
    --      at all, if monitor callbacks are disabled
    if not unilib.setting.awards_enable_flag or unilib.setting.awards_disable_monitors_flag then
        return
    end

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "voyager_biome_count",
        trigger_type = "custom",
        hint_list = {"Visit one new biome", "Visit @1 new biomes"},
        progress_list = {"Visit one new biome", "Visit @1/@2 new biomes"},
    })

    unilib.awards.register_trigger_prototype({
        name = "voyager_biome_ratio",
        trigger_type = "custom",
        hint_list = {"Visit 1% of biomes", "Visit @1% of biomes"},
        progress_list = {"Visit 1% of biomes", "Visit @1/@2% of biomes"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    unilib.awards.register_monitor_callback(
        "pos_str",
        function(player, pos)

            local pname = player:get_player_name()

            -- As a time-saving measure, only check achievements if the player is in a non-excluded
            --      biome...
            local data_table = core.get_biome_data(pos)
            if not data_table.biome then
                return
            end

            local biome_name = core.get_biome_name(data_table.biome)
            if not biome_table[biome_name] then
                return
            end

            -- ...and in a biome they haven't visited before. A table of visited biomes is stored
            --      under the first achievement listed below, but applies to all of them
            local main_achievement = "unilib_voyager_biome_count_1"
            local awards_table = unilib.global.awards_player_table[pname]
            if awards_table["data_table"][main_achievement] == nil then
                awards_table["data_table"][main_achievement] = {}
            end

            if awards_table["data_table"][main_achievement][biome_name] == true then
                return
            end

            -- New biome
            awards_table["data_table"][main_achievement][biome_name] = true

            local count = unilib.utils.get_table_size(
                awards_table["data_table"][main_achievement]
            )
            local ratio = ceil((count / total_count) * 100)

            -- Now we can check achievements individually
            for _, achievement_name in ipairs(
                unilib.awards.retrieve_data_from_custom_watch_table(player, "voyager_biome_count")
            ) do

                if awards_table["unlock_table"][achievement_name] == nil then
                    unlock_count_achievement(player, awards_table, achievement_name, count)
                end

            end

            for _, achievement_name in ipairs(
                unilib.awards.retrieve_data_from_custom_watch_table(player, "voyager_biome_ratio")
            ) do

                if awards_table["unlock_table"][achievement_name] == nil then
                    unlock_ratio_achievement(player, awards_table, achievement_name, ratio)
                end

            end

        end
    )

    -- Achievements -------------------------------------------------------------------------------

    -- Combination (biome) achievments
    for i, mini_list in ipairs({
        -- Number of biomes explored
        {1, "voyager_biome_count", S("Amateur Wayfarer"), S("Discover 5 new biomes"), 10, 5},
        {2, "voyager_biome_count", S("Skilled Wayfarer"), S("Discover 10 new biomes"), 10, 10},
        {3, "voyager_biome_count", S("Veteran Wayfarer"), S("Discover 20 new biomes"), 10, 20},
        -- Percentage of biomes explored
        {1, "voyager_biome_ratio", S("Amateur Explorer"), S("Explore 20% of biomes"), 10, 20},
        {2, "voyager_biome_ratio", S("Novice Explorer"), S("Explore 40% of biomes"), 20, 40},
        {3, "voyager_biome_ratio", S("Skilled Explorer"), S("Explore 60% of biomes"), 30, 60},
        {4, "voyager_biome_ratio", S("Veteran Explorer"), S("Explore 80% of biomes"), 40, 80},
        {5, "voyager_biome_ratio", S("Master Explorer"), S("Explore 100% of biomes"), 50, 100},
    }) do

        unilib.awards.register_achievement({
            name = "unilib_" .. mini_list[2] .. "_" .. mini_list[1],
            trigger_table = {
                prototype = mini_list[2],
                target = mini_list[6],
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_voyager.vocation_name},
        })

    end

end
