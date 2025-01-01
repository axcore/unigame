---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_ingredients = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function craft_is_circular(full_name, recipe_table)

    -- Called by add_ingredients() when we're choosing a craft recipe for "full_name" from one of
    --      several alternatives
    -- We want to eliminate circular craft recipes, for example
    --      metal_ingot > metal_block > metal_ingot
    -- ...but only when the two items are provided by the same mod
    --
    -- Args:
    --      full_name (str): An item for which a craft recipe must be chosen
    --      recipe_table (str): A craft recipe which might be suitable for this item
    --
    -- Return values:
    --      true if the craft recipe is circular, false if not

    local mod_name = unilib.utils.get_mod_name(full_name)

    for _, ingredient_name in ipairs(recipe_table.items) do

        local all_craft_list = core.get_all_craft_recipes(ingredient_name)
        if all_craft_list ~= nil then

            for _, recipe_table in ipairs(all_craft_list) do

                -- (Throughout this chat command, we ignore "cooking" and "fuel" recipes, as the
                --      user is not likely to find them useful)
                if recipe_table.method == "normal" then

                    for _, sub_ingredient_name in ipairs(recipe_table.items) do

                        local sub_mod_name = unilib.utils.get_mod_name(sub_ingredient_name)

                        if mod_name == sub_mod_name and sub_ingredient_name == full_name then
                            return true
                        end

                    end

                end

            end

        end

    end

    return false

end

local function find_suitable_recipe(base_name, current_name, all_craft_list)

    -- Called by add_ingredients() to find a suitable craft recipe for a particular item (not
    --      specified as an argument to this function)
    --
    -- Args:
    --      base_name (str): The user's specified item (node, craftitem or tool); we try to find
    --          all ingredients used to craft it
    --      current_name (str): The item to test in this function call; initially the same as
    --          "base_name" itself, and then recursively for all of its ingredients
    --      all_craft_list (list): A list of all craft recipes for a particular item (not specified
    --          as an argument to this function)
    --
    -- Return values
    --      Return the most suitable craft recipe - one of the items returned by
    --          core.get_all_craft_recipes() - or nil

    -- Find a craft recipe which:
    --      1. Is not a cooking/fuel recipe
    --      2. Does not contain the item specified by the user, "base_name"
    --      3. Contains at least one ingredient that isn't a stair/carving (walls are acceptable)
    --      4. Is not a circular craft recipe (e.g. metal ingot > metal block > metal ingot)
    local match_recipe_table = nil
    -- If more than one suitable recipe is found, prefer the one with more unique ingredients
    --      (because that is the one the user is likely to prefer)
    local match_unique_count = 0
    -- If we don't find any suitable recipes, we will reluctantly use the first one which satisfies
    --      conditions 1 and 2
    local reserve_recipe_table = nil

    for _, recipe_table in ipairs(all_craft_list) do

        -- (Throughout this chat command, we ignore "cooking" and "fuel" recipes, as the user is not
        --      likely to find them useful)
        if recipe_table.method == "normal" then

            local match_flag = false
            local ignore_flag = false
            local unique_count = 0
            local check_table = {}

            for _, ingredient_name in ipairs(recipe_table.items) do

                if check_table[ingredient_name] == nil then
                    unique_count = unique_count + 1
                else
                    check_table[ingredient_name] = true
                end

            end

            for _, ingredient_name in ipairs(recipe_table.items) do

                if ignore_flag or
                        ingredient_name == base_name or
                        craft_is_circular(current_name, recipe_table) then

                    ignore_flag = true

                elseif unilib.global.stair_deconvert_table[ingredient_name] == nil and
                        unilib.global.carving_deconvert_table[ingredient_name] == nil then

                    match_flag = true
                    break

                end

            end

            if not ignore_flag then

                if match_flag == true then

                    if match_recipe_table == nil or unique_count > match_unique_count then

                        match_recipe_table = recipe_table
                        match_unique_count = unique_count

                    elseif reserve_recipe_table == nil then

                        reserve_recipe_table = recipe_table

                    end

                elseif reserve_recipe_table == nil then

                    reserve_recipe_table = recipe_table

                end

            end

        end

    end

    if match_recipe_table == nil then
        match_recipe_table = reserve_recipe_table
    end

    return match_recipe_table

end

