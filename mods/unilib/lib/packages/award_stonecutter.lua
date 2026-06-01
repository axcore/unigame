---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_stonecutter = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Reverse lookup table. Keys are the full_name of a node (e.g. "unilib:stone_ordinary_brick"),
--      the corresponding value is the stone type (a key in unilib.global.stone_table)
local lookup_table = {}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_stonecutter.vocation_name = "unilib_stonecutter"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function populate_lookup_table(stone_type)

    -- Populate the lookup table with each variety of stone node, regardless of whether it actually
    --      exists for the specified "stone_type" or not (e.g. rubble only exists for a minority of
    --      stone types)
    lookup_table["unilib:stone_" .. stone_type] = stone_type
    lookup_table["unilib:stone_" .. stone_type .. "_block"] = stone_type
    lookup_table["unilib:stone_" .. stone_type .. "_brick"] = stone_type
    lookup_table["unilib:stone_" .. stone_type .. "_cobble"] = stone_type
    lookup_table["unilib:stone_" .. stone_type .. "_rubble"] = stone_type

end

local function on_collect(player, full_name)

    if not unilib.utils.is_player(player) or full_name == nil then
        return
    end

    if lookup_table[full_name] ~= nil then

        local stone_type = lookup_table[full_name]
        unilib.awards.handle_collection_trigger(
            player, "stonecutter_collect_type", "unilib_stonecutter_collect_type_1", stone_type
        )

        local category = unilib.global.stone_table[stone_type]["category"]
        if category == "exclusive" or
                category == "intrusive" or
                category == "sedimentary" or
                category == "metamorphic" then

            unilib.awards.handle_collection_trigger(
                player,
                "stonecutter_collect_category",
                "unilib_stonecutter_collect_" .. category,
                full_name
            )

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_stonecutter.init()

    return {
        description = "Awards for breaking/placing/crafting stone (\"Stonecutter\")",
        notes = "Assumes a world with at least 5 types of stone (there are 6 in minetest_game)",
    }

end

