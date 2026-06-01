---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_unlock_achievement = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_unlock_achievement.init()

    return {
        description = "Chat commands /unlock_achievement, /lock_achievement",
        notes = "Unlocks/locks an achievement for a player",
    }

end

function unilib.pkg.chat_unlock_achievement.exec()

    core.register_chatcommand("unlock_achievement", {
        params = "<achievement> [player]",
        description = S("Unlocks an achievement for a player"),
        privs = {unilib_admin = true},

        func = function(pname, param)

            -- If no player name specified, then use the player who typed the command
            local param_list = unilib.utils.split_string_by_whitespace(param)
            local achievement_name = param_list[1]
            local target_pname = param_list[2]
            if target_pname == nil or target_pname == "" then
                target_pname = pname
            end

            -- Basic checks
            if not core.get_player_by_name(target_pname) then
                return false, unilib.constant.chat_offline_msg
            elseif not unilib.setting.awards_enable_flag then
                return false, S("Player awards are not enabled in settings")
            elseif achievement_name == nil or achievement_name == "" then
                return false, S("Please specify an achievement name (try: /show_achievements)")
            elseif unilib.global.awards_achievement_table[achievement_name] == nil then
                return false, S("Unregistered achievement name (try: /show_achievements)")
            end

            local data_table = unilib.global.awards_player_table[target_pname]
            if data_table == nil then
                return false, S("Unregistered player name, or no player award data found")
            elseif data_table.unlock_table[achievement_name] then
                return false, S("Achievement already unlocked")
            end

            -- Unlock the achievement
            local player = core.get_player_by_name(target_pname)
            if not unilib.awards.unlock_achievement(player, achievement_name) then
                return false, S("Failed to unlock the achievement \"@1\"", achievement_name)
            else
                return true, S("Achievement \"@1\" unlocked", achievement_name)
            end

        end,
    })

    core.register_chatcommand("lock_achievement", {
        params = "<achievement> [player]",
        description = S("Locks an achievement for a player"),
        privs = {unilib_admin = true},

        func = function(pname, param)

            -- If no player name specified, then use the player who typed the command
            local param_list = unilib.utils.split_string_by_whitespace(param)
            local achievement_name = param_list[1]
            local target_pname = param_list[2]
            if target_pname == nil or target_pname == "" then
                target_pname = pname
            end

            -- Basic checks
            if not unilib.setting.awards_enable_flag then
                return false, S("Player awards are not enabled in settings")
            elseif achievement_name == nil or achievement_name == "" then
                return false, S("Please specify an achievement name (try: /show_achievements)")
            elseif unilib.global.awards_achievement_table[achievement_name] == nil then
                return false, S("Unregistered achievement name (try: /show_achievements)")
            end

            local data_table = unilib.global.awards_player_table[target_pname]
            if data_table == nil then
                return false, S("Unregistered player name, or no player award data found")
            elseif data_table.unlock_table[achievement_name] == nil then
                return false, S("Achievement already locked")
            end

            -- Unlock the achievement
            local player = core.get_player_by_name(target_pname)
            if not unilib.awards.lock_achievement(player, achievement_name) then

                return false, S("Failed to lock the achievement \"@1\"", achievement_name)

            else

                return true, S(
                    "Achievement \"@1\" locked (any related vocations have not been updated)",
                    achievement_name
                )

            end

        end,
    })

end
