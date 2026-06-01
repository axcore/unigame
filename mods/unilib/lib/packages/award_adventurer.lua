---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_adventurer = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Localise math functions (for speed)
local floor = math.floor

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_adventurer.vocation_name = "unilib_adventurer"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_hour(player, hour)

    -- Don't unlock the achievement, if the player is not plausibly on the surface
    local pos = player:get_pos()
    if pos.y < 1 or pos.y > 100 then
        return
    end

    if hour == 5 then
        unilib.awards.increment_achievement_counter(player, "unilib_adventurer_select_dawn", 1)
    elseif hour == 18 then
        unilib.awards.increment_achievement_counter(player, "unilib_adventurer_select_dusk", 1)
    end

end

local function on_mine(player, full_name, pos)

    if not unilib.utils.is_player(player) or full_name == nil or pos == nil then
        return
    end

    -- N.B. To avoid placing unnecessary load on the server, use a single node for each situation,
    --      rather than a list of them
    if full_name == "unilib:liquid_water_ordinary_source" then

        for _, achievement_name in ipairs(
            unilib.awards.retrieve_data_from_simple_watch_table(player, "adventurer_select_mine_in")
        ) do
            unilib.awards.increment_achievement_counter(player, achievement_name, 1)
        end

    elseif core.find_node_near(pos, 2, "unilib:liquid_lava_ordinary_source") then

        for _, achievement_name in ipairs(
            unilib.awards.retrieve_data_from_simple_watch_table(
                player, "adventurer_select_mine_near"
            )
        ) do
            unilib.awards.increment_achievement_counter(player, achievement_name, 1)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_adventurer.init()

    return {
        description = "Awards for new players (\"Adventurer\")",
    }

end

