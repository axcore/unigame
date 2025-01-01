---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dump_abm = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_dump_abm(pname, param)

    local abm_list = {}
    local count = 0

    for _, abm_table in ipairs(core.registered_abms) do

        if param == "" or (abm_table.label ~= nil and string.find(abm_table.label, param)) then

            table.insert(abm_list, abm_table)
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No ABMs are registered")
        else
            return false, S("No registered ABMs match the pattern \"@1\"", param)
        end

    else

        if param == "" then
            unilib.utils.chat_send_player(pname, S("List of registered ABMs"))
        else
            unilib.utils.chat_send_player(pname, S("List of matching ABMs"))
        end

        for _, abm_table in ipairs(abm_list) do

            if abm_table.label == nil or abm_table.label == "" then
                unilib.utils.chat_send_player(pname, S("ABM with no label"))
            else
                unilib.utils.chat_send_player(pname, "ABM: " .. abm_table.label)
            end

            unilib.utils.show_table_in_chat(pname, abm_table)

        end

        unilib.utils.chat_send_player(pname, S("End of list (matching ABMs found: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dump_abm.init()

    return {
        description = "Chat command /dump_abm",
        notes = "Dumps definitions of ABMs with a matching label",
    }

end

function unilib.pkg.chat_dump_abm.exec()

    core.register_chatcommand("dump_abm", {
        params = "<pattern>",
        description = S("Dumps ABM definitions for any ABM whose label matches the pattern"),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_dump_abm(name, param)
        end,
    })

end
