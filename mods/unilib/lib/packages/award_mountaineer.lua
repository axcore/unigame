---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_mountaineer = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Localise math functions (for speed)
local floor = math.floor

-- Split the world into zones with this width
local zone_size = 500
-- Mountains must be at least this high. 100 is appropriate for the "carpathian" mapgen; perhaps
--      use 50 or 60 for other mapgens
local mountain_height = 100

-- Table of non-walkable blocks, on which the player can be standing in order to mark a location as
--      climbed
local alt_block_table = {
    ["unilib:snow_ordinary"] = true,
    ["default:snow"] = true,
}

-- Chat window message shown after every successful climb
local success_msg =
    "The Mountaineers' Club congratulates you on climbing another mountain" ..
    " (total climbed so far: @1)." ..
    " Your next climb should be an average of @2m from this location!"

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_mountaineer.vocation_name = "unilib_mountaineer"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_zone_str(pos)

    -- The world having been divided up into zones of size "zone_size", return a string that's
    --      unique to the current zone

    local x = floor(pos.x / zone_size) * zone_size
    local z = floor(pos.z / zone_size) * zone_size

    return x .. "_" .. z

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_mountaineer.init()

    return {
        description = "Climbing awards (\"Mountaineer\")",
        notes = "Awards for climbing hills and mountains. The world is divided into zones of a" ..
                " specified width; only one climb in each zone counts towards achievements." ..
                " These awards assume a spawn point at a location near the surface, and should" ..
                " not be used in worlds, in which flying is possible",
    }

end

function unilib.pkg.award_mountaineer.post()

    -- Sanity check -------------------------------------------------------------------------------

    -- All awards in this vocation depend on monitor callback, so don't both creating the vocation
    --      at all, if monitor callbacks are disabled
    if not unilib.setting.awards_enable_flag or unilib.setting.awards_disable_monitors_flag then
        return
    end

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "mountaineer_comb_count",
        trigger_type = "custom",
        hint_list = {"Climb one mountain", "Climb @1 mountains"},
        progress_list = {"Climb one mountain", "Climb @1/@2 mountains"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    unilib.awards.register_monitor_callback(
        "pos_str",
        function(player, pos)

            -- Sanity check: must be high enough, must be standing on a walkable block
            if pos.y < mountain_height then
                return
            end

            local below_node = core.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
            if not below_node then
                return
            end

            if alt_block_table[below_node.name] == nil then

                local def_table = core.registered_nodes[below_node.name]
                if not def_table.walkable then
                    return
                end

            end

            -- The world having been divided up into zones of size "zone_size", return a string
            --      that's unique to the current zone
            local zone_str = get_zone_str(pos)

            -- If a mountain in a new zone has not been climed, the function returns nil
            local count = unilib.awards.add_item_to_collection(
                player, "unilib_mountaineer_comb_1", zone_str
            )
            if count == nil then
                return
            end

            -- Unusual step: show a message for every mountain claimed, as it's potentially
            --      confusing for a player, if a new achievement is not unlocked
            unilib.utils.chat_send_player(pname, S(success_msg, count, zone_size))

            -- Now we can check achievements individually
            for _, achievement_name in ipairs(
                unilib.awards.retrieve_data_from_custom_watch_table(
                    player, "mountaineer_comb_count"
                )
            ) do

                if awards_table["unlock_table"][achievement_name] == nil then
                    unilib.awards.unlock_collection_achievement(player, achievement_name, count)
                end

            end

        end
    )

    -- Vocations ----------------------------------------------------------------------------------

    unilib.awards.register_vocation({
        name = unilib.pkg.award_mountaineer.vocation_name,

        title = S("Mountaineer"),
        description = S("Climb mountains until you've bagged them all"),
        icon = "unilib_award_vocation_mountaineer.png",
        level_list = {
            {title = S("First Ascent"), score = 10},
            {title = S("Is This Even a Mountain?"), score = 20},
            {title = S("Weekend Rambler"), score = 30},
            {title = S("Mountain Goat in Training"), score = 40},
            {title = S("Forgot to Breathe but Kept Going"), score = 50},
            {title = S("Altitude Attitude"), score = 60},
            {title = S("Clouds Are Just an Illusion"), score = 70},
            {title = S("Sherpa in Training"), score = 80},
            {title = S("The Air Is Getting Thin"), score = 90},
            {title = S("Peak Performance "), score = 100},
            {title = S("Hill-Bent on Adventure"), score = 110},
            {title = S("Disciple of Edmund Hilary"), score = 120},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    for i, mini_list in ipairs({
        {S("Amateur Climber"), S("Climb 1 mountain"), 10, 1},
        {S("Aspiring Climber"), S("Climb 2 mountains"), 10, 2},
        {S("Junior Climber"), S("Climb 3 mountains"), 10, 3},
        {S("Novice Climber"), S("Climb 5 mountains"), 10, 5},
        {S("Competent Climber"), S("Climb 7 mountains"), 10, 7},
        {S("Skilled Climber"), S("Climb 10 mountains"), 10, 10},
        {S("Seasoned Climber"), S("Climb 15 mountains"), 10, 15},
        {S("Advanced Climber"), S("Climb 20 mountains"), 10, 20},
        {S("Veteran Climber"), S("Climb 25 mountains"), 10, 25},
        {S("Master Climber"), S("Climb 30 mountains"), 10, 30},
        {S("Grandmaster Climber"), S("Climb 40 mountains"), 10, 40},
        {S("Elite Climber"), S("Climb 50 mountains"), 10, 50},
    }) do

        unilib.awards.register_achievement({
            name = "unilib_mountaineer_comb_" .. i,
            trigger_table = {
                prototype = "mountaineer_comb_count",
                target = mini_list[4],
            },

            title = mini_list[1],
            description = mini_list[2],
            score = mini_list[3],
            vocation_list = {unilib.pkg.award_mountaineer.vocation_name},
        })

    end

end
