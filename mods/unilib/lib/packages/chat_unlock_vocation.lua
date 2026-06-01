---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_unlock_vocation = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_unlock_vocation.init()

    return {
        description = "Chat commands /unlock_vocation, /reset_vocation",
    }

end

function unilib.pkg.chat_unlock_vocation.exec()

    core.register_chatcommand("unlock_vocation", {
        params = "<vocation> [player]",
        description = S("Unlocks the next level in the vocation for a player"),
        privs = {unilib_admin = true},

        func = function(pname, param)

            -- If no player name specified, then use the player who typed the command
            local param_list = unilib.utils.split_string_by_whitespace(param)
            local vocation_name = param_list[1]
            local target_pname = param_list[2]
            if target_pname == nil or target_pname == "" then
                target_pname = pname
            end

            -- Basic checks
            if not core.get_player_by_name(target_pname) then
                return false, unilib.constant.chat_offline_msg
            elseif not unilib.setting.awards_enable_flag then
                return false, S("Player awards are not enabled in settings")
            elseif vocation_name == nil or vocation_name == "" then
                return false, S("Please specify a vocation name (try: /show_vocations)")
            elseif unilib.global.awards_vocation_table[vocation_name] == nil then
                return false, S("Unregistered vocation name (try: /show_vocations)")
            end

            local data_table = unilib.global.awards_player_table[target_pname]
            if data_table == nil then
                return false, S("Unregistered player name, or no player award data found")
            end

            local level = data_table.level_table[vocation_name]
            if level == nil then
                level = 1
            else
                level = level + 1
            end

            local max_levels = #unilib.global.awards_vocation_table[vocation_name]["level_list"]
            if level > max_levels then
                return false, S("All levels in the vocation are already unlocked")
            end

            -- Unlock the next level in the vocation
            local player = core.get_player_by_name(target_pname)
            if not unilib.awards.unlock_level(player, vocation_name, level) then

                return false,
                        S("Failed to unlock the next level in the vocation \"@1\"", vocation_name)

            else

                return true, S("Next level in the vocation \"@1\" unlocked", vocation_name)

            end

        end,
    })

    core.register_chatcommand("reset_vocation", {
        params = "<vocation> [player]",
        description = S("Resets all levels in the vocation for a player"),
        privs = {unilib_admin = true},

        func = function(pname, param)

            -- If no player name specified, then use the player who typed the command
            local param_list = unilib.utils.split_string_by_whitespace(param)
            local vocation_name = param_list[1]
            local target_pname = param_list[2]
            if target_pname == nil or target_pname == "" then
                target_pname = pname
            end

            -- Basic checks
            if not unilib.setting.awards_enable_flag then
                return false, S("Player awards are not enabled in settings")
            elseif vocation_name == nil or vocation_name == "" then
                return false, S("Please specify a vocation name (try: /show_vocations)")
            elseif unilib.global.awards_vocation_table[vocation_name] == nil then
                return false, S("Unregistered vocation name (try: /show_vocations)")
            end

            local data_table = unilib.global.awards_player_table[target_pname]
            if data_table == nil then
                return false, S("Unregistered player name, or no player award data found")
            elseif data_table.level_table[vocation_name] == nil or
                    data_table.level_table[vocation_name] == 0 then
                return false, S("All levels in the vocation are already locked")
            end

            -- Reset levels in the vocation
            local player = core.get_player_by_name(target_pname)
            unilib.awards.reset_level(player, vocation_name)
            return true, S("Levels reset in the vocation \"@1\"", vocation_name)

        end,
    })

end
