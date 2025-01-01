---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_player_attributes = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_show_player_attributes(pname, param)

    local player = core.get_player_by_name(pname)
    local meta = player:get_meta()
    local attrib_table = meta:to_table().fields

    local key_list = {}
    for k, v in pairs(attrib_table) do
        table.insert(key_list, k)
    end

    table.sort(key_list)

    unilib.utils.chat_send_player(pname, S("Player attribute table for @1", pname))
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

function unilib.pkg.chat_show_player_attributes.init()

    return {
        description = "Chat commands /show_player_attributes, /show_player_attribute",
        notes = "Shows table of player attributes (i.e. player metadata)",
    }

end

function unilib.pkg.chat_show_player_attributes.exec()

    core.register_chatcommand("show_player_attributes", {
        params = "",
        description = S("Shows a table of player attributes"),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            elseif not player.get_meta then
                return false, S("Player attribute table not available")
            else
                return do_show_player_attributes(name, param)
            end

        end,
    })

    core.register_chatcommand("show_player_attribute", {
        params = "",
        description = S("Shows a table of player attributes"),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            elseif not player.get_meta then
                return false, S("Player attribute table not available")
            else
                return do_show_player_attributes(name, param)
            end

        end,
    })

end
