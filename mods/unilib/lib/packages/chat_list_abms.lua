---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_abms = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_abm(pname, param)

    local description_list = {}
    local count = 0

    local not_flag, param = unilib.pkg.shared_chat_list.convert_param(param)

    for _, abm_table in ipairs(core.registered_abms) do

        if param == "" or
                (not not_flag and param == abm_table.mod_origin) or
                (not_flag and param ~= abm_table.mod_origin) then

            if abm_table.label == nil then
                table.insert(description_list, abm_table.mod_origin .. " - " .. S("No label"))
            else
                table.insert(description_list, abm_table.mod_origin .. " - " .. abm_table.label)
            end

            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No ABMs are registered")
        elseif not_flag then
            return false, S("No ABMs are registered for mods other than the  \"@1\" mod", param)
        else
            return false, S("No ABMs are registered for the \"@1\" mod", param)
        end

    else

        if param == "" then

            unilib.utils.chat_send_player(pname, S("Registered ABMs"))

        elseif not_flag then

            unilib.utils.chat_send_player(
                pname, S("Registered ABMs for mods other than the \"@1\" mod", param)
            )

        else

            unilib.utils.chat_send_player(pname, S("Registered ABMs for the \"@1\" mod", param))

        end

        table.sort(description_list)
        for _, description in ipairs(description_list) do
            unilib.utils.chat_send_player(pname, "   " .. description)
        end

        unilib.utils.chat_send_player(pname, S("End of list (ABMs found: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_abms.init()

    return {
        description = "Chat commands /list_abms, /list_abm",
        notes = "Lists all registered ABMS, or just ABMs from the specified mod",
        depends = "shared_chat_list",
    }

end

function unilib.pkg.chat_list_abms.exec()

    core.register_chatcommand("list_abms", {
        params = "[mod]",
        description = S("Lists all registered ABMS, or just ABMs from the specified mod (use" ..
                " \"!<mod>\" to list ABMs from all mods but the specified one)"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_abm(name, param)
        end,
    })

    core.register_chatcommand("list_abm", {
        params = "[mod]",
        description = S("Lists all registered ABMS, or just ABMs from the specified mod (use" ..
                " \"!<mod>\" to list ABMs from all mods but the specified one)"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_abm(name, param)
        end,
    })

end
