---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dawn = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dawn.init()

    return {
        description = "Chat command /dawn",
        notes = "Changes time to dawn. See also the \"staff_time\" package, which provides tools" ..
                " for setting these times",
    }

end

function unilib.pkg.chat_dawn.exec()

    core.register_chatcommand("dawn", {
        params = "",
        description = S("Changes time to dawn"),
        privs = {unilib_admin = true},

        func = function(name, param)

            if not core.get_player_by_name(name) then
                return false, unilib.constant.chat_offline_msg
            end

            -- 4:47
            core.set_timeofday(0.2)

        end,
    })

end
