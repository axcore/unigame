---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- dump.lua
--      Set up chat commands for dumping definitions (of nodes, etc) to the chat window
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_dump(name, param)

    local item_type = nil

    if param == "" then

        return false, S("Please specify the exact name of a node, craftitem or tool")

    else

        local def_table = minetest.registered_nodes[param]
        if def_table ~= nil then

            item_type = "node"

        else

            def_table = minetest.registered_craftitems[param]
            if def_table ~= nil then

                item_type = "craftitem"

            else

                def_table = minetest.registered_tools[param]
                if def_table ~= nil then

                    item_type = "tool"

                end

            end

        end

        if def_table == nil then

            return false, S("No registered items match the name \"@1\"", param)

        else

            if item_type == "node" then
                minetest.chat_send_player(name, "Node: " .. param)
            elseif item_type == "craftitem" then
                minetest.chat_send_player(name, "Craftitem: " .. param)
            else
                minetest.chat_send_player(name, "Tool: " .. param)
            end

            unilib.show_table_in_chat(name, def_table)

        end

    end

end

local function do_dump_item(name, param)

    local item_list = {}
    local check_table = {}
    local count = 0

    for k, _ in pairs(minetest.registered_nodes) do

        if param == "" or string.find(k, param) then

            table.insert(item_list, tostring(k))
            check_table[k] = true
            count = count + 1

        end

    end

    for k, _ in pairs(minetest.registered_craftitems) do

        if check_table[k] == nil and (param == "" or string.find(k, param)) then

            table.insert(item_list, tostring(k))
            check_table[k] = true
            count = count + 1

        end

    end

    for k, _ in pairs(minetest.registered_tools) do

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
            minetest.chat_send_player(name, S("List of registered nodes/craftitems/tools"))
        else
            minetest.chat_send_player(name, S("List of matching nodes/craftitems/tools"))
        end

        table.sort(item_list)
        for _, full_name in ipairs(item_list) do

            if minetest.registered_nodes[full_name] ~= nil then

                minetest.chat_send_player(name, "Node: " .. full_name)
                unilib.show_table_in_chat(name, minetest.registered_nodes[full_name])

            elseif minetest.registered_craftitems[full_name] ~= nil then

                minetest.chat_send_player(name, "Craftitem: " .. full_name)
                unilib.show_table_in_chat(name, minetest.registered_craftitems[full_name])

            else

                minetest.chat_send_player(name, "Tool: " .. full_name)
                unilib.show_table_in_chat(name, minetest.registered_tools[full_name])

            end

        end

        minetest.chat_send_player(name, S("End of list (matching items found: @1)", count))

    end

end

local function do_dump_abm(name, param)

    local abm_list = {}
    local count = 0

    for _, abm_table in ipairs(minetest.registered_abms) do

        if param == "" or (abm_table.label ~= nil and string.find(abm_table.label, param)) then

            table.insert(abm_list, abm_table)
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No ABMs are registered")
        else
            return false, S("No registered ABMs match the pattern \"@1\"", param)
        end

    else

        if param == "" then
            minetest.chat_send_player(name, S("List of registered ABMs"))
        else
            minetest.chat_send_player(name, S("List of matching ABMs"))
        end

        for _, abm_table in ipairs(abm_list) do

            if abm_table.label == nil or abm_table.label == "" then
                minetest.chat_send_player(name, S("ABM with no label"))
            else
                minetest.chat_send_player(name, "ABM: " .. abm_table.label)
            end

            unilib.show_table_in_chat(name, abm_table)

        end

        minetest.chat_send_player(name, S("End of list (matching ABMs found: @1)", count))

    end

end

local function do_dump_biome(name, param)

    local biome_list = {}
    local count = 0

    for k, _ in pairs(minetest.registered_biomes) do

        if param == "" or string.find(k, param) then

            table.insert(biome_list, tostring(k))
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No biomes are registered")
        else
            return false, S("No registered biomes match the pattern \"@1\"", param)
        end

    else

        if param == "" then
            minetest.chat_send_player(name, S("List of registered biomes"))
        else
            minetest.chat_send_player(name, S("List of matching biomes"))
        end

        table.sort(biome_list)
        for _, biome_name in ipairs(biome_list) do

            minetest.chat_send_player(name, "Biome: " .. biome_name)
            unilib.show_table_in_chat(name, minetest.registered_biomes[biome_name])

        end

        minetest.chat_send_player(name, S("End of list (matching biomes found: @1)", count))

    end

