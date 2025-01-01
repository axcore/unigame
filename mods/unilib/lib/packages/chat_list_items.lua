---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_items = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_items(pname, param)

    local item_list = {}
    local count = 0

    local not_flag, param = unilib.pkg.shared_chat_list.convert_param(param)

    for k, _ in pairs(core.registered_items) do

        if param == "" or
                (not not_flag and string.find(k, ":") and param == string.split(k, ":")[1]) or
                (not_flag and string.find(k, ":") and param ~= string.split(k, ":")[1]) then

            table.insert(item_list, tostring(k))
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No items are registered")
        elseif not_flag then
            return false, S("No items are registered for mods other than the  \"@1\" mod", param)
        else
            return false, S("No items are registered for the \"@1\" mod", param)
        end

    else

        if param == "" then

            unilib.utils.chat_send_player(
                pname, S("Registered nodes/craftitems/tools (* = hidden)")
            )

        elseif not_flag then

            unilib.utils.chat_send_player(
                pname,
                S("Registered items for mods other than the \"@1\" mod (* = hidden)", param)
            )

        else

            unilib.utils.chat_send_player(
                pname, S("Registered items for the \"@1\" mod (* = hidden)", param)
            )

        end

        table.sort(item_list)
        for _, full_name in ipairs(item_list) do

            if unilib.global.hidden_item_table[full_name] ~= nil then
                unilib.utils.chat_send_player(pname, " * " .. full_name)
            else
                unilib.utils.chat_send_player(pname, "   " .. full_name)
            end

        end

        unilib.utils.chat_send_player(pname, S("End of list (items found: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_items.init()

    return {
        description = "Chat commands /list_items, /list_items",
        notes = "Lists all registered nodes/craftitems/tools, or just items from the specified mod",
        depends = "shared_chat_list",
    }

end

function unilib.pkg.chat_list_items.exec()

    core.register_chatcommand("list_items", {
        params = "[mod]",
        description = S(
            "Lists all registered nodes/craftitems/tools, or just items from the specified mod" ..
                    " (use \"!<mod>\" to list items from all mods but the specified one)"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_items(name, param)
        end,
    })

    core.register_chatcommand("list_item", {
        params = "[mod]",
        description = S(
            "Lists all registered nodes/craftitems/tools, or just items from the specified mod" ..
                    " (use \"!<mod>\" to list items from all mods but the specified one)"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_items(name, param)
        end,
    })

end
