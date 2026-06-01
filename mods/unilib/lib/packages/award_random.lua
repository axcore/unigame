---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_random = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Table mapping player names, onto the game time (core.get_gametime()) at which the last chat
--      message was sent
local player_chat_table = {}
-- The interval between chat messages which are counted towards an achievement
local chat_interval = 30

-- List of secret words, used for the "unilib_random_select_chat_secret" achievement
local secret_word_list = {"xyzzy", "plugh"}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_random.vocation_name = "unilib_random"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_chat(player, msg)

    if not unilib.utils.is_player(player) or string.find(msg, "^/") then
        return
    end

    -- Prevent spamming by ignoring chat messages within a certain interval
    local pname = player:get_player_name()
    local now = core.get_gametime()

    if player_chat_table[pname] == nil or (now - player_chat_table[pname]) >= chat_interval then

        player_chat_table[pname] = now
        unilib.awards.handle_simple_trigger(player, "random_comb_chat", 1)

    end

    -- Check for secret words
    for _, word in ipairs(secret_word_list) do

        if string.find(msg, word) then

            unilib.awards.handle_simple_trigger(player, "random_select_chat_secret", 1)
            break

        end

    end

end

local function on_cheat(player)

    if not unilib.utils.is_player(player) then
        return
    end

    unilib.awards.handle_simple_trigger(player, "random_select_cheat", 1)

end

local function on_cmd(player)

    if not unilib.utils.is_player(player) then
        return
    end

    unilib.awards.handle_simple_trigger(player, "random_comb_cmd", 1)

end

local function on_grief(player)

    if not unilib.utils.is_player(player) then
        return
    end

    unilib.awards.handle_simple_trigger(player, "random_comb_grief", 1)

end

local function on_join(player)

    local count = #core.get_connected_players()

    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_custom_watch_table(player, "random_comb_player_join")
    ) do

        local achievement_table = unilib.global.awards_achievement_table[achievement_name]
        local target = achievement_table["trigger_table"]["target"]
        if target <= count then

            for _, player in ipairs(core.get_connected_players()) do
                unilib.awards.unlock_achievement(player, achievement_name)
            end

        end

    end

end

local function on_leave(player)

    local count = #core.get_connected_players()

    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_custom_watch_table(player, "random_comb_player_leave")
    ) do

        local achievement_table = unilib.global.awards_achievement_table[achievement_name]
        local target = achievement_table["trigger_table"]["target"]
        if target <= count then

            for _, other_player in ipairs(core.get_connected_players()) do

                if other_player ~= player then
                    unilib.awards.unlock_achievement(other_player, achievement_name)
                end

            end

        end

    end

end

local function on_pickup(player)

    if not unilib.utils.is_player(player) then
        return
    end

    unilib.awards.handle_simple_trigger(player, "random_comb_pickup", 1)

end

local function on_playtime()

    for _, player in ipairs(core.get_connected_players()) do
        unilib.awards.handle_simple_trigger(player, "random_comb_playtime", 1)
    end

end

local function on_priv_grant(receiver, giver)

    if not unilib.utils.is_player(receiver) or not unilib.utils.is_player(giver) then
        return
    end

    unilib.awards.handle_simple_trigger(receiver, "random_select_priv_gain", 1)
    unilib.awards.handle_simple_trigger(giver, "random_select_priv_grant", 1)

end

local function on_priv_revoke(receiver, giver)

    if not unilib.utils.is_player(receiver) or not unilib.utils.is_player(giver) then
        return
    end

    unilib.awards.handle_simple_trigger(receiver, "random_select_priv_lose", 1)
    unilib.awards.handle_simple_trigger(giver, "random_select_priv_revoke", 1)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_random.init()

    return {
        description = "Awards for all kinds of silly stuff (\"You're So Random!\")",
    }

end

