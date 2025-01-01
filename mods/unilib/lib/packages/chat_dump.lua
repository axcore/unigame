---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dump = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_dump(pname, param)

    local item_type = nil

    if param == "" then

        return false, S("Please specify the exact name of a node, craftitem or tool")

    else

        local def_table = core.registered_nodes[param]
        if def_table ~= nil then

            item_type = "node"

        else

            def_table = core.registered_craftitems[param]
            if def_table ~= nil then

                item_type = "craftitem"

            else

                def_table = core.registered_tools[param]
                if def_table ~= nil then

                    item_type = "tool"

                end

            end

        end

        if def_table == nil then

            return false, S("No registered items match the name \"@1\"", param)

        else

            if item_type == "node" then
                unilib.utils.chat_send_player(pname, "Node: " .. param)
            elseif item_type == "craftitem" then
                unilib.utils.chat_send_player(pname, "Craftitem: " .. param)
            else
                unilib.utils.chat_send_player(pname, "Tool: " .. param)
            end

            unilib.utils.show_table_in_chat(pname, def_table)

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dump.init()

    return {
        description = "Chat command /dump",
        notes = "Dumps definition of the node, craftitem or tool with the (exact) specified name",
    }

end

function unilib.pkg.chat_dump.exec()

    core.register_chatcommand("dump", {
        params = "<name>",
        description = S(
            "Dumps definition of the node, craftitem or tool with the (exact) specified name"
        ),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_dump(name, param)
        end,
    })

end
