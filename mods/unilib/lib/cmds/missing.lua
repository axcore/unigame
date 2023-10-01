---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- missing.lua
--      Set up chat commands for checking recipes with missing items
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local variables
---------------------------------------------------------------------------------------------------

-- Table of deliberate missing ingredients
local exception_table = {}
for _, mini_list in pairs(unilib.craft_recipe_missing_ingredient_list) do

    if exception_table[mini_list[1]] == nil then
        exception_table[mini_list[1]] = {}
    end

    exception_table[mini_list[1]][mini_list[2]] = true

end

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function compile_craft_list()

    -- Return a complete list of craft recipes for all nodes, craftitems and tools, checking for
    --      duplicate node/craftitem/tool names as we go

    local craft_list = {}
    local check_table = {}

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

    return craft_list

end

local function compile_group_table()

    -- Return a complete table of groups, and the nodes/craftitems/tools that supply those groups
    -- Table in the form
    --      group_table[group_name] = list_of_nodes_craftitems_and_tools

    local group_table = {}

    for full_name, def_table in pairs(minetest.registered_nodes) do

        if def_table.groups ~= nil then

            for group, value in pairs(def_table.groups) do

                if group_table[group] == nil then
                    group_table[group] = {full_name}
                else
                    table.insert(group_table[group], full_name)
                end

            end

        end

    end

    for full_name, def_table in pairs(minetest.registered_craftitems) do

        if def_table.groups ~= nil then

            for group, value in pairs(def_table.groups) do

                if group_table[group] == nil then
                    group_table[group] = {full_name}
                else
                    table.insert(group_table[group], full_name)
                end

            end

        end

    end

    for full_name, def_table in pairs(minetest.registered_tools) do

        if def_table.groups ~= nil then

            for group, value in pairs(def_table.groups) do

                if group_table[group] == nil then
                    group_table[group] = {full_name}
                else
                    table.insert(group_table[group], full_name)
                end

            end

        end

    end

    return group_table

end

local function check_combined_groups(group_name, group_table)

    -- Special handling for "group:flower,color_red" etc
    -- Checks whether any node/craftitem/tool provides all of the groups specified by "group_name",
    --      in this case the groups "flower" and "color_red"
    -- "group_table" is the table returned in an earlier call to compile_group_table()

    local group_name_list = {}
    for word in string.gmatch(group_name, "([^,]+)") do
        table.insert(group_name_list, word)
    end

    -- (We only need to check the entry for the first group; if it fails, all subsequent groups
    --      would also fail)
    if group_table[group_name_list[1]] == nil then
        return false
    end

    for _, this_item in pairs(group_table[group_name_list[1]]) do

        local missing_flag = false

        for _, this_group in pairs(group_name_list) do

            if unilib.get_definition_and_group(this_item, this_group) == 0 then

                missing_flag = true
                break

            end

        end

        if not missing_flag then

            -- Found a node/craftitem/tool with all the required groups
            return true

        end

    end

    return false

end

local function check_broken_recipes(detailed_output_flag)

    local missing_count = 0

    -- Compile a complete list of craft recipes for all nodes, craftitems and tools
    local craft_list = compile_craft_list()
    -- Compile a table of groups, and the nodes/craftitems/tools that supply those groups
    local group_table = compile_group_table()

    -- Check each craft recipe in turn
    for _, craft_table in pairs(craft_list) do

        local output, _ = unilib.get_item_and_multiple(craft_table.output)

        for _, ingredient in ipairs(craft_table.items) do

            if exception_table[output] ~= nil and
                    exception_table[output][ingredient] ~= nil then

                -- (Do nothing)

            elseif string.sub(ingredient, 1, 6) ~= "group:" then

                if minetest.registered_nodes[ingredient] == nil and
                        minetest.registered_craftitems[ingredient] == nil and
                        minetest.registered_tools[ingredient] == nil then

                    missing_count = missing_count + 1

                    if detailed_output_flag then

                        minetest.chat_send_player(name, S("Missing ingredient in craft recipe"))
                        minetest.chat_send_player(name, "   " .. S("Output:") .. " " .. output)
                        minetest.chat_send_player(name, "   " .. S("Missing:") .. " " .. ingredient)

                    end

                end

            else

                local group_name = string.sub(ingredient, 7)
                if not string.match(group_name, ",") then

                    if group_table[group_name] == nil then

                        missing_count = missing_count + 1

                        if detailed_output_flag then

                            minetest.chat_send_player(
                                name, S("Missing ingredient group in craft recipe")
                            )
                            minetest.chat_send_player(name, "   " .. S("Output:") .. " " .. output)
                            minetest.chat_send_player(
                                name, "   " .. S("Group:") .. " " .. group_name
                            )

                        end

                    end

                else

                    -- Special handling for "group:flower,color_red" etc
                    if not check_combined_groups(group_name, group_table) then

                        missing_count = missing_count + 1

                        if detailed_output_flag then

                            minetest.chat_send_player(
                                name, S("Missing ingredient groups in craft recipe")
                            )
                            minetest.chat_send_player(
                                name, "   " .. S("Output:") .. " " .. output
                            )
                            minetest.chat_send_player(
                                name, "   " .. S("Groups:") .. " " .. group_name
                            )

                        end

                    end

                end

            end

        end

    end

    return missing_count

end

---------------------------------------------------------------------------------------------------
-- /count_broken_recipes: Checks for missing recipe ingredients, displaying the total number found
-- /check_broken_recipes: Checks for missing recipe ingredients, displaying detailed output
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("count_broken_recipes", {
    params = "",
    description = S("Checks for missing recipe ingredients, displaying the total number found"),
    privs = {unilib_tools = true},

    func = function(name, param)

        local missing_count = check_broken_recipes(false)

        if missing_count > 0 then
            return false, S("Missing recipe ingredients detected: @1", missing_count)
        else
            return true, S("No missing recipe ingredients found")
        end

    end,
})

minetest.register_chatcommand("check_broken_recipes", {
    params = "",
    description = S("Checks for missing recipe ingredients, displaying detailed output"),
    privs = {unilib_tools = true},

    func = function(name, param)

        local missing_count = check_broken_recipes(true)

        if missing_count > 0 then
            return false, S("Missing recipe ingredients detected: @1", missing_count)
        else
            return true, S("No missing recipe ingredients found")
        end

    end,
})

---------------------------------------------------------------------------------------------------
-- /list_groups: List groups, and the items that provide them
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("list_groups", {
    params = "[<group name>]",
    description = S("List groups, and the items that provide them"),
    privs = {unilib_tools = true},

    func = function(name, param)

        local group_table = compile_group_table()
        if param ~= "" then

            if group_table[param] == nil then

                return false, S("No items provide the \"@1\" group", param)

            else

                local item_list = group_table[param]
                group_table = {}
                group_table[param] = item_list

            end

        end

        minetest.chat_send_player(name, S("Registered groups"))

        local group_list = unilib.sort_table(group_table)
        for _, group_name in ipairs(group_list) do

            minetest.chat_send_player(name, S("Group: @1", group_name))
            local item_list = group_table[group_name]
            table.sort(item_list)

            for _, full_name in ipairs(item_list) do
                minetest.chat_send_player(name, "   " .. full_name)
            end

        end

        minetest.chat_send_player(name, S("End of list (unique groups found: @1)", #group_list))

    end,
})
