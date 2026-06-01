---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_botanist = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Lists and lookup tables for the flowers, mushrooms and plants used in this package's achievements
local flower_compat_list = {}
local flower_lookup_table = {}
local mushroom_compat_list = {}
local mushroom_lookup_table = {}
local plant_compat_list = {}
local plant_lookup_table = {}

-- Achievements for a small number of individual flowers, mushrooms and plants
-- Items can be added or removed from this list; as appropriate. Any items that don't exist in the
--      world are removed automatically
-- mini_lists in the form
--      [partial_achievement_name, full_name, title, description, target]
local selected_list = {
    -- (mtgame flowers)
    {"chrysanthemum_green", "unilib:flower_chrysanthemum_green", S("Mum's the Word"), S("Pick 18 green chrysanthemums"), 18},
    {"dandelion_yellow", "unilib:flower_dandelion_yellow", S("Blow and Behold"), S("Pick 10 yellow dandelions"), 10},
    {"dandelion_white", "unilib:flower_dandelion_white", S("Wishmaker"), S("Pick 10 white dandelions"), 10},
    {"geranium_blue", "unilib:flower_geranium_blue", S("Geranium Grabber"), S("Pick 22 blue geraniums"), 22},
    {"viola_purple", "unilib:flower_viola_purple", S("Colourful Crescendo"), S("Pick 13 purple viola flowers"), 13},
    {"rose_red", "unilib:flower_rose_red", S("Rosy Outlook"), S("Pick 12 red roses"), 12},
    {"tulip_black", "unilib:flower_tulip_black", S("Tulip Mania"), S("Pick 15 black tulips"), 15},
    {"tulip_orange", "unilib:flower_tulip_orange", S("Tiptoe Through the Tulips"), S("Pick 15 orange tulips"), 15},
    -- (mtgame mushrooms)
    {"mushroom_brown", "unilib:mushroom_brown", S("Fungus Among Us"), S("Pick 25 brown mushrooms"), 25},
    {"mushroom_red", "unilib:mushroom_red", S("Spore Explorer"), S("Pick 25 red mushrooms"), 25},
    -- (mtgame plants)
    {"cactus_ordinary", "unilib:plant_cactus_ordinary", S("Prickly Business"), S("Pick 30 ordinary cactus block"), 30},
    {"kelp_ordinary", "unilib:plant_kelp_ordinary", S("Kelp Yourself"), S("Pick 50 ordinary kelp"), 50},
    {"papyrus_ordinary", "unilib:plant_papyrus_ordinary", S("Scribe of the Ancients"), S("Pick 50 ordinary papyrus"), 50},
    {"shrub_dry", "unilib:plant_shrub_dry", S("Desert Cleanup Crew"), S("Pick 111 dry shrubs"), 111},
    -- (bakedclay flowers)
    {"delphinium_blue", "unilib:flower_delphinium_blue", S("Florist Gump"), S("Pick 15 blue delphiniums"), 15},
    {"lazarus_bell", "unilib:flower_lazarus_bell", S("Saved by the Bell"), S("Pick 13 lazarus bells"), 13},
    {"thistle", "unilib:flower_thistle", S("Thisle While You Work"), S("Pick 11 thistle flowers"), 11},
    -- (bakedclay plants)
    {"reed_mannagrass", "unilib:grass_reed_mannagrass", S("The Grass Is Always Greener"), S("Pick 31 reed mannagrass"), 31},
}

