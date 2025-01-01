---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dusk = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dusk.init()

    return {
        description = "Chat command /dusk",
        notes = "Changes time to dusk. See also the \"staff_time\" package, which provides tools" ..
                " for setting these times",
    }

end

function unilib.pkg.chat_dusk.exec()

    core.register_chatcommand("dusk", {
        params = "",
        description = S("Changes time to dusk"),
        privs = {unilib_admin = true},

        func = function(name, param)

            if not core.get_player_by_name(name) then
                return false, unilib.constant.chat_offline_msg
            end

            -- 19:12
            core.set_timeofday(0.8)

        end,
    })

end