end

local function do_dump_craftitem(name, param)

    local craftitem_list = {}
    local count = 0

    for k, _ in pairs(minetest.registered_craftitems) do

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
            minetest.chat_send_player(name, S("List of registered craftitems"))
        else
            minetest.chat_send_player(name, S("List of matching craftitems"))
        end

        table.sort(craftitem_list)
        for _, full_name in ipairs(craftitem_list) do

            minetest.chat_send_player(name, "Craftitem: " .. full_name)
            unilib.show_table_in_chat(name, minetest.registered_craftitems[full_name])

        end

        minetest.chat_send_player(name, S("End of list (matching craftitems found: @1)", count))

    end

end

local function do_dump_decoration(name, param)

    local deco_list = {}
    local count = 0

    for k, _ in pairs(minetest.registered_decorations) do

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
            minetest.chat_send_player(name, S("List of registered decorations"))
        else
            minetest.chat_send_player(name, S("List of matching decorations"))
        end

        table.sort(deco_list)
        for _, deco_name in ipairs(deco_list) do

            minetest.chat_send_player(name, "Decoration: " .. deco_name)
            unilib.show_table_in_chat(name, minetest.registered_decorations[deco_name])

        end

        minetest.chat_send_player(name, S("End of list (matching decorations found: @1)", count))

    end

end

local function do_dump_lbm(name, param)

    local lbm_list = {}
    local count = 0

    for _, lbm_table in ipairs(minetest.registered_lbms) do

        if param == "" or
                (lbm_table.label ~= nil and string.find(lbm_table.label, param)) or
                (lbm_table.name ~= nil and string.find(lbm_table.name, param)) then

            table.insert(lbm_list, lbm_table)
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No LBMs are registered")
        else
            return false, S("No registered LBMs match the pattern \"@1\"", param)
        end

    else

        if param == "" then
            minetest.chat_send_player(name, S("List of registered LBMs"))
        else
            minetest.chat_send_player(name, S("List of matching LBMs"))
        end

        for _, lbm_table in ipairs(lbm_list) do

            minetest.chat_send_player(name, "   " .. lbm_table.mod_origin)

            if lbm_table.label == nil or lbm_table.label == "" then
                minetest.chat_send_player(name, "      " .. S("No label"))
            else
                minetest.chat_send_player(name, "      " .. lbm_table.label)
            end

            if lbm_table.name == nil or lbm_table.name == "" then
                minetest.chat_send_player(name, "      " .. S("No name"))
            else
                minetest.chat_send_player(name, "      " .. lbm_table.name)
            end

            unilib.show_table_in_chat(name, lbm_table)

        end

        minetest.chat_send_player(name, S("End of list (matching LBMs found: @1)", count))

    end

end

local function do_dump_node(name, param)

    local node_list = {}
    local count = 0

    for k, _ in pairs(minetest.registered_nodes) do

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
            minetest.chat_send_player(name, S("List of registered nodes"))
        else
            minetest.chat_send_player(name, S("List of matching nodes"))
        end

        table.sort(node_list)
        for _, full_name in ipairs(node_list) do

            minetest.chat_send_player(name, "Node: " .. full_name)
            unilib.show_table_in_chat(name, minetest.registered_nodes[full_name])

        end

        minetest.chat_send_player(name, S("End of list (matching nodes found: @1)", count))

    end

end

local function do_dump_ore(name, param)

    local ore_list = {}
    local count = 0

    for _, ore_table in pairs(minetest.registered_ores) do

        if param == "" or
                (ore_table.type ~= nil and string.find(ore_table.type, param)) or
                (ore_table.ore ~= nil and string.find(ore_table.ore, param)) or
                (ore_table.wherein ~= nil and string.find(ore_table.wherein, param)) then

            table.insert(ore_list, ore_table)
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No ores are registered")
        else
            return false, S("No registered ores match the pattern \"@1\"", param)
        end

    else

        if param == "" then
            minetest.chat_send_player(name, S("List of registered ores"))
        else
            minetest.chat_send_player(name, S("List of matching ores"))
        end

        for _, ore_table in ipairs(ore_list) do

            minetest.chat_send_player(name, "Ore: " .. ore_table.ore)
            unilib.show_table_in_chat(name, ore_table)

        end

        minetest.chat_send_player(name, S("End of list (matching ores found: @1)", count))

    end

