---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_craftsman = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_craftsman.vocation_name = "unilib_craftsman"

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_craftsman.init()

    return {
        description = "Awards for crafting decorative blocks (\"Craftsman\")",
        optional = {"misc_painting_landscape", "misc_painting_portrait", "misc_painting_small"},
    }

end

function unilib.pkg.award_craftsman.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Vocations ----------------------------------------------------------------------------------

    -- If all packages are loaded, total score would be 840
    unilib.awards.register_vocation({
        name = unilib.pkg.award_craftsman.vocation_name,

        title = S("Craftsman"),
        description = S("Craft as many decorative items as you can"),
        icon = "unilib_award_vocation_craftsman.png",
        level_list = {
            {title = S("Flint Knapper"), score = 10},
            {title = S("Pine in the Glass"), score = 20},
            {title = S("Craftastrophe Averted"), score = 40},
            {title = S("Set in Stone"), score = 60},
            {title = S("Block and Awe"), score = 90},
            {title = S("Fancy Pants"), score = 120},
            {title = S("Joint Effort"), score = 160},
            {title = S("Boulder Choices"), score = 20},
            {title = S("Nice Work if You Can Craft It"), score = 250},
            {title = S("The Decorator Will See You Now"), score = 300},
            {title = S("Shelf-Made Millionaire"), score = 400},
            {title = S("The Finer Things in Life"), score = 500},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    local comb_list = {}
    if unilib.global.pkg_executed_table["misc_painting_landscape"] ~= nil then

        table.insert(comb_list, {"painting_landscape_1", "group:landscape_painting", "unilib_craft", S("Amateur Landscape Painter"), S("Craft a landscape painting"), 10, 1})
        table.insert(comb_list, {"painting_landscape_2", "group:landscape_painting", "unilib_craft", S("Skilled Painter"), S("Craft 12 landscape paintings"), 20, 12})
        table.insert(comb_list, {"painting_landscape_3", "group:landscape_painting", "unilib_craft", S("Veteran Landscape Painter"), S("Craft 144 landscape paintings"), 30, 144})

    end
    if unilib.global.pkg_executed_table["misc_painting_portrait"] ~= nil then

        table.insert(comb_list, {"painting_portrait_1", "group:portrait_painting", "unilib_craft", S("Amateur Portrait Painter"), S("Craft a portrait painting"), 10, 10})
        table.insert(comb_list, {"painting_portrait_2", "group:portrait_painting", "unilib_craft", S("Skilled Portrait Painter"), S("Craft 12 portrait paintings"), 20, 12})
        table.insert(comb_list, {"painting_portrait_3", "group:portrait_painting", "unilib_craft", S("Veteran Portrait Painter"), S("Craft 144 portrait paintings"), 30, 144})

    end
    if unilib.global.pkg_executed_table["misc_painting_small"] ~= nil then

        table.insert(comb_list, {"painting_small_1", "group:small_painting", "unilib_craft", S("Amateur Fine Artist"), S("Craft a small painting"), 10, 10})
        table.insert(comb_list, {"painting_small_2", "group:small_painting", "unilib_craft", S("Skilled Fine Artist"), S("Craft 12 small paintings"), 20, 12})
        table.insert(comb_list, {"painting_small_3", "group:small_painting", "unilib_craft", S("Veteran Fine Artist"), S("Craft 144 small paintings"), 30, 144})

    end

    for i, mini_list in ipairs(comb_list) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unilib_craftsman_comb_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_craftsman.vocation_name},
            })

        end

    end

    -- Selective achievements
    local disintegrate_list = {
        "unilib:decor_disintegrating_stone_desert",
        "unilib:decor_disintegrating_stone_ordinary",
        "unilib:decor_disintegrating_stone_sandstone_desert",
        "unilib:decor_disintegrating_stone_sandstone_ordinary",
        "unilib:decor_disintegrating_stone_sandstone_silver",
    }
    local edge_list = {
        "unilib:decor_bricks_stone_desert_with_gold",
        "unilib:decor_bricks_stone_obsidian_with_gold",
        "unilib:decor_bricks_stone_ordinary_with_gold",
        "unilib:decor_bricks_stone_sandstone_desert_with_gold",
        "unilib:decor_bricks_stone_sandstone_silver_with_gold",
        "unilib:decor_bricks_stone_sandstone_with_gold",
    }
    local plate_list = {
        "unilib:decor_plate_steel_hard",
        "unilib:decor_plate_steel_rusty",
        "unilib:decor_plate_steel_soft",
    }
    local rockwall_list = {
        "unilib:decor_rockwall_stone_desert", "unilib:decor_rockwall_stone_desert_dark",
        "unilib:decor_rockwall_stone_ordinary", "unilib:decor_rockwall_stone_ordinary_dark",
        "unilib:decor_rockwall_stone_sandstone_desert", "unilib:decor_rockwall_stone_sandstone_desert_dark",
        "unilib:decor_rockwall_stone_sandstone_ordinary", "unilib:decor_rockwall_stone_sandstone_ordinary_dark",
        "unilib:decor_rockwall_stone_sandstone_silver", "unilib:decor_rockwall_stone_sandstone_silver_dark",
    }

    for i, mini_list in ipairs({
        -- (castle)
        {"castle_corner", "unilib:decor_stone_castle_corner", "unilib_craft", S("Cornered but Not Defeated"), S("Craft 60 castle wall corners"), 10, 60},
        {"castle_dungeon", "unilib:decor_stone_castle_dungeon", "unilib_craft", S("Dungeon Dweller"), S("Craft 60 castle dungeon stones"), 10, 60},
        {"castle_rubble", "unilib:decor_stone_castle_rubble", "unilib_craft", S("Rubble Without a Cause"), S("Craft 60 castle wall rubble blocks"), 10, 60},
        {"castle_wall", "unilib:decor_stone_castle_wall", "unilib_craft", S("Stonewalled"), S("Craft 60 castle wall blocks"), 10, 60},
        {"paving_normal", "unilib:decor_paving_normal", "unilib_craft", S("Pave new world"), S("Craft 35 normal paving stones"), 10, 35},
        -- (columnia)
        {"rusty", "unilib:decor_block_metal_rusty", "unilib_craft", S("Rust in Peace"), S("Craft 8 rusty metal blocks"), 10, 8},
        {"rusty_etched", "unilib:decor_block_metal_rusty_etched", "unilib_craft", S("Rustworthy"), S("Craft 16 etched rusty metal blocks"), 10, 16},
        -- (darkage)
        {"brick_chalked", "unilib:decor_bricks_stone_chalked", "unilib_craft", S("Chalk It Up"), S("Craft 70 decorative chalked bricks"), 10, 70},
        {"brick_small_stone", "unilib:decor_bricks_stone_small", "unilib_craft", S("Mini Masonry"), S("Craft 70 decorative small stone bricks"), 10, 70},
        -- (farlands)
        {"disintegrate", disintegrate_list, "unilib_craft", S("Dust to Dust"), S("Craft 150 disintegrating stone blocks"), 20, 150},
        {"pillar_bone", "unilib:decor_pillar_bone", "unilib_craft", S("A Bone to Pick"), S("Craft 30 bone pillars"), 10, 30},
        {"tiles_dirt", "unilib:decor_stone_tiles_with_dirt", "unilib_craft", S("Grime and Punishment"), S("Craft 75 old stone tiles with dirt"), 10, 75},
        {"tiles_moss", "unilib:decor_stone_tiles_with_moss", "unilib_craft", S("Moss Boss"), S("Craft 75 mossy old stone tiles"), 10, 75},
        {"tiles_stone", "unilib:decor_stone_tiles", "unilib_craft", S("Worn-Out but Well-Loved"), S("Craft 75 old stone tiles"), 10, 75},
        -- (GLEM)
        {"paving_slate", "unilib:decor_paving_slate", "unilib_craft", S("Shingle and Ready to Mingle"), S("Craft 35 paving slates"), 10, 35},
        {"rockwall", rockwall_list, "unilib_craft", S("Rock Solid"), S("Craft 225 rockwall blocks"), 20, 225},
        -- (moreblocks)
        {"brick_cactus", "unilib:decor_bricks_cactus", "unilib_craft", S("Cactus Nostalgia"), S("Craft 12 decorative cactus bricks"), 10, 12},
        {"brick_stone_circle", "unilib:decor_bricks_stone_circle", "unilib_craft", S("Circle of the Ancients"), S("Craft 10 decorative circle stone bricks"), 10, 10},
        {"brick_stone_coal", "unilib:decor_bricks_stone_coal", "unilib_craft", S("Coal Craftsman"), S("Craft 10 decorative coal stone bricks"), 10, 10},
        {"brick_stone_grey", "unilib:decor_bricks_stone_grey", "unilib_craft", S("Greyed Out"), S("Craft 10 decorative grey stone bricks"), 10, 10},
        {"brick_stone_iron", "unilib:decor_bricks_stone_iron", "unilib_craft", S("Ironclad Assurance"), S("Craft 10 decorative iron stone bricks"), 10, 10},
        {"checker_cactus", "unilib:decor_tiled_cactus_checker", "unilib_craft", S("Cactus-Based Kitchen"), S("Craft 15 decorative cactus checkered tiles"), 10, 15},
        {"checker_coal", "unilib:decor_tiled_coal_checker", "unilib_craft", S("Plays Chess as Black"), S("Craft 15 decorative checkered coal tiles"), 10, 15},
        {"checker_iron", "unilib:decor_tiled_iron_checker", "unilib_craft", S("Plays Chess as White"), S("Craft 15 decorative checkered iron tiles"), 10, 15},
        {"coal_checker", "unilib:decor_tiled_coal_checker", "unilib_craft", S("Who Was This Saint-Maclou Guy, Anyway?"), S("Craft 25 decorative checkered coal tiles"), 10, 25},
        {"iron_checker", "unilib:decor_tiled_iron_checker", "unilib_craft", S("Tiled Hard"), S("Craft 25 decorative checkered iron tiles"), 10, 25},
        {"stone_coal", "unilib:decor_stone_coal", "unilib_craft", S("Shadow Stones"), S("Craft 10 decorative coal stone bricks"), 10, 10},
        {"stone_iron", "unilib:decor_stone_iron", "unilib_craft", S("Fortified with Iron"), S("Craft 10 decroation iron stone bricks"), 10, 10},
        {"stone_ordinary_trap", "unilib:stone_ordinary_trap", "unilib_craft", S("Bait and Brick"), S("Craft 25 ordinary stone traps"), 10, 25},
        {"tiled_plankstone", "unilib:decor_tiled_plankstone", "unilib_craft", S("Wooden Mason I"), S("Craft 27 decorative plankstone tiles"), 10, 27},
        {"tiled_plankstone_centre", "unilib:decor_tiled_plankstone_centre", "unilib_craft", S("Wooden Mason II"), S("Craft 27 decorative centred plankstone tiles"), 10, 27},
        {"tiled_plankstone_offset", "unilib:decor_tiled_plankstone_offset", "unilib_craft", S("Wooden Mason III"), S("Craft 27 decorative offset plankstone tiles"), 10, 27},
        {"tiled_stone", "unilib:decor_tiled_stone", "unilib_craft", S("Stylish Stonework I"), S("Craft 45 decorative stone tiles"), 10, 45},
        {"tiled_stone_checker", "unilib:decor_tiled_stone_checker", "unilib_craft", S("Stylish Stonework II"), S("Craft 45 decorative checkered stone tiles"), 10, 45},
        {"tiled_stone_split", "unilib:decor_tiled_stone_split", "unilib_craft", S("Stylish Stonework III"), S("Craft 45 decorative ordinary stone split tiles"), 10, 45},
        {"tiled_wood", "unilib:decor_tiled_wood", "unilib_craft", S("Forest Tiler I"), S("Craft 40 decorative wood tiles"), 10, 40},
        {"tiled_wood_centre", "unilib:decor_tiled_wood_centre", "unilib_craft", S("Forest Tiler II"), S("Craft 40 decorative centred wood tiles"), 10, 40},
        {"tiled_wood_full", "unilib:decor_tiled_wood_full", "unilib_craft", S("Forest Tiler III"), S("Craft 40 decorative full wood tiles"), 10, 40},
        {"tiled_wood_offset", "unilib:decor_tiled_wood_offset", "unilib_craft", S("Forest Tiler IV"), S("Craft 40 decorative offset wood tiles"), 10, 40},
        -- (mtg_plus)
        {"brick_bronze", "unilib:decor_bricks_metal_bronze", "unilib_craft", S("Gold Bricks on a Budget"), S("Craft 50 decorative bronze bricks"), 10, 50},
        {"brick_copper", "unilib:decor_bricks_metal_copper", "unilib_craft", S("Patina Pending"), S("Craft 50 decorative copper bricks"), 10, 50},
        {"brick_gold", "unilib:decor_bricks_metal_gold", "unilib_craft", S("Fort Knox Foreman"), S("Craft 50 decorative gold bricks"), 10, 50},
        {"brick_steel", "unilib:decor_bricks_metal_steel", "unilib_craft", S("Heavy Metal"), S("Craft 50 decorative steel bricks"), 10, 50},
        {"brick_tin", "unilib:decor_bricks_metal_tin", "unilib_craft", S("Bronze Bricks on a Budge"), S("Craft 50 decorative tin bricks"), 10, 50},
        {"diamond_block", "unilib:mineral_diamond_block_hard", "unilib_craft", S("Broke 99 pickaxes"), S("Craft 20 hard diamond blocks"), 10, 20},
        {"diamond_gold", "unilib:mineral_diamond_block_gold", "unilib_craft", S("In the Lap of Luxury"), S("Craft 25 gold-framed diamond blocks"), 10, 25},
        {"edge_gold", edge_list, "unilib_craft", S("More Money Than Sense"), S("Craft 300 decorative bricks with gold edges"), 30, 300},
        {"gravel_cobble", "unilib:gravel_ordinary_cobble", "unilib_craft", S("True Grit"), S("Craft 200 cobbled ordinary gravel"), 10, 200},
        {"ice_tile", "unilib:ice_ordinary_tile_small", "unilib_craft", S("Glacial Pace"), S("Craft 180 small ordinary ice tiles"), 10, 180},
        {"jungle_cobble", "unilib:stone_jungle_cobble", "unilib_craft", S("Monkey-Proof Masonry"), S("Craft 195 jungle cobblestone"), 10, 195},
        {"papyrus_block", "unilib:plant_papyrus_ordinary_block", "unilib_craft", S("Parchwright"), S("Craft 300 ordinary papyrus blocks"), 10, 300},
        {"sandstone_cobble", "unilib:stone_sandstone_ordinary_cobble", "unilib_craft", S("My Name Is Ozymandius"), S("Craft 195 cobbled ordinary sandstone"), 10, 195},
        {"snow_brick", "unilib:snow_ordinary_brick_hard", "unilib_craft", S("Snow Place Like Home"), S("Craft 175 hard ordinary snow bricks"), 10, 175},
        {"tree_gold", "unilib:tree_gold_wood", "unilib_craft", S("24-carat Carpentry"), S("Craft 70 gold-enriched wood planks"), 10, 70},
        -- (steel)
        {"plate_misc", plate_list, "unilib_craft", S("Industrial pancake Maker"), S("Craft 33 steel plates"), 10, 33},
        -- (xdecor)
        {"brick_ice", "unilib:decor_block_ice_packed", "unilib_craft", S("Ice Ice Baby"), S("Craft 12 decorative packed ice blocks"), 10, 12},
        {"brick_cactus_old", "unilib:decor_bricks_cactus_old", "unilib_craft", S("Emerald Brick Road"), S("Craft 12 decorative old cactus bricks"), 10, 12},
        {"brick_moonbrick", "unilib:decor_bricks_moonbrick", "unilib_craft", S("Over the Moon"), S("Craft 42 decorative moon bricks"), 10, 42},
        {"brick_runestone", "unilib:decor_bricks_runestone", "unilib_craft", S("Runes of Engagement"), S("Craft 42 decorative runestone bricks"), 10, 42},
        {"tiled_coal", "unilib:decor_tiled_coal", "unilib_craft", S("Charcoal Charm"), S("Craft 66 decorative coal tiles"), 10, 66},
        {"tiled_desert", "unilib:decor_tiled_stone_desert", "unilib_craft", S("Sunscorched"), S("Craft 81 decorative desert stone tiles"), 10, 81},
        {"tiled_jointed", "unilib:decor_tiled_wood_jointed", "unilib_craft", S("Joint Venture"), S("Craft 81 decorative jointed wood tiles"), 10, 81},
    }) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unilib_craftsman_select_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_craftsman.vocation_name},
            })

        end

    end

end
