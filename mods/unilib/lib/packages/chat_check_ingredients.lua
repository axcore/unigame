---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_check_ingredients = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_check_ingredients.init()

    return {
        description = "Chat command /check_ingredients",
        notes = "Checks whether ingredients provided by external mods are actually available",
    }

end

function unilib.pkg.chat_check_ingredients.exec()

    core.register_chatcommand("check_ingredients", {
        params = "",
        description = S(
            "Checks whether ingredients provided by external mods are actually available, or not"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)

            -- Compile a list of registered nodes, craftitems and tools (from all loaded mods), and
            --      all the groups they provide
            local check_table = {}
            local missing_table = {}
            local found_table = {}
            local count = 0

            for full_name, def_table in pairs(core.registered_nodes) do

                check_table[full_name] = true
                if def_table.groups ~= nil then

                    for group_name, _ in pairs(def_table.groups) do
                        check_table["group:" .. group_name] = true
                    end

                end

            end

            for full_name, def_table in pairs(core.registered_craftitems) do

                check_table[full_name] = true
                if def_table.groups ~= nil then

                    for group_name, _ in pairs(def_table.groups) do
                        check_table["group:" .. group_name] = true
                    end

                end

            end

            for full_name, def_table in pairs(core.registered_tools) do

                check_table[full_name] = true
                if def_table.groups ~= nil then

                    for group_name, _ in pairs(def_table.groups) do
                        check_table["group:" .. group_name] = true
                    end

                end

            end

            -- Now check unilib's external ingredient table
            for full_name, ingredient_list in pairs(unilib.global.external_ingredient_table) do

                local this_list = {}

                for _, ingredient in ipairs(ingredient_list) do

                    if check_table[ingredient] == nil then

                        table.insert(this_list, ingredient)
                        missing_table[ingredient] = true

                    else

                        found_table[ingredient] = true

                    end

                end

                if #this_list > 0 then

                    count = count + 1

                    unilib.utils.chat_send_player(
                        name,
                        S("Missing external ingredients for @1", full_name)
                    )

                    for _, ingredient in ipairs(this_list) do
                        unilib.utils.chat_send_player(name, "   " .. ingredient)
                    end

                end

            end

            unilib.utils.chat_send_player(
                name, S("End of list (items with missing external ingredients found: @1)", count)
            )

            if found_table then

                unilib.utils.chat_send_player(name, S("Summary of available external ingredients"))

                local found_list = unilib.utils.sort_table(found_table)
                for _, ingredient in ipairs(found_list) do
                    unilib.utils.chat_send_player(name, "   " .. ingredient)
                end

                unilib.utils.chat_send_player(
                    name, S("End of list (available external ingredients found: @1)", #found_list)
                )

            end

            if missing_table then

                unilib.utils.chat_send_player(name, S("Summary of missing external ingredients"))

                local missing_list = unilib.utils.sort_table(missing_table)
                for _, ingredient in ipairs(missing_list) do
                    unilib.utils.chat_send_player(name, "   " .. ingredient)
                end

                unilib.utils.chat_send_player(
                    name, S("End of list (missing external ingredients found: @1)", #missing_list)
                )

            end

        end,
    })

end
