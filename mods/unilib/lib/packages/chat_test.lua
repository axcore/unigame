---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_test = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_test.init()

    return {
        description = "Chat command /test",
        notes = "Runs some arbitrary code",
    }

end

function unilib.pkg.chat_test.exec()

    core.register_chatcommand("test", {
        params = "",
        description = S("Runs some arbitrary code"),
        privs = {unilib_admin = true},

        func = function(name, param)

            if not core.get_player_by_name(name) then
                return false, unilib.constant.chat_offline_msg
            end

            return true, S("Hello, world!")

        end,
    })

end