-- Exclude any unsuitable items by adding them (as keys) to the tables below. Items in the
--      "not_in_creative_inventory" group are automatically excluded
-- For the "mtgame" remix, this leaves 9 flowers, 2 mushrooms and 4 plants
-- For all packages combined (as of v1.2.0), there are approximately 215 flowers, 60 mushrooms and
--      140 plants
local flower_exclude_table = {
    ["unilib:flower_dandelion_yellow_cluster"] = true,
    ["unilib:flower_dandelion_white_cluster"] = true,
    ["unilib:flower_geranium_blue_cluster"] = true,
    ["unilib:flower_rose_black_cluster"] = true,
    ["unilib:flower_rose_red_cluster"] = true,
}
local mushroom_exclude_table = {}
local plant_exclude_table = {
    ["unilib:plant_bush_underground_dead"] = true,
    ["unilib:plant_cactus_exotic_seed"] = true,
    ["unilib:plant_cactus_ordinary_seed"] = true,
    ["unilib:plant_fungus_beefsteak_cooked"] = true,
    ["unilib:plant_fungus_honey_cooked"] = true,
    ["unilib:plant_fungus_nightlight_cooked"] = true,
    ["unilib:plant_fungus_pingpong_bats_cooked"] = true,
    ["unilib:plant_palm_mangrove_leaf_bottom"] = true,
    ["unilib:plant_palm_mangrove_leaf_top"] = true,
    ["unilib:plant_palm_mangrove_trunk"] = true,
    ["unilib:plant_shrub_dead"] = true,
    ["unilib:plant_weed_dead"] = true,
}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_botanist.vocation_name = "unilib_botanist"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function compile_items()

    for full_name, _ in pairs(core.registered_nodes) do

        if core.get_item_group(full_name, "not_in_creative_inventory") == 0 then

            -- For unilib items, we can be picky about the item's name; for non-unilib items, just
            --      accept them as they come
            local mod_name = unilib.utils.get_mod_name(full_name)
            local first_component = unilib.utils.get_first_component(full_name)
            local last_component = tonumber(unilib.utils.get_last_component(full_name))

            local flower_group = core.get_item_group(full_name, "flower")
            local mushroom_group = core.get_item_group(full_name, "mushroom")
            -- N.B. Plants don't have a "plant" group, unfortunately

            if flower_group > 0 and
                    (mod_name ~= "unilib" or first_component == "flower") and
                    flower_exclude_table[full_name] == nil then

                table.insert(flower_compat_list, full_name)
                flower_lookup_table[full_name] = true

            elseif mushroom_group > 0 and
                    (mod_name ~= "unilib" or first_component == "mushroom") and
                    mushroom_exclude_table[full_name] == nil then

                table.insert(mushroom_compat_list, full_name)
                mushroom_lookup_table[full_name] = true

            -- Because plants don't have an identifying group, just do the best we can - use any
            --      unilib item with the "plant" category, but don't use any with growth stages
            --      (i.e. "last_component" is a number)
            elseif mod_name == "unilib" and
                    first_component == "plant" and
                    last_component == nil and
                    plant_exclude_table[full_name] == nil then

                table.insert(plant_compat_list, full_name)
                plant_lookup_table[full_name] = true

            end

        end

    end

end

local function on_collect(player, full_name)

    if not unilib.utils.is_player(player) or full_name == nil then
        return
    end

    if flower_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "botanist_collect_flower", "unilib_botanist_collect_flower_1", full_name
        )

    elseif mushroom_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "botanist_collect_mushroom", "unilib_botanist_collect_mushroom_1", full_name
        )

    elseif plant_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "botanist_collect_plant", "unilib_botanist_collect_plant_1", full_name
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_botanist.init()

    return {
        description = "Awards for collecting flowers, mushrooms and plants (\"Botanist\")",
        notes = "Assumes a world containing at least as many flowers, mushrooms and plants as" ..
                " minetest_game",
    }

end

