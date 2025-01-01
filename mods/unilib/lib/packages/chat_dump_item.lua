---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dump_item = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_dump_item(pname, param)

    local item_list = {}
    local check_table = {}
    local count = 0

    for k, _ in pairs(core.registered_nodes) do

        if param == "" or string.find(k, param) then

            table.insert(item_list, tostring(k))
            check_table[k] = true
            count = count + 1

        end

    end

    for k, _ in pairs(core.registered_craftitems) do

        if check_table[k] == nil and (param == "" or string.find(k, param)) then

            table.insert(item_list, tostring(k))
            check_table[k] = true
            count = count + 1

        end

    end

    for k, _ in pairs(core.registered_tools) do

        if check_table[k] == nil and (param == "" or string.find(k, param)) then

            table.insert(item_list, tostring(k))
            check_table[k] = true
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No items are registered")
        else
            return false, S("No registered items match the pattern \"@1\"", param)
        end

    else

        if param == "" then
            unilib.utils.chat_send_player(pname, S("List of registered nodes/craftitems/tools"))
        else
            unilib.utils.chat_send_player(pname, S("List of matching nodes/craftitems/tools"))
        end

        table.sort(item_list)
        for _, full_name in ipairs(item_list) do

            if core.registered_nodes[full_name] ~= nil then

                unilib.utils.chat_send_player(pname, "Node: " .. full_name)
                unilib.utils.show_table_in_chat(pname, core.registered_nodes[full_name])

            elseif core.registered_craftitems[full_name] ~= nil then

                unilib.utils.chat_send_player(pname, "Craftitem: " .. full_name)
                unilib.utils.show_table_in_chat(pname, core.registered_craftitems[full_name])

            else

                unilib.utils.chat_send_player(pname, "Tool: " .. full_name)
                unilib.utils.show_table_in_chat(pname, core.registered_tools[full_name])

            end

        end

        unilib.utils.chat_send_player(pname, S("End of list (matching items found: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dump_item.init()

    return {
        description = "Chat command /dump_item",
        notes = "Dumps definitions of nodes, craftitems and tools with a matching name",
    }

end

function unilib.pkg.chat_dump_item.exec()

    core.register_chatcommand("dump_item", {
        params = "<pattern>",
        description = S(
            "Dumps definitions for any node/craftitem/tool whose name matches the pattern"
        ),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_dump_item(name, param)
        end,
    })

end
