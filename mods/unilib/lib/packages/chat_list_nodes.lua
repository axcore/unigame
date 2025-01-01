---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_nodes = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_nodes(pname, param)

    local node_list = {}
    local count = 0

    local not_flag, param = unilib.pkg.shared_chat_list.convert_param(param)

    for k, _ in pairs(core.registered_nodes) do

        if param == "" or
                (not not_flag and string.find(k, ":") and param == string.split(k, ":")[1]) or
                (not_flag and string.find(k, ":") and param ~= string.split(k, ":")[1]) then

            table.insert(node_list, tostring(k))
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No nodes are registered")
        elseif not_flag then
            return false, S("No nodes are registered for mods other than the  \"@1\" mod", param)
        else
            return false, S("No nodes are registered for the \"@1\" mod", param)
        end

    else

        if param == "" then

            unilib.utils.chat_send_player(pname, S("Registered nodes (* = hidden)"))

        elseif not_flag then

            unilib.utils.chat_send_player(
                pname,
                S("Registered nodes for mods other than the \"@1\" mod (* = hidden)", param)
            )

        else

            unilib.utils.chat_send_player(
                pname, S("Registered nodes for the \"@1\" mod (* = hidden)", param)
            )

        end

        table.sort(node_list)
        for _, full_name in ipairs(node_list) do

            if unilib.global.hidden_item_table[full_name] ~= nil then
                unilib.utils.chat_send_player(pname, " * " .. full_name)
            else
                unilib.utils.chat_send_player(pname, "   " .. full_name)
            end

        end

        unilib.utils.chat_send_player(pname, S("End of list (nodes found: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_nodes.init()

    return {
        description = "Chat commands /list_nodes, /list_node",
        notes = "Lists all registered nodes, or just nodes from the specified mod",
        depends = "shared_chat_list",
    }

end

function unilib.pkg.chat_list_nodes.exec()

    core.register_chatcommand("list_nodes", {
        params = "[mod]",
        description = S(
            "Lists all registered nodes, or just nodes from the specified mod (use \"!<mod>\" to" ..
                    " list nodes from all mods but the specified one)"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_nodes(name, param)
        end,
    })

    core.register_chatcommand("list_node", {
        params = "[mod]",
        description = S(
            "Lists all registered nodes, or just nodes from the specified mod (use \"!<mod>\" to" ..
                    " list nodes from all mods but the specified one)"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_nodes(name, param)
        end,
    })

end