function unilib.pkg.award_botanist.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Setup --------------------------------------------------------------------------------------

    -- N.B. There are no registers of flowers, mushrooms and plants, so we have to compile our own
    compile_items()

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "botanist_collect_flower",
        trigger_type = "custom",
        hint_list = {"Pick one type of flower", "Pick @1 types of flower"},
        progress_list = {"Pick one type of flower", "Pick @1/@2 types of flower"},
    })

    unilib.awards.register_trigger_prototype({
        name = "botanist_collect_mushroom",
        trigger_type = "custom",
        hint_list = {"Pick one type of mushroom", "Pick @1 types of mushroom"},
        progress_list = {"Pick one type of mushroom", "Pick @1/@2 types of mushroom"},
    })

    unilib.awards.register_trigger_prototype({
        name = "botanist_collect_plant",
        trigger_type = "custom",
        hint_list = {"Pick one type of plant", "Pick @1 types of plant"},
        progress_list = {"Pick one type of plant", "Pick @1/@2 types of plant"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    core.register_on_dignode(function(pos, oldnode, digger)
        on_collect(digger, oldnode.name)
    end)

    -- Vocations ----------------------------------------------------------------------------------

    -- Assumes at least the "mtgame" remix (or something better), providing 9 flowers, 2 mushrooms
    --      and 4 plants for a score of 1090
    unilib.awards.register_vocation({
        name = unilib.pkg.award_botanist.vocation_name,

        title = S("Botanist"),
        description = S("Collect various flowers, mushrooms and plants"),
        icon = "unilib_award_vocation_botanist.png",
        level_list = {
            {title = S("Freshly Plucked"), score = 10},
            {title = S("Blooming Amateur"), score = 20},
            {title = S("Petal Pilferer"), score = 50},
            {title = S("Amateur Aromatherapist"), score = 100},
            {title = S("Leaf It To Me"), score = 200},
            {title = S("Thorny Problem"), score = 300},
            {title = S("A Fun Guy to Be With"), score = 400},
            {title = S("Petal to the Metal"), score = 500},
            {title = S("Shroom with a View"), score = 600},
            {title = S("The Spore the Merrier"), score = 700},
            {title = S("Rooted in Greatness"), score = 850},
            {title = S("Head Gardener"), score = 1050},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    for i, mini_list in ipairs({
        {"flower_break_1", "group:flower", "unilib_break", S("Amateur Florist"), S("Pick 10 flowers"), 10, 10},
        {"flower_break_2", "group:flower", "unilib_break", S("Novice Florist"), S("Pick 50 flowers"), 20, 50},
        {"flower_break_3", "group:flower", "unilib_break", S("Skilled Florist"), S("Pick 250 flowers"), 30, 250},
        {"flower_break_4", "group:flower", "unilib_break", S("Seasoned Florist"), S("Pick 1250 flowers"), 40, 1250},
        {"flower_break_5", "group:flower", "unilib_break", S("Veteran Florist"), S("Pick 6000 flowers"), 50, 6000},

        {"flower_place_1", "group:flower", "unilib_place", S("Amateur Gardener"), S("Place 10 flowers"), 10, 50},
        {"flower_place_2", "group:flower", "unilib_place", S("Novice Gardener"), S("Place 50 flowers"), 20, 50},
        {"flower_place_3", "group:flower", "unilib_place", S("Skilled Gardener"), S("Place 250 flowers"), 30, 250},
        {"flower_place_4", "group:flower", "unilib_place", S("Seasoned Gardener"), S("Place 1250 flowers"), 40, 1250},
        {"flower_place_5", "group:flower", "unilib_place", S("Veteran Gardener"), S("Place 6000 flowers"), 50, 6000},

        {"mushroom_break_1", "group:mushroom", "unilib_break", S("Amateur Mycologist"), S("Pick 10 mushrooms"), 10, 10},
        {"mushroom_break_2", "group:mushroom", "unilib_break", S("Novice Mycologist"), S("Pick 50 mushrooms"), 20, 50},
        {"mushroom_break_3", "group:mushroom", "unilib_break", S("Skilled Mycologist"), S("Pick 250 mushrooms"), 30, 250},
        {"mushroom_break_4", "group:mushroom", "unilib_break", S("Seasoned Mycologist"), S("Pick 1250 mushrooms"), 40, 1250},
        {"mushroom_break_5", "group:mushroom", "unilib_break", S("Veteran Mycologist"), S("Pick 6000 mushrooms"), 50, 6000},

        {"plant_break_1", plant_compat_list, "unilib_break", S("Amateur Horticulturist"), S("Pick 10 plants"), 10, 10},
        {"plant_break_2", plant_compat_list, "unilib_break", S("Novice Horticulturist"), S("Pick 50 plants"), 20, 50},
        {"plant_break_3", plant_compat_list, "unilib_break", S("Skilled Horticulturist"), S("Pick 250 plants"), 30, 250},
        {"plant_break_4", plant_compat_list, "unilib_break", S("Seasoned Horticulturist"), S("Pick 1250 plants"), 40, 1250},
        {"plant_break_5", plant_compat_list, "unilib_break", S("Veteran Horticulturist"), S("Pick 6000 plants"), 50, 6000},
    }) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unilib_botanist_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_botanist.vocation_name},
            })

        end

    end

    -- Selective achievements
    for _, mini_list in ipairs(selected_list) do

        -- mini_list in the form
        --      [partial_achievement_name, full_name, title, description, target]
        unilib.awards.register_achievement({
            name = "unilib_botanist_select_" .. mini_list[1],
            trigger_table = {
                prototype = "unilib_break",
                target = mini_list[5],
                item_list = unilib.utils.convert_to_list(mini_list[2]),
            },

            title = mini_list[3],
            description = mini_list[4],
            score = 10,
            vocation_list = {unilib.pkg.award_botanist.vocation_name},
        })

    end

    -- Collector achievements
    local flower_count = #flower_compat_list
    local flower_list = {
        {S("Elite Flower Collector"), S("Pick every type of flower"), 100, flower_count},
        {S("Amateur Flower Collector"), S("Pick 2 types of flower"), 10, 2},
        {S("Aspiring Flower Collector"), S("Pick 5 types of flower"), 10, 5},
    }

    if flower_count >= 10 then
        table.insert(flower_list, {S("Novice Flower Collector"), S("Pick 10 types of flower"), 10, 10})
    end

    if flower_count >= 20 then
        table.insert(flower_list, {S("Skilled Flower Collector"), S("Pick 20 types of flower"), 10, 20})
    end

    if flower_count >= 30 then
        table.insert(flower_list, {S("Seasoned Flower Collector"), S("Pick 30 types of flower"), 20, 30})
    end

    if flower_count >= 50 then
        table.insert(flower_list, {S("Veteran Flower Collector"), S("Pick 50 types of flower"), 30, 50})
    end

    if flower_count >= 100 then
        table.insert(flower_list, {S("Master Flower Collector"), S("Pick 100 types of flower"), 40, 100})
    end

    if flower_count >= 200 then
        table.insert(flower_list, {S("Grandmaster Flower Collector"), S("Pick 200 types of flower"), 50, 200})
    end

    for i, mini_list in ipairs(flower_list) do

        unilib.awards.register_achievement({
            name = "unilib_botanist_collect_flower_" .. i,
            trigger_table = {
                prototype = "botanist_collect_flower",
                target = mini_list[4],
                item_list = {"group:flower"},
            },

            title = mini_list[1],
            description = mini_list[2],
            score = mini_list[3],
            vocation_list = {unilib.pkg.award_botanist.vocation_name},
        })

    end

    local mushroom_count = #mushroom_compat_list
    local mushroom_list = {
        {S("Elite Mushroom Collector"), S("Pick every type of mushroom"), 100, mushroom_count},
        {S("Amateur Mushroom Collector"), S("Pick 2 types of mushroom"), 10, 2},
    }

    if mushroom_count >= 5 then
        table.insert(mushroom_list, {S("Aspiring Mushroom Collector"), S("Pick 5 types of mushroom"), 10, 5})
    end

    if mushroom_count >= 10 then
        table.insert(mushroom_list, {S("Novice Mushroom Collector"), S("Pick 10 types of mushroom"), 10, 10})
    end

    if mushroom_count >= 20 then
        table.insert(mushroom_list, {S("Skilled Mushroom Collector"), S("Pick 20 types of mushroom"), 10, 20})
    end

    if mushroom_count >= 30 then
        table.insert(mushroom_list, {S("Seasoned Mushroom Collector"), S("Pick 30 types of mushroom"), 20, 30})
    end

    if mushroom_count >= 50 then
        table.insert(mushroom_list, {S("Veteran Mushroom Collector"), S("Pick 50 types of mushroom"), 30, 50})
    end

    if mushroom_count >= 100 then
        table.insert(mushroom_list, {S("Master Mushroom Collector"), S("Pick 100 types of mushroom"), 40, 100})
    end

    if mushroom_count >= 200 then
        table.insert(mushroom_list, {S("Grandmaster Mushroom Collector"), S("Pick 200 types of mushroom"), 50, 200})
    end

    for i, mini_list in ipairs(mushroom_list) do

        unilib.awards.register_achievement({
            name = "unilib_botanist_collect_mushroom_" .. i,
            trigger_table = {
                prototype = "botanist_collect_mushroom",
                target = mini_list[4],
                item_list = {"group:mushroom"},
            },

            title = mini_list[1],
            description = mini_list[2],
            score = mini_list[3],
            vocation_list = {unilib.pkg.award_botanist.vocation_name},
        })

    end

    local plant_count = #plant_compat_list
    local plant_list = {
        {S("Elite Plant Collector"), S("Pick every type of plant"), 100, plant_count},
        {S("Amateur Plant Collector"), S("Pick 2 types of plant"), 10, 2},
        {S("Aspiring Plant Collector"), S("Pick 5 types of plant"), 10, 5},
    }

    if plant_count >= 10 then
        table.insert(plant_list, {S("Novice Plant Collector"), S("Pick 10 types of plant"), 10, 10})
    end

    if plant_count >= 20 then
        table.insert(plant_list, {S("Skilled Plant Collector"), S("Pick 20 types of plant"), 10, 20})
    end

    if plant_count >= 30 then
        table.insert(plant_list, {S("Seasoned Plant Collector"), S("Pick 30 types of plant"), 20, 30})
    end

    if plant_count >= 50 then
        table.insert(plant_list, {S("Veteran Plant Collector"), S("Pick 50 types of plant"), 30, 50})
    end

    if plant_count >= 100 then
        table.insert(plant_list, {S("Master Plant Collector"), S("Pick 100 types of plant"), 40, 100})
    end

    if plant_count >= 200 then
        table.insert(plant_list, {S("Grandmaster Plant Collector"), S("Pick 200 types of plant"), 50, 200})
    end

    for i, mini_list in ipairs(plant_list) do

        unilib.awards.register_achievement({
            name = "unilib_botanist_collect_plant_" .. i,
            trigger_table = {
                prototype = "botanist_collect_plant",
                target = mini_list[4],
                item_list = plant_compat_list,
            },

            title = mini_list[1],
            description = mini_list[2],
            score = mini_list[3],
            vocation_list = {unilib.pkg.award_botanist.vocation_name},
        })

    end

end
