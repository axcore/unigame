---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_unilib = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_unilib.init()

    return {
        description = "Chat command /unilib",
        notes = "Configures unilib remixes and packages",
    }

end

function unilib.pkg.chat_unilib.exec()

    core.register_chatcommand("unilib", {
        params = "",
        description = S("Configures unilib remixes and packages"),
        privs = {unilib_admin = true},

        func = function(pname, param)

            if not core.get_player_by_name(pname) then
                return false, unilib.constant.chat_offline_msg
            end

            unilib.gui.open_config_formspec(pname)

        end,
    })

end