end

local function do_dump_tool(name, param)

    local tool_list = {}
    local count = 0

    for k, _ in pairs(minetest.registered_tools) do

        if param == "" or string.find(k, param) then

            table.insert(tool_list, tostring(k))
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No tools are registered")
        else
            return false, S("No registered tools match the pattern \"@1\"", param)
        end

    else

        if param == "" then
            minetest.chat_send_player(name, S("List of registered tools"))
        else
            minetest.chat_send_player(name, S("List of matching tools"))
        end

        table.sort(tool_list)
        for _, full_name in ipairs(tool_list) do

            minetest.chat_send_player(name, "Tool: " .. full_name)
            unilib.show_table_in_chat(name, minetest.registered_tools[full_name])

        end

        minetest.chat_send_player(name, S("End of list (matching tools found: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- /dump: Dumps definition of the node, craftitem or tool with the (exact) specified name
-- /dump_item: Dumps definitions of nodes, craftitems and tools with a matching name
--
-- /dump_abm: Dumps definitions of ABMs with a matching label
-- /dump_biome: Dumps definitions of biomes with a matching name
-- /dump_craftitem: Dumps definitions of craftitems with a matching name
-- /dump_decoration: Dumps definitions of decorations with a matching name
-- /dump_lbm: Dumps definitions of LBMs with a matching name or label
-- /dump_node: Dumps definitions of nodes with a matching name
-- /dump_ore: Dumps definitions of ores with a matching type, ore node or wherein node
-- /dump_tool: Dumps definitions of tools  with a matching name
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("dump", {
    params = "<name>",
    description = S(
        "Dumps definition of the node, craftitem or tool with the (exact) specified name"
    ),
    privs = {unilib_admin = true},

    func = function(name, param)
        return do_dump(name, param)
    end,
})

minetest.register_chatcommand("dump_item", {
    params = "<pattern>",
    description = S("Dumps definitions for any node/craftitem/tool whose name matches the pattern"),
    privs = {unilib_admin = true},

    func = function(name, param)
        return do_dump_item(name, param)
    end,
})

minetest.register_chatcommand("dump_abm", {
    params = "<pattern>",
    description = S("Dumps ABM definitions for any ABM whose label matches the pattern"),
    privs = {unilib_admin = true},

    func = function(name, param)
        return do_dump_abm(name, param)
    end,
})

minetest.register_chatcommand("dump_biome", {
    params = "<pattern>",
    description = S("Dumps biome definitions for any biome whose name matches the pattern"),
    privs = {unilib_admin = true},

    func = function(name, param)
        return do_dump_biome(name, param)
    end,
})

minetest.register_chatcommand("dump_craftitem", {
    params = "<pattern>",
    description = S("Dumps craftitem definitions for any craftitem whose name matches the pattern"),
    privs = {unilib_admin = true},

    func = function(name, param)
        return do_dump_craftitem(name, param)
    end,
})

minetest.register_chatcommand("dump_decoration", {
    params = "<pattern>",
    description = S(
        "Dumps decoration definitions for any decoration whose name matches the pattern"
    ),
    privs = {unilib_admin = true},

    func = function(name, param)
        return do_dump_decoration(name, param)
    end,
})

minetest.register_chatcommand("dump_lbm", {
    params = "<pattern>",
    description = S("Dumps LBM definitions for any LBM whose name or label matches the pattern"),
    privs = {unilib_admin = true},

    func = function(name, param)
        return do_dump_lbm(name, param)
    end,
})

minetest.register_chatcommand("dump_node", {
    params = "<pattern>",
    description = S("Dumps node definitions for any node whose name matches the pattern"),
    privs = {unilib_admin = true},

    func = function(name, param)
        return do_dump_node(name, param)
    end,
})

minetest.register_chatcommand("dump_ore", {
    params = "<pattern>",
    description = S(
        "Dumps ore definitions for any ore whose type/ore node/wherein node matches the pattern"
    ),
    privs = {unilib_admin = true},

    func = function(name, param)
        return do_dump_ore(name, param)
    end,
})

minetest.register_chatcommand("dump_tool", {
    params = "<pattern>",
    description = S("Dumps tool definitions for any tool whose name matches the pattern"),
    privs = {unilib_admin = true},

    func = function(name, param)
        return do_dump_tool(name, param)
    end,
})
