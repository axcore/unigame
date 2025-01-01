---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utils_log.lua
--      Log utility functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function format_log_args(arg1, arg2, arg3)

    -- Information, error and warning messages written to core.log() can have up to two optional
    --      arguments. This function returns a nicely-formatted string (or an empty one)

    local str = ""

    if arg1 ~= nil then

        str = ": " .. unilib.utils.convert_to_string(arg1)
        if arg2 ~= nil then

            str = str .. " / " .. unilib.utils.convert_to_string(arg2)
            if arg3 ~= nil then

                str = str .. " / " .. unilib.utils.convert_to_string(arg3)

            end

        end

    end

    return str

end

local function is_pos(vector)

    -- Adapted from minetest_game/default/functions.lua, is_pos()

    return type(vector) == "table" and
            type(vector.x) == "number" and
            type(vector.y) == "number" and
            type(vector.z) == "number"

end

local function empty_func()
end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.utils._show_msg(msg, arg1, arg2, arg3)

    -- Code should call this function, instead of calling core.log() directly
    -- The message is not displayed if unilib.setting.show_msg_flag is not set
    --
    -- Args:
    --      msg (str): The message to display
    --
    -- Optional args:
    --      arg1, arg2, arg3 (any): Optional arguments which, if specified, are converted to strings
    --          and displayed below the main message

    if unilib.setting.show_msg_flag then
        core.log(unilib.core.info_header .. msg .. format_log_args(arg1, arg2, arg3))
    end

end

function unilib.utils._show_error(msg, arg1, arg2, arg3)

    -- Code should call this function, instead of calling core.log() directly
    -- The message is not displayed if unilib.setting.show_error_flag is not set
    --
    -- Args:
    --      msg (str): The error message to display
    --
    -- Optional args:
    --      arg1, arg2, arg3 (any): Optional arguments which, if specified, are converted to strings
    --          and displayed below the error message

    if unilib.setting.show_error_flag then
        core.log(unilib.core.error_header .. msg .. format_log_args(arg1, arg2, arg3))
    end

end

function unilib.utils._show_warning(msg, arg1, arg2, arg3)

    -- Code should call this function, instead of calling core.log() directly
    -- The message is not displayed if unilib.setting.show_warning_flag is not set
    --
    -- Args:
    --      msg (str): The message to display
    --
    -- Optional args:
    --      arg1, arg2, arg3 (any): Optional arguments which, if specified, are converted to strings
    --          and displayed below the warning message

    if unilib.setting.show_warning_flag then
        core.log(unilib.core.warning_header .. msg .. format_log_args(arg1, arg2, arg3))
    end

end

function unilib.utils._log(category, msg)

    -- This function exists so that, during debugging, the developer can insert temporary core.log()
    --      calls, and then later easily find them to remove them
    -- In contrast, calls to this function are regarded as permanent
    --
    -- Args:
    --      category (str): Optional argument; the core.log() level. As of Minetest v5.4.1, values
    --          are "none" (default), "error", "warning", "action", "info", or "verbose"`
    --      msg (str): The message to log

    if category ~= nil then

        if msg == nil then
            core.log(category)
        else
            core.log(category, msg)
        end

    end

end

function unilib.utils._chat_send_player(pname, msg)

    -- Wrapper for core.chat_send_player(), in order to display the output of chat commands in the
    --      debug file (as well as in the chat window), if Minetest settings require it
    if not unilib.setting.log_chat_cmd_flag then
        core.chat_send_player(pname, msg)
    else
        unilib.utils.log("none", msg)
    end

end

function unilib.utils._log_player_action(player, ...)

    -- Adapted from minetest_game/default/functions.lua, default.log_player_action()
    -- Standard function to log player actions (e.g. when digging/placing items)

    local msg = player:get_player_name()

    -- Notes from original mod:
    -- The use of .is_fake_player is an unofficial standard between mods
    -- These non-players are marked by the content of .is_fake_player (if it is a string) or a
    --      "*" in brackets after the player name in the log
    if player.is_fake_player or not player:is_player() then

        if not unilib.setting.log_non_player_actions_flag then
            return
        end

        msg = msg .. "(" .. (
            type(player.is_fake_player) == "string" and player.is_fake_player or "*"
        ) .. ")"

    end

    for _, v in ipairs({...}) do

        -- Translate pos
        local part = is_pos(v) and core.pos_to_string(v) or v
        -- No leading spaces before punctuation marks
        msg = msg .. (string.match(part, "^[;,.]") and "" or " ") .. part

    end

    unilib.utils.log("action",  msg)

end

function unilib.utils._set_inventory_action_loggers(def_table, full_name)

    -- Adapted from minetest_game/default/functions.lua, default.log_player_action()
    -- Standard function to modify a node/craftitem/tool definition, to log player actions (for
    --      example when moving items to/from a chest)

    local on_move = def_table.on_metadata_inventory_move or empty_func
    def_table.on_metadata_inventory_move = function(
        pos, from_list, from_index, to_list, to_index, count, player
    )
        unilib.utils.log_player_action(player, "moves items in", full_name, "at", pos)
        return on_move(pos, from_list, from_index, to_list, to_index, count, player)

    end

    local on_put = def_table.on_metadata_inventory_put or empty_func
    def_table.on_metadata_inventory_put = function(pos, listname, index, stack, player)

        unilib.utils.log_player_action(
            player, "moves", stack:get_name(), stack:get_count(), "to", full_name, "at", pos
        )

        return on_put(pos, listname, index, stack, player)

    end

    local on_take = def_table.on_metadata_inventory_take or empty_func
    def_table.on_metadata_inventory_take = function(pos, listname, index, stack, player)

        unilib.utils.log_player_action(
            player, "takes", stack:get_name(), stack:get_count(), "from", full_name, "at", pos
        )

        return on_take(pos, listname, index, stack, player)

    end

end
