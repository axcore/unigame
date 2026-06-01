---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_zoologist = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

-- Compiled lists/tables of items
local mob_repel_table = {}
local mob_follow_table = {}
local mob_tame_table = {}
local mob_breed_table = {}
local mob_convert_table = {}
-- Table of excluded mob types (do not count towards repel/follow/tame/breed/convert awards), in
--  the form
--      MOB_TYPE = true
local mob_exclude_table = {}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_zoologist.vocation_name = "unimobs_zoologist"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function compile_mobs()

    for mob_type, data_table in pairs(unimobs.petz_msetting) do

        if mob_exclude_table[mob_type] == nil then

            if data_table.repel_item_first ~= "" then
                mob_repel_table[mob_type] = data_table.repel_item_first
            end

            if data_table.follow_item_first ~= "" then
                mob_follow_table[mob_type] = data_table.follow_item_first
            end

            if data_table.feed_item_first ~= "" then
                mob_tame_table[mob_type] = data_table.feed_item_first
            end

            if data_table.breed_item_first ~= "" then
                mob_breed_table[mob_type] = data_table.breed_item_first
            end

            if data_table.convert_with_first ~= "" then
                mob_convert_table[mob_type] = data_table.convert_with_first
            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_zoologist.on_mob_repel(player, self)

    -- Called by unilib.pkg.mtb_start_repelling.do_action()

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            not self or
            self.mob_type == nil then
        return
    end

    if mob_repel_table[self.mob_type] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "zoologist_collect_repel", "unimobs_zoologist_collect_repel_1", self.mob_type
        )

    end

end

function unilib.pkg.award_zoologist.on_mob_follow(player, self)

    -- Called by unilib.pkg.mtb_start_following.do_action()

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            not self or
            self.mob_type == nil then
        return
    end

    if mob_follow_table[self.mob_type] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "zoologist_collect_follow", "unimobs_zoologist_collect_follow_1", self.mob_type
        )

    end

end

function unilib.pkg.award_zoologist.on_mob_tame(player, self)

    -- Called by unimobs.kitz_api.tame_mob() and unimobs.petz_api.tame_mob_with_lash()

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            not self or
            self.mob_type == nil then
        return
    end

    if mob_tame_table[self.mob_type] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "zoologist_collect_tame", "unimobs_zoologist_collect_tame_1", self.mob_type
        )

        unilib.awards.handle_simple_filter_trigger(
            player, "zoologist_select_tame", self.mob_type, 1
        )

    end

end

function unilib.pkg.award_zoologist.on_mob_breed(player, self)

    -- Called by create_baby_entity() in unimobs/lib/system/petz/petz_breed.lua

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            not self or
            self.mob_type == nil then
        return
    end

    if mob_breed_table[self.mob_type] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "zoologist_collect_breed", "unimobs_zoologist_collect_breed_1", self.mob_type
        )

        unilib.awards.handle_simple_filter_trigger(
            player, "zoologist_select_breed", self.mob_type, 1
        )

    end

end

function unilib.pkg.award_zoologist.on_mob_convert(player, old_self, new_self)

    -- Called by unimobs.petz_api.convert_mob()

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            not old_self or
            old_self.mob_type == nil then
        return
    end

    if mob_convert_table[old_self.mob_type] ~= nil then

        unilib.awards.handle_simple_filter_trigger(
            player, "zoologist_select_convert", old_self.mob_type, 1

        )
    end

end

