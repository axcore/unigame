---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_display_light = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Blue text
local hud_colour = 0x57B9FF

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function open_hud(player)

    unilib.hud.add_section(player, "chat_display_light", 3)
    unilib.hud.update_line(player, "chat_display_light", 1, "-", hud_colour)

end

local function close_hud(player)

    unilib.hud.remove_section(player, "chat_display_light")

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_display_light.init()

    return {
        description = "Chat command /display_light",
        notes = "Toggles displaying the current light",
    }

end

function unilib.pkg.chat_display_light.exec()

    -- Table of connected player names (as keys) and their current position data (table as a value)
    local display_player_table = {}
    -- Global callbacks are expected every 0.1 seconds, but don't update the display more often than
    --      every 0.5 seconds
    local display_timer = 0

    core.register_on_joinplayer(function(player)

        -- When the player connects, add an entry to "display_player_table"

        local pname = player:get_player_name()
        local storage_key = "light_display_" .. pname
        if tonumber(unilib.utils.get_mod_attribute(storage_key)) == 1 then

            -- Display enabled
            display_player_table[pname] = {
                last_pos = {x = 0, y = 0, z = 0},
                enable = true,
                visible = false,
            }

        else

            -- Display not enabled
            close_hud(player)
            display_player_table[pname] = {
                last_pos = {x = 0,y = 0, z = 0},
                enable = false,
                visible = false,
            }

        end

    end)

    core.register_on_leaveplayer(function(player)

        -- When the player disconnects, remove the entry to "display_player_table"

        local pname = player:get_player_name()
        if display_player_table[pname] then

            close_hud(player)
            display_player_table[pname] = nil

        end

    end)

    core.register_globalstep(function(dtime)

        -- Global callback to update the light displayed

        -- Global callbacks are expected every 0.1 seconds, but don't update the display more often
        --      than every 0.5 seconds
        display_timer = display_timer + dtime
        if display_timer < 0.5 then
            return
        end
        display_timer = 0

        -- Update each player's display in turn
        for _, player in ipairs(core.get_connected_players()) do

            local pname = player:get_player_name()
            if display_player_table[pname].enable == true then

                if display_player_table[pname].visible == false then

                    open_hud(player)
                    display_player_table[pname].visible = true

                end

                -- Player position
                local pos = player:get_pos()
                -- If the position has changed...
                if not vector.equals(pos, display_player_table[pname].last_pos) then

                    local time_string, _ = unilib.utils.get_clock_time()

                    unilib.hud.update_line(
                        player,
                        "chat_display_light",
                        1,
                        S(
                            "Current light is @1 (time: @2) (pos: @3, @4, @5)",
                            core.get_node_light(pos, nil),
                            time_string,
                            string.format("%.1f", pos.x),
                            string.format("%.1f", pos.y),
                            string.format("%.1f", pos.z)
                        ),
                        hud_colour
                    )

                end

            elseif display_player_table[pname].visible == true then

                close_hud(player)
                display_player_table[pname].visible = false

            end

        end

    end)

    core.register_chatcommand("display_light", {
        params = "",
        description = S("Toggles displaying the current light"),
        privs = {unilib_tools = true},

        func = function(pname, param)

            local player = core.get_player_by_name(pname)
            if not player then
                return false, unilib.constant.chat_offline_msg
            end

            local storage_key = "light_display_" .. pname
            if display_player_table[pname].enable == true then

                close_hud(player)
                display_player_table[pname].enable = false
                display_player_table[pname].visible = false
                unilib.utils.set_mod_attribute(storage_key, "0")

            else

                open_hud(player)
                display_player_table[pname].enable = true
                display_player_table[pname].visible = false
                -- Reset position
                display_player_table[pname].last_pos = {x = 0, y = 0, z = 0}
                unilib.utils.set_mod_attribute(storage_key, "1")

            end

        end,
    })

end
