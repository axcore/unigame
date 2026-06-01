---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_farmer = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

local crate_list = {
    "unilib:container_crate_agave",
    "unilib:container_crate_asparagus_green",
    "unilib:container_crate_aubergine",
    "unilib:container_crate_beetroot_merlin",
    "unilib:container_crate_cabbage_brunswick",
    "unilib:container_crate_carrot_chantenay",
    "unilib:container_crate_cassava",
    "unilib:container_crate_corn_flint",
    "unilib:container_crate_cucumber_english",
    "unilib:container_crate_jute",
    "unilib:container_crate_mint_liquorice",
    "unilib:container_crate_onion_spanish",
    "unilib:container_crate_pepper_rocoto",
    "unilib:container_crate_potato_maris_piper",
    "unilib:container_crate_sisal",
    "unilib:container_crate_spinach",
    "unilib:container_crate_strawberry_gariguette",
    "unilib:container_crate_tomato_cherry",
}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_farmer.vocation_name = "unilib_farmer"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function refine_crate_list()

    local new_list = {}

    for _, full_name in ipairs(crate_list) do

        if core.registered_nodes[full_name] then
            table.insert(new_list, full_name)
        end

    end

    crate_list = new_list

end

local function refine_plant_list(mini_list)

    -- "mini_list" in the form
    --      (package_name, plant_full_name)
    -- Return a list of "plant_full_name" items from any "package_name" that has been loaded

    local return_list = {}

    for _, this_list in ipairs(mini_list) do

        if unilib.global.pkg_executed_table[this_list[1]] ~= nil then
            table.insert(return_list, this_list[2])
        end

    end

    return return_list

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_farmer.init()

    return {
        description = "Crop and produce awards (\"Farmer\")",
        notes = "Awards for harvesting crops and produce. Provides over 60 achievement sets for" ..
                " various types of crop/produce, representing most of the crop/produce packages" ..
                " available in unilib v1.2.0. Some similar crops/produce count towards the same" ..
                " achievements (e.g. all varieties of tomato count)",
    }

end

function unilib.pkg.award_farmer.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Setup code ---------------------------------------------------------------------------------

    refine_crate_list()

    -- Vocations ----------------------------------------------------------------------------------

    -- Assume 10 achievement sets each with a total score of 60 (not including 200 for the
    --      "combination achievements" set)
    local score_list = {10, 20, 50, 100, 150, 200, 300, 400, 500, 600, 700, 800}
    -- Assume 20 achievement sets each with a total score of 60
--  local score_list = {10, 20, 50, 100, 200, 300, 400, 600, 800, 1000, 1200, 1400}
    -- Assume 40 achievement sets each with a total score of 60
