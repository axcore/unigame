---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_voyager = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Localise math functions (for speed)
local abs = math.abs
local floor = math.floor
local sqrt = math.sqrt

-- N.B. This value also used in the "award_spelunker" package
local world_boundary = 30925

-- Table of player positions; updated whenever a player moves to a new position
local player_pos_table = {}
-- Ignore distance changes greater than this (indicating flying, cheating or teleporting)
local max_delta = 7

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_voyager.vocation_name = "unilib_voyager"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function unlock_axis_achievement(player, awards_table, achievement_name, pos_n)

    -- This award is locked; unlock, if the target has been reached, otherwise store the player's
    --      axis position "pos_n" as an indication of progress towards the target
    local target =
            unilib.global.awards_achievement_table[achievement_name]["trigger_table"]["target"]

    if target < 0 then

        if pos_n <= target then

            unilib.awards.unlock_achievement(player, achievement_name)

        else

            if awards_table["current_table"][achievement_name] == nil or
                    awards_table["current_table"][achievement_name] > pos_n then
                awards_table["current_table"][achievement_name] = pos_n
            end

        end

    else

        if pos_n >= target then

            unilib.awards.unlock_achievement(player, achievement_name)

        else

            if awards_table["current_table"][achievement_name] == nil or
                    awards_table["current_table"][achievement_name] < pos_n then
                awards_table["current_table"][achievement_name] = pos_n
            end

        end

    end

end

local function unlock_distance_achievement(player, awards_table, achievement_name, pos)

    -- This award is locked; unlock, if the target has been reached, otherwise store the player's
    --      distance from origin as an indication of progress towards the target
    local distance = floor(sqrt((pos.x * pos.x) + (pos.z * pos.z)) + 0.5)
    local target =
            unilib.global.awards_achievement_table[achievement_name]["trigger_table"]["target"]

    if distance >= target then

        unilib.awards.unlock_achievement(player, achievement_name)

    else

        if awards_table["current_table"][achievement_name] == nil or
                awards_table["current_table"][achievement_name] > distance then
            awards_table["current_table"][achievement_name] = distance
        end

    end

end

local function unlock_boundary_achievement(player, awards_table, achievement_name, pos)

    -- This award is locked; unlock, if the target has been reached, otherwise store the player's
    --      distance from origin as an indication of progress towards the target
    local pos_x = abs(pos.x)
    local pos_z = abs(pos.z)

    local distance = ((pos_x > pos_z) and pos_x) or pos_z
    local target =
            unilib.global.awards_achievement_table[achievement_name]["trigger_table"]["target"]

    if distance >= target then

        unilib.awards.unlock_achievement(player, achievement_name)

    else

        if awards_table["current_table"][achievement_name] == nil or
                awards_table["current_table"][achievement_name] > distance then
            awards_table["current_table"][achievement_name] = distance
        end

    end

end

local function on_trek(player, pos)

    local pname = player:get_player_name()
    local old_pos = player_pos_table[pname]
    player_pos_table[pname] = pos

    -- If player just connected to server; calculate distance travelled from this point onwards
    if old_pos == nil then
        return
    end

    -- Trekking awards don't apply when player is mounted on a pony, riding in a vehicle, etc
    if player:get_attach() then
        return
    end

--  local delta = vector.distance(pos, player_pos_table[pname])
    local delta = vector.distance(
        {x = pos.x, y = 0, z = pos.z},
        {x = old_pos.x, y = 0, z = old_pos.z}
    )

    if delta > 0 and delta < max_delta then

        local current_table = unilib.global.awards_player_table[pname]["current_table"]

        for _, achievement_name in ipairs(
            unilib.awards.retrieve_data_from_custom_watch_table(player, "voyager_comb_trek")
        ) do

            current_table[achievement_name] = (current_table[achievement_name] or 0) + delta

            local trigger_table =
                    unilib.global.awards_achievement_table[achievement_name]["trigger_table"]
            if current_table[achievement_name] >= trigger_table.target then
                unilib.awards.unlock_achievement(player, achievement_name)
            end

        end

    end

end

