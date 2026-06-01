---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_gourmand = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Compiled lists/tables of items
local food_compat_list = {}
local food_lookup_table = {}
local drink_compat_list = {}
local drink_lookup_table = {}

-- Achievements for a small number of foods and drinks
-- Items can be added or removed from this list; as appropriate. Any items that don't exist in the
--      world are removed automatically
-- mini_lists in the form
--      [partial_achievement_name, full_name, title, description, target]
local selected_list = {
    {"mushroom_brown", "unilib:mushroom_brown", S("Spore Loser"), S("Eat 25 brown mushrooms"), 10, 25},
    {"mushroom_red", "unilib:mushroom_red", S("Toxic Taste Tester"), S("Eat 5 red mushrooms"), 10, 5},
    {"fruit_apple", "unilib:fruit_apple", S("An Apple a Day"), S("Eat 44 ordinary apples"), 10, 44},
    {"food_bread_ordinary", "unilib:food_bread_ordinary", S("Bready or Not, Here I Crumb"), S("Eat 33 ordinary breads"), 10, 33},
    {"fruit_blueberry_ordinary", "unilib:fruit_blueberry_ordinary", S("Berry the Evidence"), S("Eat 55 ordinary blueberries"), 10, 55},
}
-- Table of food/drink items which are excluded from most achievements, in the form
--      FULL_NAME = true
local excluded_table = {}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_gourmand.vocation_name = "unilib_gourmand"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function has_food_group(group_table)

    for group, _ in pairs(group_table) do

        if group == "food" or string.sub(group, 1, 5) == "food_" then
            return true
        end

    end

    return false

end

local function is_food(full_name, def_table)

    if core.get_item_group(full_name, "not_in_creative_inventory") == 0 and
            def_table.on_use ~= nil and
            def_table.groups ~= nil and
            has_food_group(def_table.groups) then
        return true
    else
        return false
    end

end

local function compile_items()

    -- Use all nodes/craftitems that have an .on_use function (which is hopefully
    --      unilib.cuisine.eat_on_use() or unilib.cuisine.drink_on_use() ), and which have at
    --      least one group in the form "food_X"
    for full_name, def_table in pairs(core.registered_nodes) do

        if core.get_item_group(full_name, "drink") > 0 then

            table.insert(drink_compat_list, full_name)
            drink_lookup_table[full_name] = true

        elseif is_food(full_name, def_table) then

            table.insert(food_compat_list, full_name)
            food_lookup_table[full_name] = true

        end

    end

    for full_name, def_table in pairs(core.registered_craftitems) do

        if core.get_item_group(full_name, "drink") > 0 then

            table.insert(drink_compat_list, full_name)
            drink_lookup_table[full_name] = true

        elseif is_food(full_name, def_table) then

            table.insert(food_compat_list, full_name)
            food_lookup_table[full_name] = true

        end

    end

    for full_name, _ in pairs(excluded_table) do

        food_lookup_table[full_name] = nil
        drink_lookup_table[full_name] = nil

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_gourmand.on_collect_food(player, full_name, old_size)

    -- Called by unilib.cuisine.eat_on_use()

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            full_name == nil or
            old_size == 0 then
        return
    end

    if food_lookup_table[full_name] ~= nil then

        -- N.B. If hunger is enabled (unilib.setting.hunger_enable_flag == true) and the player's
        --      satiation is at maximum, this function is called even though no item was consumed
        -- Filter out those events by allowing the engine to handle eating as normal, before
        --      checking the results
        core.after(0.1, function()

            local new_size = player:get_wielded_item():get_count()
            if new_size < old_size then

                unilib.awards.handle_collection_trigger(
                    player, "gourmand_collect_food", "unilib_gourmand_collect_food_1", full_name
                )

            end

        end)

    end

end