--  local score_list = {10, 20, 50, 100, 200, 400, 600, 800, 1000, 1500, 2000, 2600}

    unilib.awards.register_vocation({
        name = unilib.pkg.award_farmer.vocation_name,

        title = S("Farmer Sam"),
        description = S("Dig (crops) for victory!"),
        icon = "unilib_award_vocation_farmer.png",
        level_list = {
            {title = S("Born in the Mud"), score = score_list[1]},
            {title = S("Alarmed by the Roosters"), score = score_list[2]},
            {title = S("First-Time Tractor Driver"), score = score_list[3]},
            {title = S("Weed Whacker"), score = score_list[4]},
            {title = S("Rotten Tomato"), score = score_list[5]},
            {title = S("Potato Peeler"), score = score_list[6]},
            {title = S("Cotton Picker"), score = score_list[7]},
            {title = S("Pumpkin Carver"), score = score_list[8]},
            {title = S("Field Researcher"), score = score_list[9]},
            {title = S("Green Thumb"), score = score_list[10]},
            {title = S("Fencepost Philosopher"), score = score_list[11]},
            {title = S("Bought My Own Farm"), score = score_list[12]},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements (all crops/produce)
    for i, mini_list in ipairs({
        {S("Amateur Farmer"), S("Harvest a mature crop or produce"), 10, 1},
        {S("Novice Farmer"), S("Harvest 100 mature crops or produce"), 30, 100},
        {S("Skilled Farmer"), S("Harvest 1000 mature crops or produce"), 60, 1000},
        {S("Veteran Farmer"), S("Harvest 10000 mature crops or produce"), 100, 10000},
    }) do

        unilib.awards.register_achievement({
            name = "unilib_farmer_comb_harvest_" .. i,
            trigger_table = {
                prototype = "unilib_break",
                target = mini_list[4],
                item_list = {"group:harvestable"},
            },

            title = mini_list[1],
            description = mini_list[2],
            score = mini_list[3],
            vocation_list = {unilib.pkg.award_farmer.vocation_name},
        })

    end

    -- Combination achievements (crates)
    if #crate_list >= 3 then

        for i, mini_list in ipairs({
            {S("Amateur Crate Packer"), S("Craft 60 vegetable crates"), 10, 1},
            {S("Novice Crate Packer"), S("Craft 360 vegetable crates"), 20, 100},
            {S("Skilled Crate Packer"), S("Harvest 2160 vegetable crates"), 30, 1000},
            {S("Veteran Crate Packer"), S("Harvest 12960 vegetable crates"), 50, 10000},
        }) do

            unilib.awards.register_achievement({
                name = "unilib_farmer_comb_crate_" .. i,
                trigger_table = {
                    prototype = "unilib_craft",
                    target = mini_list[4],
                    item_list = crate_list,
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_farmer.vocation_name},
            })

        end

    end

    -- Combination achievements (selected crops/produce)
    -- Each group of achievements is only registered, if at least one of the specified packages has
    --      been loaded; if more than one has been loaded, all of their items count towards the
    --      achievement
    for _, mini_list in ipairs({
        {
            "agave",
            {
                {S("Amateur Agave Farmer"), S("Harvest 50 agave"), 10, 50},
                {S("Skilled Agave Farmer"), S("Harvest 500 agave"), 20, 500},
                {S("Veteran Agave Farmer"), S("Harvest 5000 agave"), 30, 5000},
            },
            {
                {"produce_agave", "unilib:produce_agave_grow_3"},
            },
            {"group:food_agave"},
        },
        {
            "aloe",
            {
                {S("Amateur Aloe Farmer"), S("Harvest 50 aloe"), 10, 50},
                {S("Skilled Aloe Farmer"), S("Harvest 500 aloe"), 20, 500},
                {S("Veteran Aloe Farmer"), S("Harvest 5000 aloe"), 30, 5000},
            },
            {
                {"produce_aloe", "unilib:produce_aloe_grow_3"},
            },
            {"group:food_aloe"},
        },
        {
            "artichoke",
            {
                {S("Amateur Artichoke Farmer"), S("Harvest 50 artichokes"), 10, 50},
                {S("Skilled Artichoke Farmer"), S("Harvest 500 artichokes"), 20, 500},
                {S("Veteran Artichoke Farmer"), S("Harvest 5000 artichokes"), 30, 5000},
            },
            {
                {"produce_artichoke", "unilib:produce_artichoke_grow_5"},
            },
            {"group:food_artichoke"},
        },
        {
            "asparagus",
            {
                {S("Amateur Asparagus Farmer"), S("Harvest 50 asparagus"), 10, 50},
                {S("Skilled Asparagus Farmer"), S("Harvest 500 asparagus"), 20, 500},
                {S("Veteran Asparagus Farmer"), S("Harvest 5000 asparagus"), 30, 5000},
            },
            {
                {"crop_asparagus_white", "unilib:crop_asparagus_white_grow_6"},
                {"produce_asparagus_green", "unilib:produce_asparagus_green_grow_5"},
            },
            {"group:food_asparagus"},
        },
        {
            "aubergine",
            {
                {S("Amateur Aubergine Farmer"), S("Harvest 50 aubergines"), 10, 50},
                {S("Skilled Aubergine Farmer"), S("Harvest 500 aubergines"), 20, 500},
                {S("Veteran Aubergine Farmer"), S("Harvest 5000 aubergines"), 30, 5000},
            },
            {
                {"crop_aubergine", "unilib:crop_aubergine_grow_4"},
            },
            {"group:food_aubergine", "group:food_eggplant"},
        },
        {
            "banana_dwarf",
            {
                {S("Amateur Dwarf Banana Farmer"), S("Harvest 50 dwarf bananas"), 10, 50},
                {S("Skilled Dwarf Banana Farmer"), S("Harvest 500 dwarf bananas"), 20, 500},
                {S("Veteran Dwarf Banana Farmer"), S("Harvest 5000 dwarf bananas"), 30, 5000},
            },
            {
                {"crop_banana_dwarf", "unilib:crop_banana_dwarf_grow_8"},
            },
            {"unilib:crop_banana_dwarf_harvest"},
        },
        {
            "barley",
            {
                {S("Amateur Barley Farmer"), S("Harvest 50 barley"), 10, 50},
                {S("Skilled Barley Farmer"), S("Harvest 500 barley"), 20, 500},
                {S("Veteran Barley Farmer"), S("Harvest 5000 barley"), 30, 5000},
            },
            {
                {"crop_barley", "unilib:crop_barley_grow_8"},
            },
            {"group:food_barley"},
        },
        {
            "bean",
            {
                {S("Amateur Bean Farmer"), S("Harvest 50 beans"), 10, 50},
                {S("Skilled Bean Farmer"), S("Harvest 500 beans"), 20, 500},
                {S("Veteran Bean Farmer"), S("Harvest 5000 beans"), 30, 5000},
            },
            {
                {"produce_bean_adzuki", "unilib:produce_bean_adzuki_grow_7"},
                {"produce_bean_green", "unilib:produce_bean_green_grow_5"},
            },
            {"group:food_adzuki", "group:food_beans"},
        },
        {
            "beet",
            {
                {S("Amateur Sugar Beet Farmer"), S("Harvest 50 sugar beets"), 10, 50},
                {S("Skilled Sugar Beet Farmer"), S("Harvest 500 sugar beets"), 20, 500},
                {S("Veteran Sugar Beet Farmer"), S("Harvest 5000 sugar beets"), 30, 5000},
            },
            {
                {"crop_beet_sugar", "unilib:crop_beet_sugar_grow_5"},
            },
            {"unilib:crop_beet_sugar_harvest"},
        },
        {
            "beetroot",
            {
                {S("Amateur Beetroot Farmer"), S("Harvest 50 beetroots"), 10, 50},
                {S("Skilled Beetroot Farmer"), S("Harvest 500 beetroots"), 20, 500},
                {S("Veteran Beetroot Farmer"), S("Harvest 5000 beetroots"), 30, 5000},
            },
            {
                {"crop_beetroot_common", "unilib:crop_beetroot_common_grow_8"},
                {"crop_beetroot_merlin", "unilib:crop_beetroot_merlin_grow_4"},
                {"produce_beetroot_normal", "unilib:produce_beetroot_normal_grow_5"},
            },
            {"group:food_beetroot"},
        },
        {
            "bokchoy",
            {
                {S("Amateur Bokchoy Farmer"), S("Harvest 50 bokchoy"), 10, 50},
                {S("Skilled Bokchoy Farmer"), S("Harvest 500 bokchoy"), 20, 500},
                {S("Veteran Bokchoy Farmer"), S("Harvest 5000 bokchoy"), 30, 5000},
            },
            {
                {"crop_bokchoy", "unilib:crop_bokchoy_grow_3"},
            },
            {"group:food_bokchoy"},
        },
        {
            "cabbage",
            {
                {S("Amateur Cabbage Farmer"), S("Harvest 50 cabbages"), 10, 50},
                {S("Skilled Cabbage Farmer"), S("Harvest 500 cabbages"), 20, 500},
                {S("Veteran Cabbage Farmer"), S("Harvest 5000 cabbages"), 30, 5000},
            },
            {
                {"crop_cabbage_brunswick", "unilib:crop_cabbage_brunswick_grow_6"},
                {"produce_cabbage_normal", "unilib:produce_cabbage_normal_grow_6"},
            },
            {"group:food_cabbage"},
        },
        {
            "carrot",
            {
                {S("Amateur Carrot Farmer"), S("Harvest 50 carrots"), 10, 50},
                {S("Skilled Carrot Farmer"), S("Harvest 500 carrots"), 20, 500},
                {S("Veteran Carrot Farmer"), S("Harvest 5000 carrots"), 30, 5000},
            },
            {
                {"crop_carrot_danvers", "unilib:crop_carrot_danvers_grow_8"},
                {"crop_carrot_nantes", "unilib:crop_carrot_nantes_grow_6"},
                {"produce_carrot_chantenay", "unilib:produce_carrot_chantenay_grow_8"},
                {"produce_carrot_normal", "unilib:produce_carrot_normal_grow_8"},
            },
            {"group:food_carrot"},
        },
        {
            "cassava",
            {
                {S("Amateur Cassava Farmer"), S("Harvest 50 cassava"), 10, 50},
                {S("Skilled Cassava Farmer"), S("Harvest 500 cassava"), 20, 500},
                {S("Veteran Cassava Farmer"), S("Harvest 5000 cassava"), 30, 5000},
            },
            {
                {"produce_cassava", "unilib:produce_cassava_grow_3"},
            },
            {"group:food_cassava"},
        },
        {
            "chilli",
            {
                {S("Amateur Chilli Farmer"), S("Harvest 50 chillis"), 10, 50},
                {S("Skilled Chilli Farmer"), S("Harvest 500 chillis"), 20, 500},
                {S("Veteran Chilli Farmer"), S("Harvest 5000 chillis"), 30, 5000},
            },
            {
                {"crop_chilli_gorria", "unilib:crop_chilli_gorria_grow_7"},
                {"produce_chilli_cayenne", "unilib:produce_chilli_cayenne_grow_5"},
                {"produce_chilli_normal", "unilib:produce_chilli_normal_grow_8"},
            },
            {"group:food_chili_pepper", "group:food_chilli_pepper"},
        },
        {
            "chives",
            {
                {S("Amateur Chives Farmer"), S("Harvest 50 chives"), 10, 50},
                {S("Skilled Chives Farmer"), S("Harvest 500 chives"), 20, 500},
                {S("Veteran Chives Farmer"), S("Harvest 5000 chives"), 30, 5000},
            },
            {
                {"crop_chives", "unilib:crop_chives_grow_5"},
            },
            {"group:food_chives"},
        },
        {
            "cocoa",
            {
                {S("Amateur Cocoa Farmer"), S("Harvest 50 cocoa"), 10, 50},
                {S("Skilled Cocoa Farmer"), S("Harvest 500 cocoa"), 20, 500},
                {S("Veteran Cocoa Farmer"), S("Harvest 5000 cocoa"), 30, 5000},
            },
            {
                {"crop_cocoa_trinitario", "unilib:crop_cocoa_trinitario_grow_8"},
                {"produce_cocoa_jungle", "unilib:produce_cocoa_jungle_grow_4"},
            },
            {"group:food_cocoa"},
        },
        {
            "coffee",
            {
                {S("Amateur Coffee Farmer"), S("Harvest 50 coffee"), 10, 50},
                {S("Skilled Coffee Farmer"), S("Harvest 500 coffee"), 20, 500},
                {S("Veteran Coffee Farmer"), S("Harvest 5000 coffee"), 30, 5000},
            },
            {
                {"produce_coffee", "unilib:produce_coffee_grow_5"},
            },
            {"group:food_coffee"},
        },
        {
            "corn",
            {
                {S("Amateur Corn Farmer"), S("Harvest 50 corn"), 10, 50},
                {S("Skilled Corn Farmer"), S("Harvest 500 corn"), 20, 500},
                {S("Veteran Corn Farmer"), S("Harvest 5000 corn"), 30, 5000},
            },
            {
                {"crop_corn_dent", "unilib:crop_corn_dent_grow_8"},
                {"produce_corn_flint", "unilib:produce_corn_flint_grow_8"},
                {"produce_corn_normal", "unilib:produce_corn_normal_grow_8"},
            },
            {"group:food_corn"},
        },
        {
            "cotton",
            {
                {S("Amateur Cotton Farmer"), S("Harvest 50 cotton"), 10, 50},
                {S("Skilled Cotton Farmer"), S("Harvest 500 cotton"), 20, 500},
                {S("Veteran Cotton Farmer"), S("Harvest 5000 cotton"), 30, 5000},
            },
            {
                {"crop_cotton", "unilib:crop_cotton_grow_8"},
            },
            {"unilib:crop_cotton_harvest"},
        },
        {
            "cucumber",
            {
                {S("Amateur Cucumber Farmer"), S("Harvest 50 cucumbers"), 10, 50},
                {S("Skilled Cucumber Farmer"), S("Harvest 500 cucumbers"), 20, 500},
                {S("Veteran Cucumber Farmer"), S("Harvest 5000 cucumbers"), 30, 5000},
            },
            {
                {"produce_cucumber_english", "unilib:produce_cucumber_english_grow_4"},
                {"produce_cucumber_normal", "unilib:produce_cucumber_normal_grow_4"},
            },
            {"group:food_cucumber"},
        },
        {
            "flax",
            {
                {S("Amateur Flax Farmer"), S("Harvest 50 flax"), 10, 50},
                {S("Skilled Flax Farmer"), S("Harvest 500 flax"), 20, 500},
                {S("Veteran Flax Farmer"), S("Harvest 5000 flax"), 30, 5000},
            },
            {
                {"crop_flax_brown", "unilib:crop_flax_brown_grow_8"},
                {"crop_flax_golden", "unilib:crop_flax_golden_grow_6"},
            },
            {"group:crop_flax"},
        },
        {
            "garlic",
            {
                {S("Amateur Garlic Farmer"), S("Harvest 50 garlic"), 10, 50},
                {S("Skilled Garlic Farmer"), S("Harvest 500 garlic"), 20, 500},
                {S("Veteran Garlic Farmer"), S("Harvest 5000 garlic"), 30, 5000},
            },
            {
                {"crop_garlic_porcelain", "unilib:crop_garlic_porcelain_grow_8"},
                {"crop_garlic_silverskin", "unilib:crop_garlic_silverskin_grow_6"},
                {"produce_garlic_normal", "unilib:produce_garlic_normal_grow_5"},
            },
            {"group:food_garlic"},
        },
        {
            "ginger",
            {
                {S("Amateur Ginger Farmer"), S("Harvest 50 ginger"), 10, 50},
                {S("Skilled Ginger Farmer"), S("Harvest 500 ginger"), 20, 500},
                {S("Veteran Ginger Farmer"), S("Harvest 5000 ginger"), 30, 5000},
            },
            {
                {"produce_ginger", "unilib:produce_ginger_grow_4"},
            },
            {"group:food_ginger"},
        },
        {
            "gourd",
            {
                {S("Amateur Bottle Gourd Farmer"), S("Harvest 50 bottle gourds"), 10, 50},
                {S("Skilled Bottle Gourd Farmer"), S("Harvest 500 bottle gourds"), 20, 500},
                {S("Veteran Bottle Gourd Farmer"), S("Harvest 5000 bottle gourds"), 30, 5000},
            },
            {
                {"produce_gourd_bottle", "unilib:produce_gourd_bottle_grow_7"},
            },
            {"group:food_gourd"},
        },
        {
            "grape",
            {
                {S("Amateur Grape Farmer"), S("Harvest 50 bunches of grapes"), 10, 50},
                {S("Skilled Grape Farmer"), S("Harvest 500 bunches of grapes"), 20, 500},
                {S("Veteran Grape Farmer"), S("Harvest 5000 bunches of grapes"), 30, 5000},
            },
            {
                {"produce_grape", "unilib:produce_grape_grow_8"},
            },
            {"unilib:produce_grape_harvest"},
        },
        {
            "hemp",
            {
                {S("Amateur Hemp Farmer"), S("Harvest 50 hemp"), 10, 50},
                {S("Skilled Hemp Farmer"), S("Harvest 500 hemp"), 20, 500},
                {S("Veteran Hemp Farmer"), S("Harvest 5000 hemp"), 30, 5000},
            },
            {
                {"crop_hemp", "unilib:crop_hemp_grow_8"},
            },
            {"unilib:crop_hemp_harvest"},
        },
        {
            "herb_medicinal",
            {
                {S("Amateur Medicinal Herb Farmer"), S("Harvest 50 medicinal herbs"), 10, 50},
                {S("Skilled Medicinal Herb Farmer"), S("Harvest 500 medicinal herbs"), 20, 500},
                {S("Veteran Medicinal Herb Farmer"), S("Harvest 5000 medicinal herbs"), 30, 5000},
            },
            {
                {"produce_herb_medicinal", "unilib:produce_herb_medicinal_grow_4"},
            },
            {"group:food_herb_medicinal"},
        },
        {
            "jute",
            {
                {S("Amateur Jute Farmer"), S("Harvest 50 jute"), 10, 50},
                {S("Skilled Jute Farmer"), S("Harvest 500 jute"), 20, 500},
                {S("Veteran Jute Farmer"), S("Harvest 5000 jute"), 30, 5000},
            },
            {
                {"produce_jute", "unilib:produce_jute_grow_3"},
            },
            {"group:food_jute"},
        },
        {
            "kale",
            {
                {S("Amateur Kale Farmer"), S("Harvest 50 kale"), 10, 50},
                {S("Skilled Kale Farmer"), S("Harvest 500 kale"), 20, 500},
                {S("Veteran Kale Farmer"), S("Harvest 5000 kale"), 30, 5000},
            },
            {
                {"produce_kale", "unilib:produce_kale_grow_3"},
            },
            {"group:food_kale"},
        },
        {
            "kohlrabi",
            {
                {S("Amateur Kohlrabi Farmer"), S("Harvest 50 kohlrabi"), 10, 50},
                {S("Skilled Kohlrabi Farmer"), S("Harvest 500 kohlrabi"), 20, 500},
                {S("Veteran Kohlrabi Farmer"), S("Harvest 5000 kohlrabi"), 30, 5000},
            },
            {
                {"crop_kohlrabi", "unilib:crop_kohlrabi_grow_6"},
            },
            {"group:food_kohlrabi"},
        },
        {
            "lettuce",
            {
                {S("Amateur Lettuce Farmer"), S("Harvest 50 lettuces"), 10, 50},
                {S("Skilled Lettuce Farmer"), S("Harvest 500 lettuces"), 20, 500},
                {S("Veteran Lettuce Farmer"), S("Harvest 5000 lettuces"), 30, 5000},
            },
            {
                {"produce_lettuce", "unilib:produce_lettuce_grow_5"},
            },
            {"group:food_lettuce"},
        },
        {
            "melon",
            {
                {S("Amateur Melon Farmer"), S("Harvest 50 melons"), 10, 50},
                {S("Skilled Melon Farmer"), S("Harvest 500 melons"), 20, 500},
                {S("Veteran Melon Farmer"), S("Harvest 5000 melons"), 30, 5000},
            },
            {
                {"produce_melon", "unilib:produce_melon_grow_8"},
            },
            {"group:food_melon"},
        },
        {
            "millet",
            {
                {S("Amateur Millet Farmer"), S("Harvest 50 millet"), 10, 50},
                {S("Skilled Millet Farmer"), S("Harvest 500 millet"), 20, 500},
                {S("Veteran Millet Farmer"), S("Harvest 5000 millet"), 30, 5000},
            },
            {
                {"produce_millet", "unilib:produce_millet_grow_3"},
            },
            {"group:food_millet"},
        },
        {
            "mint",
            {
                {S("Amateur Mint Farmer"), S("Harvest 50 mint"), 10, 50},
                {S("Skilled Mint Farmer"), S("Harvest 500 mint"), 20, 500},
                {S("Veteran Mint Farmer"), S("Harvest 5000 mint"), 30, 5000},
            },
            {
                {"crop_mint_liquorice", "unilib:crop_mint_liquorice_grow_4"},
                {"crop_mint_normal", "unilib:crop_mint_normal_grow_4"},
            },
            {"group:food_mint"},
        },
        {
            "oat",
            {
                {S("Amateur Oat Farmer"), S("Harvest 50 oats"), 10, 50},
                {S("Skilled Oat Farmer"), S("Harvest 500 oats"), 20, 500},
                {S("Veteran Oat Farmer"), S("Harvest 5000 oats"), 30, 5000},
            },
            {
                {"crop_oat", "unilib:crop_oat_grow_8"},
            },
            {"group:food_oats"},
        },
        {
            "onion",
            {
                {S("Amateur Onion Farmer"), S("Harvest 50 onions"), 10, 50},
                {S("Skilled Onion Farmer"), S("Harvest 500 onions"), 20, 500},
                {S("Veteran Onion Farmer"), S("Harvest 5000 onions"), 30, 5000},
            },
            {
                {"crop_onion_sweet", "unilib:crop_onion_sweet_grow_7"},
                {"produce_onion_normal", "unilib:produce_onion_normal_grow_5"},
                {"produce_onion_spanish", "unilib:produce_onion_spanish_grow_8"},
            },
            {"group:food_onion"},
        },
        {
            "parsley",
            {
                {S("Amateur Parsley Farmer"), S("Harvest 50 parsleys"), 10, 50},
                {S("Skilled Parsley Farmer"), S("Harvest 500 parsleys"), 20, 500},
                {S("Veteran Parsley Farmer"), S("Harvest 5000 parsleys"), 30, 5000},
            },
            {
                {"crop_parsley_curly", "unilib:crop_parsley_curly_grow_5"},
                {"produce_parsley_flatleaf", "unilib:produce_parsley_flatleaf_grow_3"},
            },
            {"group:food_parsley"},
        },
        {
            "pea",
            {
                {S("Amateur Pea Farmer"), S("Harvest 50 pea pods"), 10, 50},
                {S("Skilled Pea Farmer"), S("Harvest 500 pea pods"), 20, 500},
                {S("Veteran Pea Farmer"), S("Harvest 5000 pea pods"), 30, 5000},
            },
            {
                {"produce_pea", "unilib:produce_pea_grow_5"},
            },
            {"group:food_pea_pod"},
        },
        {
            "pepper",
            {
                {S("Amateur Pepper Farmer"), S("Harvest 50 peppers"), 10, 50},
                {S("Skilled Pepper Farmer"), S("Harvest 500 peppers"), 20, 500},
                {S("Veteran Pepper Farmer"), S("Harvest 5000 peppers"), 30, 5000},
            },
            {
                {"crop_pepper_rocoto", "unilib:crop_pepper_rocoto_grow_5"},
                {"produce_pepper", "unilib:food_pepper_green"},
                {"produce_pepper", "unilib:food_pepper_yellow"},
                {"produce_pepper", "unilib:food_pepper_red"},
            },
            {"group:food_pepper"},
        },
        {
            "potato",
            {
                {S("Amateur Potato Farmer"), S("Harvest 50 potatoes"), 10, 50},
                {S("Skilled Potato Farmer"), S("Harvest 500 potatoes"), 20, 500},
                {S("Veteran Potato Farmer"), S("Harvest 5000 potatoes"), 30, 5000},
            },
            {
                {"crop_potato_russet", "unilib:crop_potato_russet_grow_7"},
                {"crop_potato_sweet", "unilib:crop_potato_sweet_grow_8"},
                {"produce_potato_maris_piper", "unilib:produce_potato_maris_piper_grow_4"},
                {"produce_potato_normal", "unilib:produce_potato_normal_grow_4"},
            },
            {"group:food_potato"},
        },
        {
            "pumpkin",
            {
                {S("Amateur Pumpkin Farmer"), S("Harvest 50 pumpkins"), 10, 50},
                {S("Skilled Pumpkin Farmer"), S("Harvest 500 pumpkins"), 20, 500},
                {S("Veteran Pumpkin Farmer"), S("Harvest 5000 pumpkins"), 30, 5000},
            },
            {
                {"produce_pumpkin_yellow", "unilib:produce_pumpkin_yellow_grow_8"},
            },
            {"group:food_pumpkin"},
        },
        {
            "quadrotriticale",
            {
                {S("Amateur Quadrotriticale Farmer"), S("Harvest 50 quadrotriticale"), 10, 50},
                {S("Skilled Quadrotriticale Farmer"), S("Harvest 500 quadrotriticale"), 20, 500},
                {S("Veteran Quadrotriticale Farmer"), S("Harvest 5000 quadrotriticale"), 30, 5000},
            },
            {
                {"crop_quadrotriticale", "unilib:crop_quadrotriticale_grow_8"},
            },
            {"group:food_quadrotriticale"},
        },
        {
            "radicchio",
            {
                {S("Amateur Radicchio Farmer"), S("Harvest 50 radicchio"), 10, 50},
                {S("Skilled Radicchio Farmer"), S("Harvest 500 radicchio"), 20, 500},
                {S("Veteran Radicchio Farmer"), S("Harvest 5000 radicchio"), 30, 5000},
            },
            {
                {"crop_radicchio", "unilib:crop_radicchio_grow_5"},
            },
            {"group:food_radicchio"},
        },
        {
            "radish",
            {
                {S("Amateur Radish Farmer"), S("Harvest 50 radishes"), 10, 50},
                {S("Skilled Radish Farmer"), S("Harvest 500 radishes"), 20, 500},
                {S("Veteran Radish Farmer"), S("Harvest 5000 radishes"), 30, 5000},
            },
            {
                {"produce_raddish", "unilib:produce_raddish_grow_5"},
            },
            {"group:food_radish"},
        },
        {
            "rhubarb",
            {
                {S("Amateur Rhubarb Farmer"), S("Harvest 50 rhubarbs"), 10, 50},
                {S("Skilled Rhubarb Farmer"), S("Harvest 500 rhubarbs"), 20, 500},
                {S("Veteran Rhubarb Farmer"), S("Harvest 5000 rhubarbs"), 30, 5000},
            },
            {
                {"produce_rhubarb", "unilib:produce_rhubarb_grow_4"},
            },
            {"group:food_rhubarb"},
        },
        {
            "rice",
            {
                {S("Amateur Rice Farmer"), S("Harvest 50 rice"), 10, 50},
                {S("Skilled Rice Farmer"), S("Harvest 500 rice"), 20, 500},
                {S("Veteran Rice Farmer"), S("Harvest 5000 rice"), 30, 5000},
            },
            {
                {"crop_rice_brown", "unilib:crop_rice_brown_grow_6"},
                {"crop_rice_white", "unilib:crop_rice_white_grow_8"},
                {"produce_rice_arborio", "unilib:produce_rice_arborio_grow_8"},
            },
            {"group:food_rice"},
        },
        {
            "rosemary",
            {
                {S("Amateur Rosemary Farmer"), S("Harvest 50 rosemary"), 10, 50},
                {S("Skilled Rosemary Farmer"), S("Harvest 500 rosemary"), 20, 500},
                {S("Veteran Rosemary Farmer"), S("Harvest 5000 rosemary"), 30, 5000},
            },
            {
                {"crop_rosemary", "unilib:crop_rosemary_grow_6"},
            },
            {"group:food_rosemary"},
        },
        {
            "rye",
            {
                {S("Amateur Rye Farmer"), S("Harvest 50 rye"), 10, 50},
                {S("Skilled Rye Farmer"), S("Harvest 500 rye"), 20, 500},
                {S("Veteran Rye Farmer"), S("Harvest 5000 rye"), 30, 5000},
            },
            {
                {"crop_rye", "unilib:crop_rye_grow_8"},
            },
            {"group:food_rye"},
        },
        {
            "sisal",
            {
                {S("Amateur Sisal Farmer"), S("Harvest 50 sisal"), 10, 50},
                {S("Skilled Sisal Farmer"), S("Harvest 500 sisal"), 20, 500},
                {S("Veteran Sisal Farmer"), S("Harvest 5000 sisal"), 30, 5000},
            },
            {
                {"produce_sisal", "unilib:produce_sisal_grow_3"},
            },
            {"group:food_sisal"},
        },
        {
            "soy",
            {
                {S("Amateur Soybean Farmer"), S("Harvest 50 soybeans"), 10, 50},
                {S("Skilled Soybean Farmer"), S("Harvest 500 soybeans"), 20, 500},
                {S("Veteran Soybean Farmer"), S("Harvest 5000 soybeans"), 30, 5000},
            },
            {
                {"crop_soy_red", "unilib:crop_soy_red_grow_8"},
                {"crop_soy_yellow", "unilib:crop_soy_yellow_grow_8"},
                {"produce_soy_normal", "unilib:produce_soy_normal_grow_7"},
            },
            {"group:food_soybean", "group:food_soy_pod"},
        },
        {
            "spiceleaf",
            {
                {S("Amateur Spiceleaf Farmer"), S("Harvest 50 spiceleafs"), 10, 50},
                {S("Skilled Spiceleaf Farmer"), S("Harvest 500 spiceleafs"), 20, 500},
                {S("Veteran Spiceleaf Farmer"), S("Harvest 5000 spiceleafs"), 30, 5000},
            },
            {
                {"produce_spiceleaf", "unilib:produce_spiceleaf_grow_3"},
            },
            {"group:food_spiceleaf"},
        },
        {
            "spinach",
            {
                {S("Amateur Spinach Farmer"), S("Harvest 50 spinach"), 10, 50},
                {S("Skilled Spinach Farmer"), S("Harvest 500 spinach"), 20, 500},
                {S("Veteran Spinach Farmer"), S("Harvest 5000 spinach"), 30, 5000},
            },
            {
                {"crop_spinach", "unilib:crop_spinach_grow_4"},
            },
            {"group:food_spinach"},
        },
        {
            "strawberry",
            {
                {S("Amateur Strawberry Farmer"), S("Harvest 50 strawberries"), 10, 50},
                {S("Skilled Strawberry Farmer"), S("Harvest 500 strawberries"), 20, 500},
                {S("Veteran Strawberry Farmer"), S("Harvest 5000 strawberries"), 30, 5000},
            },
            {
                {"crop_strawberry_gariguette", "unilib:crop_strawberry_gariguette_grow_8"},
                {"produce_strawberry_normal", "unilib:produce_strawberry_normal_grow_8"},
            },
            {"group:food_strawberry"},
        },
        {
            "sunflower",
            {
                {S("Amateur Sunflower Farmer"), S("Harvest 50 sunflowers"), 10, 50},
                {S("Skilled Sunflower Farmer"), S("Harvest 500 sunflowers"), 20, 500},
                {S("Veteran Sunflower Farmer"), S("Harvest 5000 sunflowers"), 30, 5000},
            },
            {
                {"crop_sunflower_dwarf", "unilib:crop_sunflower_dwarf_grow_5"},
                {"crop_sunflower_giant", "unilib:crop_sunflower_giant_grow_8"},
            },
            {"nilib:crop_sunflower_dwarf_harvest", "unilib:crop_sunflower_giant_harvest"},
        },
        {
            "tomato",
            {
                {S("Amateur Tomato Farmer"), S("Harvest 50 tomatoes"), 10, 50},
                {S("Skilled Tomato Farmer"), S("Harvest 500 tomatoes"), 20, 500},
                {S("Veteran Tomato Farmer"), S("Harvest 5000 tomatoes"), 30, 5000},
            },
            {
                {"crop_tomato_beefsteak", "unilib:crop_tomato_beefsteak_grow_8"},
                {"crop_tomato_cherry", "unilib:crop_tomato_cherry_grow_5"},
                {"produce_tomato_salad", "unilib:produce_tomato_salad_grow_8"},
            },
            {"group:food_tomato"},
        },
        {
            "undersesa",
            {
                {S("Amateur Undersea Farmer"), S("Harvest 50 undersea plants"), 10, 50},
                {S("Skilled Undersea Farmer"), S("Harvest 500 undersea plants"), 20, 500},
                {S("Veteran Undersea Farmer"), S("Harvest 5000 undersea plants"), 30, 5000},
            },
            {
                {"crop_undersea_algae", "unilib:crop_undersea_algae_grow_6"},
                {"crop_undersea_anemone", "unilib:crop_undersea_anemone_grow_5"},
                {"crop_undersea_cucumber", "unilib:crop_undersea_cucumber_grow_8"},
                {"crop_undersea_grass", "unilib:crop_undersea_grass_grow_5"},
                {"crop_undersea_strawberry", "unilib:crop_undersea_strawberry_grow_8"},
            },
            {
                "unilib:crop_undersea_algae_harvest",
                "unilib:crop_undersea_anemone_harvest",
                "unilib:crop_undersea_cucumber_harvest",
                "unilib:crop_undersea_grass_harvest",
                "unilib:crop_undersea_strawberry_harvest",
            },
        },
        {
            "vanilla",
            {
                {S("Amateur Vanilla Farmer"), S("Harvest 50 vanilla"), 10, 50},
                {S("Skilled Vanilla Farmer"), S("Harvest 500 vanilla"), 20, 500},
                {S("Veteran Vanilla Farmer"), S("Harvest 5000 vanilla"), 30, 5000},
            },
            {
                {"produce_vanilla", "unilib:produce_vanilla_grow_8"},
            },
            {"group:food_vanilla"},
        },
        {
            "watermelon",
            {
                {S("Amateur Watermelon Farmer"), S("Harvest 50 watermelons"), 10, 50},
                {S("Skilled Watermelon Farmer"), S("Harvest 500 watermelons"), 20, 500},
                {S("Veteran Watermelon Farmer"), S("Harvest 5000 watermelons"), 30, 5000},
            },
            {
                {"crop_watermelon_tiny", "unilib:crop_watermelon_tiny_grow_8"},
            },
            {"group:crop_watermelon"},
        },
        {
            "wheat",
            {
                {S("Amateur Wheat Farmer"), S("Harvest 50 wheat"), 10, 50},
                {S("Skilled Wheat Farmer"), S("Harvest 500 wheat"), 20, 500},
                {S("Veteran Wheat Farmer"), S("Harvest 5000 wheat"), 30, 5000},
            },
            {
                {"crop_wheat", "unilib:crop_wheat_grow_8"},
            },
            {"unilib:crop_wheat_harvest"},
        },
        {
            "yucca",
            {
                {S("Amateur Yucca Farmer"), S("Harvest 50 yucca"), 10, 50},
                {S("Skilled Yucca Farmer"), S("Harvest 500 yucca"), 20, 500},
                {S("Veteran Yucca Farmer"), S("Harvest 5000 yucca"), 30, 5000},
            },
            {
                {"produce_yucca", "unilib:produce_yucca_grow_3"},
            },
            {"group:food_yucca"},
        },
    }) do

        local part_name = mini_list[1]
        local achievement_list = mini_list[2]
        local plant_list = refine_plant_list(mini_list[3])
        local harvest_list = mini_list[4]

        if #plant_list > 0 then

            for i, this_list in ipairs(achievement_list) do

                unilib.awards.register_achievement({
                    name = "unilib_farmer_comb_" .. part_name .. "_" .. i,
                    trigger_table = {
                        prototype = "unilib_receive",
                        target = this_list[4],
                        item_list = harvest_list,
                    },

                    title = this_list[1],
                    description = this_list[2],
                    score = this_list[3],
                    vocation_list = {unilib.pkg.award_farmer.vocation_name},
                })

            end

            for _, full_name in ipairs(plant_list) do

                core.override_item(full_name, {
                    after_dig_node = unilib.awards.on_receive,
                })

            end

        end

    end

    -- Selective achievements
    for i, mini_list in ipairs({
        -- Fertiliser
        {"bonemeal", "unilib:item_fertiliser_bonemeal", "unilib_craft", S("The Bone Ranger"), S("Craft 90 bone meal"), 10, 90},
        {"fertiliser", "unilib:item_fertiliser_bonemeal", "unilib_craft", S("Compost Mentis"), S("Craft 90 compound fertiliser"), 10, 90},
        {"mulch", "unilib:item_fertiliser_bonemeal", "unilib_craft", S("Mulch Ado About Nothing"), S("Craft 45 mulch"), 10, 45},
        -- Common ingredients
        {"flour", "unilib:ingredient_flour_ordinary", "unilib_craft", S("Flour for Algernon"), S("Craft 120 ordinary flour"), 10, 120},
        {"sugar", "unilib:ingredient_sugar_normal", "unilib_craft", S("Sweet Tooth"), S("Craft 120 ordinary sugar"), 10, 120},
    }) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unilib_farmer_select_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_farmer.vocation_name},
            })

        end

    end

end
