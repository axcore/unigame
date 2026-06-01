---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_fisherman = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Compiled lists/tables of items
local fish_lookup_table = {}
local bonus_lookup_table = {}
local junk_lookup_table = {}
-- Table of items excluded from most achievements, in the form
--      FULL_NAME = true
local exclude_table = {}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_fisherman.vocation_name = "unilib_fisherman"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function compile_items()

    for _, mini_table in ipairs(unilib.global.fishing_fish_list) do

        if exclude_table[mini_table.full_name] == nil then
            fish_lookup_table[mini_table.full_name] = true
        end

    end

    for _, mini_table in ipairs(unilib.global.fishing_bonus_list) do

        if exclude_table[mini_table.full_name] == nil then
            bonus_lookup_table[mini_table.full_name] = true
        end

    end

    for _, mini_table in ipairs(unilib.global.fishing_junk_list) do

        if exclude_table[mini_table.full_name] == nil then
            junk_lookup_table[mini_table.full_name] = true
        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_fisherman.on_catch(player, full_name)

    -- Called by code in the "item_rod_fishing" package

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            not full_name then
        return
    end

    if fish_lookup_table[full_name] then

        unilib.awards.handle_simple_trigger(player, "fisherman_comb_fish")
        unilib.awards.handle_collection_trigger(
            player, "fisherman_collect_fish", "unilib_fisherman_collect_fish_1", full_name
        )

    elseif bonus_lookup_table[full_name] then

        unilib.awards.handle_simple_trigger(player, "fisherman_comb_bonus")

    elseif junk_lookup_table[full_name] then

        unilib.awards.handle_simple_trigger(player, "fisherman_comb_junk")

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_fisherman.init()

    return {
        description = "Awards for catching fish (and any other junk you find) (\"Fisherman\")",
    }

end

function unilib.pkg.award_fisherman.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag or
            not unilib.global.pkg_executed_table["item_rod_fishing"] then
        return
    end

    -- Setup --------------------------------------------------------------------------------------

    -- Convert unilib.global.fishing_fish_list, etc, into lookup tables
    compile_items()

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "fisherman_comb_fish",
        trigger_type = "simple",
        hint_list = {"Catch one fish", "Catch @1 fish"},
        progress_list = {"Catch one fish", "Catch @1/@2 fish"},
    })

    unilib.awards.register_trigger_prototype({
        name = "fisherman_comb_bonus",
        trigger_type = "simple",
        hint_list = {"Catch one bonus item", "Catch @1 bonus items"},
        progress_list = {"Catch one bonus item", "Catch @1/@2 bonus items"},
    })

    unilib.awards.register_trigger_prototype({
        name = "fisherman_comb_junk",
        trigger_type = "simple",
        hint_list = {"Catch one junk item", "Catch @1 junk item"},
        progress_list = {"Catch one junk item", "Catch @1/@2 junk items"},
    })

    unilib.awards.register_trigger_prototype({
        name = "fisherman_collect_fish",
        trigger_type = "custom",
        hint_list = {"Catch one type of fish", "Catch @1 types of fish"},
        progress_list = {"Catch one type of fish", "Catch @1/@2 types of fish"},
    })

    -- Vocations ----------------------------------------------------------------------------------

    -- Assumes 50 different types of fish (as in the "gaia" remix), at least one bonus and at least
    --      one junk item, for a total score of 460
    unilib.awards.register_vocation({
        name = unilib.pkg.award_fisherman.vocation_name,

        title = S("Fisherman"),
        description = S("Get out your fishing rod, who knows what you'll catch"),
        icon = "unilib_award_vocation_fisherman.png",
        level_list = {
            {title = S("Booty Hunter"), score = 10},
            {title = S("Trash Trawler"), score = 20},
            {title = S("Water You Doing"), score = 40},
            {title = S("Reel Improvement"), score = 60},
            {title = S("Fin-atic"), score = 90},
            {title = S("Carp Diem"), score = 120},
            {title = S("Holy Mackerel"), score = 150},
            {title = S("Sole Proprietor "), score = 200},
            {title = S("Net Prophet"), score = 250},
            {title = S("Hooked on Greatness"), score = 300},
            {title = S("Poseidon's Intern"), score = 350},
            {title = S("The Codfather"), score = 450},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    for i, mini_list in ipairs({
        {"fish_1", "fisherman_comb_fish", S("Amateur Angler"), S("Catch 5 fish"), 10, 5},
        {"fish_2", "fisherman_comb_fish", S("Novice Angler"), S("Catch 25 fish"), 20, 25},
        {"fish_3", "fisherman_comb_fish", S("Skilled Angler"), S("Catch 125 fish"), 30, 125},
        {"fish_4", "fisherman_comb_fish", S("Seasoned Angler"), S("Catch 500 fish"), 40, 500},
        {"fish_5", "fisherman_comb_fish", S("Veteran Angler"), S("Catch 1250 fish"), 50, 1250},

        {"bonus_1", "fisherman_comb_bonus", S("Amateur Scavenger"), S("Catch 5 bonus items while fishing"), 10, 5},
        {"bonus_2", "fisherman_comb_bonus", S("Novice Scavenger"), S("Catch 25 bonus items while fishing"), 20, 25},
        {"bonus_3", "fisherman_comb_bonus", S("Skilled Scavenger"), S("Catch 125 bonus items while fishing"), 30, 125},

        {"junk_1", "fisherman_comb_junk", S("Amateur Boot Fisher"), S("Catch 5 junk items while fishing"), 10, 5},
        {"junk_2", "fisherman_comb_junk", S("Novice Boot Fisher"), S("Catch 25 junk items while fishing"), 20, 25},
        {"junk_3", "fisherman_comb_junk", S("Skilled Boot Fisher"), S("Catch 125 junk items while fishing"), 30, 125},
    }) do

        unilib.awards.register_achievement({
            name = "unilib_fisherman_comb_" .. mini_list[1],
            trigger_table = {
                prototype = mini_list[2],
                target = mini_list[6],
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_fisherman.vocation_name},
        })

    end

    -- Collector achievements
    local fish_count = unilib.utils.get_table_size(unilib.global.fishing_fish_list)
    if fish_count >= 5 then

        local fish_list = {
            {S("Elite Ichthyologist"), S("Catch every type of fish"), 100, fish_count},
            {S("Amateur Ichthyologist"), S("Catch 5 types of fish"), 10, 5},
        }

        if fish_count > 10 then
            table.insert(fish_list, {S("Novice Ichthyologist"), S("Catch 10 types of fish"), 10, 10})
        end

        if fish_count > 20 then
            table.insert(fish_list, {S("Skilled Ichthyologist"), S("Catch 20 types of fish"), 20, 20})
        end

        if fish_count > 30 then
            table.insert(fish_list, {S("Seasoned Ichthyologist"), S("Catch 30 types of fish"), 20, 30})
        end

        if fish_count > 50 then
            table.insert(fish_list, {S("Master Ichthyologist"), S("Catch 50 types of fish"), 30, 50})
        end

        if fish_count > 100 then
            table.insert(fish_list, {S("Grandmaster Ichthyologist"), S("Catch 100 types of fish"), 50, 100})
        end

        for i, mini_list in ipairs(fish_list) do

            unilib.awards.register_achievement({
                name = "unilib_fisherman_collect_fish_" .. i,
                trigger_table = {
                    prototype = "fisherman_collect_fish",
                    target = mini_list[4],
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_fisherman.vocation_name},
            })

        end

    end

end
