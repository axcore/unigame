---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dump_lbm = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_dump_lbm(pname, param)

    local lbm_list = {}
    local count = 0

    for _, lbm_table in ipairs(core.registered_lbms) do

        if param == "" or
                (lbm_table.label ~= nil and string.find(lbm_table.label, param)) or
                (lbm_table.name ~= nil and string.find(lbm_table.name, param)) then

            table.insert(lbm_list, lbm_table)
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No LBMs are registered")
        else
            return false, S("No registered LBMs match the pattern \"@1\"", param)
        end

    else

        if param == "" then
            unilib.utils.chat_send_player(pname, S("List of registered LBMs"))
        else
            unilib.utils.chat_send_player(pname, S("List of matching LBMs"))
        end

        for _, lbm_table in ipairs(lbm_list) do

            unilib.utils.chat_send_player(pname, "   " .. lbm_table.mod_origin)

            if lbm_table.label == nil or lbm_table.label == "" then
                unilib.utils.chat_send_player(pname, "      " .. S("No label"))
            else
                unilib.utils.chat_send_player(pname, "      " .. lbm_table.label)
            end

            if lbm_table.name == nil or lbm_table.name == "" then
                unilib.utils.chat_send_player(pname, "      " .. S("No name"))
            else
                unilib.utils.chat_send_player(pname, "      " .. lbm_table.name)
            end

            unilib.utils.show_table_in_chat(pname, lbm_table)

        end

        unilib.utils.chat_send_player(pname, S("End of list (matching LBMs found: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dump_lbm.init()

    return {
        description = "Chat command /dump_lbm",
        notes = "Dumps definitions of LBMs with a matching name or label",
    }

end

function unilib.pkg.chat_dump_lbm.exec()

    core.register_chatcommand("dump_lbm", {
        params = "<pattern>",
        description = S(
            "Dumps LBM definitions for any LBM whose name or label matches the pattern"
        ),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_dump_lbm(name, param)
        end,
    })

end
