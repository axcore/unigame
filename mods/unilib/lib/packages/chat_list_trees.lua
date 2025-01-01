---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_trees = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_trees(pname, param)

    if unilib.utils.is_table_empty(unilib.global.tree_table) then

        return false, S("No tree types have been registered")

    elseif param ~= nil and param ~= "" then

        -- Ignore multiple tree types, if specified
        local tree_list = unilib.utils.split_string_by_whitespace(param)
        local tree_type = tree_list[1]

        if tree_type == nil or tree_type == "" or unilib.global.tree_table[tree_type] == nil then

            return false, S("Unrecognised tree type, try /list_trees")

        else

            unilib.utils.chat_send_player(pname, S("Information for tree type \"@1\"", tree_type))

            local base_name = "unilib:tree_" .. tree_type

            if unilib.global.super_tree_table[tree_type] ~= nil then
                unilib.utils.chat_send_player(pname, "   " .. S("Super tree: YES"))
            else
                unilib.utils.chat_send_player(pname, "   " .. S("Super tree: NO"))
            end

            if core.registered_nodes[base_name .. "_trunk"] ~= nil then
                unilib.utils.chat_send_player(pname, "   " .. S("Trunk node: YES"))
            else
                unilib.utils.chat_send_player(pname, "   " .. S("Trunk node: NO"))
            end

            if core.registered_nodes[base_name .. "_wood"] ~= nil then
                unilib.utils.chat_send_player(pname, "   " .. S("Wood node: YES"))
            else
                unilib.utils.chat_send_player(pname, "   " .. S("Wood node: NO"))
            end

            if core.registered_nodes[base_name .. "_leaves"] ~= nil then
                unilib.utils.chat_send_player(pname, "   " .. S("Leaves node: YES"))
            else
                unilib.utils.chat_send_player(pname, "   " .. S("Leaves node: NO"))
            end

            if core.registered_nodes[base_name .. "_sapling"] ~= nil then
                unilib.utils.chat_send_player(pname, "   " .. S("Sapling: YES"))
            else
                unilib.utils.chat_send_player(pname, "   " .. S("Sapling: NO"))
            end

            if core.registered_nodes[base_name .. "_wood_fence"] ~= nil then
                unilib.utils.chat_send_player(pname, "   " .. S("Fence: YES"))
            else
                unilib.utils.chat_send_player(pname, "   " .. S("Fence: NO"))
            end

            if core.registered_nodes[base_name .. "_wood_fence_rail"] ~= nil then
                unilib.utils.chat_send_player(pname, "   " .. S("Fence rail: YES"))
            else
                unilib.utils.chat_send_player(pname, "   " .. S("Fence rail: NO"))
            end

            if core.registered_nodes["unilib:gate_" .. tree_type .. "_closed"] ~= nil then
                unilib.utils.chat_send_player(pname, "   " .. S("Fence gate: YES"))
            else
                unilib.utils.chat_send_player(pname, "   " .. S("Fence gate: NO"))
            end

            if unilib.global.tree_table[tree_type]["incomplete_flag"] == true then
                unilib.utils.chat_send_player(pname, "   " .. S("Incomplete tree: YES"))
            else
                unilib.utils.chat_send_player(pname, "   " .. S("Incomplete tree: NO"))
            end

            if unilib.global.tree_table[tree_type]["slim_flag"] == true then
                unilib.utils.chat_send_player(pname, "   " .. S("Slim trunk: YES"))
            else
                unilib.utils.chat_send_player(pname, "   " .. S("Slim trunk: NO"))
            end

            unilib.utils.chat_send_player(pname, S("End of tree type information"))

        end

    else

        local tree_list = {}
        for k, _ in pairs(unilib.global.tree_table) do
            table.insert(tree_list, k)
        end

        table.sort(tree_list)

        unilib.utils.chat_send_player(pname, S("List of tree types (* = super tree)"))
        unilib.utils.chat_send_player(
            pname,
            S(
                "<T = trunk, t = stripped trunk, W = wood, L = leaves, S = sapling, P = panel," ..
                        " F = fence, R = rail, G = gate, I = incomplete tree, s = slim trunk>"
            )
        )

        for _, tree_type in ipairs(tree_list) do

            local postscript = ""
            local base_name = "unilib:tree_" .. tree_type

            if core.registered_nodes[base_name .. "_trunk"] ~= nil then
                postscript = postscript .. "T"
            end

            if core.registered_nodes[base_name .. "_trunk_stripped"] ~= nil then
                postscript = postscript .. "t"
            end

            if core.registered_nodes[base_name .. "_wood"] ~= nil then
                postscript = postscript .. "W"
            end

            if core.registered_nodes[base_name .. "_leaves"] ~= nil then
                postscript = postscript .. "L"
            end

            if core.registered_nodes[base_name .. "_sapling"] ~= nil then
                postscript = postscript .. "S"
            end

            if core.registered_nodes[base_name .. "_panel"] ~= nil then
                postscript = postscript .. "P"
            end

            if core.registered_nodes[base_name .. "_wood_fence"] ~= nil then
                postscript = postscript .. "F"
            end

            if core.registered_nodes[base_name .. "_wood_fence_rail"] ~= nil then
                postscript = postscript .. "R"
            end

            if core.registered_nodes["unilib:gate_" .. tree_type .. "_closed"] ~= nil then
                postscript = postscript .. "G"
            end

            if unilib.global.tree_table[tree_type]["incomplete_flag"] == true then
                postscript = postscript .. "I"
            end

            if unilib.global.tree_table[tree_type]["slim_flag"] == true then
                postscript = postscript .. "s"
            end

            if postscript ~= "" then
                postscript = " <" .. postscript .. ">"
            end

            if unilib.global.super_tree_table[tree_type] == nil then
                unilib.utils.chat_send_player(pname, "   " .. tree_type .. postscript)
            else
                unilib.utils.chat_send_player(pname, " * " .. tree_type .. postscript)
            end

        end

        unilib.utils.chat_send_player(pname, S("End of list (tree types found: @1)", #tree_list))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_trees.init()

    return {
        description = "Chat commands /list_trees, /list_tree",
        notes = "Lists tree types, or details for the specified tree type",
    }

end

function unilib.pkg.chat_list_trees.exec()

    core.register_chatcommand("list_trees", {
        params = "",
        description = S("Lists all tree types, or details for the specified tree type"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_trees(name, param)
        end,
    })

    core.register_chatcommand("list_tree", {
        params = "",
        description = S("Lists all tree types, or details for the specified tree type"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_trees(name, param)
        end,
    })

end
