---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_lbms = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_lbms(pname, param)

    local output_list = {}
    local count = 0

    local not_flag, param = unilib.pkg.shared_chat_list.convert_param(param)

    for _, lbm_table in ipairs(core.registered_lbms) do

        if param == "" or
            (not not_flag and param == lbm_table.mod_origin) or
            (not_flag and param ~= lbm_table.mod_origin) then

            local mini_list = {lbm_table.mod_origin}

            if lbm_table.label == nil or lbm_table.label == "" then
                table.insert(mini_list, S("No label"))
            else
                table.insert(mini_list, lbm_table.label)
            end

            if lbm_table.name == nil or lbm_table.name == "" then
                table.insert(mini_list, S("No name"))
            else
                table.insert(mini_list, lbm_table.name)
            end

            table.insert(output_list, mini_list)
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No LBMs are registered")
        elseif not_flag then
            return false, S("No LBMs are registered for mods other than the  \"@1\" mod", param)
        else
            return false, S("No LBMs are registered for the \"@1\" mod", param)
        end

    else

        if param == "" then


            unilib.utils.chat_send_player(pname, S("Registered LBMs"))

        elseif not_flag then

            unilib.utils.chat_send_player(
                pname, S("Registered LBMs for mods other than the \"@1\" mod", param)
            )

        else

            unilib.utils.chat_send_player(pname, S("Registered LBMs for the \"@1\" mod", param))

        end

        for _, mini_list in ipairs(output_list) do

            unilib.utils.chat_send_player(pname, "   " .. mini_list[1])
            unilib.utils.chat_send_player(pname, "      " .. mini_list[2])
            unilib.utils.chat_send_player(pname, "      " .. mini_list[3])

        end

        unilib.utils.chat_send_player(pname, S("End of list (LBMs found: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_lbms.init()

    return {
        description = "Chat commands /list_lbms, /list_lbm",
        notes = "Lists all registered LBMs, or just LBMs from the specified mod",
        depends = "shared_chat_list",
    }

end

function unilib.pkg.chat_list_lbms.exec()

    core.register_chatcommand("list_lbms", {
        params = "[mod]",
        description = S("Lists all registered LBMs, or just LBMs from the specified mod (use" ..
                " \"!<mod>\" to list LBMs from all mods but the specified one)"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_lbms(name, param)
        end,
    })

    core.register_chatcommand("list_lbm", {
        params = "[mod]",
        description = S("Lists all registered LBMs, or just LBMs from the specified mod (use" ..
                " \"!<mod>\" to list LBMs from all mods but the specified one)"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_lbms(name, param)
        end,
    })

end