function unilib.pkg.award_zoologist.on_mob_capture(player, self)

    -- Called by unimobs.petz_api.capture_mob()

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            not self or
            self.mob_type == nil then
        return
    end

    if unimobs.petz_msetting[self.mob_type] ~= nil then

        unilib.awards.handle_simple_filter_trigger(
            player, "zoologist_select_capture", self.mob_type, 1
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_zoologist.init()

    return {
        description = "Awards for interacting with mobs (\"Zoologist\")",
        notes = "Works with petz-compatible mobs in the unimobs expansion pack (only)",
    }

end

function unilib.pkg.award_zoologist.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Setup --------------------------------------------------------------------------------------

    -- Compile lists of creatures that can interact with the player
    compile_mobs()

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "zoologist_select_tame",
        trigger_type = "simple",
        hint_list = {"Tame one creature", "Tame @1 creatures"},
        progress_list = {"Tame one creature", "Tame @1/@2 creatures"},
    })

    unilib.awards.register_trigger_prototype({
        name = "zoologist_select_breed",
        trigger_type = "simple",
        hint_list = {"Breed one creature", "Breed @1 creatures"},
        progress_list = {"Breed one creature", "Breed @1/@2 creatures"},
    })

    unilib.awards.register_trigger_prototype({
        name = "zoologist_select_convert",
        trigger_type = "simple",
        hint_list = {"Convert one creature", "Convert @1 creatures"},
        progress_list = {"Convert one creature", "Convert @1/@2 creatures"},
    })

    unilib.awards.register_trigger_prototype({
        name = "zoologist_select_capture",
        trigger_type = "simple",
        hint_list = {"Capture one creature", "Capture @1 creatures"},
        progress_list = {"Capture one creature", "Capture @1/@2 creatures"},
    })

    unilib.awards.register_trigger_prototype({
        name = "zoologist_collect_repel",
        trigger_type = "custom",
        hint_list = {"Repel one type of creature", "Repel @1 types of creature"},
        progress_list = {"Repel one type of creature", "Repel @1/@2 types of creature"},
    })

    unilib.awards.register_trigger_prototype({
        name = "zoologist_collect_follow",
        trigger_type = "custom",
        hint_list = {"Attract one type of creature", "Attract @1 types of creature"},
        progress_list = {"Attract one type of creature", "Attract @1/@2 types of creature"},
    })

    unilib.awards.register_trigger_prototype({
        name = "zoologist_collect_tame",
        trigger_type = "custom",
        hint_list = {"Tame one type of creature", "Tame @1 types of creature"},
        progress_list = {"Tame one type of creature", "Tame @1/@2 types of creature"},
    })

    unilib.awards.register_trigger_prototype({
        name = "zoologist_collect_breed",
        trigger_type = "custom",
        hint_list = {"Breed one type of creature", "Breed @1 types of creature"},
        progress_list = {"Breed one type of creature", "Breed @1/@2 types of creature"},
    })

    -- Vocations ----------------------------------------------------------------------------------

    -- Assuming a "petz" remix, total score is 820
    unilib.awards.register_vocation({
        name = unilib.pkg.award_zoologist.vocation_name,

        title = S("Zoologist"),
        description = S("Tame, breed and capture many different creatures"),
        icon = "unilib_award_vocation_zoologist.png",
        level_list = {
            {title = S("Snack Distributor"), score = 10},
            {title = S("Clucks of Approval"), score = 20},
            {title = S("Horsing Around"), score = 59},
            {title = S("Pig Deal"), score = 100},
            {title = S("Wolfing It Down"), score = 150},
            {title = S("Mutton for Nothing"), score = 200},
            {title = S("Bee My Guest"), score = 300},
            {title = S("Feed Me, Seymour!"), score = 400},
            {title = S("The Zoo Must Go On"), score = 500},
            {title = S("Claws for Celebration"), score = 600},
            {title = S("Noah's Assistant"), score = 700},
            {title = S("Zoo Tycoon"), score = 800},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    -- N.B. For convenience, we re-use selective trigger prototypes from the section below
    for i, mini_list in ipairs({
        {"tame_1", "zoologist_select_tame", S("Amateur Trainer"), S("Tame 2 creatures"), 10, 2},
        {"tame_2", "zoologist_select_tame", S("Novice Trainer"), S("Tame 22 creatures"), 20, 22},
        {"tame_3", "zoologist_select_tame", S("Skilled Trainer"), S("Tame 222 creatures"), 30, 222},
        {"tame_4", "zoologist_select_tame", S("Veteran Trainer"), S("Tame 2222 creatures"), 40, 2222},

        {"breed_1", "zoologist_select_breed", S("Amateur Zookeeper"), S("Breed 2 creatures"), 10, 2},
        {"breed_2", "zoologist_select_breed", S("Novice Zookeeper"), S("Breed 22 creatures"), 20, 22},
        {"breed_3", "zoologist_select_breed", S("Skilled Zookeeper"), S("Breed 222 creatures"), 30, 222},
        {"breed_4", "zoologist_select_breed", S("Veteran Zookeeper"), S("Breed 2222 creatures"), 40, 2222},

        {"capture_1", "zoologist_select_capture", S("Amateur Animal Warden"), S("Capture 2 creatures"), 10, 2},
        {"capture_2", "zoologist_select_capture", S("Novice Animal Warden"), S("Capture 22 creatures"), 20, 22},
        {"capture_3", "zoologist_select_capture", S("Skilled Animal Warden"), S("Capture 222 creatures"), 30, 222},
        {"capture_4", "zoologist_select_capture", S("Veteran Animal Warden"), S("Capture 2222 creatures"), 40, 2222},
    }) do

        unilib.awards.register_achievement({
            name = "unimobs_zoologist_comb_" .. mini_list[1],
            trigger_table = {
                prototype = mini_list[2],
                target = mini_list[6],
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_zoologist.vocation_name},
        })

    end

    -- Selective achievements
    local tame_list = {}
    if mob_tame_table["bear_grizzly"] or mob_tame_table["bear_polar"] then
        table.insert(tame_list, {"bear_mixed", {"bear_grizzly", "bear_polar"}, S("Bearward"), S("Tame 9 bears"), 20, 9})
    end

    if mob_tame_table["camel_normal"] then
        table.insert(tame_list, {"camel_normal", "camel_normal", S("Camel Trainer"), S("Tame 12 camels"), 20, 12})
    end

    if mob_tame_table["cat_normal"] then
        table.insert(tame_list, {"cat_normal", "cat_normal", S("Cat Feeder"), S("Tame 13 cats"), 20, 13})
    end

    if mob_tame_table["elephant_normal_male"] or mob_tame_table["elephant_normal_female"] then
        table.insert(tame_list, {"elephant_mixed", {"elephant_normal_male", "elephant_normal_female"}, S("Mahout"), S("Tame 18 elephants"), 20, 1})
    end

    if mob_tame_table["pony_normal"] then
        table.insert(tame_list, {"pony_normal", "pony_normal", S("Horse Breaker"), S("Tame 10 ponies"), 20, 10})
    end

    for i, mini_list in ipairs(tame_list) do

        unilib.awards.register_achievement({
            name = "unimobs_zoologist_select_tame_" .. mini_list[1],
            trigger_table = {
                prototype = "zoologist_select_tame",
                target = mini_list[6],
                filter_list = unilib.utils.convert_to_list(mini_list[2]),
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_zoologist.vocation_name},
        })

    end

    local breed_list = {}
    if mob_breed_table["chicken_chicklet"] then
        table.insert(breed_list, {"chicken_chicklet", S("Chicken Farmer"), S("Breed 30 chickens"), 20, 30})
    end

    if mob_breed_table["cow_normal"] then
        table.insert(breed_list, {"cow_normal", S("Cattle Farmer"), S("Breed 30 cows"), 20, 30})
    end

    if mob_breed_table["pig_normal"] then
        table.insert(breed_list, {"pig_normal", S("Pig Farmer"), S("Breed 30 pigs"), 20, 30})
    end

    if mob_breed_table["penguin_normal"] then
        table.insert(breed_list, {"penguin_normal", S("Penguin Farmer"), S("Breed 30 penguins"), 20, 30})
    end

    if mob_breed_table["sheep_normal"] then
        table.insert(breed_list, {"sheep_normal", S("Sheep Farmer"), S("Breed 30 sheep"), 20, 30})
    end

    for i, mini_list in ipairs(breed_list) do

        unilib.awards.register_achievement({
            name = "unimobs_zoologist_select_breed_" .. mini_list[1],
            trigger_table = {
                prototype = "zoologist_select_breed",
                target = mini_list[5],
                filter_list = unilib.utils.convert_to_list(mini_list[1]),
            },

            title = mini_list[2],
            description = mini_list[3],
            score = mini_list[4],
            vocation_list = {unilib.pkg.award_zoologist.vocation_name},
        })

    end

    local convert_list = {}
    if mob_convert_table["wolf_normal"] then
        table.insert(convert_list, {"wolf_normal", S("Obedience trainer"), S("Convert 5 wolves"), 20, 5})
    end

    for i, mini_list in ipairs(convert_list) do

        unilib.awards.register_achievement({
            name = "unimobs_zoologist_select_convert_" .. mini_list[1],
            trigger_table = {
                prototype = "zoologist_select_convert",
                target = mini_list[5],
                filter_list = unilib.utils.convert_to_list(mini_list[1]),
            },

            title = mini_list[2],
            description = mini_list[3],
            score = mini_list[4],
            vocation_list = {unilib.pkg.award_zoologist.vocation_name},
        })

    end

    -- Collector achievements
    local collector_list = {}

    local repel_count = unilib.utils.get_table_size(mob_repel_table)
    if repel_count >= 2 then
        table.insert(collector_list, {S("Amateur Sentinel"), S("Repel 2 types of creature"), 10, 2})
    end

    if repel_count >= 5 then
        table.insert(collector_list, {S("Aspiring Sentinel"), S("Repel 5 types of creature"), 10, 5})
        table.insert(collector_list, {S("Elite Sentinel"), S("Repel every type of creature"), 50, repel_count})
    end

    if repel_count >= 10 then
        table.insert(collector_list, {S("Competent Sentinel"), S("Repel 10 types of creature"), 10, 10})
    end

    if repel_count >= 20 then
        table.insert(collector_list, {S("Skilled Sentinel"), S("Repel 20 types of creature"), 20, 20})
    end

    if repel_count >= 50 then
        table.insert(collector_list, {S("Veteran Sentinel"), S("Repel 50 types of creature"), 20, 50})
    end

    for i, mini_list in ipairs(collector_list) do

        unilib.awards.register_achievement({
            name = "unimobs_zoologist_collect_repel_" .. i,
            trigger_table = {
                prototype = "zoologist_collect_repel",
                target = mini_list[4],
            },

            title = mini_list[1],
            description = mini_list[2],
            score = mini_list[3],
            vocation_list = {unilib.pkg.award_zoologist.vocation_name},
        })

    end

    local follow_count = unilib.utils.get_table_size(mob_follow_table)
    if follow_count >= 2 then
        table.insert(collector_list, {S("Amateur Whisperer"), S("Attract 2 types of creature"), 10, 2})
    end

    if follow_count >= 5 then
        table.insert(collector_list, {S("Aspiring Whisperer"), S("Attract 5 types of creature"), 10, 5})
        table.insert(collector_list, {S("Elite Whisperer"), S("Attract every type of creature"), 50, follow_count})
    end

    if follow_count >= 10 then
        table.insert(collector_list, {S("Competent Whisperer"), S("Attract 10 types of creature"), 10, 10})
    end

    if follow_count >= 20 then
        table.insert(collector_list, {S("Skilled Whisperer"), S("Attract 20 types of creature"), 20, 20})
    end

    if follow_count >= 50 then
        table.insert(collector_list, {S("Veteran Whisperer"), S("Attract 50 types of creature"), 20, 50})
    end

    for i, mini_list in ipairs(collector_list) do

        unilib.awards.register_achievement({
            name = "unimobs_zoologist_collect_follow_" .. i,
            trigger_table = {
                prototype = "zoologist_collect_follow",
                target = mini_list[4],
            },

            title = mini_list[1],
            description = mini_list[2],
            score = mini_list[3],
            vocation_list = {unilib.pkg.award_zoologist.vocation_name},
        })

    end

    local tame_count = unilib.utils.get_table_size(mob_tame_table)
    if tame_count >= 2 then
        table.insert(collector_list, {S("Amateur Caretaker"), S("Tame 2 types of creature"), 10, 2})
    end

    if tame_count >= 5 then
        table.insert(collector_list, {S("Aspiring Caretaker"), S("Tame 5 types of creature"), 10, 5})
        table.insert(collector_list, {S("Elite Caretaker"), S("Tame every type of creature"), 50, tame_count})
    end

    if tame_count >= 10 then
        table.insert(collector_list, {S("Competent Caretaker"), S("Tame 10 types of creature"), 10, 10})
    end

    if tame_count >= 20 then
        table.insert(collector_list, {S("Skilled Caretaker"), S("Tame 20 types of creature"), 20, 20})
    end

    if tame_count >= 50 then
        table.insert(collector_list, {S("Veteran Caretaker"), S("Tame 50 types of creature"), 20, 50})
    end

    for i, mini_list in ipairs(collector_list) do

        unilib.awards.register_achievement({
            name = "unimobs_zoologist_collect_tame_" .. i,
            trigger_table = {
                prototype = "zoologist_collect_tame",
                target = mini_list[4],
            },

            title = mini_list[1],
            description = mini_list[2],
            score = mini_list[3],
            vocation_list = {unilib.pkg.award_zoologist.vocation_name},
        })

    end

    local breed_count = unilib.utils.get_table_size(mob_breed_table)
    if breed_count >= 2 then
        table.insert(collector_list, {S("Amateur Breeder"), S("Breed 2 types of creature"), 10, 2})
    end

    if breed_count >= 5 then
        table.insert(collector_list, {S("Aspiring Breeder"), S("Breed 5 types of creature"), 10, 5})
        table.insert(collector_list, {S("Elite Breeder"), S("Breed every type of creature"), 50, breed_count})
    end

    if breed_count >= 10 then
        table.insert(collector_list, {S("Competent Breeder"), S("Breed 10 types of creature"), 10, 10})
    end

    if breed_count >= 20 then
        table.insert(collector_list, {S("Skilled Breeder"), S("Breed 20 types of creature"), 20, 20})
    end

    if breed_count >= 50 then
        table.insert(collector_list, {S("Veteran Breeder"), S("Breed 50 types of creature"), 20, 50})
    end

    for i, mini_list in ipairs(collector_list) do

        unilib.awards.register_achievement({
            name = "unimobs_zoologist_collect_breed_" .. i,
            trigger_table = {
                prototype = "zoologist_collect_breed",
                target = mini_list[4],
            },

            title = mini_list[1],
            description = mini_list[2],
            score = mini_list[3],
            vocation_list = {unilib.pkg.award_zoologist.vocation_name},
        })

    end

end
