---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_general = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_general.vocation_name = "unilib_general"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_break(player, pos)

    if not unilib.utils.is_player(player) or pos == nil then
        return
    end

    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_custom_watch_table(player, "general_comb_break_above")
    ) do

        local achievement_table = unilib.global.awards_achievement_table[achievement_name]
        local target = achievement_table["trigger_table"]["target"]
        if target <= pos.y then
            unilib.awards.unlock_achievement(player, achievement_name)
        end

    end

end

local function on_place(player, pos)

    if not unilib.utils.is_player(player) or pos == nil then
        return
    end

    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_custom_watch_table(player, "general_comb_place_above")
    ) do

        local achievement_table = unilib.global.awards_achievement_table[achievement_name]
        local target = achievement_table["trigger_table"]["target"]
        if target <= pos.y then
            unilib.awards.unlock_achievement(player, achievement_name)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_general.init()

    return {
        description = "General awards (\"Dull Miner's Club\")",
        notes = "Awards for breaking, placing and crafting all types of item",
    }

end

function unilib.pkg.award_general.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "general_comb_break_above",
        trigger_type = "custom",
        hint_list = {"Break a block at great heights", "Break @1 blocks at great heights"},
        progress_list = {"Break a block at great heights", "Break @1/@2 blocks at great heights"},
    })

    unilib.awards.register_trigger_prototype({
        name = "general_comb_place_above",
        trigger_type = "custom",
        hint_list = {"Place a block at great heights", "Place @1 blocks at great heights"},
        progress_list = {"Place a block at great heights", "Place @1/@2 blocks at great heights"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    core.register_on_dignode(function(pos, oldnode, digger)
        on_break(digger, pos)
    end)

    core.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
        on_place(placer, pos)
    end)

    -- Vocations ----------------------------------------------------------------------------------

    -- Total score (for 1,000,000 items broken/placed/crafted, and breaking/placing at y=1000) is
    --      1090
    -- Total score (for 100,000 items broken/placed/crafted) is 600
    unilib.awards.register_vocation({
        name = unilib.pkg.award_general.vocation_name,

        title = S("Dull Miner's Club"),
        description = S("Let other players have their fun; you've got dirt to dig!"),
        icon = "unilib_award_vocation_general.png",
        level_list = {
            {title = S("Just Testing My Shovel"), score = 10},
            {title = S("Hole Puncher"), score = 20},
            {title = S("Dirt Farmer"), score = 40},
            {title = S("Groundhog Day"), score = 70},
            {title = S("Block Party"), score = 100},
            {title = S("You've Been Busy"), score = 150},
            {title = S("Block and Roll"), score = 200},
            {title = S("Trained in Terraforming"), score = 250},
            {title = S("Certified Block Technician"), score = 300},
            {title = S("Rebuilt the Grand Canyon"), score = 400},
            {title = S("The Grind Never Ends"), score = 500},
            {title = S("The Block Stops Here"), score = 600},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    for i, mini_list in ipairs({
        {"break_1", "unilib_break", S("Amateur Basher"), S("Break 10 items"), 10, 10},
        {"break_2", "unilib_break", S("Aspiring Basher"), S("Break 100 items"), 10, 100},
        {"break_3", "unilib_break", S("Novice Basher"), S("Break 250 items"), 20, 250},
        {"break_4", "unilib_break", S("Competent Basher"), S("Break 1000 items"), 20, 1000},
        {"break_5", "unilib_break", S("Skilled Basher"), S("Break 2,500 items"), 30, 2500},
        {"break_6", "unilib_break", S("Season Basher"), S("Break 10,000 items"), 30, 10000},
        {"break_7", "unilib_break", S("Veteran Basher"), S("Break 25,000 items"), 40, 25000},
        {"break_8", "unilib_break", S("Master Basher"), S("Break 100,000 items"), 40, 100000},
        {"break_9", "unilib_break", S("Grandmaster Basher"), S("Break 250,000 items"), 50, 250000},
        {"break_10", "unilib_break", S("Elite Basher"), S("Break 1,000,000 items"), 100, 1000000},

        {"break_above_1", "general_comb_break_above", S("High-Maintenance Miner"), S("Break a block at least 100m above sea level"), 10, 100},
        {"break_above_2", "general_comb_break_above", S("Altitude Adjustment"), S("Break a block at least 1000m above sea level"), 20, 1000},
        {"break_above_3", "general_comb_break_above", S("The Sky's The Limit"), S("Break a block at least 10,000m above sea level"), 30, 10000},

        {"place_1", "unilib_place", S("Amateur Plonker"), S("Place 10 items"), 10, 10},
        {"place_2", "unilib_place", S("Aspiring Plonker"), S("Place 100 items"), 10, 100},
        {"place_3", "unilib_place", S("Novice Plonker"), S("Place 250 items"), 20, 250},
        {"place_4", "unilib_place", S("Competent Plonker"), S("Place 1000 items"), 20, 1000},
        {"place_5", "unilib_place", S("Skilled Plonker"), S("Place 2,500 items"), 30, 2500},
        {"place_6", "unilib_place", S("Season Plonker"), S("Place 10,000 items"), 30, 10000},
        {"place_7", "unilib_place", S("Veteran Plonker"), S("Place 25,000 items"), 40, 25000},
        {"place_8", "unilib_place", S("Master Plonker"), S("Place 100,000 items"), 40, 100000},
        {"place_9", "unilib_place", S("Grandmaster Plonker"), S("Place 250,000 items"), 50, 250000},
        {"place_10", "unilib_place", S("Elite Plonker"), S("Place 1,000,000 items"), 100, 1000000},

        {"place_above_1", "general_comb_place_above", S("Raising the Roof"), S("Place a block at least 100m above sea level"), 10, 100},
        {"place_above_2", "general_comb_place_above", S("Cloud Storage"), S("Place a block at least 1000m above sea level"), 20, 1000},
        {"place_above_3", "general_comb_place_above", S("Heaven's Handyman"), S("Place a block at least 10,000m above sea level"), 30, 10000},

        {"craft_1", "unilib_craft", S("Amateur Crafter"), S("Craft 10 items"), 10, 10},
        {"craft_2", "unilib_craft", S("Aspiring Crafter"), S("Craft 100 items"), 10, 100},
        {"craft_3", "unilib_craft", S("Novice Crafter"), S("Craft 250 items"), 20, 250},
        {"craft_4", "unilib_craft", S("Competent Crafter"), S("Craft 1000 items"), 20, 1000},
        {"craft_5", "unilib_craft", S("Skilled Crafter"), S("Craft 2,500 items"), 30, 2500},
        {"craft_6", "unilib_craft", S("Season Crafter"), S("Craft 10,000 items"), 30, 10000},
        {"craft_7", "unilib_craft", S("Veteran Crafter"), S("Craft 25,000 items"), 40, 25000},
        {"craft_8", "unilib_craft", S("Master Crafter"), S("Craft 100,000 items"), 40, 100000},
        {"craft_9", "unilib_craft", S("Grandmaster Crafter"), S("Craft 250,000 items"), 50, 250000},
        {"craft_10", "unilib_craft", S("Elite Crafter"), S("Craft 1,000,000 items"), 100, 1000000},
    }) do

        unilib.awards.register_achievement({
            name = "unilib_general_comb_" .. mini_list[1],
            trigger_table = {
                prototype = mini_list[2],
                target = mini_list[6],
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_general.vocation_name},
        })

    end

end