function unilib.pkg.award_random.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Trigger prototypes -------------------------------------------------------------------------

    -- (For normal chat messages)
    unilib.awards.register_trigger_prototype({
        name = "random_comb_chat",
        trigger_type = "simple",
        hint_list = {"Send a chat message", "Send @1 chat messages"},
        progress_list = {"Send a chat message", "Send @1/@2 chat messages"},
    })

    unilib.awards.register_trigger_prototype({
        name = "random_comb_cmd",
        trigger_type = "simple",
        hint_list = {"Type an engine command", "Type @1 engine commands"},
        progress_list = {"Type an engine command", "Type @1/@2 engine commands"},
    })

    unilib.awards.register_trigger_prototype({
        name = "random_comb_grief",
        trigger_type = "simple",
        hint_list = {"Generate a protection violation", "Generate @1 protection violations"},
        progress_list = {"Generate a protection violation", "Generate @1/@2 protection violations"},
    })

    unilib.awards.register_trigger_prototype({
        name = "random_comb_pickup",
        trigger_type = "simple",
        hint_list = {"Pick up an item", "Pick up @1 items"},
        progress_list = {"Pick up an item", "Pick up @1/@2 items"},
    })

    unilib.awards.register_trigger_prototype({
        name = "random_comb_player_join",
        trigger_type = "custom",
        hint_list = {"Be on a server alone", "Be on a server with @1 players"},
        progress_list = {"Be on a server alone", "Be on a server with @1/@2 players"},
    })

    unilib.awards.register_trigger_prototype({
        name = "random_comb_player_leave",
        trigger_type = "custom",
        hint_list = {"Be on a server alone", "Be on a server with @1 players"},
        progress_list = {"Be on a server alone", "Be on a server with @1/@2 players"},
    })

    unilib.awards.register_trigger_prototype({
        name = "random_comb_playtime",
        trigger_type = "simple",
        hint_list = {"Play for one minute", "Play for @1 minutes"},
        progress_list = {"Play for one minute", "Play for @1/@2 minutes"},
    })

    unilib.awards.register_trigger_prototype({
        name = "random_select_chat_secret",
        trigger_type = "simple",
        hint_list = {"Send a chat message", "Send @1 chat messages"},
        progress_list = {"Send a chat message", "Send @1/@2 chat messages"},
    })

    unilib.awards.register_trigger_prototype({
        name = "random_select_cheat",
        trigger_type = "simple",
        hint_list = {"Get caught cheating once", "Get caught cheating @1 chat times"},
        progress_list = {"Get caught cheating once", "Get caught cheating @1/@2 chat times"},
    })

    unilib.awards.register_trigger_prototype({
        name = "random_select_priv_gain",
        trigger_type = "simple",
        hint_list = {"Gain a privilege", "Gain @1 privileges"},
        progress_list = {"Gain a privilege", "Gain @1/@2 privileges"},
    })

    unilib.awards.register_trigger_prototype({
        name = "random_select_priv_grant",
        trigger_type = "simple",
        hint_list = {"Grant a privilege", "Grant @1 privileges"},
        progress_list = {"Grant a privilege", "Grant @1/@2 privileges"},
    })

    unilib.awards.register_trigger_prototype({
        name = "random_select_priv_lose",
        trigger_type = "simple",
        hint_list = {"Lose a privilege", "Lose @1 privileges"},
        progress_list = {"Lose a privilege", "Lose @1/@2 privileges"},
    })

    unilib.awards.register_trigger_prototype({
        name = "random_select_priv_revoke",
        trigger_type = "simple",
        hint_list = {"Revoke a privilege", "Revoke @1 privileges"},
        progress_list = {"Revoke a privilege", "Revoke @1/@2 privileges"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    -- Award total playtime achievements (for the purposes of unlocking achievements, checks once
    --      per minute are accurate enough)
    local timer = 0
    local check_interval = 60

    core.register_globalstep(function(dtime)

        timer = timer + dtime
        if timer < check_interval then

            return

        else

            timer = 0
            on_playtime()

        end

    end)

    -- Award other achievements
    core.register_on_chat_message(function(name, message)
        on_chat(core.get_player_by_name(name), message)
    end)

    core.register_on_chatcommand(function(name, command, params)
        on_cmd(core.get_player_by_name(name))
    end)

    core.register_on_cheat(function(player, cheat)
        on_cheat(player)
    end)

    core.register_on_joinplayer(function(player)
        on_join(player)
    end)

    core.register_on_leaveplayer(function(player, timed_out)
        on_leave(player)
    end)

    core.register_on_protection_violation(function(pos, name)
        on_grief(core.get_player_by_name(name))
    end)

    core.register_on_item_pickup(function(itemstack, picker)
        on_pickup(picker)
    end)

    core.register_on_priv_grant(function(name, granter, priv)
        on_priv_grant(core.get_player_by_name(name), granter)
    end)

    core.register_on_priv_revoke(function(name, revoker, priv)
        on_priv_revoke(core.get_player_by_name(name), revoker)
    end)

    -- Vocations ----------------------------------------------------------------------------------

    -- Assume score of 420 for combination achievements (140 extra available in multi-player mode)
    -- Assume score of 450 for selective achievements (200 extra available if certain packages are
    --      loaded)
    unilib.awards.register_vocation({
        name = unilib.pkg.award_random.vocation_name,

        title = S("You're So Random!"),
        description = S("Awards for all kinds of silly stuff"),
        icon = "unilib_award_vocation_random.png",
        level_list = {
            {title = S("Blockbusters"), score = 10},
            {title = S("Button Masher"), score = 20},
            {title = S("Dirt Picasso"), score = 40},
            {title = S("Tree Hugger"), score = 80},
            {title = S("Jumping to Conclusions"), score = 120},
            {title = S("Splash Test Dummy"), score = 160},
            {title = S("Fence Sitter"), score = 200},
            {title = S("Fishing for Compliments"), score = 300},
            {title = S("Shear Madness"), score = 400},
            {title = S("Woolly Thinking"), score = 500},
            {title = S("Stairway to Heaven"), score = 600},
            {title = S("Inventory Tetris Champion"), score = 800},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    local comb_list = {
        {"chat_1", "random_comb_chat", S("Keyboard Warrior"), S("Send a chat message"), 10, 1},
        {"cmd_1", "random_comb_cmd", S("Typo Farmer"), S("Type 5 engine commands"), 10, 5, true},
        {"cmd_2", "random_comb_cmd", S("Oops, Wrong Coordinates"), S("Type 55 engine commands"), 20, 55, true},
        {"cmd_3", "random_comb_cmd", S("Admin in Training"), S("Type 555 engine commands"), 30, 555, true},
        {"grief_1", "random_comb_grief", S("Nuisance Newbie"), S("Generate 6 protection violations"), 10, 6, true},
        {"grief_2", "random_comb_grief", S("How to Lose Friends and Annoy People"), S("Generate 66 protection violations"), 10, 6, true},
        {"grief_3", "random_comb_grief", S("Menace to Society"), S("Generate 666 protection violations"), 10, 6, true},
        {"join_1", "unilib_join", S("Oh - It's YOU Again!"), S("Join the server 2 times"), 10, 2, true},
        {"join_2", "unilib_join", S("Just Swinging By"), S("Join the server 5 times"), 10, 5, true},
        {"join_3", "unilib_join", S("Back At It"), S("Join the server 25 times"), 20, 25, true},
        {"join_4", "unilib_join", S("Outstaying Your Welcome"), S("Join the server 125 times"), 20, 125, true},
        {"join_5", "unilib_join", S("Hanging Around Like a Bad Smell"), S("Join the server 625 times"), 30, 625, true},

        {"pickup_1", "random_comb_pickup", S("Might Need This Later"), S("Pick up 7 items"), 10, 7},
        {"pickup_2", "random_comb_pickup", S("Nothing Goes to Waste"), S("Pick up 49 items"), 10, 49},
        {"pickup_3", "random_comb_pickup", S("Vault Filler"), S("Pick up 343 items"), 10, 343},
        {"pickup_4", "random_comb_pickup", S("Inventory Crisis"), S("Pick up 2401 items"), 10, 2401},

        {"playtime_1", "random_comb_playtime", S("Time Well Spent"), S("Play for a whole game day"), 10, 20},
        {"playtime_2", "random_comb_playtime", S("Hour You Kidding Me"), S("Play for an hour"), 10, 60},
        {"playtime_3", "random_comb_playtime", S("Time Flies When You Never Log Off"), S("Play for 3 hours"), 10, 60 * 3},
        {"playtime_4", "random_comb_playtime", S("Clockwise"), S("Play for 12 hours"), 20, 60 * 12},
        {"playtime_5", "random_comb_playtime", S("Time to Call It a Day"), S("Play for 24 hours"), 20, 60 * 24},
        {"playtime_6", "random_comb_playtime", S("Eternally AFK"), S("Play for 100 hours"), 30, 60 * 100},
        {"playtime_7", "random_comb_playtime", S("Chrono Sapiens"), S("Play for 250 hours"), 40, 60 * 250},
        {"playtime_8", "random_comb_playtime", S("Time to Get Another Hobby"), S("Play for 1000 hours"), 50, 60 * 1000},
    }

    if not core.is_singleplayer() then

        table.insert(comb_list, {"chat_2", "random_comb_chat", S("Block Quote"), S("Over time, send 7 chat messages"), 20, 7, true})
        table.insert(comb_list, {"chat_3", "random_comb_chat", S("Extrovert"), S("Over time, send 77 chat messages"), 30, 77, true})
        table.insert(comb_list, {"chat_4", "random_comb_chat", S("Socialite"), S("Over time, send 777 chat messages"), 40, 777, true})
        table.insert(comb_list, {"chat_5", "random_comb_chat", S("Racounteur"), S("Over time, send 7777 chat messages"), 50, 7777, true})

        table.insert(comb_list, {"player_1", "random_comb_player_leave", S("Last Man on Earth"), S("Be the last player logged in"), 10, 1})
        table.insert(comb_list, {"player_2", "random_comb_player_join", S("At Last! Another Player!"), S("Be on a server with 1 other player"), 10, 2})
        table.insert(comb_list, {"player_3", "random_comb_player_join", S("Reluctant Recluse"), S("Be on a server with 4 other players"), 10, 5})
        table.insert(comb_list, {"player_4", "random_comb_player_join", S("Waiting for Your Buddies"), S("Be on a server with 9 other players"), 10, 10})
        table.insert(comb_list, {"player_5", "random_comb_player_join", S("It's Getting Crowded in Here"), S("Be on a server with 24 other players"), 20, 25})
        table.insert(comb_list, {"player_6", "random_comb_player_join", S("Squashed like Sardines"), S("Be on a server with 49 other players"), 30, 50})
        table.insert(comb_list, {"player_7", "random_comb_player_join", S("Stand on Zanzibar"), S("Be on a server with 99 other players"), 50, 100})

    end

    for i, mini_list in ipairs(comb_list) do

        unilib.awards.register_achievement({
            name = "unilib_random_comb_" .. mini_list[1],
            trigger_table = {
                prototype = mini_list[2],
                target = mini_list[6],
            },

            title = mini_list[3],
            description = mini_list[4],
            secret_flag = mini_list[7],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_random.vocation_name},
        })

    end

    -- Selective achievements
    local boat_list = {}
    for _, part_name in ipairs({"acacia", "apple", "aspen", "jungle", "pine"}) do
        table.insert(boat_list, "unilib:boat_simple_" .. part_name)
    end

    local coral_list = {}
    for _, part_name in ipairs({
        "blue", "brown", "bubble", "crimson", "fire", "green", "horn", "orange", "pink", "red",
        "rose", "skeleton", "sponge", "tangerine", "tube", "violet", "yellow",
    }) do
        table.insert(coral_list, "unilib:coral_block_" .. part_name)
    end

    local door_list = {"unilib:door_steel", "unilib:door_steel_bar"}
    local marram_list = {"unilib:grass_marram_ordinary_1", "unilib:grass_marram_ordinary_2", "unilib:grass_marram_ordinary_3"}
    local permafrost_list = {"unilib:dirt_permafrost_ordinary", "unilib:dirt_permafrost_ordinary_with_moss", "unilib:dirt_permafrost_ordinary_with_litter_stone"}

    local rooted_list = {}
    for _, part_name in ipairs({
        "blue", "blue_glow", "bubble", "cyan", "fire", "green", "green_glow", "horn", "orange",
        "orange_glow", "pink", "pink_big", "pink_glow", "red", "rose", "spider", "tube",
    }) do
        table.insert(rooted_list, "unilib:coral_rooted_" .. part_name)
    end

    for i, mini_list in ipairs({
        -- (original to unilib)
        {"chat_secret", nil, "random_select_chat_secret", S("Nothing Happens"), S("Send a chat message containing the secret word"), 50, 1, true},
        {"cheat", nil, "random_select_cheat", S("Dirty Rotten Cheater"), S("Get caught cheating"), 10, 1, true},
        {"priv_gain", nil, "random_select_priv_gain", S("Power Trip"), S("Gain a privilege"), 10, 1, true},
        {"priv_grant", nil, "random_select_priv_grant", S("Permission Granted"), S("Grant a privilege"), 10, 1, true},
        {"priv_lose", nil, "random_select_priv_lose", S("Access Denied"), S("Lose a privilege"), 10, 1, true},
        {"priv_revoke", nil, "random_select_priv_revoke", S("Downgraded"), S("Revoke a privilege"), 10, 1, true},
        -- (mtgame)
        {"axe_wood", "unilib:tool_axe_wood", "unilib_craft", S("Axident Waiting to Happen"), S("Craft a stack of wooden axes"), 10, 99},
        {"binoculars_ordinary", "unilib:item_binoculars_ordinary", "unilib_craft", S("Zoom and Gloom"), S("Craft ordinary binoculars"), 10, 1},
        {"book_ordinary", "unilib:item_book_ordinary", "unilib_craft", S("Bound to Overdo It"), S("Craft 40 ordinary books"), 10, 40},
        {"boat", boat_list, "unilib_craft", S("Accidental Admiral"), S("Craft 3 boats"), 10, 3},
        {"bottle_glass", "unilib:vessel_bottle_glass_empty", "unilib_craft", S("Bottleneck"), S("Craft 12 empty glass bottles"), 10, 12},
        {"bottle_steel", "unilib:vessel_bottle_steel_empty", "unilib_craft", S("Steel Yourself"), S("Craft 12 empty heavy steel bottles"), 10, 12},
        {"bucket_steel", "unilib:bucket_steel_empty", "unilib_craft", S("There's a Hole in My Bucket"), S("Craft 15 empty steel buckets"), 10, 15},
        {"bush_ordinary", "unilib:bush_ordinary_leaves", "unilib_place", S("Shrub Slinger"), S("Place 23 ordinary bush leaves"), 10, 23},
        {"coral_block", coral_list, "unilib_break", S("Reef Raider"), S("Vandalise 45 block corals"), 10, 45},
        {"coral_rooted", rooted_list, "unilib_break", S("Coral Collector"), S("Vandalise 45 rooted corals"), 10, 45},
        {"coral_skeleton", "unilib:coral_block_skeleton", "unilib_receive", S("Dead Sea Digger"), S("Obtain 17 coral skeletons"), 10, 17},
        {"cotton_seed", "unilib:crop_cotton_seed", "unilib_receive", S("Cotton On"), S("Obtain a stack of cotton seeds"), 10, 99},
        {"door_glass", "unilib:door_glass_ordinary", "unilib_craft", S("Pane and Suffering"), S("Craft 18 ordinary glass doors"), 10, 18},
        {"door_obsidian", "unilib:door_glass_obsidian", "unilib_craft", S("Shard Knocker"), S("Craft 18 obsidian glass doors"), 10, 18},
        {"door_steel", door_list, "unilib_craft", S("Steel the Deal"), S("Craft 18 steel or steel bar doors"), 10, 18},
        {"door_wood", "unilib:door_wood_ordinary", "unilib_craft", S("Knock on Wood"), S("Craft 18 ordinary wooden doors"), 10, 18},
        {"fire_permanent", "unilib:fire_permanent", "unilib_place", S("Eternal Flame"), S("Place 54 permanent flames"), 10, 54},
        {"grass_marram", marram_list, "unilib_break", S("Costal Composter"), S("Pick 83 ordinary marram grass"), 10, 83},
        {"kit_mapping", "unilib:item_kit_mapping", "unilib_craft", S("You've Been Framed"), S("Craft a mapping kit"), 10, 1},
        {"kit_radar", "unilib:item_kit_radar", "unilib_craft", S("Ping King"), S("Craft a radar kit"), 10, 1},
        {"paper_ordinary", "unilib:item_paper_ordinary", "unilib_craft", S("Milling About"), S("Craft 375 ordinary paper"), 20, 375},
        {"permafrost", permafrost_list, "unilib_break", S("Chill Seeker"), S("Dig 72 ordinary permafrost blocks"), 10, 72},
        {"pick_stone", "unilib:tool_pick_stone", "unilib_craft", S("Stone Tool Stampede"), S("Craft a stack of stone pickaxes"), 10, 99},
        {"screwdriver_ordinary", "unilib:item_screwdriver_ordinary", "unilib_craft", S("Twist 'n' Shout"), S("Craft an ordinary screwdriver"), 10, 1},
        {"sign_steel", "unilib:sign_wall_steel", "unilib_craft", S("Steel the Show"), S("Craft a steel wall sign"), 10, 1},
        {"sign_wood", "unilib:sign_wall_wood", "unilib_craft", S("Sign Me Up"), S("Craft a wooden wall sign"), 10, 1},
        {"string_ordinary", "unilib:item_string_ordinary", "unilib_craft", S("Knot Again"), S("Craft 735 ordinary string"), 20, 735},
        {"tnt_ordinary", "unilib:tnt_ordinary", "unilib_craft", S("Kaboom Connoisseur"), S("Craft a stack of TNT"), 20, 99},
        {"trapdoor_steel", "unilib:trapdoor_steel_closed", "unilib_place", S("Gravity's Little Helper"), S("Place a steel trapdoor"), 10, 1},
        {"vessel_glass", "unilib:vessel_glass_empty", "unilib_craft", S("Glass Act"), S("Craft 12 empty glasses"), 10, 12},
        {"wheat_seed", "unilib:crop_wheat_seed", "unilib_receive", S("Wheat Whacker"), S("Obtain a stack of wheat seeds"), 10, 99},
        -- (nyancat)
        {"nyancat", "unilib:misc_nyancat", "unilib_break", S("The Cat is Out of the Bag"), S("Mine a nyan cat"), 10, 1, true},
        {"nyancat_rainbow", "unilib:misc_nyancat_rainbow", "unilib_break", S("Tail of Many Colours"), S("Mine 5 nyan cat rainbows"), 10, 5, true},
        -- (xtraores)
        {"geminitium_block", "unilib:metal_geminitium_block", "unilib_place", S("Aaaaaaghhh My Eyes!"), S("Place a geminitium block"), 10, 1},
        {"rainbow_stone", "unilib:decor_block_rainbow_stone", "unilib_place", S("Somewhere Over the Rainbow"), S("Place a stone rainbow block"), 10, 1},
        {"rainbow_glass", "unilib:decor_block_rainbow_glass", "unilib_place", S("Found a Pot of Gold"), S("Place a glass rainbow block"), 10, 1},
        {"rainbow_wood", "unilib:decor_block_rainbow_wood", "unilib_place", S("Visible Spectrum"), S("Place a wooden rainbow block"), 10, 1},
    }) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unilib_random_select_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                secret_flag = mini_list[8],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_random.vocation_name},
            })

        end

    end

end
