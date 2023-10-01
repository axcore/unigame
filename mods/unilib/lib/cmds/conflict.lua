---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- conflict.lua
--      Set up chat commands for checking recipe conflicts
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local variables
---------------------------------------------------------------------------------------------------

-- Table of exceptions (craft recipes whose .output conflicts another craft recipe's .output
--      deliberately)
local exception_table = {}
for _, mini_list in pairs(unilib.craft_recipe_conflict_list) do

    if exception_table[mini_list[1]] == nil then
        exception_table[mini_list[1]] = {}
    end

    exception_table[mini_list[1]][mini_list[2]] = true

    if exception_table[mini_list[2]] == nil then
        exception_table[mini_list[2]] = {}
    end

    exception_table[mini_list[2]][mini_list[1]] = true

end

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_groups(full_name)

    -- Returns the value of the .groups field for the specified node, craftitem or tool, or an
    --      empty table if no .groups field can be found

    local def_table = minetest.registered_nodes[full_name]
    if def_table ~= nil then

        -- (The code below is a little simpler, if it can assume a table
        if def_table.groups == nil then
            return {}
        else
            return def_table.groups
        end

    end

    def_table = minetest.registered_craftitems[full_name]
    if def_table ~= nil then

        if def_table.groups == nil then
            return {}
        else
            return def_table.groups
        end

    end

    def_table = minetest.registered_tools[full_name]
    if def_table ~= nil then

        if def_table.groups == nil then
            return {}
        else
            return def_table.groups
        end

    end

    return {}

end

local function compare_craft(a_craft_table, b_craft_table, check_groups_flag)

    -- Compares two tables generated in a call to minetest.get_all_craft_recipes() for two distinct
    --      nodes/craftitems/tools
    -- If the craft recipes conflict, returns true; if there is no conflict, returns false

    if a_craft_table.type ~= b_craft_table.type or a_craft_table.width ~= b_craft_table.width then
        return false
    end

    if a_craft_table.output ~= nil and b_craft_table.output ~= nil then

        local mini_table = exception_table[a_craft_table.output]
        if mini_table ~= nil and mini_table[b_craft_table.output] ~= nil then
            return false
        end

    end

    -- In a crafting grid, a call to minetest.register_craft() uses an empty string for an empty
    --      cell, but only full cells are stored in the craft tables produced by
    --      minetest.get_all_craft_recipes()
    local a_size = 0
    for i, _ in pairs(a_craft_table.items) do

        if a_size < i then
            a_size = i
        end

    end

    local b_size = 0
    for i, _ in pairs(b_craft_table.items) do

        if b_size < i then
            b_size = i
        end

    end

    -- I don't think a zero size is possible, but we'll check anyway...
    if a_size ~= b_size or a_size == 0 then
        return false
    end

    -- Check for conflicts
    for i = 1, a_size do

        local a_item = a_craft_table.items[i]
        local b_item = b_craft_table.items[i]

        if not check_groups_flag then

            -- Don't take item groups into account
            if a_item ~= b_item then
                return false
            end

        else

            -- Take item groups into account
            if (a_item == nil and b_item ~= nil) or (a_item ~= nil and b_item == nil) then
                return false
            end

            local a_group_table = get_groups(a_item)
            local b_group_table = get_groups(b_item)

            local a_group = nil
            if a_item ~= nil and string.sub(a_item, 1, 6) == "group:" then
                a_group = string.sub(a_item, 7)
            end

            local b_group = nil
            if b_item ~= nil and string.sub(b_item, 1, 6) == "group:" then
                b_group = string.sub(b_item, 7)
            end

            if a_group ~= nil and b_group ~= nil then

                -- (Continue if both items share the same group, or if neither does)
                if a_group_table[b_group] == nil or b_group_table[a_group] == nil then
                    return false
                end

            elseif a_group ~= nil then

                if b_group_table[a_group] == nil then
                    return false
                end

            elseif b_group ~= nil then

                if a_group_table[b_group] == nil then
                    return false
                end

            else

                if a_item ~= b_item then
                    return false
                end

            end

        end

    end

    -- Craft recipe conflict detected
    return true

end

local function check_recipe_conflicts(detailed_output_flag, check_groups_flag)

    local craft_list = {}
    local check_table = {}
    local conflict_count = 0

    -- Compile a complete list of craft recipes for all nodes, craftitems and tools
    for full_name, _ in pairs(minetest.registered_nodes) do

        check_table[full_name] = S("node")

        local node_craft_list = minetest.get_all_craft_recipes(full_name)
        if node_craft_list ~= nil then

            for _, craft_table in pairs(node_craft_list) do
                table.insert(craft_list, craft_table)
            end

        end

    end

    for full_name, _ in pairs(minetest.registered_craftitems) do

        if check_table[full_name] ~= nil then

            minetest.chat_send_player(name, S("Detected duplicate item name"))
            minetest.chat_send_player(name, full_name .. " [" .. S("craftitem") .. "]")
            minetest.chat_send_player(name, full_name .. " [" .. check_table[full_name] .. "]")

        else

            check_table[full_name] = S("craftitem")

        end

        local craftitem_craft_list = minetest.get_all_craft_recipes(full_name)
        if craftitem_craft_list ~= nil then

            for _, craft_table in pairs(craftitem_craft_list) do
                table.insert(craft_list, craft_table)
            end

        end

    end

    for full_name, _ in pairs(minetest.registered_tools) do

        if check_table[full_name] ~= nil then

            minetest.chat_send_player(name, S("Detected duplicate item name"))
            minetest.chat_send_player(name, full_name .. " [" .. S("tool") .. "]")
            minetest.chat_send_player(name, full_name .. " [" .. check_table[full_name] .. "]")

        else

            check_table[full_name] = S("tool")

        end

        local tool_craft_list = minetest.get_all_craft_recipes(full_name)
        if tool_craft_list ~= nil then

            for _, craft_table in pairs(tool_craft_list) do
                table.insert(craft_list, craft_table)
            end

        end

    end

    -- Compare all of these craft recipes against each other, looking for conflicts
    -- If the MT setting is enabled, show a detailed report in the chat window; otherwise, just
    --      show the number of conflicts found
    local size = #craft_list
    if size >= 2 then

        -- (Don't check a craft recipe against itself; don't check A against B, then B
        --      against A)
        for a = 1, size do

            for b = a, size do

                if a ~= b then

                    if compare_craft(craft_list[a], craft_list[b], check_groups_flag) then

                        conflict_count = conflict_count + 1

                        if detailed_output_flag then

                            minetest.chat_send_player(name, S("Detected craft recipe conflict"))
                            unilib.show_table_in_chat(name, craft_list[a])
                            unilib.show_table_in_chat(name, craft_list[b])

                        end

                    end

                end

            end

        end

    end

    return conflict_count

end

---------------------------------------------------------------------------------------------------
-- /count_recipe_conflicts: Checks for recipe conflicts, displaying the total number found
-- /check_recipe_conflicts: Checks for recipe conflicts, displaying detailed output
-- /count_group_conflicts: Checks for recipe conflicts (taking groups into account), and displays
--      the total number found
-- /check_group_conflicts: Checks for recipe conflicts (taking groups into account), and displays
--      the total number found
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("count_recipe_conflicts", {
    params = "",
    description = S("Checks for recipe conflicts, displaying the total number found"),
    privs = {unilib_tools = true},

    func = function(name, param)

        local conflict_count = check_recipe_conflicts(false, false)

        if conflict_count > 0 then
            return false, S("Craft recipe conflicts detected: @1", conflict_count)
        else
            return true, S("No recipe conflicts found")
        end

    end,
})

minetest.register_chatcommand("check_recipe_conflicts", {
    params = "",
    description = S("Checks for recipe conflicts, displaying detailed output"),
    privs = {unilib_tools = true},

    func = function(name, param)

        local conflict_count = check_recipe_conflicts(true, false)

        if conflict_count > 0 then
            return false, S("Craft recipe conflicts detected: @1", conflict_count)
        else
            return true, S("No recipe conflicts found")
        end

    end,
})

minetest.register_chatcommand("count_group_conflicts", {
    params = "",
    description = S(
        "Checks for recipe conflicts (taking groups into account), and displays the total number" ..
        " found"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)

        local conflict_count = check_recipe_conflicts(false, true)

        if conflict_count > 0 then
            return false, S("Craft recipe conflicts detected: @1", conflict_count)
        else
            return true, S("No recipe conflicts found")
        end

    end,
})

minetest.register_chatcommand("check_group_conflicts", {
    params = "",
    description = S(
        "Checks for recipe conflicts (taking groups into account), and displays the total number" ..
        " found"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)

        local conflict_count = check_recipe_conflicts(true, true)

        if conflict_count > 0 then
            return false, S("Craft recipe conflicts detected: @1", conflict_count)
        else
            return true, S("No recipe conflicts found")
        end

    end,
})