function unilib.pkg.award_gourmand.on_collect_drink(player, full_name, old_size)

    -- Called by unilib.cuisine.drink_on_use()

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            full_name == nil or
            old_size == 0 then
        return
    end

    if drink_lookup_table[full_name] ~= nil then

        -- N.B. If hunger is enabled (unilib.setting.hunger_enable_flag == true) and the player's
        --      satiation is at maximum, this function is called even though no item was consumed
        -- Filter out those events by allowing the engine to handle eating as normal, before
        --      checking the results
        core.after(0.1, function()

            local new_size = player:get_wielded_item():get_count()
            if new_size < old_size then

                unilib.awards.handle_collection_trigger(
                    player, "gourmand_collect_drink", "unilib_gourmand_collect_drink_1", full_name
                )

            end

        end)

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_gourmand.init()

    return {
        description = "Awards for eating and drinking things (\"Gourmand\")",
        notes = "Assumes a world containing at least as many food types as minetest_game; does" ..
                " not assume that the world contains at least one drink",
    }

end

function unilib.pkg.award_gourmand.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Setup --------------------------------------------------------------------------------------

    -- N.B. There are no registers of food and drink items, so we have to compile our own
    compile_items()

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "gourmand_collect_food",
        trigger_type = "custom",
        hint_list = {"Taste one type of food", "Taste @1 types of food"},
        progress_list = {"Taste one type of food", "Taste @1/@2 types of food"},
    })

    unilib.awards.register_trigger_prototype({
        name = "gourmand_collect_drink",
        trigger_type = "custom",
        hint_list = {"Sample one type of drink", "Sample @1 types of drink"},
        progress_list = {"Sample one type of drink", "Sample @1/@2 types of drink"},
    })

    -- Vocations ----------------------------------------------------------------------------------

    -- Assumes at least 5 food types but no drinks types (as in minetest_game), giving a minimum
    --      total score of 370
    unilib.awards.register_vocation({
        name = unilib.pkg.award_gourmand.vocation_name,

        title = S("Gourmand"),
        description = S("Eat and drink until you burst"),
        icon = "unilib_award_vocation_gourmand.png",
        level_list = {
            {title = S("The First Supper"), score = 10},
            {title = S("Slightly Peckish"), score = 20},
            {title = S("Bite Club"), score = 40},
            {title = S("Snack to the Future"), score = 60},
            {title = S("The Munch Bunch"), score = 80},
            {title = S("You Butter Believe it"), score = 120},
            {title = S("Gulp Fiction"), score = 160},
            {title = S("Nibbler on the Roof"), score = 200},
            {title = S("Thirst Responder"), score = 240},
            {title = S("Lord of the Fries"), score = 280},
            {title = S("Gastronaut"), score = 320},
            {title = S("Michelin Chef"), score = 370},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    for i, mini_list in ipairs({
        {"eat_1", food_compat_list, S("Amateur Gastronome"), S("Consume 25 foods"), 10, 25},
        {"eat_2", food_compat_list, S("Skilled Gastronome"), S("Consume 250 foods"), 20, 250},
        {"eat_3", food_compat_list, S("Seasoned Gastronome"), S("Consume 1000 foods"), 30, 1000},
        {"eat_4", food_compat_list, S("Veteran Gastronome"), S("Consume 2500 foods"), 40, 2500},

        {"drink_1", drink_compat_list, S("Amateur Sommelier"), S("Consume 25 drinks"), 10, 25},
        {"drink_2", drink_compat_list, S("Skilled Sommelier"), S("Consume 250 drinks"), 20, 250},
        {"drink_3", drink_compat_list, S("Seasoned Sommelier"), S("Consume 1000 drinks"), 30, 1000},
        {"drink_4", drink_compat_list, S("Veteran Sommelier"), S("Consume 2500 drinks"), 40, 2500},
    }) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unilib_gourmand_comb_" .. mini_list[1],
                trigger_table = {
                    prototype = "unilib_eat",
                    target = mini_list[6],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[3],
                description = mini_list[4],
                score = mini_list[5],
                vocation_list = {unilib.pkg.award_gourmand.vocation_name},
            })

        end

    end

    -- Selective achievements
    for _, mini_list in ipairs(selected_list) do

        if unilib.awards.check_argument(mini_list[2]) then

            -- mini_list in the form
            --      [partial_achievement_name, full_name, title, description, score, target]
            unilib.awards.register_achievement({
                name = "unilib_gourmand_select_" .. mini_list[1],
                trigger_table = {
                    prototype = "unilib_eat",
                    target = mini_list[6],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[3],
                description = mini_list[4],
                score = mini_list[5],
                vocation_list = {unilib.pkg.award_gourmand.vocation_name},
            })

        end

    end

    -- Collector achievements
    local food_count = #food_compat_list
    local food_list = {
        {S("Elite Taste Tester"), S("Taste every type of food"), 100, food_count},
        {S("Amateur Taste Tester"), S("Taste 2 types of food"), 10, 2},
        {S("Aspiring Taste Tester"), S("Taste 5 types of food"), 10, 5},
    }

    if food_count >= 10 then
        table.insert(food_list, {S("Novice Taste Tester"), S("Taste 10 types of food"), 10, 10})
    end

    if food_count >= 20 then
        table.insert(food_list, {S("Skilled Taste Tester"), S("Taste 20 types of food"), 10, 20})
    end

    if food_count >= 30 then
        table.insert(food_list, {S("Seasoned Taste Tester"), S("Taste 30 types of food"), 20, 30})
    end

    if food_count >= 50 then
        table.insert(food_list, {S("Veteran Taste Tester"), S("Taste 50 types of food"), 30, 50})
    end

    if food_count >= 100 then
        table.insert(food_list, {S("Master Taste Tester"), S("Taste 100 types of food"), 40, 100})
    end

    if food_count >= 200 then
        table.insert(food_list, {S("Grandmaster Taste Tester"), S("Taste 200 types of food"), 50, 200})
    end

    for i, mini_list in ipairs(food_list) do

        unilib.awards.register_achievement({
            name = "unilib_gourmand_collect_food_" .. i,
            trigger_table = {
                prototype = "gourmand_collect_food",
                target = mini_list[4],
                item_list = food_compat_list,
            },

            title = mini_list[1],
            description = mini_list[2],
            score = mini_list[3],
            vocation_list = {unilib.pkg.award_gourmand.vocation_name},
        })

    end

    local drink_count = #drink_compat_list
    if drink_count > 0 then

        local drink_list = {
            {S("Elite Guzzler"), S("Sample every type of drink"), 100, drink_count},
        }

        if drink_count >= 2 then
            table.insert(drink_list, {S("Amateur Guzzler"), S("Sample 2 types of drink"), 10, 2})
        end

        if drink_count >= 5 then
            table.insert(drink_list, {S("Aspiring Guzzler"), S("Sample 5 types of drink"), 10, 5})
        end

        if drink_count >= 10 then
            table.insert(drink_list, {S("Novice Guzzler"), S("Sample 10 types of drink"), 10, 10})
        end

        if drink_count >= 20 then
            table.insert(drink_list, {S("Skilled Guzzler"), S("Sample 20 types of drink"), 10, 20})
        end

        if drink_count >= 30 then
            table.insert(drink_list, {S("Seasoned Guzzler"), S("Sample 30 types of drink"), 20, 30})
        end

        if drink_count >= 50 then
            table.insert(drink_list, {S("Veteran Guzzler"), S("Sample 50 types of drink"), 30, 50})
        end

        if drink_count >= 100 then
            table.insert(drink_list, {S("Master Guzzler"), S("Sample 100 types of drink"), 40, 100})
        end

        if drink_count >= 200 then
            table.insert(drink_list, {S("Grandmaster Guzzler"), S("Sample 200 types of drink"), 50, 200})
        end

        for i, mini_list in ipairs(drink_list) do

            unilib.awards.register_achievement({
                name = "unilib_gourmand_collect_drink_" .. i,
                trigger_table = {
                    prototype = "gourmand_collect_drink",
                    target = mini_list[4],
                    item_list = drink_compat_list,
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_gourmand.vocation_name},
            })

        end

    end

end
