---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_mod_attributes = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_show_mod_attributes(pname, param)

    local attrib_table = unilib.core.mod_storage:to_table().fields

    local key_list = {}
    for k, v in pairs(attrib_table) do
        table.insert(key_list, k)
    end

    table.sort(key_list)

    unilib.utils.chat_send_player(pname, S("Mod attribute table"))
    for _, k in ipairs(key_list) do

        unilib.utils.chat_send_player(
            pname, "   " .. tostring(k) .. " = " .. tostring(attrib_table[k])
        )

    end

    unilib.utils.chat_send_player(pname, S("End of table"))

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_mod_attributes.init()

    return {
        description = "Chat commands /show_mod_attributes, /show_mod_attribute",
        notes = "Shows table of mod attributes (i.e. mod storage)",
    }

end

function unilib.pkg.chat_show_mod_attributes.exec()

    core.register_chatcommand("show_mod_attributes", {
        params = "",
        description = S("Shows a table of mod attributes"),
        privs = {unilib_admin = true},

        func = function(name, param)

            if not core.get_player_by_name(name) then
                return false, unilib.constant.chat_offline_msg
            else
                return do_show_mod_attributes(name, param)
            end

        end,
    })

    core.register_chatcommand("show_mod_attribute", {
        params = "",
        description = S("Shows a table of mod attributes"),
        privs = {unilib_admin = true},

        func = function(name, param)

            if not core.get_player_by_name(name) then
                return false, unilib.constant.chat_offline_msg
            else
                return do_show_mod_attributes(name, param)
            end

        end,
    })

end
