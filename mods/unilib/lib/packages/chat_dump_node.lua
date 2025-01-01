---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dump_node = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_dump_node(pname, param)

    local node_list = {}
    local count = 0

    for k, _ in pairs(core.registered_nodes) do

        if param == "" or string.find(k, param) then

            table.insert(node_list, tostring(k))
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No nodes are registered")
        else
            return false, S("No registered nodes match the pattern \"@1\"", param)
        end

    else

        if param == "" then
            unilib.utils.chat_send_player(pname, S("List of registered nodes"))
        else
            unilib.utils.chat_send_player(pname, S("List of matching nodes"))
        end

        table.sort(node_list)
        for _, full_name in ipairs(node_list) do

            unilib.utils.chat_send_player(pname, "Node: " .. full_name)
            unilib.utils.show_table_in_chat(pname, core.registered_nodes[full_name])

        end

        unilib.utils.chat_send_player(pname, S("End of list (matching nodes found: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dump_node.init()

    return {
        description = "Chat command /dump_node",
        notes = "Dumps definitions of nodes with a matching name",
    }

end

function unilib.pkg.chat_dump_node.exec()

    core.register_chatcommand("dump_node", {
        params = "<pattern>",
        description = S("Dumps node definitions for any node whose name matches the pattern"),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_dump_node(name, param)
        end,
    })

end
