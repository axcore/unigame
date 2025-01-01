---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_chat_missing = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Tables of deliberate missing ingredients
local broken_exception_table = {}
local populated_flag = false

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function populate_table()

    -- Table used by the commands /check_broken_recipes, /count_broken_recipes
    for _, mini_list in pairs(unilib.global.craft_recipe_missing_ingredient_list) do

        if broken_exception_table[mini_list[1]] == nil then
            broken_exception_table[mini_list[1]] = {}
        end

        broken_exception_table[mini_list[1]][mini_list[2]] = true

    end

    populated_flag = true

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

local function compile_craft_list(pname)

    -- Return a complete list of craft recipes for all nodes, craftitems and tools, checking for
    --      duplicate node/craftitem/tool names as we go

    local craft_list = {}
    local check_table = {}

    for full_name, _ in pairs(core.registered_nodes) do

        check_table[full_name] = S("node")

        local node_craft_list = core.get_all_craft_recipes(full_name)
        if node_craft_list ~= nil then

            for _, craft_table in pairs(node_craft_list) do
                table.insert(craft_list, craft_table)
            end

        end

    end

    for full_name, _ in pairs(core.registered_craftitems) do

        if check_table[full_name] ~= nil then

            unilib.utils.chat_send_player(pname, S("Detected duplicate item name"))
            unilib.utils.chat_send_player(pname, full_name .. " [" .. S("craftitem") .. "]")
            unilib.utils.chat_send_player(pname, full_name .. " [" .. check_table[full_name] .. "]")

        else

            check_table[full_name] = S("craftitem")

        end

        local craftitem_craft_list = core.get_all_craft_recipes(full_name)
        if craftitem_craft_list ~= nil then

            for _, craft_table in pairs(craftitem_craft_list) do
                table.insert(craft_list, craft_table)
            end

        end

    end

    for full_name, _ in pairs(core.registered_tools) do

        if check_table[full_name] ~= nil then

            unilib.utils.chat_send_player(pname, S("Detected duplicate item name"))
            unilib.utils.chat_send_player(pname, full_name .. " [" .. S("tool") .. "]")
            unilib.utils.chat_send_player(pname, full_name .. " [" .. check_table[full_name] .. "]")

        else

            check_table[full_name] = S("tool")

        end

        local tool_craft_list = core.get_all_craft_recipes(full_name)
        if tool_craft_list ~= nil then

            for _, craft_table in pairs(tool_craft_list) do
                table.insert(craft_list, craft_table)
            end

        end

    end

    return craft_list

end

function unilib.pkg.shared_chat_missing.compile_group_table()

    -- Return a complete table of groups, and the nodes/craftitems/tools that supply those groups
    -- Table in the form
    --      group_table[group_name] = list_of_nodes_craftitems_and_tools

    local group_table = {}

    for full_name, def_table in pairs(core.registered_nodes) do

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

    for full_name, def_table in pairs(core.registered_craftitems) do

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

    for full_name, def_table in pairs(core.registered_tools) do

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

    -- Special handling for "group:flower,colour_red" etc
    -- Checks whether any node/craftitem/tool provides all of the groups specified by "group_name",
    --      in this case the groups "flower" and "colour_red"
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

            if unilib.utils.get_definition_and_group(this_item, this_group) == 0 then

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

function unilib.pkg.shared_chat_missing.check_broken_recipes(pname, detailed_output_flag)

    local missing_count = 0

    -- Compile a complete list of craft recipes for all nodes, craftitems and tools
    local craft_list = compile_craft_list(pname)
    -- Compile a table of groups, and the nodes/craftitems/tools that supply those groups
    local group_table = unilib.pkg.shared_chat_missing.compile_group_table()

    -- The first time this function is called, populate "broken_exception_table"
    if not populated_flag then
        populate_table()
    end

    -- Check each craft recipe in turn
    for _, craft_table in pairs(craft_list) do

        local output, _ = unilib.utils.get_item_and_multiple(craft_table.output)

        for _, ingredient in ipairs(craft_table.items) do

            if broken_exception_table[output] ~= nil and
                    broken_exception_table[output][ingredient] ~= nil then

                -- (Do nothing)

            elseif string.sub(ingredient, 1, 6) ~= "group:" then

                if core.registered_nodes[ingredient] == nil and
                        core.registered_craftitems[ingredient] == nil and
                        core.registered_tools[ingredient] == nil then

                    missing_count = missing_count + 1

                    if detailed_output_flag then

                        unilib.utils.chat_send_player(
                            pname, S("Missing ingredient in craft recipe")
                        )
                        unilib.utils.chat_send_player(
                            pname, "   " .. S("Output:") .. " " .. output
                        )
                        unilib.utils.chat_send_player(
                            pname, "   " .. S("Missing:") .. " " .. ingredient
                        )

                    end

                end

            else

                local group_name = string.sub(ingredient, 7)
                if not string.match(group_name, ",") then

                    if group_table[group_name] == nil then

                        missing_count = missing_count + 1

                        if detailed_output_flag then

                            unilib.utils.chat_send_player(
                                pname, S("Missing ingredient group in craft recipe")
                            )
                            unilib.utils.chat_send_player(
                                pname, "   " .. S("Output:") .. " " .. output
                            )
                            unilib.utils.chat_send_player(
                                pname, "   " .. S("Group:") .. " " .. group_name
                            )

                        end

                    end

                else

                    -- Special handling for "group:flower,colour_red" etc
                    if not check_combined_groups(group_name, group_table) then

                        missing_count = missing_count + 1

                        if detailed_output_flag then

                            unilib.utils.chat_send_player(
                                pname, S("Missing ingredient groups in craft recipe")
                            )
                            unilib.utils.chat_send_player(
                                pname, "   " .. S("Output:") .. " " .. output
                            )
                            unilib.utils.chat_send_player(
                                pname, "   " .. S("Groups:") .. " " .. group_name
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
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_chat_missing.init()

    return {
        description = "Shared functions for chat commands for checking recipes with missing items",
    }

end
