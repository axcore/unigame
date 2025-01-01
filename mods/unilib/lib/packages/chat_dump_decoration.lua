---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dump_decoration = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_dump_decoration(pname, param)

    local deco_list = {}
    local count = 0

    for k, _ in pairs(core.registered_decorations) do

        if param == "" or string.find(k, param) then

            table.insert(deco_list, tostring(k))
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No decorations are registered")
        else
            return false, S("No registered decorations match the pattern \"@1\"", param)
        end

    else

        if param == "" then
            unilib.utils.chat_send_player(pname, S("List of registered decorations"))
        else
            unilib.utils.chat_send_player(pname, S("List of matching decorations"))
        end

        table.sort(deco_list)
        for _, deco_name in ipairs(deco_list) do

            unilib.utils.chat_send_player(pname, "Decoration: " .. deco_name)
            unilib.utils.show_table_in_chat(pname, core.registered_decorations[deco_name])

        end

        unilib.utils.chat_send_player(
            pname, S("End of list (matching decorations found: @1)", count)
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dump_decoration.init()

    return {
        description = "Chat command /dump_decoration",
        notes = "Dumps definitions of decorations with a matching name",
    }

end

function unilib.pkg.chat_dump_decoration.exec()

    core.register_chatcommand("dump_decoration", {
        params = "<pattern>",
        description = S(
            "Dumps decoration definitions for any decoration whose name matches the pattern"
        ),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_dump_decoration(name, param)
        end,
    })

end
