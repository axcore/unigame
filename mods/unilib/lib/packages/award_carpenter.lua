---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_carpenter = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Compiled lists/tables of items
local basic_tree_list = {"acacia", "apple", "aspen", "jungle", "pine"}
-- From "furniture_basic"
local basic_bench_list = {}
local basic_cabinet_list = {}
local basic_chair_list = {}
local basic_table_list = {}
local basic_comb_list = {}
-- From other packages
local bookshelf_list = {}
local utility_list = {}
local vessel_list = {}
local ordinary_bed_list = {}
local fancy_bed_list = {}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_carpenter.vocation_name = "unilib_carpenter"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function compile_items()

    -- (From the "furniture_basic") pkg)
    for _, tree_type in ipairs(basic_tree_list) do

        local bench = "unilib:furniture_bench_basic_" .. tree_type
        local cabinet = "unilib:furniture_cabinet_basic_" .. tree_type
        local chair = "unilib:furniture_chair_basic_" .. tree_type
        local dining_table = "unilib:furniture_table_dining_basic_" .. tree_type
        local end_table = "unilib:furniture_table_end_basic_" .. tree_type

        table.insert(basic_bench_list, bench)
        table.insert(basic_cabinet_list, cabinet)
        table.insert(basic_chair_list, chair)
        table.insert(basic_table_list, dining_table)
        table.insert(basic_table_list, end_table)

        table.insert(basic_comb_list, bench)
        table.insert(basic_comb_list, cabinet)
        table.insert(basic_comb_list, chair)
        table.insert(basic_comb_list, dining_table)
        table.insert(basic_comb_list, end_table)

    end

    for tree_type, _ in pairs(unilib.global.super_tree_table) do

        table.insert(bookshelf_list, "unilib:furniture_shelf_bookshelf_" .. tree_type)
        table.insert(utility_list, "unilib:furniture_shelf_utility_" .. tree_type)
        table.insert(vessel_list, "unilib:furniture_shelf_vessel_" .. tree_type)

    end

    table.insert(ordinary_bed_list, "unilib:bed_ordinary_bottom")
    table.insert(fancy_bed_list, "unilib:bed_fancy_bottom")

    -- N.B. "red" not included in the packages "bed_ordinary_quilt", "bed_fancy_quilt"
    for _, colour in ipairs({
        "black", "blue", "brown", "cyan", "green", "green_dark", "grey_dark", "magenta", "orange",
        "pink", "violet", "white", "yellow"
    }) do

        table.insert(ordinary_bed_list, "unilib:bed_ordinary_quilt_" .. colour .. "_bottom")
        table.insert(fancy_bed_list, "unilib:bed_fancy_quilt_" .. colour .. "_bottom")

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_carpenter.init()

    return {
        description = "Awards for making furniture (\"Carpenter\")",
        optional = {
            "furniture_basic",
            "furniture_shelf_bookshelf",
            "furniture_shelf_utility",
            "furniture_shelf_vessel",
            "shared_beds",
        },
    }

end

