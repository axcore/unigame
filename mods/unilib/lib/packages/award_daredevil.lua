---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_daredevil = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_daredevil.vocation_name = "unilib_daredevil"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_die(player, hp_change_table)

    if not unilib.utils.is_player(player) or
            hp_change_table == nil or
            hp_change_table.type == nil then
        return
    end

    -- N.B. "hp_change_table" is a Minetest PlayerHPChangeReason
    local reason = hp_change_table.type
    local pos = player:get_pos()

    -- Die in (a medium)
    if reason == "node_damage" and hp_change_table.node ~= nil then

        for _, achievement_name in ipairs(
            unilib.awards.retrieve_data_from_simple_watch_table(player, "daredevil_select_die_in")
        ) do

            local trigger_table =
                    unilib.global.awards_achievement_table[achievement_name]["trigger_table"]

            -- N.B. In this case, we do NOT handle the event if .filter_list is nil
            if trigger_table.filter_list ~= nil and
                    unilib.utils.is_value_in_list(
                        hp_change_table.node, trigger_table.filter_list
                    ) then
                unilib.awards.increment_achievement_counter(player, achievement_name, 1)
            end

        end

    -- Die near (a node)
    elseif reason == "set_hp" and pos then

        for _, achievement_name in ipairs(
            unilib.awards.retrieve_data_from_simple_watch_table(player, "daredevil_select_die_near")
        ) do

            local trigger_table =
                    unilib.global.awards_achievement_table[achievement_name]["trigger_table"]

            -- N.B. In this case, we do NOT handle the event if .filter_list is nil
            if trigger_table.filter_list ~= nil then

                for _, item in ipairs(trigger_table.filter_list) do

                    if core.find_node_near(pos, 2, item) ~= nil then

                        unilib.awards.increment_achievement_counter(player, achievement_name, 1)
                        break

                    end

                end

            end

        end

    end

    -- Die at (a position)
    if pos then

        for _, achievement_name in ipairs(
            unilib.awards.retrieve_data_from_simple_watch_table(player, "daredevil_select_die_at")
        ) do

            -- .filter_list in the form (max_x, min_x, max_y, min_y, max_z, min_z), where any or
            --      all values can be specified
            local trigger_table =
                    unilib.global.awards_achievement_table[achievement_name]["trigger_table"]

            -- N.B. In this case, we do NOT handle the event if .filter_list is nil
            if trigger_table.filter_list ~= nil then

                local max_x = trigger_table.filter_list[1]
                local min_x = trigger_table.filter_list[2]
                local max_y = trigger_table.filter_list[3]
                local min_y = trigger_table.filter_list[4]
                local max_z = trigger_table.filter_list[5]
                local min_z = trigger_table.filter_list[6]
                if (max_x ~= nil and pos.x <= max_x) or
                        (min_x ~= nil and pos.x >= min_x) or
                        (max_y ~= nil and pos.y <= max_y) or
                        (min_y ~= nil and pos.y >= min_y) or
                        (max_z ~= nil and pos.z <= max_z) or
                        (min_z ~= nil and pos.z >= min_z) then
                    unilib.awards.increment_achievement_counter(player, achievement_name, 1)
                end

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_daredevil.init()

    return {
        description = "Player death awards (\"Daredevil\")",
        notes = "Awards for your own player's deaths. Assumes a world with a radius of at least" ..
                " 10,000 blocks",
    }

end

