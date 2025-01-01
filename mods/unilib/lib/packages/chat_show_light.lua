---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_light = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_light.init()

    return {
        description = "Chat command /show_light",
        notes = "",
    }

end

function unilib.pkg.chat_show_light.exec()

    core.register_chatcommand("show_light", {
        params = "",
        description = S("Displays light at the player's location"),
        privs = {unilib_tools = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            end

            local pos = player:get_pos()
            local time_string, _ = unilib.utils.get_clock_time()
            return true, S(
                "Current light is @1 (time: @2) (pos: @3, @4, @5)",
                core.get_node_light(pos, nil),
                time_string,
                string.format("%.1f", pos.x),
                string.format("%.1f", pos.y),
                string.format("%.1f", pos.z)
            )

        end,
    })

end