function unilib.pkg.award_carpenter.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Setup --------------------------------------------------------------------------------------

    -- N.B. There are no registers of furniture items, so we have to compile our own
    compile_items()

    -- Vocations ----------------------------------------------------------------------------------

    -- Assumes that the "furniture_basic" package is loaded, and that minetest_game furnitures/beds
    --      are available (total score 410)
    unilib.awards.register_vocation({
        name = unilib.pkg.award_carpenter.vocation_name,

        title = S("Carpenter"),
        description = S("Craft various beds and items of furniture"),
        icon = "unilib_award_vocation_carpenter.png",
        level_list = {
            {title = S("Flat-Pack Fumbler"), score = 10},
            {title = S("Bedtime Beginner"), score = 20},
            {title = S("Sofa, So Good"), score = 40},
            {title = S("Cabinet Habit"), score = 60},
            {title = S("Turning the Tables"), score = 90},
            {title = S("Chair Force One"), score = 120},
            {title = S("Couch Potato Farmer"), score = 150},
            {title = S("The Furnish-ing Touch"), score = 200},
            {title = S("Joiner of the Pack"), score = 250},
            {title = S("Master of Bedtime Stories"), score = 300},
            {title = S("The Lord of the Springs"), score = 350},
            {title = S("Sofa King"), score = 400},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    local furnish_list = {}

    if unilib.global.pkg_executed_table["furniture_basic"] ~= nil then

        table.insert(furnish_list, {"bench_maker_1", basic_bench_list, S("Amateur Bench Maker"), S("Craft 3 basic benches"), 10, 3})
        table.insert(furnish_list, {"cabinet_maker_1", basic_cabinet_list, S("Amateur Cabinet Maker"), S("Craft 3 basic cabinets"), 10, 3})
        table.insert(furnish_list, {"chair_maker_1", basic_chair_list, S("Amateur Chair Maker"), S("Craft 3 basic chairs"), 10, 3})
        table.insert(furnish_list, {"table_maker_1", basic_table_list, S("Amateur Table Maker"), S("Craft 3 basic tables"), 10, 3})

        table.insert(furnish_list, {"bench_maker_2", basic_bench_list, S("Competent Bench Maker"), S("Craft 30 basic benches"), 20, 30})
        table.insert(furnish_list, {"cabinet_maker_2", basic_cabinet_list, S("Competent Cabinet Maker"), S("Craft 30 basic cabinets"), 20, 30})
        table.insert(furnish_list, {"chair_maker_2", basic_chair_list, S("Competent Chair Maker"), S("Craft 30 basic chairs"), 20, 30})
        table.insert(furnish_list, {"table_maker_2", basic_table_list, S("Competent Table Maker"), S("Craft 30 basic tables"), 20, 30})

        table.insert(furnish_list, {"furniture_1", basic_comb_list, S("Skilled Furniture Maker"), S("Craft 35 basic furniture items"), 20, 35})
        table.insert(furnish_list, {"furniture_2", basic_comb_list, S("Veteran Furniture Maker"), S("Craft 350 basic furniture items"), 30, 350})

    end

    for _, mini_list in ipairs({
        -- cottages
        {"bench_simple", "unilib:furniture_bench_simple", S("Novice Bench Maker"), S("Craft 5 simple wooden benches"), 10, 5},
        {"shelf_rustic", "unilib:furniture_shelf_rustic", S("Amateur Shelf Maker"), S("Craft 5 rustic wooden shelves"), 10, 5},
        {"table_rustic", "unilib:furniture_table_rustic", S("Seasoned Table Maker"), S("Craft 5 rustic wooden tables"), 10, 5},
        -- darkage
        {"shelf_fancy", "unilib:furniture_shelf_fancy", S("Competent Shelf Maker"), S("Craft 5 fancy wooden shelves"), 10, 5},
        -- xdecor
        {"cabinet_simple", "unilib:furniture_cabinet_simple", S("Novice Cabinet Maker"), S("Craft 5 simple cabinets"), 10, 5},
        {"chair_simple", "unilib:furniture_chair_simple", S("Novice Chair Maker"), S("Craft 5 simple chairs"), 10, 5},
        {"table_simple", "unilib:furniture_table_simple", S("Novice Table Maker"), S("Craft 5 simple tables"), 10, 5},
    }) do

        if mini_list[2] == nil or core.registered_items[mini_list[2]] ~= nil then
            table.insert(furnish_list, mini_list)
        end

    end

    if unilib.global.pkg_executed_table["furniture_shelf_bookshelf"] ~= nil then

        table.insert(furnish_list, {"bookshelf_1", bookshelf_list, S("Amateur Bookshelf Maker"), S("Craft 5 bookshelves"), 10, 5})
        table.insert(furnish_list, {"bookshelf_2", bookshelf_list, S("Competent Bookshelf Maker"), S("Craft 25 bookshelves"), 20, 25})
        table.insert(furnish_list, {"bookshelf_3", bookshelf_list, S("Skilled Bookshelf Maker"), S("Craft 250 bookshelves"), 30, 250})

    end

    if unilib.global.pkg_executed_table["furniture_shelf_utility"] ~= nil then

        table.insert(furnish_list, {"utility_1", utility_list, S("Amateur Utility Shelf Maker"), S("Craft 5 utility shelves"), 10, 5})
        table.insert(furnish_list, {"utility_2", utility_list, S("Competent Utility Shelf Maker"), S("Craft 25 utility shelves"), 20, 25})
        table.insert(furnish_list, {"utility_3", utility_list, S("Skilled Utility Shelf Maker"), S("Craft 250 utility shelves"), 30, 250})

    end

    if unilib.global.pkg_executed_table["furniture_shelf_vessel"] ~= nil then

        table.insert(furnish_list, {"vessel_1", vessel_list, S("Amateur Vessel Shelf Maker"), S("Craft 5 vessel shelves"), 10, 5})
        table.insert(furnish_list, {"vessel_2", vessel_list, S("Competent Vessel Shelf Maker"), S("Craft 25 vessel shelves"), 20, 25})
        table.insert(furnish_list, {"vessel_3", vessel_list, S("Skilled Vessel Shelf Maker"), S("Craft 250 vessel shelves"), 30, 250})

    end

    if unilib.global.pkg_executed_table["shared_beds"] ~= nil then

        table.insert(furnish_list, {"bed_1", ordinary_bed_list, S("Amateur Bed Maker"), S("Craft 5 ordinary beds"), 10, 5})
        table.insert(furnish_list, {"bed_2", ordinary_bed_list, S("Novice Bed Maker"), S("Craft 25 ordinary beds"), 10, 25})
        table.insert(furnish_list, {"bed_3", fancy_bed_list, S("Competent Bed Maker"), S("Craft 5 fancy beds"), 20, 5})
        table.insert(furnish_list, {"bed_4", fancy_bed_list, S("Skilled Bed Maker"), S("Craft 25 fancy beds"), 20, 25})

    end

    for i, mini_list in ipairs(furnish_list) do

        unilib.awards.register_achievement({
            name = "unilib_carpenter_comb_" .. mini_list[1],
            trigger_table = {
                prototype = "unilib_craft",
                target = mini_list[6],
                item_list = unilib.utils.convert_to_list(mini_list[2]),
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_carpenter.vocation_name},
        })

    end

end