local function add_ingredients(
    pname, excluded_mod_table, excluded_item_table, display_table, base_name, current_name,
    current_multiple, comb_multiple, level, max_level
)
    -- Function called initially by /show_ingredients, then recursively by this function
    --
    -- Args:
    --      pname (str): The player name
    --      excluded_mod_table (table): Table of excluded mods, in the form table[mod_name] = true.
    --          When an item provided by any of these mods is encountered, we don't add any of its
    --          ingredients
    --      excluded_item_table (table): Table of excluded items, in the form
    --          table[item_name] = true. When any of these items are encountered, we don't add any
    --          of their ingredients
    --      display_table (table): Partial table of ingredients for <item>, omitting ingredients
    --          used in all intermediate crafting stages (in the form described below)
    --      base_name (str): The user's specified item (node, craftitem or tool); we try to find
    --          all ingredients used to craft it
    --      current_name (str): The item to test in this function call; initially the same as
    --          "base_name" itself, and then recursively for all of its ingredients
    --      current_multiple (int): How many of "current_name" are required to make its parent item
    --      comb_multiple (int): How many of "current_name" are required to make "base_name"
    --      level (int): The level of recursion (the first level is 1)
    --      max_level (int): The maximum level of recursion
    --
    -- Return values:
    --      A success flag (true if "current_name"'s craft recipe can be used in the output) and the
    --          updated "display_table"

    -- Current recursion level
    level = level + 1

    -- Check that at least one craft recipe exists for "current_name"
    all_craft_list = core.get_all_craft_recipes(current_name)
    if all_craft_list == nil then

        -- No craft recipes found
        return false, display_table

    end

    -- Find a craft recipe which:
    --      1. Is not a cooking/fuel recipe
    --      2. Does not contain the item specified by the user, "base_name"
    --      3. Contains at least one ingredient that isn't a stair/carving (walls are acceptable)
    --      4. Is not a circular craft recipe (e.g. metal ingot > metal block > metal ingot)
    -- If we don't find any suitable recipes, we will reluctantly use the first one which satisfies
    --      conditions 1 and 2
    local recipe_table = find_suitable_recipe(base_name, current_name, all_craft_list)
    if recipe_table == nil then

        -- No suitable craft recipe found
        return false, display_table

    end

    -- Sanity test
    local output_name, output_multiple = unilib.utils.get_item_and_multiple(recipe_table.output)
    if output_name == nil or output_name ~= current_name then

        unilib.utils.chat_send_player(pname, S("Recursion error on @1", current_name))
        return false, display_table

    end

    -- Now add the craft recipe's ingredients to the table, calling this function recursively to
    --       add their ingredients too

    -- Ingredients may appear in the craft recipe once, or multiple times. Compile a table to store
    --      each ingredient and its quantity
    local mini_ingredient_table = {}
    for _, ingredient_name in ipairs(recipe_table.items) do

        if mini_ingredient_table[ingredient_name] == nil then
            mini_ingredient_table[ingredient_name] = 1
        else
            mini_ingredient_table[ingredient_name] = mini_ingredient_table[ingredient_name] + 1
        end

    end

    -- Deal with each ingredient in turn
    for ingredient_name, ingredient_multiple in pairs(mini_ingredient_table) do

        local factor = 1
        local unused = 0
        local success_flag = false
        local adj_ingredient_name = ingredient_name
        local adj_mod_name = nil
        local column = string.rep("  ", (level + 1))

        -- e.g. [9 x unilib:crop_wheat_harvest] crafts [3 x unilib:misc_straw_ordinary]
        -- If the parent craft recipe needs 3 or more straw bales, then we use all of them
        -- Otherwise we don't divide by "output_multiple", and 2 of the straw bales go to waste
        if comb_multiple < output_multiple then

            factor = comb_multiple * ingredient_multiple
            unused = factor - (factor / output_multiple)

        else

            factor = comb_multiple * ingredient_multiple / output_multiple

        end

        -- Display a unilib item (e.g. "unilib:stone_ordinary") if possible, otherwise display the
        --      original mod's name (e.g. "default:stone"
        local unilib_name, orig_name_list = unilib.utils.convert_item(ingredient_name)
        if unilib_name then
            adj_ingredient_name = unilib_name
        elseif orig_name_list[1] ~= nil then
            adj_ingredient_name = orig_name_list[1]
        end

        adj_mod_name = unilib.utils.get_mod_name(adj_ingredient_name)

        -- Display lines in the crafting chain list
        if unused > 1 then

            if factor > ingredient_multiple then

                unilib.utils.chat_send_player(
                    pname,
                    string.format(
                        "%s%s %d (unused: %d) [%d]",
                        column,
                        adj_ingredient_name,
                        factor,
                        unused,
                        ingredient_multiple
                    )
                )

            else

                unilib.utils.chat_send_player(
                    pname,
                    string.format(
                        "%s%s %d (unused: %d)",
                        column,
                        adj_ingredient_name,
                        factor,
                        unused
                    )
                )

            end

        else

            if factor > ingredient_multiple then

                unilib.utils.chat_send_player(
                    pname,
                    string.format(
                        "%s%s %d [%d]",
                        column,
                        adj_ingredient_name,
                        factor,
                        ingredient_multiple
                    )
                )

            else

                unilib.utils.chat_send_player(
                    pname,
                    string.format(
                        "%s%s %d",
                        column,
                        adj_ingredient_name,
                        factor
                    )
                )

            end

        end

        -- craft_is_circular() will catch many circular craft recipes in the form
        --      metal ingot > metal block > metal ingot
        -- But it won't variations on that theme, e.g. copper ingot > copper patina block
        -- For simplicity's sake, don't do recursion on any ingots
        if level < max_level and
                unilib.global.stair_deconvert_table[ingredient_name] == nil and
                unilib.global.carving_deconvert_table[ingredient_name] == nil and
                excluded_mod_table[adj_mod_name] == nil and
                excluded_item_table[ingredient_name] == nil and
                not string.find(ingredient_name, "_ingot") then

            -- Call this function recursively to add ingredients used to craft this
            --      ingredient
            success_flag, display_table = add_ingredients(
                pname,
                excluded_mod_table,
                excluded_item_table,
                display_table,
                base_name,
                ingredient_name,
                comb_multiple * ingredient_multiple,
                factor,
                level,
                max_level
            )

        end

        -- Add stuff to be displayed in the basic ingredients list, after recursion has finished
        if success_flag == false then

            if display_table[ingredient_name] ~= nil then
                display_table[ingredient_name] = display_table[ingredient_name] + factor
            else
                display_table[ingredient_name] = factor
            end

        end

    end

    return true, display_table

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_ingredients.init()

    return {
        description = "Chat command /show_ingredients",
        notes = "Displays full list of ingredients for crafting the specified item",
    }

end

function unilib.pkg.chat_show_ingredients.exec()

    core.register_chatcommand("show_ingredients", {
        params = "<item> [multiple] [list_of_excluded_mods] [list_of_excluded_items]",
        description = S("Displays full list of ingredients for crafting the specified item"),
        privs = {unilib_tools = true},

        func = function(name, param)

            -- Partial table of ingredients for <item>, omitting ingredients used in all
            --      intermediate crafting stages
            -- Table in the form
            --      display_table[full_name] = multiple
            local display_table = {}
            -- Conversion table for everything in display_table, in the form
            --      convert_display_table[unilib_name] = orig_name_list
            local convert_display_table = {}
            -- Recursively update the table, up to a maximum level of recursion
            local level = 0
            local max_level = 8

            -- Parse arguments, eliminating duplicates
            local param_list = unilib.utils.split_string_by_whitespace(param, true)
            local base_name = nil
            local base_multiple = 1
            local excluded_mod_table = {}
            local excluded_item_table = {}

            -- Basic checks
            if param == nil or param == "" then
                return false, S("Show ingredients for which item?")
            end

            -- Parse "param"
            for _, arg in ipairs(param_list) do

                if base_name == nil then

                    -- First argument must be an item name
                    base_name = arg

                elseif tonumber(arg) ~= nil then

                    -- Use the last specified multiple
                    arg = tonumber(arg)
                    if math.floor(arg) == arg and arg > 1 then
                        base_multiple = arg
                    end

                elseif string.find(arg, ":") then

                    excluded_item_table[arg] = true

                else

                    excluded_mod_table[arg] = true

                end

            end

            -- If <item> does not include the mod name is specified, assume unilib
            if unilib.utils.get_mod_name(base_name) == "" then
                base_name = "unilib:" .. base_name
            end

            -- Sanity checks
            if core.registered_nodes[base_name] == nil and
                    core.registered_craftitems[base_name] == nil and
                    core.registered_tools[base_name] == nil then

                return false, S("Item not found (must be a node, craftitem or tool)")

            end

            craft_table = core.get_all_craft_recipes(base_name)
            if craft_table == nil then

                return false, S("No craft recipes found for that item")

            end

            -- Compile the tables of ingredients
            unilib.utils.chat_send_player(
                name, S("Craft recipe chain for @1 > @2", base_name, base_multiple)
            )
            unilib.utils.chat_send_player(name, string.format("  %s %d", base_name, base_multiple))

            success_flag, display_table = add_ingredients(
                name,
                excluded_mod_table,
                excluded_item_table,
                display_table,
                base_name,
                base_name,
                base_multiple,
                base_multiple,
                level,
                max_level
            )

            if not success_flag or unilib.utils.is_table_empty(display_table) then

                unilib.utils.chat_send_player(name, S("Item cannot be crafted easily", base_name))
                unilib.utils.chat_send_player(name, S("End of chain"))

            else

                unilib.utils.chat_send_player(name, S("End of chain"))
                unilib.utils.chat_send_player(
                    name, S("Basic ingredients for \"@1 @2\"", base_name, base_multiple)
                )

                -- The ingredient tables might include unilib items or their original equivalents.
                --      We want to use the unilib item, whenever possible
                for key, value in pairs(display_table) do

                    local unilib_name, orig_name_list = unilib.utils.convert_item(key)

                    if unilib_name then
                        convert_display_table[unilib_name] = value
                    elseif orig_name_list[1] ~= nil then
                        convert_display_table[orig_name_list[1]] = value
                    else
                        -- e.g. "group:wood"
                        convert_display_table[key] = value
                    end

                end

                for _, key in ipairs(unilib.utils.sort_table(convert_display_table)) do

                    -- Surely no craft recipe requires more than 100000 ingredients, right...?
                    unilib.utils.chat_send_player(
                        name, string.format("%6d %s", convert_display_table[key], key)
                    )

                end

                unilib.utils.chat_send_player(name, S("End of chain"))

            end

        end,
    })

end
