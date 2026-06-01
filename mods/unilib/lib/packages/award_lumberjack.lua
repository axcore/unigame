---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_lumberjack = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Reverse lookup tables. Keys are the full_name of a tree trunk or sapling; the corresponding value
--      is the tree type (a key in unilib.global.tree_table)
local trunk_lookup_table = {}
local sapling_lookup_table = {}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_lumberjack.vocation_name = "unilib_lumberjack"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function populate_lookup_tables(tree_type)

    -- Populate the lookup table with each variety of tree node, regardless of whether it actually
    --      exists for the specified "tree_type" or not
    -- (N.B. Because of the check for .incomplete_flag below, both the trunk and sapling nodes
    --      will almost certainly exist)
    trunk_lookup_table["unilib:tree_" .. tree_type] = tree_type
    sapling_lookup_table["unilib:tree_" .. tree_type .. "_sapling"] = tree_type

end

local function on_collect(player, full_name)

    if not unilib.utils.is_player(player) or full_name == nil then
        return
    end

    if trunk_lookup_table[full_name] ~= nil then

        local tree_type = trunk_lookup_table[full_name]
        unilib.awards.handle_collection_trigger(
            player, "lumberjack_collect_trunk", "unilib_lumberjack_collect_trunk_1", tree_type
        )

    elseif sapling_lookup_table[full_name] ~= nil then

        local tree_type = sapling_lookup_table[full_name]
        unilib.awards.handle_collection_trigger(
            player, "lumberjack_collect_sapling", "unilib_lumberjack_collect_sapling_1", tree_type
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_lumberjack.init()

    return {
        description = "Awards for cutting down/growing trees (\"Lumberjack\")",
        notes = "Assumes a world with at least 5 types of tree (there are 5 in minetest_game)," ..
                " each providing tree trunks, planks, leaves, saplings and fences/gates",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.award_lumberjack.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "lumberjack_collect_trunk",
        trigger_type = "custom",
        hint_list = {"Chop one type of tree trunk", "Chop @1 types of tree trunk"},
        progress_list = {"Chop one type of tree trunk", "Chop @1/@2 types of tree trunk"},
    })

    unilib.awards.register_trigger_prototype({
        name = "lumberjack_collect_sapling",
        trigger_type = "custom",
        hint_list = {"Plant one category of tree sapling", "Plant @1 categories of tree sapling"},
        progress_list = {"Plant one category of tree sapling", "Plant @1/@2 categories of tree sapling"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    core.register_on_dignode(function(pos, oldnode, digger)
        on_collect(digger, oldnode.name)
    end)

    -- Vocations ----------------------------------------------------------------------------------

    -- Assumes at least 5 tree types (as in minetest_game), giving a minimum total score of 760
    unilib.awards.register_vocation({
        name = unilib.pkg.award_lumberjack.vocation_name,

        title = S("Lumberjack"),
        description = S("He sleeps all night and he works all day"),
        icon = "unilib_award_vocation_lumberjack.png",
        level_list = {
            {title = S("Wood You Look At That"), score = 10},
            {title = S("Sapling Dropper"), score = 20},
            {title = S("Bud Spreader"), score = 40},
            {title = S("Branch Manager"), score = 60},
            {title = S("Stick With It"), score = 100},
            {title = S("Log-istical Nightmare"), score = 150},
            {title = S("Rewilding Enthusiast"), score = 200},
            {title = S("Woody Woodpecker"), score = 300},
            {title = S("Tree-mendous Effort"), score = 400},
            {title = S("Friend of the Squirrels"), score = 500},
            {title = S("Old Man of the Trees"), score = 600},
            {title = S("The Logfather"), score = 750},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    local stick_list = {"unilib:item_stick_ordinary", "default:stick"}

    local comb_list = {
        {"trunk_1", "group:tree", "unilib_break", S("Amateur Logger"), S("Chop 25 tree trunks"), 10, 25},
        {"trunk_2", "group:tree", "unilib_break", S("Novice Logger"), S("Chop 250 tree trunks"), 20, 250},
        {"trunk_3", "group:tree", "unilib_break", S("Skilled Logger"), S("Chop 2500 tree trunks"), 30, 2500},
        {"trunk_4", "group:tree", "unilib_break", S("Veteran Logger"), S("Chop 25,000 tree trunks"), 50, 25000},

        {"wood_1", "group:wood", "unilib_craft", S("Amateur De-Barker"), S("Craft 25 wood planks"), 10, 25},
        {"wood_2", "group:wood", "unilib_craft", S("Skilled De-Barker"), S("Craft 250 wood planks"), 20, 250},
        {"wood_3", "group:wood", "unilib_craft", S("Veteran De-Barker"), S("Craft 2500 wood planks"), 30, 2500},

        {"leaves_1", "group:leaves", "unilib_break", S("Amateur Tree Pruner"), S("Clear 25 tree/bush leaves"), 10, 25},
        {"leaves_2", "group:leaves", "unilib_break", S("Skilled Tree Pruner"), S("Clear 250 tree/bush leaves"), 20, 250},
        {"leaves_3", "group:leaves", "unilib_break", S("Veteran Tree Pruner"), S("Clear 2500 tree/bush leaves"), 30, 2500},

        {"sapling_1", "group:sapling", "unilib_place", S("Amateur Tree Planter"), S("Place 25 tree/bush saplings"), 10, 25},
        {"sapling_2", "group:sapling", "unilib_place", S("Skilled Tree Planter"), S("Place 250 tree/bush saplings"), 20, 250},
        {"sapling_3", "group:sapling", "unilib_place", S("Veteran Tree Planter"), S("Place 2500 tree/bush saplings"), 30, 2500},

        {"fence_craft_1", "group:fence", "unilib_craft", S("Amateur Fencer"), S("Craft 25 fences, rails and gates"), 10, 25},
        {"fence_craft_2", "group:fence", "unilib_craft", S("Skilled Fencer"), S("Craft 250 fences, rails and gates"), 20, 250},
        {"fence_craft_3", "group:fence", "unilib_craft", S("Veteran Fencer"), S("Craft 2500 fences, rails and gates"), 30, 2500},

        {"fence_place_1", "group:fence", "unilib_place", S("Amateur Post Setter"), S("Place 25 fences, rails and gates"), 10, 25},
        {"fence_place_2", "group:fence", "unilib_place", S("Skilled Post Setter"), S("Place 250 fences, rails and gates"), 20, 250},
        {"fence_place_3", "group:fence", "unilib_place", S("Veteran Post Setter"), S("Place 2500 fences, rails and gates"), 30, 2500},
    }

    if unilib.global.pkg_executed_table["item_stick_ordinary"] ~= nil then

        table.insert(comb_list, {"stick_1", stick_list, "unilib_craft", S("Amateur Stick Collector"), S("Craft 25 sticks"), 10, 25})
        table.insert(comb_list, {"stick_2", stick_list, "unilib_craft", S("Skilled Stick Collector"), S("Craft 250 sticks"), 10, 250})
        table.insert(comb_list, {"stick_3", stick_list, "unilib_craft", S("Veteran Stick Collector"), S("Craft 2500 sticks"), 20, 2500})
        table.insert(comb_list, {"stick_4", stick_list, "unilib_craft", S("Veteran Stick Collector"), S("Craft 25,000 sticks"), 20, 25000})

    end

    for i, mini_list in ipairs(comb_list) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unilib_lumberjack_comb_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_lumberjack.vocation_name},
            })

        end

    end

    -- Selective achievements
    local tree_count = 0
    for part_name, data_table in pairs(unilib.global.tree_table) do

        if not data_table.incomplete_flag then

            unilib.awards.register_achievement({
                name = "unilib_lumberjack_select_trunk_" .. part_name,
                trigger_table = {
                    prototype = "unilib_break",
                    target = 250,
                    item_list = {"unilib:tree_" .. part_name},
                },

                title = unilib.utils.brackets(S("Timberman"), data_table.description),
                description = unilib.utils.brackets(
                    S("Break 250 tree trunks"), data_table.description
                ),
                score = 10,
                vocation_list = {unilib.pkg.award_lumberjack.vocation_name},
            })

            unilib.awards.register_achievement({
                name = "unilib_lumberjack_select_sapling_" .. part_name,
                trigger_table = {
                    prototype = "unilib_place",
                    target = 250,
                    item_list = {"unilib:tree_" .. part_name .. "_sapling"},
                },

                title = unilib.utils.brackets(S("Arboriculturist"), data_table.description),
                description = unilib.utils.brackets(
                    S("Plant 250 tree saplings"), data_table.description
                ),
                score = 10,
                vocation_list = {unilib.pkg.award_lumberjack.vocation_name},
            })

            populate_lookup_tables(part_name)
            tree_count = tree_count + 1

        end

    end

    -- Collector achievements
    local trunk_list = {
        {"lumberjack_collect_trunk", S("Elite Tree Trunk Collector"), S("Chop every type of tree trunk"), 100, tree_count},
        {"lumberjack_collect_trunk", S("Amateur Tree Trunk Collector"), S("Chop 2 types of tree trunk"), 10, 2},
        {"lumberjack_collect_trunk", S("Aspiring Tree Trunk Collector"), S("Chop 5 types of tree trunk"), 10, 5},
    }

    local sapling_list = {
        {"lumberjack_collect_sapling", S("Elite Tree Sapling Collector"), S("Plant every type of tree sapling"), 100, tree_count},
        {"lumberjack_collect_sapling", S("Amateur Tree Sapling Collector"), S("Plant 2 types of tree sapling"), 10, 2},
        {"lumberjack_collect_sapling", S("Aspiring Tree Sapling Collector"), S("Plant 5 types of tree sapling"), 10, 2},
    }

    if tree_count >= 10 then

        table.insert(trunk_list, {"lumberjack_collect_trunk", S("Novice Tree Trunk Collector"), S("Chop 10 types of tree trunk"), 10, 10})
        table.insert(sapling_list, {"lumberjack_collect_sapling", S("Novice Tree Sapling Collector"), S("Plant 5 types of tree sapling"), 10, 10})

    end

    if tree_count >= 20 then

        table.insert(trunk_list, {"lumberjack_collect_trunk", S("Skilled Tree Trunk Collector"), S("Chop 20 types of tree trunk"), 10, 20})
        table.insert(sapling_list, {"lumberjack_collect_sapling", S("Skilled Tree Sapling Collector"), S("Plant 5 types of tree sapling"), 10, 20})

    end

    if tree_count >= 30 then

        table.insert(trunk_list, {"lumberjack_collect_trunk", S("Seasoned Tree Trunk Collector"), S("Chop 30 types of tree trunk"), 20, 30})
        table.insert(sapling_list, {"lumberjack_collect_sapling", S("Seasoned Tree Sapling Collector"), S("Plant 5 types of tree sapling"), 20, 30})

    end

    if tree_count >= 50 then

        table.insert(trunk_list, {"lumberjack_collect_trunk", S("Master Tree Trunk Collector"), S("Chop 50 types of tree trunk"), 30, 50})
        table.insert(sapling_list, {"lumberjack_collect_sapling", S("Master Tree Sapling Collector"), S("Plant 5 types of tree sapling"), 30, 50})

    end

    if tree_count >= 100 then

        table.insert(trunk_list, {"lumberjack_collect_trunk", S("Grandmaster Tree Trunk Collector"), S("Chop 100 types of tree trunk"), 40, 100})
        table.insert(sapling_list, {"lumberjack_collect_sapling", S("Grandmaster Tree Sapling Collector"), S("Plant 100 types of tree sapling"), 40, 100})

    end

    for i, mini_list in ipairs(trunk_list) do

        unilib.awards.register_achievement({
            name = "unilib_lumberjack_collect_trunk_" .. i,
            trigger_table = {
                prototype = mini_list[1],
                target = mini_list[5],
                item_list = {"group:tree"},
            },

            title = mini_list[2],
            description = mini_list[3],
            score = mini_list[4],
            vocation_list = {unilib.pkg.award_lumberjack.vocation_name},
        })

    end

    for i, mini_list in ipairs(sapling_list) do

        unilib.awards.register_achievement({
            name = "unilib_lumberjack_collect_sapling_" .. i,
            trigger_table = {
                prototype = mini_list[1],
                target = mini_list[5],
                item_list = {"group:sapling"},
            },

            title = mini_list[2],
            description = mini_list[3],
            score = mini_list[4],
            vocation_list = {unilib.pkg.award_lumberjack.vocation_name},
        })

    end

end