function unilib.pkg.award_stonecutter.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "stonecutter_collect_type",
        trigger_type = "custom",
        hint_list = {"Break one type of stone", "Break @1 types of stone"},
        progress_list = {"Break one type of stone", "Break @1/@2 types of stone"},
    })

    unilib.awards.register_trigger_prototype({
        name = "stonecutter_collect_category",
        trigger_type = "custom",
        hint_list = {"Break one category of stone", "Break @1 categories of stone"},
        progress_list = {"Break one category of stone", "Break @1/@2 categories of stone"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    core.register_on_dignode(function(pos, oldnode, digger)
        on_collect(digger, oldnode.name)
    end)

    -- Vocations ----------------------------------------------------------------------------------

    -- Assumes at least 5 stone types (6 in minetest_game), giving a minimum total score of 1330
    -- We'll leave aside the 200 for breaking a million blocks, which gives us 1130
    unilib.awards.register_vocation({
        name = unilib.pkg.award_stonecutter.vocation_name,

        title = S("Stonecutter"),
        description = S("Dig until your pickaxe begs you to stop"),
        icon = "unilib_award_vocation_stonecutter.png",
        level_list = {
            {title = S("Surface Scraper"), score = 10},
            {title = S("Pebble Pusher"), score = 20},
            {title = S("Rock Rookie"), score = 50},
            {title = S("Cobble Collector"), score = 100},
            {title = S("Rubble Rummager"), score = 200},
            {title = S("Gravel Grabber"), score = 300},
            {title = S("Boulder Buster"), score = 400},
            {title = S("Tuff Customer"), score = 500},
            {title = S("Rock Solid"), score = 600},
            {title = S("Manic Miner"), score = 700},
            {title = S("You've Hit Rock Bottom"), score = 900},
            {title = S("The Uncrackable Pickaxe"), score = 1100},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements (stone)
    local all_group_list = {"group:smoothstone", "group:cobble", "group:rubble", "group:stoneblock", "group:stonebrick"}

    for i, mini_list in ipairs({
        -- Break smooth stone
        {"smooth_1", "group:smoothstone", "unilib_break", S("Amateur Tunneler"), S("Break 10 smooth stone blocks"), 10, 10},
        {"smooth_2", "group:smoothstone", "unilib_break", S("Novice Tunneler"), S("Break 100 smooth stone blocks"), 10, 100},
        {"smooth_3", "group:smoothstone", "unilib_break", S("Skilled Tunneler"), S("Break 1000 smooth stone blocks"), 20, 1000},
        {"smooth_4", "group:smoothstone", "unilib_break", S("Veteran Tunneler"), S("Break 10,000 smooth stone blocks"), 50, 10000},
        {"smooth_5", "group:smoothstone", "unilib_break", S("Master Tunneler"), S("Break 100,000 smooth stone blocks"), 100, 100000},
        {"smooth_6", "group:smoothstone", "unilib_break", S("Elite Tunneler"), S("Break 1,000,000 smooth stone blocks"), 200, 1000000},
        -- Break cobble/rubble
        {"cobble_1", {"group:cobble", "group:rubble"}, "unilib_break", S("Amateur Cobbler"), S("Break 100 cobble/rubble blocks"), 10, 100},
        {"cobble_2", {"group:cobble", "group:rubble"}, "unilib_break", S("Skilled Cobbler"), S("Break 1000 cobble/rubble blocks"), 20, 1000},
        {"cobble_3", {"group:cobble", "group:rubble"}, "unilib_break", S("Veteran Cobbler"), S("Break 10000 cobble/rubble blocks"), 50, 10000},
        -- Craft stone blocks
        {"block_1", "group:stoneblock", "unilib_craft", S("Amateur Stonemason"), S("Craft 100 stone blocks"), 10, 100},
        {"block_2", "group:stoneblock", "unilib_craft", S("Skilled Stonemason"), S("Craft 1000 stone blocks"), 20, 1000},
        {"block_3", "group:stoneblock", "unilib_craft", S("Veteran Stonemason"), S("Craft 10000 stone blocks"), 50, 10000},
        -- Craft stone blocks
        {"brick_1", "group:stonebrick", "unilib_craft", S("Amateur Bricklayer"), S("Craft 100 stone bricks"), 10, 100},
        {"brick_2", "group:stonebrick", "unilib_craft", S("Skilled Bricklayer"), S("Craft 1000 stone bricks"), 20, 1000},
        {"brick_3", "group:stonebrick", "unilib_craft", S("Veteran Bricklayer"), S("Craft 10000 stone bricks"), 50, 10000},
        -- Place all stone nodes
        {"place_1", all_group_list, "unilib_place", S("Amateur Builder"), S("Place 50 stone nodes"), 10, 50},
        {"place_2", all_group_list, "unilib_place", S("Novice Builder"), S("Place 500 stone nodes"), 20, 500},
        {"place_3", all_group_list, "unilib_place", S("Skilled Builder"), S("Place 5000 stone nodes"), 50, 5000},
        {"place_4", all_group_list, "unilib_place", S("Veteran Builder"), S("Place 50000 stone nodes"), 100, 50000},
    }) do

        unilib.awards.register_achievement({
            name = "unilib_stonecutter_comb_" .. mini_list[1],
            trigger_table = {
                prototype = mini_list[3],
                target = mini_list[7],
                item_list = unilib.utils.convert_to_list(mini_list[2]),
            },

            title = mini_list[4],
            description = mini_list[5],
            score = mini_list[6],
            vocation_list = {unilib.pkg.award_stonecutter.vocation_name},
        })

    end

    -- Selective achievements (stone)
    local stone_count = 0
    for part_name, data_table in pairs(unilib.global.stone_table) do

        if not data_table.no_smooth_flag then

            unilib.awards.register_achievement({
                name = "unilib_stonecutter_select_" .. part_name,
                trigger_table = {
                    prototype = "unilib_break",
                    target = 250,
                    item_list = {"unilib:stone_" .. part_name},
                },

                title = unilib.utils.brackets(S("Lithophile"), data_table.description),
                description = unilib.utils.brackets(
                    S("Break 250 smooth stone blocks"), data_table.description
                ),
                score = 10,
                vocation_list = {unilib.pkg.award_stonecutter.vocation_name},
            })

            populate_lookup_table(part_name)
            stone_count = stone_count + 1

        end

    end

    -- Collector achievements (stone)
    local collect_list = {
        {S("Elite Stone Collector"), S("Break every type of stone"), 100, stone_count},
        {S("Amateur Stone Collector"), S("Break 2 types of stone"), 10, 2},
        {S("Aspiring Stone Collector"), S("Break 5 types of stone"), 10, 5},
    }

    if stone_count >= 10 then
        table.insert(collect_list, {S("Novice Stone Collector"), S("Break 10 types of stone"), 10, 10})
    end

    if stone_count >= 20 then
        table.insert(collect_list, {S("Skilled Stone Collector"), S("Break 20 types of stone"), 10, 20})
    end

    if stone_count >= 30 then
        table.insert(collect_list, {S("Seasoned Stone Collector"), S("Break 30 types of stone"), 20, 30})
    end

    if stone_count >= 50 then
        table.insert(collect_list, {S("Master Stone Collector"), S("Break 50 types of stone"), 30, 50})
    end

    if stone_count >= 100 then
        table.insert(collect_list, {S("Grandmaster Stone Collector"), S("Break 100 types of stone"), 40, 100})
    end

    for i, mini_list in ipairs(collect_list) do

        unilib.awards.register_achievement({
            name = "unilib_stonecutter_collect_type_" .. i,
            trigger_table = {
                prototype = "stonecutter_collect_type",
                target = mini_list[4],
                item_list = all_group_list,
            },

            title = mini_list[1],
            description = mini_list[2],
            score = mini_list[3],
            vocation_list = {unilib.pkg.award_stonecutter.vocation_name},
        })

    end

    for i, mini_list in ipairs({
        {"intrusive", S("Intrusive Stone Collector"), S("Break 5 types of intrusive igneous stone"), 20, 5},
        {"extrusive", S("Extrusive Stone Collector"), S("Break 5 types of extrusive igneous stone"), 20, 5},
        {"sedimentary", S("Sedimentary Stone Collector"), S("Break 5 types of sedimentary stone"), 20, 5},
        {"metamorphic", S("Metamorphic Stone Collector"), S("Break 5 types of metamorphic stone"), 20, 5},
    }) do

        unilib.awards.register_achievement({
            name = "unilib_stonecutter_collect_" .. mini_list[1],
            trigger_table = {
                prototype = "stonecutter_collect_category",
                target = mini_list[5],
                item_list = all_group_list,
            },

            title = mini_list[2],
            description = mini_list[3],
            score = mini_list[4],
            vocation_list = {unilib.pkg.award_stonecutter.vocation_name},
        })

    end

    -- Combination achievements (clay/dirt/gravel/sand)
    for i, mini_list in ipairs({
        {"clay_1", "group:clay", S("Amateur Clay Pit Miner"), S("Break 25 clay blocks"), 10, 25},
        {"clay_2", "group:clay", S("Novice Clay Pit Miner"), S("Break 250 clay blocks"), 10, 250},
        {"clay_3", "group:clay", S("Skilled Clay Pit Miner"), S("Break 2500 clay blocks"), 20, 2500},
        {"clay_4", "group:clay", S("Veteran Clay Pit Miner"), S("Break 25000 clay blocks"), 50, 25000},

        -- N.B. Applies to simple dirt nodes, as well as dirt-with-turf nodes
        {"dirt_1", "group:soil", S("Amateur Earthworker"), S("Break 25 dirt blocks"), 10, 25},
        {"dirt_2", "group:soil", S("Novice Earthworker"), S("Break 250 dirt blocks"), 10, 250},
        {"dirt_3", "group:soil", S("Skilled Earthworker"), S("Break 2500 dirt blocks"), 20, 2500},
        {"dirt_4", "group:soil", S("Veteran Earthworker"), S("Break 25000 dirt blocks"), 50, 25000},

        {"gravel_1", "group:gravel", S("Amateur Aggregator"), S("Break 25 sand blocks"), 10, 25},
        {"gravel_2", "group:gravel", S("Novice Aggregator"), S("Break 250 sand blocks"), 10, 250},
        {"gravel_3", "group:gravel", S("Skilled Aggregator"), S("Break 2500 sand blocks"), 20, 2500},
        {"gravel_4", "group:gravel", S("Veteran Aggregator"), S("Break 25000 sand blocks"), 50, 25000},

        {"sand_1", "group:sand", S("Amateur Beachcomber"), S("Break 25 sand blocks"), 10, 25},
        {"sand_2", "group:sand", S("Novice Beachcomber"), S("Break 250 sand blocks"), 10, 250},
        {"sand_3", "group:sand", S("Skilled Beachcomber"), S("Break 2500 sand blocks"), 20, 2500},
        {"sand_4", "group:sand", S("Veteran Beachcomber"), S("Break 25000 sand blocks"), 50, 25000},
    }) do

        unilib.awards.register_achievement({
            name = "unilib_stonecutter_comb_" .. mini_list[1],
            trigger_table = {
                prototype = "unilib_break",
                target = mini_list[6],
                item_list = unilib.utils.convert_to_list(mini_list[2]),
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_stonecutter.vocation_name},
        })

    end

end
