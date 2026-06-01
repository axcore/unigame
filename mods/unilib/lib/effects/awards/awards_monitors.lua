---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- awards_monitors.lua
--      Track changes to the player and the world, firing a trigger when something changes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Localise math functions (for speed)
local floor = math.floor

-- A table storing (trigger) event callbacks to be called, whenever changes to the player and the
--      world are noticed by a monitor function
-- (Any code can create new monitor functions; some "standard" monitor functions are included below)
-- Table in the form
--      callback_table[key] = list_of_callbacks
-- ...where "key" is some arbitrary string. The "standard" monitors below use the following keys:
--          pos_str - Player's current position, converted to a string by core.pos_to_string()
--          pos_x - Player's current position (x coordinate)
--          pos_y - Player's current position (y coordinate)
--          pos_z - Player's current position (z coordinate)
--          HP - Player's current HP
local callback_table = {}

---------------------------------------------------------------------------------------------------
-- Shared function
---------------------------------------------------------------------------------------------------

function unilib.awards.register_monitor_callback(key, func)

    if not unilib.setting.awards_disable_monitors_flag then

        if callback_table[key] == nil then
            callback_table[key] = {func}
        else
            table.insert(callback_table[key], func)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

if not unilib.setting.awards_disable_monitors_flag then

    -- Track player position
    unilib.awards.register_short_timer_callback(function()

        for _, player in ipairs(core.get_connected_players()) do

            local pname = player:get_player_name()
            local monitor_table = unilib.global.awards_player_table[pname]

            -- Get the player's current position (all coordinates rounded to nearest integer)
            local pos = player:get_pos()
            local pos_str = core.pos_to_string(pos, 0)
            local pos_x = floor(pos.x + 0.5)
            local pos_y = floor(pos.y + 0.5)
            local pos_z = floor(pos.z + 0.5)

            if monitor_table.pos_str == nil or monitor_table.pos_str ~= pos_str then

                -- Player position has changed, fire triggers
                if callback_table.pos_str ~= nil then

                    for _, callback in ipairs(callback_table.pos_str) do
                        callback(player, pos)
                    end

                end

                if callback_table.pos_x ~= nil and (
                    monitor_table.pos_x == nil or monitor_table.pos_x ~= pos_x
                ) then

                    for _, callback in ipairs(callback_table.pos_x) do
                        callback(player, pos)
                    end

                end

                if callback_table.pos_y ~= nil and (
                    monitor_table.pos_y == nil or monitor_table.pos_y ~= pos_y
                ) then

                    for _, callback in ipairs(callback_table.pos_y) do
                        callback(player, pos)
                    end

                end

                if callback_table.pos_z ~= nil and (
                    monitor_table.pos_z == nil or monitor_table.pos_z ~= pos_z
                ) then

                    for _, callback in ipairs(callback_table.pos_z) do
                        callback(player, pos)
                    end

                end

                -- Store the current player position, so movement can be detected
                monitor_table.pos_str = pos_str
                monitor_table.pos_x = pos_x
                monitor_table.pos_y = pos_y
                monitor_table.pos_z = pos_z

            end

        end

    end)

    -- Track player HP
    unilib.awards.register_short_timer_callback(function()

        for _, player in ipairs(core.get_connected_players()) do

            local pname = player:get_player_name()
            local monitor_table = unilib.global.awards_player_table[pname]

            -- Get the player's current HP
            local hp = player:get_hp()

            if monitor_table.hp == nil or monitor_table.hp ~= hp then

                if callback_table.hp ~= nil then

                    for _, callback in ipairs(callback_table.hp) do
                        callback(player, hp)
                    end

                end

                -- Store the current player HP, so changes can be detected
                monitor_table.hp = hp

            end

        end

    end)

end