function unilib.pkg.award_daredevil.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "daredevil_select_die_in",
        trigger_type = "simple",
        hint_list = {"Die in something once", "Die in something @1 times"},
        progress_list = {"Die in something once", "Die in something @1/@2 times"},
    })

    unilib.awards.register_trigger_prototype({
        name = "daredevil_select_die_near",
        trigger_type = "simple",
        hint_list = {"Die near something once", "Die near something @1 times"},
        progress_list = {"Die near something once", "Die near something @1/@2 times"},
    })

    unilib.awards.register_trigger_prototype({
        name = "daredevil_select_die_at",
        trigger_type = "simple",
        hint_list = {"Die somewhere once", "Die somewhere @1 times"},
        progress_list = {"Die somewhere once", "Die somewhere @1/@2 times"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    core.register_on_dieplayer(function(player, hp_change_table)
        on_die(player, hp_change_table)
    end)

    -- Vocations ----------------------------------------------------------------------------------

    -- Achievement scores below total 700
    unilib.awards.register_vocation({
        name = unilib.pkg.award_daredevil.vocation_name,

        title = S("Daredevil"),
        description = S("Awards for the player who laughs in the face of danger"),
        icon = "unilib_award_vocation_daredevil.png",
        level_list = {
            {title = S("What Hit Me?"), score = 10},
            {title = S("I Meant to Do That!"), score = 20},
            {title = S("Damage Magnet"), score = 40},
            {title = S("Heroic Miscalculation"), score = 70},
            {title = S("Gravity's Favourite Customer"), score = 100},
            {title = S("Out of the Frying Pan, Into the Fire"), score = 130},
            {title = S("In the Wrong Neighbourhood"), score = 160},
            {title = S("Natural Selection at Work"), score = 220},
            {title = S("Wrong Place, Wrong Time"), score = 300},
            {title = S("The Universe Hates Me"), score = 400},
            {title = S("Darwin Award Nominee"), score = 500},
            {title = S("Apprentice to The Grim Reaper"), score = 600},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    local diamond_list = {
        "unilib:stone_ordinary_with_diamond",
            "default:stone_with_diamond",
    }

    local fire_list = {
        "unilib:fire_ordinary",
            "fire:basic_flame",
    }

    local lava_list = {
        "unilib:liquid_lava_ordinary_source",
            "default:lava_source",
        "unilib:liquid_lava_ordinary_flowing",
            "default:lava_flowing",
        "unilib:liquid_lava_cooling_source",
        "unilib:liquid_lava_cooling_flowing",
    }

    -- Combination achievements
    for i, mini_list in ipairs({
        -- Total death achievements
        {"all_1", nil, S("I Got Distracted!"), S("Die 9 times"), 20, 9},
        {"all_2", nil, S("What Could Go Wrong?"), S("Die 27 times"), 50, 27},
        {"all_3", nil, S("Instant Regret"), S("Die 81 times"), 100, 100},
        -- Achievements sorted by death reason
        -- As of Minetest v5.15.1, death "reasons" seem to include "set_hp", "punch", "fall",
        --      "node_damage" and "drown" (see ../src/server/player_sao.h)
        {"hp_1", "set_hp", S("Hardcore? Never again!"), S("Die from losing HP 2 times"), 10, 2},
        {"hp_2", "set_hp", S("Bravely Ran Away"), S("Die from losing HP 10 times"), 20, 10},
        {"hp_3", "set_hp", S("Half-Heart Hero"), S("Die from losing HP 50 times"), 30, 50},

        {"punch_1", "punch", S("Glass Jaw"), S("Die from being punched 2 times"), 10, 2, },
        {"punch_2", "punch", S("Punching Bag"), S("Die from being punched 10 times"), 20, 10},
        {"punch_3", "punch", S("Creeper Hugger"), S("Die from being punched 50 times"), 30, 50},

        {"fall_1", "fall", S("Amateur Parkour Enthusiast"), S("Die from falling 2 times"), 10, 2},
        {"fall_2", "fall", S("Living on the Edge"), S("Die from falling 10 times"), 20, 10},
        {"fall_3", "fall", S("Frequent Flyer"), S("Die from falling 50 times"), 30, 50},

        {"node_1", "node_damage", S("Trap Tester"), S("Die from dangerous nodes 2 times"), 10, 2},
        {"node_2", "node_damage", S("Morbid Curiosity"), S("Die from dangerous nodes 10 times"), 20, 10},
        {"node_3", "node_damage", S("The Devil May Care"), S("Die from dangerous nodes 50 times"), 30, 50},

        {"drown_1", "drown", S("Gone for a Swim"), S("Die from drowning 2 times"), 10, 2},
        {"drown_2", "drown", S("Barely Breathing"), S("Die from drowning 10 times"), 20, 10},
        {"drown_3", "drown", S("Blind to Bubbles"), S("Die from drowning 50 times"), 30, 50},
    }) do

        unilib.awards.register_achievement({
            name = "unilib_daredevil_comb_" .. mini_list[1],
            trigger_table = {
                prototype = "unilib_die",
                target = mini_list[6],
                filter_list = unilib.utils.convert_to_list(mini_list[2]),
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_daredevil.vocation_name},
        })

    end

    -- Selective achievements ("simple" triggers)
    local select_list_simple = {
        -- "Die in" achievements
        {"fire", fire_list, "daredevil_select_die_in", S("Lightly Toasted"), S("Die in fire"), 10, 1},
        {"lava", lava_list, "daredevil_select_die_in", S("Lava-Proof? Surprisingly, No"), S("Die in lava"), 10, 1},
        -- "Die near" achievements
--      {"bones", "bones:bones", "daredevil_select_die_near", S("Bone Voyage"), S("Die near bones"), 10, 1},
        {"diamond", diamond_list, "daredevil_select_die_near", S("So Near and Yet So Far"), S("Die near diamond ore"), 10, 1},
        -- "Die at" achievements (height)
        {"above_1", {nil, nil, nil, 100, nil, nil}, "daredevil_select_die_at", S("Jealous of Birds"), S("Die above 100"), 10, 1},
        {"above_2", {nil, nil, nil, 1000, nil, nil}, "daredevil_select_die_at", S("Altitude Sickness"), S("Die above 1000"), 20, 1},
        {"below_1", {nil, nil, -100, nil, nil, nil}, "daredevil_select_die_at", S("Mining Without Insurance"), S("Die below -100"), 10, 1},
        {"below_2", {nil, nil, -1000, nil, nil, nil}, "daredevil_select_die_at", S("Dig Straight Down, They Said"), S("Die below -1000"), 20, 1},
        {"below_3", {nil, nil, -10000, nil, nil, nil}, "daredevil_select_die_at", S("Future Archaeological Find"), S("Die below -10,000"), 30, 1},
        -- "Die at" achievements (distance)
        {"north", {nil, nil, nil, nil, nil, 10000}, "daredevil_select_die_at", S("Dinner for Polar Bears"), S("Die at least 10,000 blocks north of origin"), 30, 1},
        {"south", {nil, nil, nil, nil, nil, -10000}, "daredevil_select_die_at", S("Dinner for Walruses"), S("Die at least 10,000 blocks south of origin"), 30, 1},
        {"west", {nil, -10000, nil, nil, nil, nil}, "daredevil_select_die_at", S("Westward Ho!"), S("Die at least 10,000 blocks west of origin"), 30, 1},
        {"east", {nil, 10000, nil, nil, nil, nil}, "daredevil_select_die_at", S("Singed by the Rising Sun"), S("Die at least 10,000 blocks east of origin"), 30, 1},
    }

    if core.registered_items["bones:bones"] ~= nil then
        table.insert(select_list_simple, {"bones", "bones:bones", "daredevil_select_die_near", S("Bone Voyage"), S("Die near bones"), 10, 1})
    end

    for i, mini_list in ipairs(select_list_simple) do

        unilib.awards.register_achievement({
            name = "unilib_daredevil_select_" .. mini_list[1],
            trigger_table = {
                prototype = mini_list[3],
                target = mini_list[7],
                filter_list = unilib.utils.convert_to_list(mini_list[2]),
            },

            title = mini_list[4],
            description = mini_list[5],
            score = mini_list[6],
            vocation_list = {unilib.pkg.award_daredevil.vocation_name},
        })

    end

    -- Selective achievements ("complex" triggers)
    local select_list_complex = {
        -- Pyromania
        {"flint_steel", "unilib:mineral_flint_lump_with_steel", "unilib_craft", S("Match Made in Heaven"), S("Craft 5 flint and steel"), 10, 5},
        {"extinguish", fire_list, "unilib_break", S("Burning Ambition"), S("Extinguish 101 fires"), 10, 101},
    }

    for i, mini_list in ipairs(select_list_complex) do

        unilib.awards.register_achievement({
            name = "unilib_daredevil_select_" .. mini_list[1],
            trigger_table = {
                prototype = mini_list[3],
                target = mini_list[7],
                item_list = unilib.utils.convert_to_list(mini_list[2]),
            },

            title = mini_list[4],
            description = mini_list[5],
            score = mini_list[6],
            vocation_list = {unilib.pkg.award_daredevil.vocation_name},
        })

    end

end
