---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_edit_remix = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_edit_remix.init()

    return {
        description = "Chat commands /edit_remix, /remix",
        notes = "Edits an existing remix",
    }

end

function unilib.pkg.chat_edit_remix.exec()

    core.register_chatcommand("edit_remix", {
        params = "<remix>",
        description = S("Edits an existing remix"),
        privs = {unilib_admin = true},

        func = function(pname, param)

            if not core.get_player_by_name(pname) then
                return false, unilib.constant.chat_offline_msg
            end

            unilib.gui.open_edit_formspec(pname, param)

        end,
    })

    core.register_chatcommand("remix", {
        params = "<remix>",
        description = S("Edits an existing remix"),
        privs = {unilib_admin = true},

        func = function(pname, param)

            if not core.get_player_by_name(pname) then
                return false, unilib.constant.chat_offline_msg
            end

            unilib.gui.open_edit_formspec(pname, param)

        end,
    })

end
