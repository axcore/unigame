---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dump_craftitem = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_dump_craftitem(pname, param)

    local craftitem_list = {}
    local count = 0

    for k, _ in pairs(core.registered_craftitems) do

        if param == "" or string.find(k, param) then

            table.insert(craftitem_list, tostring(k))
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No craftitems are registered")
        else
            return false, S("No registered craftitems match the pattern \"@1\"", param)
        end

    else

        if param == "" then
            unilib.utils.chat_send_player(pname, S("List of registered craftitems"))
        else
            unilib.utils.chat_send_player(pname, S("List of matching craftitems"))
        end

        table.sort(craftitem_list)
        for _, full_name in ipairs(craftitem_list) do

            unilib.utils.chat_send_player(pname, "Craftitem: " .. full_name)
            unilib.utils.show_table_in_chat(pname, core.registered_craftitems[full_name])

        end

        unilib.utils.chat_send_player(
            pname, S("End of list (matching craftitems found: @1)", count)
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dump_craftitem.init()

    return {
        description = "Chat command /dump_craftitem",
        notes = "Dumps definitions of craftitems with a matching name",
    }

end

function unilib.pkg.chat_dump_craftitem.exec()

    core.register_chatcommand("dump_craftitem", {
        params = "<pattern>",
        description = S(
            "Dumps craftitem definitions for any craftitem whose name matches the pattern"
        ),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_dump_craftitem(name, param)
        end,
    })

end