local function on_step(player, pos)

    unilib.awards.handle_complex_trigger(
        player, "voyager_select_step_in", core.get_node(pos).name, 1
    )

    pos.y = pos.y - 1
    unilib.awards.handle_complex_trigger(
        player, "voyager_select_step_on", core.get_node(pos).name, 1
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_voyager.init()

    return {
        description = "Exploration awards (\"Voyager\")",
        notes = "Awards for travelling far from the world origin, and for visiting different" ..
                " biomes. Assumes a world whose size is at least +-30000, and an origin close" ..
                " to {x=0, z=0}. These awards should not be used in worlds, in which" ..
                " teleportation is available",
    }

end

function unilib.pkg.award_voyager.post()

    -- Sanity check -------------------------------------------------------------------------------

    -- Most awards in this vocation depend on monitor callbacks, so don't both creating the vocation
    --      at all, if monitor callbacks are disabled
    if not unilib.setting.awards_enable_flag or unilib.setting.awards_disable_monitors_flag then
        return
    end

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "voyager_range_x",
        trigger_type = "custom",
        hint_list = {"Travel a distance of one block", "Travel a distance of @1 blocks"},
        progress_list = {"Travel a distance of one block", "Travel a distance of @1/@2 blocks"},
    })

    unilib.awards.register_trigger_prototype({
        name = "voyager_range_z",
        trigger_type = "custom",
        hint_list = {"Travel a distance of one block", "Travel a distance of @1 blocks"},
        progress_list = {"Travel a distance of one block", "Travel a distance of @1/@2 blocks"},
    })

    unilib.awards.register_trigger_prototype({
        name = "voyager_range_xz",
        trigger_type = "custom",
        hint_list = {"Travel a distance of one block", "Travel a distance of @1 blocks"},
        progress_list = {"Travel a distance of one block", "Travel a distance of @1/@2 blocks"},
    })

    unilib.awards.register_trigger_prototype({
        name = "voyager_range_dist",
        trigger_type = "custom",
        hint_list = {"Travel one block away from origin", "Travel @1 blocks away from origin"},
        progress_list = {"Travel one block away from origin", "Travel @1/@2 blocks away from origin"},
    })

    unilib.awards.register_trigger_prototype({
        name = "voyager_comb_trek",
        trigger_type = "custom",
        hint_list = {"Walk or swim a total of one block", "Walk or swim a total of @1 blocks"},
        progress_list = {"Walk or swim a total of one block", "Walk or swim a total of @1/@2 blocks"},
    })

    -- (Step on regular blocks)
    unilib.awards.register_trigger_prototype({
        name = "voyager_select_step_on",
        trigger_type = "complex",
        hint_list = {"Step on a block", "Step on @1 blocks"},
        progress_list = {"Step on a block", "Step on @1/@2 blocks"},
    })

    -- (Step "in" a block such as ordinary snow)
    unilib.awards.register_trigger_prototype({
        name = "voyager_select_step_in",
        trigger_type = "complex",
        hint_list = {"Step in a block", "Step in @1 blocks"},
        progress_list = {"Step in a block", "Step in @1/@2 blocks"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    unilib.awards.register_monitor_callback(
        "pos_x",
        function(player, pos)

            local pname = player:get_player_name()
            local awards_table = unilib.global.awards_player_table[pname]

            for _, achievement_name in ipairs(
                unilib.awards.retrieve_data_from_custom_watch_table(player, "voyager_range_x")
            ) do

                if awards_table["unlock_table"][achievement_name] == nil then

                    unlock_axis_achievement(
                        player, awards_table, achievement_name, floor(pos.x + 0.5)
                    )

                end

            end

        end
    )

    unilib.awards.register_monitor_callback(
        "pos_z",
        function(player, pos)

            local pname = player:get_player_name()
            local awards_table = unilib.global.awards_player_table[pname]

            for _, achievement_name in ipairs(
                unilib.awards.retrieve_data_from_custom_watch_table(player, "voyager_range_z")
            ) do

                if awards_table["unlock_table"][achievement_name] == nil then

                    unlock_axis_achievement(
                        player, awards_table, achievement_name, floor(pos.z + 0.5)
                    )

                end

            end

        end
    )

    unilib.awards.register_monitor_callback(
        "pos_str",
        function(player, pos)

            local pname = player:get_player_name()
            local awards_table = unilib.global.awards_player_table[pname]

            for _, achievement_name in ipairs(
                unilib.awards.retrieve_data_from_custom_watch_table(player, "voyager_range_dist")
            ) do

                if awards_table["unlock_table"][achievement_name] == nil then
                    unlock_distance_achievement(player, awards_table, achievement_name, pos)
                end

            end

            for _, achievement_name in ipairs(
                unilib.awards.retrieve_data_from_custom_watch_table(player, "voyager_range_xz")
            ) do

                if awards_table["unlock_table"][achievement_name] == nil then
                    unlock_boundary_achievement(player, awards_table, achievement_name, pos)
                end

            end

            on_trek(player, pos)
            on_step(player, pos)

        end
    )

    -- Vocations ----------------------------------------------------------------------------------

    -- Scores for each level depend on whether the "award_voyager_biomes" package has been loaded;
    --      here, we assume that it provides 10 new achievements with a combined score of 200
    --      (adding to the 990 we already have)
    local score_list
    if unilib.global.pkg_executed_table["award_voyager_biomes"] == nil then
        score_list = {10, 20, 40, 60, 100, 150, 200, 300, 400, 500, 600, 800}
    else
        score_list = {10, 20, 50, 100, 150, 200, 300, 400, 500, 650, 800, 1000}
    end

    unilib.awards.register_vocation({
        name = unilib.pkg.award_voyager.vocation_name,

        title = S("Voyager"),
        description = S("Travel to the far ends of the world"),
        icon = "unilib_award_vocation_voyager.png",
        level_list = {
            {title = S("First Day on the Trail"), score = score_list[1]},
            {title = S("Are We Nearly There Yet?"), score = score_list[2]},
            {title = S("Wait - There are OTHER biomes?"), score = score_list[3]},
            {title = S("Should've Brought a Horse"), score = score_list[4]},
            {title = S("I Could Swear I've Been Here Before"), score = score_list[5]},
            {title = S("Lost with Gusto"), score = score_list[6]},
            {title = S("Officially Too Far to Walk Back"), score = score_list[7]},
            {title = S("Off the Beaten Path"), score = score_list[8]},
            {title = S("The Horizon Has Given Up"), score = score_list[9]},
            {title = S("The World Border Is Getting Nervous"), score = score_list[10]},
            {title = S("Born Under a Wandering Star"), score = score_list[11]},
            {title = S("Disciple of Lee Marvin"), score = score_list[12]},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements (range)
    for i, mini_list in ipairs({
        -- Travel far from origin, in specific compass directions. (The player could, of course,
        --      kill two birds with one stone by travelling northwest or southeast...)
        {"north_1", "voyager_range_z", S("Amateur Arctic Voyager"), S("Travel 1000 blocks north of origin"), 10, 1000},
        {"north_2", "voyager_range_z", S("Novice Arctic Voyager"), S("Travel 10000 blocks north of origin"), 20, 10000},
        {"north_3", "voyager_range_z", S("Skilled Arctic Voyager"), S("Travel 20000 blocks north of origin"), 30, 20000},
        {"north_4", "voyager_range_z", S("Veteran Arctic Voyager"), S("Travel 30000 blocks north of origin"), 40, 30000},

        {"south_1", "voyager_range_z", S("Amateur Antarctic Voyager"), S("Travel 1000 blocks south of origin"), 10, -1000},
        {"south_2", "voyager_range_z", S("Novice Antarctic Voyager"), S("Travel 10000 blocks south of origin"), 20, -10000},
        {"south_3", "voyager_range_z", S("Skilled Antarctic Voyager"), S("Travel 20000 blocks south of origin"), 30, -20000},
        {"south_4", "voyager_range_z", S("Veteran Antarctic Voyager"), S("Travel 30000 blocks south of origin"), 40, -30000},

        {"west_1", "voyager_range_x", S("Amateur Occidental Voyager"), S("Travel 1000 blocks west of origin"), 10, -1000},
        {"west_2", "voyager_range_x", S("Novice Occidental Voyager"), S("Travel 10000 blocks west of origin"), 20, -10000},
        {"west_3", "voyager_range_x", S("Skilled Occidental Voyager"), S("Travel 20000 blocks west of origin"), 30, -20000},
        {"west_4", "voyager_range_x", S("Veteran Occidental Voyager"), S("Travel 30000 blocks west of origin"), 40, -30000},

        {"east_1", "voyager_range_x", S("Amateur Oriental Voyager"), S("Travel 1000 blocks east of origin"), 10, 1000},
        {"east_2", "voyager_range_x", S("Novice Oriental Voyager"), S("Travel 10000 blocks east of origin"), 20, 10000},
        {"east_3", "voyager_range_x", S("Skilled Oriental Voyager"), S("Travel 20000 blocks east of origin"), 30, 20000},
        {"east_4", "voyager_range_x", S("Veteran Oriental Voyager"), S("Travel 30000 blocks east of origin"), 40, 30000},

        -- Travel far from origin, in any direction
        {"dist_1", "voyager_range_dist", S("Amateur World Traveller"), S("Travel 1000 blocks away from origin"), 10, 1000},
        {"dist_2", "voyager_range_dist", S("Novice World Traveller"), S("Travel 10000 blocks away from origin"), 20, 10000},
        {"dist_3", "voyager_range_dist", S("Skilled World Traveller"), S("Travel 20000 blocks away from origin"), 30, 20000},
        {"dist_4", "voyager_range_dist", S("Veteran World Traveller"), S("Travel 30000 blocks away from origin"), 40, 30000},
        {"dist_5", "voyager_range_dist", S("Master World Traveller"), S("Travel 40000 blocks away from origin"), 50, 40000},
        -- Reach the world boundary, in any direction
        {"dist_6", "voyager_range_xz", S("Elite World Traveller"), S("Travel to the end of the world"), 100, world_boundary},
    }) do

        unilib.awards.register_achievement({
            name = "unilib_voyager_range_" .. mini_list[1],
            trigger_table = {
                prototype = mini_list[2],
                target = mini_list[6],
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_voyager.vocation_name},
        })

    end

    -- Combination achievements (other)
    for i, mini_list in ipairs({
        -- Aggregated total travel distance
        {"total_1", "voyager_comb_trek", S("Amateur Trekker"), S("Walk or swim a total of 1000 blocks"), 10, 1000},
        {"total_2", "voyager_comb_trek", S("Novice Trekker"), S("Walk or swim a total of 10,000 blocks"), 20, 10000},
        {"total_3", "voyager_comb_trek", S("Skilled Trekker"), S("Walk or swim a total of 25,000 blocks"), 30, 25000},
        {"total_4", "voyager_comb_trek", S("Seasoned Trekker"), S("Walk or swim a total of 100,000 blocks"), 40, 100000},
        {"total_5", "voyager_comb_trek", S("Veteran Trekker"), S("Walk or swim a total of 250,000 blocks"), 50, 250000},
        {"total_6", "voyager_comb_trek", S("Master Trekker"), S("Walk or swim a total of 1,000,000 blocks"), 100, 1000000},
        {"total_7", "voyager_comb_trek", S("Grandmaster Trekker"), S("Walk or swim a total of 2,500,000 blocks"), 150, 2500000},
        {"total_8", "voyager_comb_trek", S("Elite Trekker"), S("Walk or swim a total of 10,000,000 blocks"), 200, 10000000},
    }) do

        unilib.awards.register_achievement({
            name = "unilib_voyager_comb_" .. mini_list[1],
            trigger_table = {
                prototype = mini_list[2],
                target = mini_list[6],
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_voyager.vocation_name},
        })

    end

    -- Selective achievements
    for i, mini_list in ipairs({
        -- Step in/on
        {"step_ice_ordinary", "unilib:ice_ordinary", "voyager_select_step_on", S("Cold Feet"), S("Step on ordinary ice"), 10, 1},
        {"step_sand_desert", "unilib:sand_desert", "voyager_select_step_on", S("Lawrence of Arabia"), S("Step on desert sand"), 10, 1},
        {"step_sand_ordinary", "unilib:sand_ordinary", "voyager_select_step_on", S("A Day at the Beach"), S("Step on ordinary sand"), 10, 1},
        {"step_snow_ordinary", "unilib:snow_ordinary", "voyager_select_step_in", S("Snowman's Land"), S("Step on ordinary snow"), 10, 1},
        -- Other
        {"quadcorder_digital", "unilib:item_quadcorder_digital", "unilib_craft", S("Navigator"), S("Craft a digital quadcorder"), 10, 1},
    }) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unilib_voyager_select_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_voyager.vocation_name},
            })

        end

    end

end