function unilib.pkg.award_adventurer.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "adventurer_select_hour",
        trigger_type = "simple",
        hint_list = {"Wait for one in-game hour", "Wait for @1 in-game hours"},
        progress_list = {"Wait for one in-game hour", "Wait for @1/@2 in-game hours"},
    })

    unilib.awards.register_trigger_prototype({
        name = "adventurer_select_mine_in",
        trigger_type = "simple",
        hint_list = {"Mine in something once", "Mine in something @1 times"},
        progress_list = {"Mine in something once", "Mine in something @1/@2 times"},
    })

    unilib.awards.register_trigger_prototype({
        name = "adventurer_select_mine_near",
        trigger_type = "simple",
        hint_list = {"Mine in something once", "Mine in something @1 times"},
        progress_list = {"Mine in something once", "Mine in something @1/@2 times"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    -- Award achievements at (first) dawn and dusk
    local timer = 0
    local check_interval = 15   -- Checks three times per in-game hour
    local prev_hour

    core.register_globalstep(function(dtime)

        timer = timer + dtime
        if timer < check_interval then
            return
        else
            timer = 0
        end

        local hour = floor((core.get_timeofday() or 0) * 24)
        if prev_hour ~= hour then

            prev_hour = hour
            for _, player in ipairs(core.get_connected_players()) do
                on_hour(player, hour)
            end

        end

    end)

    -- Award achievements for mining in or near something

    core.register_on_dignode(function(pos, oldnode, digger)
        on_mine(digger, oldnode.name, pos)
    end)

    -- Vocations ----------------------------------------------------------------------------------

    -- Total score 770
    unilib.awards.register_vocation({
        name = unilib.pkg.award_adventurer.vocation_name,

        title = S("Adventurer"),
        description = S("Some easy awards for new players"),
        icon = "unilib_award_vocation_adventurer.png",
        level_list = {
            {title = S("Oops, Wrong Block"), score = 10},
            {title = S("Oops, Wrong Direction"), score = 20},
            {title = S("Oops, Not Symmetrical"), score = 50},
            {title = S("Home Sweet Cobble Box"), score = 100},
            {title = S("Punching Above Your Weight"), score = 150},
            {title = S("Creeper Bait"), score = 200},
            {title = S("Dirt Cheap"), score = 250},
            {title = S("Planks for Nothing"), score = 300},
            {title = S("Bucket List"), score = 400},
            {title = S("Torchlight Savings Time"), score = 500},
            {title = S("Housewarming Party"), score = 600},
            {title = S("Planetary Terraformer"), score = 700},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    for i, mini_list in ipairs({
        -- (mtgame) bricks
        {"brick_ordinary_1", "unilib:brick_ordinary_block", "unilib_place", S("Brick by Brick"), S("Place 45 ordinary brick blocks"), 10, 45},
        {"brick_ordinary_2", "unilib:brick_ordinary_block", "unilib_place", S("Red-Handed"), S("Place 450 ordinary brick blocks"), 10, 450},
        {"brick_ordinary_3", "unilib:brick_ordinary_block", "unilib_place", S("Bricked Up"), S("Place 4500 ordinary brick blocks"), 10, 4500},
        -- (mtgame) chests
        {"chest_ordinary_1", "unilib:container_chest_ordinary", "unilib_craft", S("Chest Quest"), S("Craft 2 ordinary chests"), 10, 2},
        {"chest_ordinary_2", "unilib:container_chest_ordinary_locked", "unilib_craft", S("Storage Issues"), S("Craft 2 ordinary locked chests"), 10, 2},
        {"chest_ordinary_3", "unilib:container_chest_ordinary_locked", "unilib_craft", S("Box Room"), S("Craft 25 ordinary locked chests"), 20, 25},
        {"chest_ordinary_4", "unilib:container_chest_ordinary_locked", "unilib_craft", S("Vaulted Ambitions"), S("Craft 250 ordinary locked chests"), 30, 250},
        -- (mtgame) ice
        {"ice_ordinary_1", "unilib:ice_ordinary", "unilib_break", S("Ice Breaker"), S("Dig some ice"), 10, 1},
        {"ice_ordinary_2", "unilib:ice_ordinary", "unilib_break", S("Cold Call"), S("Dig 50 ice"), 20, 50},
        {"ice_ordinary_3", "unilib:ice_ordinary", "unilib_break", S("Frostbite Resistant"), S("Dig 500 ice"), 30, 500},
        {"ice_ordinary_4", "unilib:ice_ordinary_block", "unilib_craft", S("Freeze Frame"), S("Craft 25 ice blocks"), 10, 25},
        {"ice_ordinary_5", "unilib:ice_ordinary_brick", "unilib_craft", S("Cool Under Pressure"), S("Craft 25 ice bricks"), 10, 25},
        -- (mtgame) ladders
        {"ladder_wood_1", "unilib:ladder_wood_ordinary", "unilib_place", S("Step Up"), S("Place 40 ordinary wooden ladders"), 10, 40},
        {"ladder_wood_2", "unilib:ladder_wood_ordinary", "unilib_place", S("Wooden Spine"), S("Place 400 ordinary wooden ladders"), 20, 400},
        {"ladder_wood_3", "unilib:ladder_wood_ordinary", "unilib_place", S("Upward Mobility"), S("Place 4000 ordinary wooden ladders"), 30, 4000},
        {"ladder_steel_1", "unilib:ladder_steel", "unilib_place", S("Going Up in the World"), S("Place 40 steel ladders"), 10, 40},
        {"ladder_steel_2", "unilib:ladder_steel", "unilib_place", S("Lord of the Rungs"), S("Place 400 steel ladders"), 20, 400},
        -- (mtgame) mossy cobble
        {"mossy_cobble_1", "group:mossycobble", "unilib_break", S("Dungeon Explorer"), S("Remove 15 mossy cobblestones"), 10, 15},
        {"mossy_cobble_2", "group:mossycobble", "unilib_break", S("Temple Stripper"), S("Remove 80 mossy cobblestones"), 20, 70},
        {"mossy_cobble_3", "group:mossycobble", "unilib_break", S("Moss Boss"), S("Remove 350 mossy cobblestones"), 30, 350},
        -- (mtgame) obsidian
        {"obsidian_1", "unilib:stone_obsidian", "unilib_break", S("Volcano Drainer"), S("Mine some obsidian"), 10, 1},
        {"obsidian_2", "unilib:stone_obsidian", "unilib_break", S("Obsidian Obsession"), S("Mine 99 obsidian"), 20, 99},
        {"obsidian_3", "unilib:stone_obsidian", "unilib_break", S("World's Most Patient Miner"), S("Mine 999 obsidian"), 30, 999},
        -- (mtgame) snow
        {"snow_ordinary_1", "unilib:snow_ordinary", "unilib_break", S("Snow Problem"), S("Clear 22 piles of snow"), 10, 22},
        {"snow_ordinary_2", "unilib:snow_ordinary", "unilib_break", S("Cold Case File"), S("Clear 222 piles of snow"), 20, 222},
        {"snow_ordinary_3", "unilib:snow_ordinary", "unilib_break", S("Avalanche Survivor"), S("Clear 2222 piles of snow"), 30, 2222},
        -- (mtgame) torches
        {"torch_craft_1", "unilib:torch_ordinary", "unilib_craft", S("Afraid of the Dark"), S("Craft 4 torches"), 10, 4},
        {"torch_craft_2", "unilib:torch_ordinary", "unilib_craft", S("Bright Idea"), S("Craft 40 torches"), 10, 40},
        {"torch_craft_3", "unilib:torch_ordinary", "unilib_craft", S("Light 'Em Up"), S("Craft 400 torches"), 20, 400},
        {"torch_craft_4", "unilib:torch_ordinary", "unilib_craft", S("Banished the Shadows"), S("Craft 4000 torches"), 30, 4000},
        {"torch_place_1", "unilib:torch_ordinary", "unilib_place", S("Torch Bearer"), S("Place 4 torches"), 10, 4},
        {"torch_place_2", "unilib:torch_ordinary", "unilib_place", S("Insured Against Everything"), S("Place 40 torches"), 10, 40},
        {"torch_place_3", "unilib:torch_ordinary", "unilib_place", S("Light Pollution Enthusiast"), S("Place 400 torches"), 20, 400},
        {"torch_place_4", "unilib:torch_ordinary", "unilib_place", S("Keeper of the Eternal Flame"), S("Place 4000 torches"), 30, 4000},
    }) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unilib_adventurer_comb_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_adventurer.vocation_name},
            })

        end

    end

    -- Selective achievements (general)
    local dry_grass_list = {"unilib:grass_dry_1", "unilib:grass_dry_2", "unilib:grass_dry_3", "unilib:grass_dry_4", "unilib:grass_dry_5"}
    local ordinary_grass_list = {"unilib:grass_ordinary_1", "unilib:grass_ordinary_2", "unilib:grass_ordinary_3", "unilib:grass_ordinary_4", "unilib:grass_ordinary_5"}

    for i, mini_list in ipairs({
        -- (mtgame) furnaces
        {"furnace", "unilib:machine_furnace_ordinary", "unilib_craft", S("Stone Cold Beginner"), S("Craft 3 ordinary furnaces"), 10, 3},
        -- (mtgame) grasses
        {"grass_dry", dry_grass_list, "unilib_break", S("Dry Run"), S("Pick 5 dry grass"), 10, 5},
        {"grass_jungle", "unilib:grass_jungle", "unilib_break", S("Tarzan's Disappointment"), S("Pick 5 jungle grass"), 10, 5},
        {"grass_ordinary", ordinary_grass_list, "unilib_break", S("Lawn Enforcement"), S("Pick 5 ordinary grass"), 10, 5},
        -- (mtgame) mese blocks
        {"mese_block", "unilib:mineral_mese_block ", "unilib_break", S("Shiny Object Syndrome"), S("Mine a mese block"), 10, 1},
        -- (mtgame) mese lamps
        {"mese_lamp", "unilib:light_block_mese", "unilib_craft", S("Glow-Getter"), S("Craft 8 mese lamps"), 10, 8},
        -- (mtgame) obsidian
        {"obsidian_block", "unilib:stone_obsidian_block", "unilib_place", S("Hardcore Home Decor"), S("Place 77 obsidian blocks"), 20, 77},
        {"obsidian_brick", "unilib:stone_obsidian_brick", "unilib_place", S("Unbreakable Aesthetic"), S("Place 77 obsidian bricks"), 20, 77},
        -- (mtgame) plants (some are used by other achievements, in greater quantities)
        {"shrub_dry", "unilib:plant_shrub_dry", "unilib_break", S("Crunch Collector"), S("Pick a dry shrub"), 10, 1},
        -- (mtgame) snow
        {"snow_ordinary_1", "unilib:snow_ordinary_block", "unilib_place", S("Show Man Builder"), S("Place 4 snow blocks"), 10, 4},
        {"snow_ordinary_2", "unilib:snow_ordinary_block", "unilib_craft", S("Snowed In"), S("Craft 15 snow blocks"), 10, 15},
        {"snow_ordinary_3", "unilib:snow_ordinary_brick", "unilib_craft", S("Frosty Foundations"), S("Craft 15 snow bricks"), 10, 15},
    }) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unilib_adventurer_select_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_adventurer.vocation_name},
            })

        end

    end

    -- Selective achievements (location)
    -- N.B. To avoid placing unnecessary load on the server, use a single node for each situation,
    --      rather than a list of them
    for i, mini_list in ipairs({
        {"in_water", "adventurer_select_mine_in", S("Wet Behind the Ears"), S("Mine in ordinary water"), 10, 1},
        {"near_lava", "adventurer_select_mine_near", S("A Warm Welcome"), S("Mine near ordinary lava"), 10, 1},
    }) do

        unilib.awards.register_achievement({
            name = "unilib_adventurer_select_" .. mini_list[1],
            trigger_table = {
                prototype = mini_list[2],
                target = mini_list[6],
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_adventurer.vocation_name},
        })

    end

    -- Selective achievements (times of day)
    for i, mini_list in ipairs({
        {"dawn", "adventurer_select_hour", S("Here Comes the Sun"), S("Watch your first sunrise"), 10, 1},
        {"dusk", "adventurer_select_hour", S("Goodnight, Sweetheart"), S("Watch your first sunset"), 10, 1},
    }) do

        unilib.awards.register_achievement({
            name = "unilib_adventurer_select_" .. mini_list[1],
            trigger_table = {
                prototype = mini_list[2],
                target = mini_list[6],
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_adventurer.vocation_name},
        })

    end

end
