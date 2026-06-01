---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_create_remix = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_create_remix.init()

    return {
        description = "Chat command /create_remix",
        notes = "Creates a new remix",
    }

end

function unilib.pkg.chat_create_remix.exec()

    core.register_chatcommand("create_remix", {
        params = "<remix>",
        description = S("Creates a new remix"),
        privs = {unilib_admin = true},

        func = function(pname, param)

            if not core.get_player_by_name(pname) then
                return false, unilib.constant.chat_offline_msg
            end

            unilib.gui.open_create_formspec(pname, param)

        end,
    })

end
