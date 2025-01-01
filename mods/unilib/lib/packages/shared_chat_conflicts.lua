---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_chat_conflicts = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Tables of deliberate missing ingredients
local conflict_exception_table = {}
local populated_flag = false

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function populate_table()

    -- Table used by the commands /count_recipe_conflicts, /check_recipe_conflicts,
    --      /count_group_conflicts, /check_group_conflicts
    for _, mini_list in pairs(unilib.global.craft_recipe_conflict_list) do

        if conflict_exception_table[mini_list[1]] == nil then
            conflict_exception_table[mini_list[1]] = {}
        end

        conflict_exception_table[mini_list[1]][mini_list[2]] = true

        if conflict_exception_table[mini_list[2]] == nil then
            conflict_exception_table[mini_list[2]] = {}
        end

        conflict_exception_table[mini_list[2]][mini_list[1]] = true

    end

    populated_flag = true

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

local function get_groups(full_name)

    -- Returns the value of the .groups field for the specified node, craftitem or tool, or an
    --      empty table if no .groups field can be found

    local def_table = core.registered_nodes[full_name]
    if def_table ~= nil then

        -- (The code below is a little simpler, if it can assume a table)
        if def_table.groups == nil then
            return {}
        else
            return def_table.groups
        end

    end

    def_table = core.registered_craftitems[full_name]
    if def_table ~= nil then

        if def_table.groups == nil then
            return {}
        else
            return def_table.groups
        end

    end

    def_table = core.registered_tools[full_name]
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

    -- Compares two tables generated in a call to core.get_all_craft_recipes() for two distinct
    --      nodes/craftitems/tools
    -- If the craft recipes conflict, returns true; if there is no conflict, returns false

    if a_craft_table.type ~= b_craft_table.type or a_craft_table.width ~= b_craft_table.width then
        return false
    end

    -- The first time this function is called, populate "conflict_exception_table"
    if not populated_flag then
        populate_table()
    end

    if a_craft_table.output ~= nil and b_craft_table.output ~= nil then

        local mini_table = conflict_exception_table[a_craft_table.output]
        if mini_table ~= nil and mini_table[b_craft_table.output] ~= nil then
            return false
        end

    end

    -- In a crafting grid, a call to core.register_craft() uses an empty string for an empty cell,
    --      but only full cells are stored in the craft tables produced by
    --      core.get_all_craft_recipes()
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

function unilib.pkg.shared_chat_conflicts.check_recipe_conflicts(
    pname, detailed_output_flag, check_groups_flag
)
    local craft_list = {}
    local check_table = {}
    local conflict_count = 0

    -- Compile a complete list of craft recipes for all nodes, craftitems and tools
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

                            unilib.utils.chat_send_player(
                                pname, S("Detected craft recipe conflict")
                            )
                            unilib.utils.show_table_in_chat(pname, craft_list[a])
                            unilib.utils.show_table_in_chat(pname, craft_list[b])

                        end

                    end

                end

            end

        end

    end

    return conflict_count

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_chat_conflicts.init()

    return {
        description = "Shared functions for chat commands for checking recipe conflicts",
    }

end
