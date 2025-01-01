---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_decorations = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_decorations(pname, param)

    local deco_list = {}
    local count = 0

    local not_flag, param = unilib.pkg.shared_chat_list.convert_param(param)

    for k, _ in pairs(core.registered_decorations) do

        if param == "" or
            (not not_flag and string.find(k, ":") and param == string.split(k, ":")[1]) or
            (not_flag and string.find(k, ":") and param ~= string.split(k, ":")[1]) then

            table.insert(deco_list, tostring(k))
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then

            return false, S("No decorations are registered")

        elseif not_flag then

            unilib.utils.chat_send_player(
                pname,
                S("No decorations are registered for mods other than the  \"@1\" mod", param)
            )

        else

            return false, S("No decorations are registered for the \"@1\" mod", param)

        end

    else

        if param == "" then

            unilib.utils.chat_send_player(pname, S("Registered decorations"))

        elseif not_flag then

            unilib.utils.chat_send_player(
                pname, S("Registered decorations for mods other than the \"@1\" mod", param)
            )

        else

            unilib.utils.chat_send_player(
                pname, S("Registered decorations for the \"@1\" mod", param)
            )

        end

        table.sort(deco_list)
        for _, full_name in ipairs(deco_list) do
            unilib.utils.chat_send_player(pname, "   " .. full_name)
        end

        unilib.utils.chat_send_player(pname, S("End of list (decorations found: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_decorations.init()

    return {
        description = "Chat commands /list_decorations, /list_decoration",
        notes = "Lists all registered decorations, or just decorations from the specified mod",
        depends = "shared_chat_list",
    }

end

function unilib.pkg.chat_list_decorations.exec()

    core.register_chatcommand("list_decorations", {
        params = "[mod]",
        description = S("Lists all registered decorations, or just decorations from the" ..
                " specified mod (use \"!<mod>\" to list decorations from all mods but the" ..
                " specified one)"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_decorations(name, param)
        end,
    })

    core.register_chatcommand("list_decoration", {
        params = "[mod]",
        description = S("Lists all registered decorations, or just decorations from the" ..
                " specified mod (use \"!<mod>\" to list decorations from all mods but the" ..
                " specified one)"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_decorations(name, param)
        end,
    })

end
