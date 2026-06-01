---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_spelunker = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Localise math functions (for speed)
local floor = math.floor

-- N.B. This value also used in the "award_voyager" package
local world_bottom = -30925

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_spelunker.vocation_name = "unilib_spelunker"

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_spelunker.init()

    return {
        description = "Subterranean awards (\"Spelunker\")",
        notes = "Awards for digging far below the surface; assumes a world whose depth is at" ..
                " least 30,000, and a surface no lower than y=0",
    }

end

function unilib.pkg.award_spelunker.post()

    -- Sanity check -------------------------------------------------------------------------------

    -- All awards in this vocation depend on monitor callbacks, so don't both creating the vocation
    --      at all, if monitor callbacks are disabled
    if not unilib.setting.awards_enable_flag or unilib.setting.awards_disable_monitors_flag then
        return
    end

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "spelunker_range_depth",
        trigger_type = "custom",
        hint_list = {"Reach one block below the surface", "Reach @1 blocks below the surface"},
        progress_list = {"Reach one block below the surface", "Reach @1/@2 blocks below the surface"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    unilib.awards.register_monitor_callback(
        "pos_y",
        function(player, pos)

            local pname = player:get_player_name()
            local awards_table = unilib.global.awards_player_table[pname]

            for _, achievement_name in ipairs(
                unilib.awards.retrieve_data_from_custom_watch_table(player, "spelunker_range_depth")
            ) do

                if awards_table["unlock_table"][achievement_name] == nil then

                    -- This achievement is locked; unlock, if the target has been reached, otherwise
                    --      store the player's y position as an indication of progress towards the
                    --      target
                    local achievement_table =
                            unilib.global.awards_achievement_table[achievement_name]
                    if achievement_table["trigger_table"]["target"] >= pos.y then

                        unilib.awards.unlock_achievement(player, achievement_name)

                    else

                        local pos_y = floor(pos.y + 0.5)
                        if awards_table["current_table"][achievement_name] == nil or
                                awards_table["current_table"][achievement_name] > pos_y then
                            awards_table["current_table"][achievement_name] = pos_y
                        end

                    end

                end

            end

        end
    )

    -- Vocations ----------------------------------------------------------------------------------

    unilib.awards.register_vocation({
        name = unilib.pkg.award_spelunker.vocation_name,

        title = S("Spelunker"),
        description = S("Reach the bottom of the world... or die in the attempt!"),
        icon = "unilib_award_vocation_spelunker.png",
        level_list = {
            {title = S("Scratching the Surface"), score = 10},
            {title = S("Up to Your Knees in Dirt"), score = 20},
            {title = S("Cave Dweller"), score = 30},
            {title = S("Casual Spelunker"), score = 40},
            {title = S("Slightly Below Average"), score = 50},
            {title = S("Descent Into Madness"), score = 60},
            {title = S("Downwardly Mobile"), score = 70},
            {title = S("Looking Into the Void"), score = 80},
            {title = S("The Void Stares Back"), score = 90},
            {title = S("Downward Spiral"), score = 100},
            {title = S("Under Achiever"), score = 110},
            {title = S("Underworld's Uninvited Guest"), score = 120},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination (range) achievements
    for i, mini_list in ipairs({
        {S("Amateur Cave Explorer"), S("Dig 50 blocks below the surface"), 10, -50},
        {S("Aspiring Cave Explorer"), S("Dig 100 blocks below the surface"), 10, -100},
        {S("Junior Cave Explorer"), S("Dig 200 blocks below the surface"), 10, -200},
        {S("Novice Cave Explorer"), S("Dig 500 blocks below the surface"), 10, -500},
        {S("Competent Cave Explorer"), S("Dig 1000 blocks below the surface"), 10, -1000},
        {S("Skilled Cave Explorer"), S("Dig 2000 blocks below the surface"), 10, -2000},
        {S("Seasoned Cave Explorer"), S("Dig 5000 blocks below the surface"), 10, -5000},
        {S("Advanced Cave Explorer"), S("Dig 10000 blocks below the surface"), 10, -10000},
        {S("Veteran Cave Explorer"), S("Dig 15000 blocks below the surface"), 10, -15000},
        {S("Master Cave Explorer"), S("Dig 20000 blocks below the surface"), 10, -20000},
        {S("Grandmaster Cave Explorer"), S("Dig 25000 blocks below the surface"), 10, -25000},
        {S("Elite Cave Explorer"), S("Dig 30000 blocks below the surface"), 10, -30000},
        {S("Disciple of Jules Verne"), S("Reach the bottom of the world"), 10, world_bottom},
    }) do

        unilib.awards.register_achievement({
            name = "unilib_spelunker_range_" .. i,
            trigger_table = {
                prototype = "spelunker_range_depth",
                target = mini_list[4],
            },

            title = mini_list[1],
            description = mini_list[2],
            score = mini_list[3],
            vocation_list = {unilib.pkg.award_spelunker.vocation_name},
        })

    end

end
