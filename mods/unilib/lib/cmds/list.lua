---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- list.lua
--      Set up chat commands for listing registered things
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions (misc)
---------------------------------------------------------------------------------------------------

local function find_match(param, data)

    -- Original to unilib
    -- Looks for param in data, which might be a string or a list. Returns true if a match is found,
    --      false if not
    -- Since this is a local function, we can assume that "data" is a list-table, not a key-value
    --      table

    if type(data) == "string" then

        if param == data then
            return true
        else
            return false
        end

    elseif type(data) == "table" then

        for _, v in ipairs(data) do

            if v == param then
                return true
            end

        end

    end

    return false

end

local function compile_string(data)

    -- Original to unilib
    -- Compiles a string from data, which might be a string or a list
    -- Since this is a local function, we can assume that "data" is a list-table, not a key-value
    --      table

    if type(data) == "string" then

        return data

    elseif type(data) == "table" then

        return table.concat(data, ", ")

    else

        return ""

    end

end

local function convert_param(param)

    -- Original to unilib
    -- Called by chat commands /list_nodes, etc
    -- "param" is the argument to the command, which might begin with a ! character (meaning
    --      "everything that does not match this"), or not
    -- If "param" starts with !, removes it and returns the modified "param" and true
    -- Otherwise returns the original "param" and false

    if string.sub(param, 1, 1) == "!" then
        return true, string.sub(param, 2)
    else
        return false, param
    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (command-specific)
---------------------------------------------------------------------------------------------------

local function do_list_remixes(name, param)

    if unilib.is_table_empty(unilib.remix_list) then

        return false, S("No remixes are loaded")

    else

        minetest.chat_send_player(name, S("Loaded remixes"))

        local count = 0
        for _, remix_name in ipairs(unilib.remix_list) do

            minetest.chat_send_player(name, "   " .. remix_name)
            minetest.chat_send_player(name, "      " .. unilib.remix_dir_table[remix_name])
            count = count + 1

        end

        minetest.chat_send_player(name, S("End of list (remixes loaded: @1)", count))

    end

end

local function do_list_packages(name, param)

    if unilib.is_table_empty(unilib.pkg_loaded_list) then

        return false, S("No packages have been loaded")

    elseif param ~= nil and param ~= "" then

        -- Ignore multiple package names, if specified
        local pkg_list = unilib.split_string_by_whitespace(param)
        local pkg_name = pkg_list[1]

        if pkg_name == nil or pkg_name == "" or unilib.pkg_table[pkg_name] == nil then

            return false, S("Unrecognised package, try /list_packages")

        else

            local mini_table = unilib.pkg_table[pkg_name]

            minetest.chat_send_player(name, S("Metadata for package \"@1\"", pkg_name))

            if mini_table.mod_name and mini_table.mod_name ~= "" then

                minetest.chat_send_player(
                    name, "   " .. S("Source mods") .. ": " .. mini_table.mod_name
                )

            end

            if mini_table.description and mini_table.description ~= "" then

                minetest.chat_send_player(
                    name, "   " .. S("Description") .. ": " .. mini_table.description
                )

            end

            if mini_table.notes and mini_table.notes ~= "" then
                minetest.chat_send_player(name, "   " .. S("Notes") .. ": " .. mini_table.notes)
            end

            if mini_table.first and mini_table.first ~= "" then
                minetest.chat_send_player(name, "   " .. S("Must be executed first: YES"))
            end

            if mini_table.last and mini_table.last ~= "" then
                minetest.chat_send_player(name, "   " .. S("Must be executed last: YES"))
            end

            if mini_table.excludes and mini_table.excludes ~= "" then

                minetest.chat_send_player(
                    name,
                    "   " .. S("Incompatible packages") .. ": " ..
                            unilib.convert_to_string(mini_table.excludes)
                )

           end

            if mini_table.depends and mini_table.depends ~= "" then

                minetest.chat_send_player(
                    name,
                    "   " .. S("Hard dependency (all packages)") .. ": " ..
                            unilib.convert_to_string(mini_table.depends)
                )

            end

            if mini_table.at_least_one and mini_table.at_least_one ~= "" then

                minetest.chat_send_player(
                    name,
                    "   " .. S("Hard dependency (at least one package)") .. ": " ..
                            unilib.convert_to_string(mini_table.at_least_one)
                )

            end

            if mini_table.optional and mini_table.optional ~= "" then

                minetest.chat_send_player(
                    name,
                    "   " .. S("Optional dependency (packages)") .. ": " ..
                            unilib.convert_to_string(mini_table.optional)
                )

            end

            if mini_table.suggested and mini_table.suggested ~= "" then

                minetest.chat_send_player(
                    name,
                    "   " .. S("Suggested dependency (packages)") .. ": " ..
                            unilib.convert_to_string(mini_table.suggested)
                )

            end

            if mini_table.mod_excludes and mini_table.mod_excludes ~= "" then

                minetest.chat_send_player(
                    name,
                    "   " .. S("Incompatible mods") .. ": " ..
                            unilib.convert_to_string(mini_table.mod_excludes)
                )

            end

            if mini_table.mod_depends and mini_table.mod_depends ~= "" then

                minetest.chat_send_player(
                    name,
                    "   " .. S("Hard dependency (all mods)") .. ": " ..
                            unilib.convert_to_string(mini_table.mod_depends)
                )

            end

            if mini_table.mod_at_least_one and mini_table.mod_at_least_one ~= "" then

                minetest.chat_send_player(
                    name,
                    "   " .. S("Hard dependency (at least one mod)") .. ": " ..
                            unilib.convert_to_string(mini_table.mod_at_least_one)
                )

            end

            if mini_table.mod_optional and mini_table.mod_optional ~= "" then

                minetest.chat_send_player(
                    name,
                    "   " .. S("Optional dependency (mods)") .. ": " ..
                            unilib.convert_to_string(mini_table.mod_optional)
                )

            end

            if mini_table.adult_flag and mini_table.adult_flag == true then
                minetest.chat_send_player(name, "   " .. S("Adult content: YES"))
            end

            minetest.chat_send_player(name, S("End of package metadata"))

        end

    else

        minetest.chat_send_player(
            name,
            S("Loaded packages (I = initialised, E = executed, X = excluded) [original mods]")
        )

        local count = 0
        for _, pkg_name in ipairs(unilib.pkg_loaded_list) do

            local column = " "
            if unilib.pkg_table[pkg_name] ~= nil then
                column = column .. "I"
            else
                column = column .. " "
            end

            if unilib.pkg_executed_table[pkg_name] ~= nil then
                column = column .. "E"
            else
                column = column .. " "
            end

            if unilib.pkg_excluded_table[pkg_name] ~= nil then
                column = column .. "X"
            else
                column = column .. " "
            end

            -- The remix specifies the original mod(s) for each package. If a hard/soft dependency
            --      doesn't appear in any loaded remix, it is force-loaded, meaning that its
            --      original mod(s) are not available
            if unilib.pkg_loaded_table[pkg_name] == nil or
                    unilib.pkg_loaded_table[pkg_name] == "" then

                minetest.chat_send_player(
                    name, column .. " " .. pkg_name .. " <" .. S("unavailable") .. ">"
                )

            else

                minetest.chat_send_player(
                    name,
                    column .. " " .. pkg_name .. " [" .. unilib.pkg_loaded_table[pkg_name] .. "]"
                )

            end

            count = count + 1

        end

        minetest.chat_send_player(name, S("End of list (packages loaded: @1)", count))

    end

end

local function do_list_other_packages(name, param)

    if unilib.is_table_empty(unilib.pkg_loaded_list) then

        return false, S("No packages have been loaded")

    else

        local count = 0
        local other_table = {}

        for pkg_name, mini_table in pairs(unilib.pkg_table) do

            for _, other_pkg_name in ipairs(unilib.convert_to_list(mini_table.depends)) do

                if unilib.pkg_loaded_table[other_pkg_name] == nil then

                    local msg = S("Hard dependency (all packages) of") .. ": " .. pkg_name
                    if other_table[other_pkg_name] == nil then
                        other_table[other_pkg_name] = {msg}
                    else
                        table.insert(other_table[other_pkg_name], msg)
                    end

                end

            end

            for _, other_pkg_name in ipairs(unilib.convert_to_list(mini_table.at_least_one)) do

                if unilib.pkg_loaded_table[other_pkg_name] == nil then

                    local msg = S("Hard dependency (at least one package) of") .. ": " .. pkg_name
                    if other_table[other_pkg_name] == nil then
                        other_table[other_pkg_name] = {msg}
                    else
                        table.insert(other_table[other_pkg_name], msg)
                    end

                end

            end

            for _, other_pkg_name in ipairs(unilib.convert_to_list(mini_table.optional)) do

                if unilib.pkg_loaded_table[other_pkg_name] == nil then

                    local msg = S("Optional dependency of") .. ": " .. pkg_name
                    if other_table[other_pkg_name] == nil then
                        other_table[other_pkg_name] = {msg}
                    else
                        table.insert(other_table[other_pkg_name], msg)
                    end

                end

            end

            for _, other_pkg_name in ipairs(unilib.convert_to_list(mini_table.suggested)) do

                if unilib.pkg_loaded_table[other_pkg_name] == nil then

                    local msg = S("Suggested dependency of") .. ": " .. pkg_name
                    if other_table[other_pkg_name] == nil then
                        other_table[other_pkg_name] = {msg}
                    else
                        table.insert(other_table[other_pkg_name], msg)
                    end

                end

            end

        end

        if unilib.is_table_empty(other_table) then

            minetest.chat_send_player(name, S("All package dependencies have been loaded"))

        else

            minetest.chat_send_player(
                name, S("List of dependent packages which have not been loaded")
            )

            local pkg_list = unilib.sort_table(other_table)
            for _, pkg_name in ipairs(pkg_list) do

                local mini_list = other_table[pkg_name]
                minetest.chat_send_player(name, "   " .. pkg_name)
                for _, msg in ipairs(mini_list) do
                    minetest.chat_send_player(name, "      " .. msg)
                end

                count = count + 1

            end

            minetest.chat_send_player(name, S("End of list (unloaded packages list: @1)", count))

        end

    end

end

local function do_list_abm(name, param)

    local description_list = {}
    local count = 0

    local not_flag, param = convert_param(param)

    for _, abm_table in ipairs(minetest.registered_abms) do

        if param == "" or
                (not not_flag and param == abm_table.mod_origin) or
                (not_flag and param ~= abm_table.mod_origin) then

            if abm_table.label == nil then
                table.insert(description_list, abm_table.mod_origin .. " - " .. S("No label"))
            else
                table.insert(description_list, abm_table.mod_origin .. " - " .. abm_table.label)
            end

            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No ABMs are registered")
        elseif not_flag then
            return false, S("No ABMs are registered for mods other than the  \"@1\" mod", param)
        else
            return false, S("No ABMs are registered for the \"@1\" mod", param)
        end

    else

        if param == "" then

            minetest.chat_send_player(name, S("Registered ABMs"))

        elseif not_flag then

            minetest.chat_send_player(
                name, S("Registered ABMs for mods other than the \"@1\" mod", param)
            )

        else

            minetest.chat_send_player(name, S("Registered ABMs for the \"@1\" mod", param))

        end

        table.sort(description_list)
        for _, description in ipairs(description_list) do
            minetest.chat_send_player(name, "   " .. description)
        end

        minetest.chat_send_player(name, S("End of list (ABMs found: @1)", count))

    end

end

local function do_list_biomes(name, param)

    local biome_list = {}
    local count = 0

    for k, _ in pairs(minetest.registered_biomes) do

        -- (The LUA sorting mechanism fails, if it is asked to compare strings and numbers)
        table.insert(biome_list, tostring(k))
        count = count + 1

    end

    if count == 0 then

        return false, S("No biomes are registered")

    else

        minetest.chat_send_player(name, S("Registered biomes"))

        table.sort(biome_list)
        for _, biome_name in ipairs(biome_list) do
            minetest.chat_send_player(name, "   " .. biome_name)
        end

        minetest.chat_send_player(name, S("End of list (biomes found: @1)", count))

    end

end

local function do_list_craftitems(name, param)

    local craftitem_list = {}
    local count = 0

    local not_flag, param = convert_param(param)

    for k, _ in pairs(minetest.registered_craftitems) do

        if param == "" or
                (not not_flag and string.find(k, ":") and param == string.split(k, ":")[1]) or
                (not_flag and string.find(k, ":") and param ~= string.split(k, ":")[1]) then

            table.insert(craftitem_list, tostring(k))
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then

            return false, S("No craftitems are registered")

        elseif not_flag then

            return false, S(
                "No craftitems are registered for mods other than the  \"@1\" mod", param
            )

        else

            return false, S("No craftitems are registered for the \"@1\" mod", param)

        end

    else

        if param == "" then

            minetest.chat_send_player(name, S("Registered craftitems (* = hidden)"))

        elseif not_flag then

            minetest.chat_send_player(
                name,
                S(
                    "Registered craftitems for mods other than the \"@1\" mod (* = hidden)",
                    param
                )
            )

        else

            minetest.chat_send_player(
                name, S("Registered craftitems for the \"@1\" mod (* = hidden)", param)
            )

        end

        table.sort(craftitem_list)
        for _, full_name in ipairs(craftitem_list) do

            if unilib.hidden_item_table[full_name] ~= nil then
                minetest.chat_send_player(name, " * " .. full_name)
            else
                minetest.chat_send_player(name, "   " .. full_name)
            end

        end

        minetest.chat_send_player(name, S("End of list (craftitems found: @1)", count))

    end

end

local function do_list_decorations(name, param)

    local deco_list = {}
    local count = 0

    local not_flag, param = convert_param(param)

    for k, _ in pairs(minetest.registered_decorations) do

        if param == "" or
            (not not_flag and string.find(k, ":") and param == string.split(k, ":")[1]) or
            (not_flag and string.find(k, ":") and param ~= string.split(k, ":")[1]) then

            table.insert(deco_list, tostring(k))
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then

            return false, S("No decorations are registered")

        elseif not_flag then

            minetest.chat_send_player(
                name,
                S("No decorations are registered for mods other than the  \"@1\" mod", param)
            )

        else

            return false, S("No decorations are registered for the \"@1\" mod", param)

        end

    else

        if param == "" then

            minetest.chat_send_player(name, S("Registered decorations"))

        elseif not_flag then

            minetest.chat_send_player(
                name, S("Registered decorations for mods other than the \"@1\" mod", param)
            )

        else

            minetest.chat_send_player(name, S("Registered decorations for the \"@1\" mod", param))

        end

        table.sort(deco_list)
        for _, full_name in ipairs(deco_list) do
            minetest.chat_send_player(name, "   " .. full_name)
        end

        minetest.chat_send_player(name, S("End of list (decorations found: @1)", count))

    end

end

local function do_list_entities(name, param)

    local entity_list = {}
    local count = 0

    local not_flag, param = convert_param(param)

    for k, _ in pairs(minetest.registered_entities) do

        if param == "" or
                (not not_flag and string.find(k, ":") and param == string.split(k, ":")[1]) or
                (not_flag and string.find(k, ":") and param ~= string.split(k, ":")[1]) then

            table.insert(entity_list, tostring(k))
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No entities are registered")
        elseif not_flag then
            return false, S("No entities are registered for mods other than the  \"@1\" mod", param)
        else
            return false, S("No entities are registered for the \"@1\" mod", param)
        end

    else

        if param == "" then

            minetest.chat_send_player(name, S("Registered entities"))

        elseif not_flag then

            minetest.chat_send_player(
                name, S("Registered entities for mods other than the \"@1\" mod", param)
            )

        else

            minetest.chat_send_player(name, S("Registered entities for the \"@1\" mod", param))

        end

        table.sort(entity_list)
        for _, full_name in ipairs(entity_list) do
            minetest.chat_send_player(name, "   " .. full_name)
        end

        minetest.chat_send_player(name, S("End of list (entities found: @1)", count))

    end

end

local function do_list_lbms(name, param)

    local output_list = {}
    local count = 0

    local not_flag, param = convert_param(param)

    for _, lbm_table in ipairs(minetest.registered_lbms) do

        if param == "" or
            (not not_flag and param == lbm_table.mod_origin) or
            (not_flag and param ~= lbm_table.mod_origin) then

            local mini_list = {lbm_table.mod_origin}

            if lbm_table.label == nil or lbm_table.label == "" then
                table.insert(mini_list, S("No label"))
            else
                table.insert(mini_list, lbm_table.label)
            end

            if lbm_table.name == nil or lbm_table.name == "" then
                table.insert(mini_list, S("No name"))
            else
                table.insert(mini_list, lbm_table.name)
            end

            table.insert(output_list, mini_list)
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No LBMs are registered")
        elseif not_flag then
            return false, S("No LBMs are registered for mods other than the  \"@1\" mod", param)
        else
            return false, S("No LBMs are registered for the \"@1\" mod", param)
        end

    else

        if param == "" then


            minetest.chat_send_player(name, S("Registered LBMs"))

        elseif not_flag then

            minetest.chat_send_player(
                name, S("Registered LBMs for mods other than the \"@1\" mod", param)
            )

        else

            minetest.chat_send_player(name, S("Registered LBMs for the \"@1\" mod", param))

        end

        for _, mini_list in ipairs(output_list) do

            minetest.chat_send_player(name, "   " .. mini_list[1])
            minetest.chat_send_player(name, "      " .. mini_list[2])
            minetest.chat_send_player(name, "      " .. mini_list[3])

        end

        minetest.chat_send_player(name, S("End of list (LBMs found: @1)", count))

    end

end

local function do_list_nodes(name, param)

    local node_list = {}
    local count = 0

    local not_flag, param = convert_param(param)

    for k, _ in pairs(minetest.registered_nodes) do

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

            minetest.chat_send_player(name, S("Registered nodes (* = hidden)"))

        elseif not_flag then

            minetest.chat_send_player(
                name,
                S("Registered nodes for mods other than the \"@1\" mod (* = hidden)", param)
            )

        else

            minetest.chat_send_player(
                name, S("Registered nodes for the \"@1\" mod (* = hidden)", param)
            )

        end

        table.sort(node_list)
        for _, full_name in ipairs(node_list) do

            if unilib.hidden_item_table[full_name] ~= nil then
                minetest.chat_send_player(name, " * " .. full_name)
            else
                minetest.chat_send_player(name, "   " .. full_name)
            end

        end

        minetest.chat_send_player(name, S("End of list (nodes found: @1)", count))

    end

end

local function do_list_ores(name, param)

    local description_list = {}
    local count = 0
    local param_num = tonumber(param)

    for k, ore_table in pairs(minetest.registered_ores) do

        local mod_name = string.split(ore_table.ore, ":")[1]

        if param == "" or
                param == ore_table.ore_type or
                param == mod_name or
                param == ore_table.ore or
                find_match(param, ore_table.wherein) or
                find_match(param, ore_table.biomes) or
                (
                    type(param_num) == "number" and param_num <= ore_table.y_max and
                    param_num >= ore_table.y_min
                ) then

            table.insert(
                description_list,
                mod_name .. " - [" .. ore_table.ore_type .. "] " .. ore_table.ore ..
                        "\n      In: " .. compile_string(ore_table.wherein) ..
                        "\n      Biomes: " .. compile_string(ore_table.biomes) ..
                        "\n      Pos: max " .. tostring(ore_table.y_max) .. " min " ..
                        tostring(ore_table.y_min)
            )

            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No ores are registered")
        else
            return false, S("No ores matching \"@1\"", param)
        end

    else

        if param == "" then
            minetest.chat_send_player(name, S("Registered ores"))
        else
            minetest.chat_send_player(name, S("Registered ores matching \"@1\"", param))
        end

        table.sort(description_list)
        for _, description in ipairs(description_list) do
            minetest.chat_send_player(name, "   " .. description)
        end

        minetest.chat_send_player(name, S("End of list (ores found: @1)", count))

    end

end

local function do_list_tools(name, param)

    local tool_list = {}
    local count = 0

    local not_flag, param = convert_param(param)

    for k, _ in pairs(minetest.registered_tools) do

        if param == "" or
                (not not_flag and string.find(k, ":") and param == string.split(k, ":")[1]) or
                (not_flag and string.find(k, ":") and param ~= string.split(k, ":")[1]) then

            table.insert(tool_list, tostring(k))
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No tools are registered")
        elseif not_flag then
            return false, S("No tools are registered for mods other than the  \"@1\" mod", param)
        else
            return false, S("No tools are registered for the \"@1\" mod", param)
        end

    else

        if param == "" then

            minetest.chat_send_player(name, S("Registered tools (* = hidden)"))

        elseif not_flag then

            minetest.chat_send_player(
                name,
                S("Registered tools for mods other than the \"@1\" mod (* = hidden)", param)
            )

        else

            minetest.chat_send_player(
                name, S("Registered tools for the \"@1\" mod (* = hidden)", param)
            )

        end

        table.sort(tool_list)
        for _, full_name in ipairs(tool_list) do

            if unilib.hidden_item_table[full_name] ~= nil then
                minetest.chat_send_player(name, " * " .. full_name)
            else
                minetest.chat_send_player(name, "   " .. full_name)
            end

        end

        minetest.chat_send_player(name, S("End of list (tools found: @1)", count))

    end

end

local function do_list_stones(name, param)

    if unilib.is_table_empty(unilib.stone_table) then

        return false, S("No stone types have been registered")

    elseif param ~= nil and param ~= "" then

        -- Ignore multiple stone types, if specified
        local stone_list = unilib.split_string_by_whitespace(param)
        local stone_type = stone_list[1]

        if stone_type == nil or stone_type == "" or unilib.stone_table[stone_type] == nil then

            return false, S("Unrecognised stone type, try /list_stones")

        else

            local mini_table = unilib.stone_table[stone_type]

            minetest.chat_send_player(name, S("Information for stone type \"@1\"", stone_type))

            if mini_table.description and mini_table.description ~= "" then

                minetest.chat_send_player(
                    name, "   " .. S("Description") .. ": " .. mini_table.description
                )

            end

            if mini_table.category and mini_table.category ~= "" then

                minetest.chat_send_player(
                    name, "   " .. S("Category") .. ": " .. mini_table.category
                )

            end

            if mini_table.super_flag and mini_table.super_flag == true then
                minetest.chat_send_player(name, "   " .. S("Super stone: YES"))
            end

            if mini_table.fictional_flag and mini_table.fictional_flag == true then
                minetest.chat_send_player(name, "   " .. S("Fictional: YES"))
            end

            if mini_table.grinder_flag and mini_table.grinder_flag == true then
                minetest.chat_send_player(name, "   " .. S("Technic grinder recipe: YES"))
            end

            if mini_table.hardness and mini_table.hardness ~= "" then

                minetest.chat_send_player(
                    name, "   " .. S("Hardness (in-game)") .. ": " .. mini_table.hardness
                )

            end

            if mini_table.hardness_real and mini_table.hardness_real ~= "" then

                minetest.chat_send_player(
                    name, "   " .. S("Hardness (real)") .. ": " .. mini_table.hardness_real
                )

            end

            if mini_table.moss_flag and mini_table.moss_flag == true then
                minetest.chat_send_player(name, "   " .. S("Moss growth: YES"))
            end

            if mini_table.no_smooth_flag and mini_table.no_smooth_flag == true then
                minetest.chat_send_player(name, "   " .. S("No smooth stone variant: YES"))
            end

            if mini_table.platform_list and mini_table.platform_list ~= "" then

                minetest.chat_send_player(name,
                    "   " .. S("Train platforms") .. ": " ..
                            unilib.convert_to_string(mini_table.platform_list)
                )

            end

            minetest.chat_send_player(name, S("End of stone type information"))

        end

    else

        local stone_list = {}
        for k, _ in pairs(unilib.stone_table) do
            table.insert(stone_list, k)
        end

        table.sort(stone_list)

        minetest.chat_send_player(
            name,
            S(
                "List of stone types (* = super stone, F = fictional, G = grinder recipe," ..
                        " 1-5 = hardness)"
            )
        )

        minetest.chat_send_player(
            name,
            S(
                "<S = smoothstone, B = block, b = brick, C = cobble, M = mossy cobble," ..
                        " R = rubble, p = compressed, d = condensed>"
            )
        )

        for _, stone_type in ipairs(stone_list) do

            local mini_table = unilib.stone_table[stone_type]

            local column = " "
            if mini_table.super_flag and mini_table.super_flag == true then
                column = column .. "*"
            else
                column = column .. " "
            end

            if mini_table.fictional_flag and mini_table.fictional_flag == true then
                column = column .. "F"
            else
                column = column .. " "
            end

            if mini_table.grinder_flag and mini_table.grinder_flag == true then
                column = column .. "G"
            else
                column = column .. " "
            end

            if mini_table.hardness and mini_table.hardness ~= "" then
                column = column .. tostring(mini_table.hardness)
            else
                column = column .. " "
            end

            local postscript = ""
            local full_name = "unilib:stone_" .. stone_type

            if minetest.registered_nodes[full_name] ~= nil then
                postscript = postscript .. "S"
            end

            if minetest.registered_nodes[full_name .. "_block"] ~= nil then
                postscript = postscript .. "B"
            end

            if minetest.registered_nodes[full_name .. "_brick"] ~= nil then
                postscript = postscript .. "b"
            end

            if minetest.registered_nodes[full_name .. "_cobble"] ~= nil then
                postscript = postscript .. "C"
            end

            if minetest.registered_nodes[full_name .. "_cobble_mossy"] ~= nil then
                postscript = postscript .. "M"
            end

            if minetest.registered_nodes[full_name .. "_rubble"] ~= nil then
                postscript = postscript .. "R"
            end

            if minetest.registered_nodes[full_name .. "_cobble_compressed"] ~= nil then
                postscript = postscript .. "p"
            end

            if minetest.registered_nodes[full_name .. "_cobble_condensed"] ~= nil then
                postscript = postscript .. "d"
            end

            if postscript ~= "" then
                postscript = " <" .. postscript .. ">"
            end

            minetest.chat_send_player(
                name,
                column .. " " .. stone_type .. " [" .. mini_table.category .. "]" .. postscript
            )

        end

        minetest.chat_send_player(name, S("End of list (stone types found: @1)", #stone_list))

    end

end

local function do_list_trees(name, param)

    if unilib.is_table_empty(unilib.tree_table) then

        return false, S("No tree types have been registered")

    elseif param ~= nil and param ~= "" then

        -- Ignore multiple tree types, if specified
        local tree_list = unilib.split_string_by_whitespace(param)
        local tree_type = tree_list[1]

        if tree_type == nil or tree_type == "" or unilib.tree_table[tree_type] == nil then

            return false, S("Unrecognised tree type, try /list_trees")

        else

            minetest.chat_send_player(name, S("Information for tree type \"@1\"", tree_type))

            local base_name = "unilib:tree_" .. tree_type

            if unilib.super_tree_table[tree_type] ~= nil then
                minetest.chat_send_player(name, "   " .. S("Super tree: YES"))
            else
                minetest.chat_send_player(name, "   " .. S("Super tree: NO"))
            end

            if minetest.registered_nodes[base_name .. "_trunk"] ~= nil then
                minetest.chat_send_player(name, "   " .. S("Trunk node: YES"))
            else
                minetest.chat_send_player(name, "   " .. S("Trunk node: NO"))
            end

            if minetest.registered_nodes[base_name .. "_wood"] ~= nil then
                minetest.chat_send_player(name, "   " .. S("Wood node: YES"))
            else
                minetest.chat_send_player(name, "   " .. S("Wood node: NO"))
            end

            if minetest.registered_nodes[base_name .. "_leaves"] ~= nil then
                minetest.chat_send_player(name, "   " .. S("Leaves node: YES"))
            else
                minetest.chat_send_player(name, "   " .. S("Leaves node: NO"))
            end

            if minetest.registered_nodes[base_name .. "_sapling"] ~= nil then
                minetest.chat_send_player(name, "   " .. S("Sapling: YES"))
            else
                minetest.chat_send_player(name, "   " .. S("Sapling: NO"))
            end

            if minetest.registered_nodes[base_name .. "_wood_fence"] ~= nil then
                minetest.chat_send_player(name, "   " .. S("Fence: YES"))
            else
                minetest.chat_send_player(name, "   " .. S("Fence: NO"))
            end

            if minetest.registered_nodes[base_name .. "_wood_fence_rail"] ~= nil then
                minetest.chat_send_player(name, "   " .. S("Fence rail: YES"))
            else
                minetest.chat_send_player(name, "   " .. S("Fence rail: NO"))
            end

            if minetest.registered_nodes["unilib:gate_" .. tree_type .. "_closed"] ~= nil then
                minetest.chat_send_player(name, "   " .. S("Fence gate: YES"))
            else
                minetest.chat_send_player(name, "   " .. S("Fence gate: NO"))
            end

            minetest.chat_send_player(name, S("End of tree type information"))

        end

    else

        local tree_list = {}
        for k, _ in pairs(unilib.tree_table) do
            table.insert(tree_list, k)
        end

        table.sort(tree_list)

        minetest.chat_send_player(name, S("List of tree types (* = super tree)"))
        minetest.chat_send_player(
            name,
            S(
                "<T = trunk, s = stripped trunk, W = wood, L = leaves, S = sapling, P = panel," ..
                        " F = fence, R = rail, G = gate>"
            )
        )

        for _, tree_type in ipairs(tree_list) do

            local postscript = ""
            local base_name = "unilib:tree_" .. tree_type

            if minetest.registered_nodes[base_name .. "_trunk"] ~= nil then
                postscript = postscript .. "T"
            end

            if minetest.registered_nodes[base_name .. "_trunk_stripped"] ~= nil then
                postscript = postscript .. "s"
            end

            if minetest.registered_nodes[base_name .. "_wood"] ~= nil then
                postscript = postscript .. "W"
            end

            if minetest.registered_nodes[base_name .. "_leaves"] ~= nil then
                postscript = postscript .. "L"
            end

            if minetest.registered_nodes[base_name .. "_sapling"] ~= nil then
                postscript = postscript .. "S"
            end

            if minetest.registered_nodes[base_name .. "_panel"] ~= nil then
                postscript = postscript .. "P"
            end

            if minetest.registered_nodes[base_name .. "_wood_fence"] ~= nil then
                postscript = postscript .. "F"
            end

            if minetest.registered_nodes[base_name .. "_wood_fence_rail"] ~= nil then
                postscript = postscript .. "R"
            end

            if minetest.registered_nodes["unilib:gate_" .. tree_type .. "_closed"] ~= nil then
                postscript = postscript .. "G"
            end

            if postscript ~= "" then
                postscript = " <" .. postscript .. ">"
            end

            if unilib.super_tree_table[tree_type] == nil then
                minetest.chat_send_player(name, "   " .. tree_type .. postscript)
            else
                minetest.chat_send_player(name, " * " .. tree_type .. postscript)
            end

        end

        minetest.chat_send_player(name, S("End of list (tree types found: @1)", #tree_list))

    end

end

local function do_list_buckets(name, param)

    if unilib.is_table_empty(unilib.generic_bucket_table) then

        return false, S("No bucket types have been loaded")

    elseif param ~= nil and param ~= "" then

        -- Ignore multiple bucket types, if specified
        local bucket_list = unilib.split_string_by_whitespace(param)
        local bucket_type = bucket_list[1]

        if bucket_type == nil or
                bucket_type == "" or
                unilib.generic_bucket_table[bucket_type] == nil then

            return false, S("Unrecognised bucket type, try /list_buckets")

        else

            local craftitem_list = {}

            local empty_name = "unilib:" .. bucket_type .. "_empty"
            if minetest.registered_craftitems[empty_name] ~= nil then
                table.insert(craftitem_list, empty_name)
            end

            for liquid_type, _ in pairs(unilib.generic_liquid_table) do

                local filled_name = "unilib:" .. bucket_type .. "_with_" .. liquid_type
                if minetest.registered_craftitems[filled_name] ~= nil then
                    table.insert(craftitem_list, filled_name)
                end

            end

            if #craftitem_list == 0 then

                return false, S("No buckets found for this bucket type")

            else

                table.sort(craftitem_list)

                minetest.chat_send_player(name, S("Bucket type \"@1\"", bucket_type))

                for _, full_name in ipairs(craftitem_list) do
                    minetest.chat_send_player(name, "   " .. full_name)
                end

                minetest.chat_send_player(
                    name, S("End of list (buckets found: @1)", #craftitem_list)
                )

            end

        end

    else

        local bucket_list = {}
        for k, _ in pairs(unilib.generic_bucket_table) do
            table.insert(bucket_list, k)
        end

        table.sort(bucket_list)

        minetest.chat_send_player(name, S("List of bucket types"))
        for _, bucket_type in ipairs(bucket_list) do

            local mini_table = unilib.generic_bucket_table[bucket_type]
            minetest.chat_send_player(
                name, "   " .. bucket_type .. " [" .. mini_table.description .. "]"
            )

        end

        minetest.chat_send_player(name, S("End of list (bucket types found: @1)", #bucket_list))

    end

end

local function do_list_liquids(name, param)

    if unilib.is_table_empty(unilib.generic_liquid_table) then

        return false, S("No liquid types have been registered")

    elseif param ~= nil and param ~= "" then

        -- Ignore multiple liquid types, if specified
        local liquid_list = unilib.split_string_by_whitespace(param)
        local liquid_type = liquid_list[1]

        if liquid_type == nil or
                liquid_type == "" or
                unilib.generic_liquid_table[liquid_type] == nil then

            return false, S("Unrecognised liquid type, try /list_liquids")

        else

            local mini_table = unilib.generic_liquid_table[liquid_type]

            minetest.chat_send_player(name, S("Information for liquid type \"@1\"", liquid_type))

            if mini_table.description and mini_table.description ~= "" then

                minetest.chat_send_player(
                    name, "   " .. S("Description") .. ": " .. mini_table.description
                )

           end

            if mini_table.source_name and mini_table.source_name ~= "" then

                minetest.chat_send_player(
                    name, "   " .. S("Source node") .. ": " .. mini_table.source_name
                )

            end

            if mini_table.flowing_name and mini_table.flowing_name ~= "" then

                minetest.chat_send_player(
                    name, "   " .. S("Flowing node") .. ": " .. mini_table.flowing_name
                )

            end

            if mini_table.burntime and mini_table.burntime ~= "" then

                minetest.chat_send_player(
                    name, "   " .. S("Burntime") .. ": " .. mini_table.burntime
                )

            end

            if mini_table.force_renew_flag and mini_table.force_renew_flag == true then
                minetest.chat_send_player(name, "   " .. S("Force renew: YES"))
            end

            if mini_table.potable_flag and mini_table.potable_flag == true then
                minetest.chat_send_player(name, "   " .. S("Potable: YES"))
            end

            if mini_table.water_flag and mini_table.water_flag == true then
                minetest.chat_send_player(name, "   " .. S("Water: YES"))
            end

            minetest.chat_send_player(name, S("End of liquid type information"))

        end

    else

        local liquid_list = {}
        for k, _ in pairs(unilib.generic_liquid_table) do
            table.insert(liquid_list, k)
        end

        table.sort(liquid_list)

        minetest.chat_send_player(
            name, S("List of liquid types (F = force renew, P = potable, W = water)")
        )

        for _, liquid_type in ipairs(liquid_list) do

            local mini_table = unilib.generic_liquid_table[liquid_type]

            local column = " "
            if mini_table.force_renew_flag and mini_table.force_renew_flag == true then
                column = column .. "F"
            else
                column = column .. " "
            end

            if mini_table.potable_flag and mini_table.potable_flag == true then
                column = column .. "P"
            else
                column = column .. " "
            end

            if mini_table.water_flag and mini_table.water_flag == true then
                column = column .. "W"
            else
                column = column .. " "
            end

            minetest.chat_send_player(
                name, column .. " " .. liquid_type .. " [" .. mini_table.description .. "]"
            )

        end

        minetest.chat_send_player(name, S("End of list (liquid types found: @1)", #liquid_list))

    end

end

local function do_list_metals(name, param)

    if unilib.is_table_empty(unilib.metal_table) then

        return false, S("No metal types are registered")

    else

        local metal_list = {}
        for k, _ in pairs(unilib.metal_table) do
            table.insert(metal_list, k)
        end

        table.sort(metal_list)

        minetest.chat_send_player(
            name,
            S(
                "List of registered metal types (A = alloy, F = fictional, P = powder," ..
                        "1-5 = hardness)"
            )
        )

        for _, part_name in ipairs(metal_list) do

            local column = " "
            local data_table = unilib.metal_table[part_name]

            if data_table.alloy_flag then
                column = column .. "A"
            else
                column = column .. " "
            end

            if data_table.fictional_flag then
                column = column .. "F"
            else
                column = column .. " "
            end

            if data_table.powder_flag then
                column = column .. "P"
            else
                column = column .. " "
            end

            column = column .. " " .. tostring(data_table.hardness) .. " "

            minetest.chat_send_player(name, column .. part_name)

        end

        minetest.chat_send_player(name, S("End of list (metal types found: @1)", #metal_list))

    end

end

local function do_list_metal_sources(name, param)

    local source_table = {}
    local no_source_list = {}

    for k, _ in pairs(unilib.metal_table) do
        source_table[k] = {}
    end

    for k, _ in pairs(unilib.mineral_table) do

        for _, v in ipairs(unilib.mineral_table[k]["metal_list"]) do

            if source_table[v] == nil then
                source_table[v] = {k}
            else
                table.insert(source_table[v], k)
            end

        end

    end

    if unilib.is_table_empty(source_table) then

        return false, S("No metal sources are registered")

    else

        local source_list = {}
        for k, _ in pairs(source_table) do
            table.insert(source_list, k)
        end

        minetest.chat_send_player(name, S("List of registered metal sources"))

        table.sort(source_list)
        for _, metal_name in ipairs(source_list) do

            local mineral_list = source_table[metal_name]

            minetest.chat_send_player(name, "   " .. metal_name)
            if not next(mineral_list) then

                minetest.chat_send_player(name, "      (no sources)")
                table.insert(no_source_list, metal_name)

            else

                minetest.chat_send_player(name, "      " .. table.concat(mineral_list, ", "))

            end

        end

        minetest.chat_send_player(name, S("End of list (metal sources found: @1)", #source_list))

        if next(no_source_list) then

            minetest.chat_send_player(name, S("List of metals with no sources (* = alloy)"))

            table.sort(no_source_list)
            for _, metal_name in ipairs(no_source_list) do

                local data_table = unilib.metal_table[metal_name]
                if data_table == nil or data_table.alloy_flag ~= true then
                    minetest.chat_send_player(name, "   " .. metal_name)
                else
                    minetest.chat_send_player(name, " * " .. metal_name)
                end

            end

            minetest.chat_send_player(
                name, S("End of list (unsourced metals found: @1)", #no_source_list)
            )

        end

    end

end

local function do_list_nonmetals(name, param)

    if unilib.is_table_empty(unilib.non_metal_table) then

        return false, S("No elemental non-metal types are registered")

    else

        local non_metal_list = {}
        for k, _ in pairs(unilib.non_metal_table) do
            table.insert(non_metal_list, k)
        end

        minetest.chat_send_player(name, S("List of registered elemental types"))

        table.sort(non_metal_list)
        for _, part_name in ipairs(non_metal_list) do
            minetest.chat_send_player(name, "   " .. part_name)
        end

        minetest.chat_send_player(
            name, S("End of list (elemental non-metal types found: @1)", #non_metal_list)
        )

    end

end

local function do_list_nonmetal_sources(name, param)

    local source_table = {}
    local no_source_list = {}

    for k, _ in pairs(unilib.non_metal_table) do
        source_table[k] = {}
    end

    for k, _ in pairs(unilib.mineral_table) do

        for _, v in ipairs(unilib.mineral_table[k]["non_metal_list"]) do

            if source_table[v] == nil then
                source_table[v] = {k}
            else
                table.insert(source_table[v], k)
            end

        end

    end

    if unilib.is_table_empty(source_table) then

        return false, S("No elemental non-metal sources are registered")

    else

        local source_list = {}
        for k, _ in pairs(source_table) do
            table.insert(source_list, k)
        end

        minetest.chat_send_player(name, S("List of registered elemental non-metal sources"))

        table.sort(source_list)
        for _, non_metal_name in ipairs(source_list) do

            local mineral_list = source_table[non_metal_name]

            minetest.chat_send_player(name, "   " .. non_metal_name)
            if not next(mineral_list) then

                minetest.chat_send_player(name, "      (no sources)")
                table.insert(no_source_list, non_metal_name)

            else

                minetest.chat_send_player(name, "      " .. table.concat(mineral_list, ", "))

            end

        end

        minetest.chat_send_player(
            name, S("End of list (elemental non-metal sources found: @1)", #source_list)
        )

        if next(no_source_list) then

            minetest.chat_send_player(name, S("Non-metals with no sources:"))

            table.sort(no_source_list)
            for _, non_metal_name in ipairs(no_source_list) do
                minetest.chat_send_player(name, "   " .. non_metal_name)
            end

            minetest.chat_send_player(
                name,
                S("End of list (unsourced elemental non-metals found: @1)", #no_source_list)
            )

        end

    end

end

local function do_list_minerals(name, param)

    if unilib.is_table_empty(unilib.mineral_table) then

        return false, S("No mineral types are registered")

    else

        local mineral_list = {}
        for k, _ in pairs(unilib.mineral_table) do
            table.insert(mineral_list, k)
        end

        minetest.chat_send_player(
            name,
            S(
                "List of registered mineral types: (F = fictional, G = gem, P = powder," ..
                        " 1-5 = hardness)"
            )
        )

        table.sort(mineral_list)
        for _, part_name in ipairs(mineral_list) do

            local column = " "
            local data_table = unilib.mineral_table[part_name]

            if data_table.fictional_flag then
                column = column .. "F"
            else
                column = column .. " "
            end

            if data_table.gem_flag then
                column = column .. "G"
            else
                column = column .. " "
            end

            if data_table.powder_flag then
                column = column .. "P"
            else
                column = column .. " "
            end

            column = column .. " " .. tostring(data_table.hardness) .. " "

            minetest.chat_send_player(name, column .. part_name)

        end

        minetest.chat_send_player(name, S("End of list (mineral types found: @1)", #mineral_list))

    end

end

local function do_list_mineral_products(name, param)

    local product_table = {}
    local missing_table = {}

    for part_name, data_table in pairs(unilib.mineral_table) do

        local mini_list = {}
        for i, item_name in ipairs(data_table.metal_list) do
            table.insert(mini_list, item_name)
        end

        for i, item_name in ipairs(data_table.non_metal_list) do
            table.insert(mini_list, item_name)
        end

        product_table[part_name] = mini_list

    end

    if unilib.is_table_empty(product_table) then

        return false, S("No minerals are registered")

    else

        local product_list = {}
        for k, _ in pairs(product_table) do
            table.insert(product_list, k)
        end

        minetest.chat_send_player(
            name,
            S("List of registered mineral products (m = metal, n = non-metal, * = unrecognised)")
        )

        table.sort(product_list)
        for _, mineral_name in ipairs(product_list) do

            local item_list = product_table[mineral_name]
            table.sort(item_list)

            local mod_item_list = {}
            for i, item_name in ipairs(item_list) do

                if unilib.metal_table[item_name] ~= nil then

                    mod_item_list[i] = "<m> " .. item_name

                elseif unilib.non_metal_table[item_name] ~= nil then

                    mod_item_list[i] = "<n> " .. item_name

                else

                    mod_item_list[i] = "*   " .. item_name
                    missing_table[item_name] = true

                end
            end

            minetest.chat_send_player(name, "   " .. mineral_name)
            if not next(mod_item_list) then
                minetest.chat_send_player(name, "      (no products)")
            else
                minetest.chat_send_player(name, "      " .. table.concat(mod_item_list, ", "))
            end

        end

        minetest.chat_send_player(
            name, S("End of list (mineral products found: @1)", #product_list)
        )

        if not unilib.is_table_empty(missing_table) then

            local missing_list = {}
            for k, _ in pairs(missing_table) do
                table.insert(missing_list, k)
            end

            minetest.chat_send_player(name, S("Unregistered metals/elemental non-metals:"))

            table.sort(missing_list)
            for _, item_name in ipairs(missing_list) do
                minetest.chat_send_player(name, "   " .. item_name)
            end

            minetest.chat_send_player(
                name, S("End of list (unregistered products found: @1)", #missing_list)
            )

        end

    end

end

---------------------------------------------------------------------------------------------------
-- /list_remixes: Lists all loaded remixes
--      /list_remix
-- /list_packages: Lists all loaded packages, or details for the specified package
--      /list_package
-- /list_other_packages: Lists all non-loaded packages which are mentioned by loaded packages
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("list_remixes", {
    params = "",
    description = S("Lists all loaded remixes"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_remixes(name, param)
    end,
})

minetest.register_chatcommand("list_remix", {
    params = "",
    description = S("Lists all loaded remixes"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_remixes(name, param)
    end,
})

minetest.register_chatcommand("list_packages", {
    params = "[<package name>]",
    description = S("Lists all loaded packages, or details for the specified package"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_packages(name, param)
    end,
})

minetest.register_chatcommand("list_package", {
    params = "[<package name>]",
    description = S("Lists all loaded packages, or details for the specified package"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_packages(name, param)
    end,
})

minetest.register_chatcommand("list_other_packages", {
    params = "",
    description = S(
        "Lists all non-loaded packages which are mentioned by loaded packages (as optional or" ..
                " suggested dependencies)"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_other_packages(name, param)
    end,
})

---------------------------------------------------------------------------------------------------
-- /list_abms: Lists all registered ABMS, or just ABMs from the specified mod
--      /list_abm
-- /list_biomes: Lists all registered biomes
--      /list_biome
-- /list_craftitems: Lists all registered craftitems, or just craftitems from the specified mod
--      /list_craftitem
-- /list_decorations: Lists all registered decorations, or just decorations from the specified mod
--      /list_decoration
-- /list_entities: Lists all registered entities, or just entities from the specified mod
--      /list_entity
-- /list_lbms: Lists all registered LBMs, or just LBMs from the specified mod
--      /list_lbm
-- /list_nodes: Lists all registered nodes, or just nodes from the specified mod
--      /list_node
-- /list_ores: "Lists all registered ores, or just ores of the specified type/mod/node/biome
--      /list_ore
-- /list_tools: Lists all registered tools, or just tools from the specified mod
--      /list_tool
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("list_abms", {
    params = "[<mod>]",
    description = S("Lists all registered ABMS, or just ABMs from the specified mod (use" ..
            " \"!<mod>\" to list ABMs from all mods but the specified one)"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_abm(name, param)
    end,
})

minetest.register_chatcommand("list_abm", {
    params = "[<mod>]",
    description = S("Lists all registered ABMS, or just ABMs from the specified mod (use" ..
            " \"!<mod>\" to list ABMs from all mods but the specified one)"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_abm(name, param)
    end,
})

minetest.register_chatcommand("list_biomes", {
    params = "",
    description = S("Lists all registered biomes"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_biomes(name, param)
    end,
})

minetest.register_chatcommand("list_biome", {
    params = "",
    description = S("Lists all registered biomes"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_biomes(name, param)
    end,
})

minetest.register_chatcommand("list_craftitems", {
    params = "[<mod>]",
    description = S("Lists all registered craftitems, or just craftitems from the specified mod" ..
            " (use \"!<mod>\" to list craftitems from all mods but the specified one)"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_craftitems(name, param)
    end,
})

minetest.register_chatcommand("list_craftitem", {
    params = "[<mod>]",
    description = S("Lists all registered craftitems, or just craftitems from the specified mod" ..
            " (use \"!<mod>\" to list craftitems from all mods but the specified one)"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_craftitems(name, param)
    end,
})

minetest.register_chatcommand("list_decorations", {
    params = "[<mod>]",
    description = S("Lists all registered decorations, or just decorations from the specified" ..
            " mod (use \"!<mod>\" to list decorations from all mods but the specified one)"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_decorations(name, param)
    end,
})

minetest.register_chatcommand("list_decoration", {
    params = "[<mod>]",
    description = S("Lists all registered decorations, or just decorations from the specified" ..
            " mod (use \"!<mod>\" to list decorations from all mods but the specified one)"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_decorations(name, param)
    end,
})

minetest.register_chatcommand("list_entities", {
    params = "[<mod>]",
    description = S("Lists all registered entities, or just entities from the specified mod" ..
            " (use \"!<mod>\" to list entities from all mods but the specified one)"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)
        do_list_entities(name, param)
    end,
})

minetest.register_chatcommand("list_entity", {
    params = "[<mod>]",
    description = S("Lists all registered entities, or just entities from the specified mod" ..
            " (use \"!<mod>\" to list entities from all mods but the specified one)"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_entities(name, param)
    end,
})

minetest.register_chatcommand("list_lbms", {
    params = "[<mod>]",
    description = S("Lists all registered LBMs, or just LBMs from the specified mod (use" ..
            " \"!<mod>\" to list LBMs from all mods but the specified one)"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_lbms(name, param)
    end,
})

minetest.register_chatcommand("list_lbm", {
    params = "[<mod>]",
    description = S("Lists all registered LBMs, or just LBMs from the specified mod (use" ..
            " \"!<mod>\" to list LBMs from all mods but the specified one)"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_lbms(name, param)
    end,
})

minetest.register_chatcommand("list_nodes", {
    params = "[<mod>]",
    description = S(
        "Lists all registered nodes, or just nodes from the specified mod (use \"!<mod>\" to" ..
                " list nodes from all mods but the specified one)"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_nodes(name, param)
    end,
})

minetest.register_chatcommand("list_node", {
    params = "[<mod>]",
    description = S(
        "Lists all registered nodes, or just nodes from the specified mod (use \"!<mod>\" to" ..
                " list nodes from all mods but the specified one)"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_nodes(name, param)
    end,
})

minetest.register_chatcommand("list_ores", {
    params = "[<matching_text>]",
    description = S(
        "Lists all registered ores, or just ores of the specified type (stratum, etc), from" ..
                " the specified mod, or matching the specified node/biome, or at the specified" ..
                " height"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_ores(name, param)
    end,
})

minetest.register_chatcommand("list_ore", {
    params = "[<matching_text>]",
    description = S(
        "Lists all registered ores, or just ores of the specified type (stratum, etc), from" ..
                " the specified mod, or matching the specified node/biome, or at the specified" ..
                " height"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_ores(name, param)
    end,
})

minetest.register_chatcommand("list_tools", {
    params = "[<mod>]",
    description = S("Lists all registered tools, or just tools from the specified mod (use" ..
            " \"!<mod>\" to list tools from all mods but the specified one)"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_tools(name, param)
    end,
})

minetest.register_chatcommand("list_tool", {
    params = "[<mod>]",
    description = S("Lists all registered tools, or just tools from the specified mod (use" ..
            " \"!<mod>\" to list tools from all mods but the specified one)"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_tools(name, param)
    end,
})

---------------------------------------------------------------------------------------------------
-- /list_hidden: Lists all hidden (because they can't be unregistered) nodes, craftitems and tools
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("list_hidden", {
    params = "",
    description = S(
        "Lists all hidden nodes, craftitems and tools (items are \"hidden\" when they cannot be" ..
                " unregistered)"
    ),
    privs = {unilib_tools = true},

    func = function(name, param)

        local hidden_list = {}
        local count = 0

        for k, v in pairs (unilib.hidden_item_table) do

            table.insert(hidden_list, tostring(k))
            count = count + 1

        end

        if count == 0 then

            return false, S("No hidden items found")

        else

            minetest.chat_send_player(name, S("List of hidden items"))

            table.sort(hidden_list)
            for _, full_name in ipairs(hidden_list) do
                minetest.chat_send_player(name, "   " .. full_name)
            end

            minetest.chat_send_player(name, S("End of list (hidden items found: @1)", count))

        end

    end,
})

---------------------------------------------------------------------------------------------------
-- /list_stones: Lists stone types, or details for the specified stone type
--      /list_stone
-- /list_trees: Lists tree types, or details for the specified tree type
--      /list_tree
-- /list_buckets: Lists bucket types, or a list of buckets of the specified type
--      /list_bucket
-- /list_liquids: Lists all liquid types, or details for the specified liquid type
--      /list_liquid
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("list_stones", {
    params = "",
    description = S("Lists all stone types, or details for the specified stone type"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_stones(name, param)
    end,
})

minetest.register_chatcommand("list_stone", {
    params = "",
    description = S("Lists all stone types, or details for the specified stone type"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_stones(name, param)
    end,
})

minetest.register_chatcommand("list_trees", {
    params = "",
    description = S("Lists all tree types, or details for the specified tree type"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_trees(name, param)
    end,
})

minetest.register_chatcommand("list_tree", {
    params = "",
    description = S("Lists all tree types, or details for the specified tree type"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_trees(name, param)
    end,
})

minetest.register_chatcommand("list_buckets", {
    params = "",
    description = S("Lists bucket types, or a list of buckets of the specified type"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_buckets(name, param)
    end,
})

minetest.register_chatcommand("list_bucket", {
    params = "",
    description = S("Lists bucket types, or a list of buckets of the specified type"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_buckets(name, param)
    end,
})

minetest.register_chatcommand("list_liquids", {
    params = "",
    description = S("Lists all liquid types, or details for the specified liquid type"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_liquids(name, param)
    end,
})

minetest.register_chatcommand("list_liquid", {
    params = "",
    description = S("Lists all liquid types, or details for the specified liquid type"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_liquids(name, param)
    end,
})

---------------------------------------------------------------------------------------------------
-- /list_metals: Lists all registered metal types
--      /list_metal
-- /list_metal_sources: Lists all metals provided by mineral sources
--      /list_metal_source
-- /list_nonmetals: Lists all registered elemental non-metal types
--      /list_nonmetal
-- /list_nonmetal_sources: Lists all elemental non-metals provided by mineral sources
--      /list_nonmetal_source
-- /list_minerals: Lists all registered mineral types
--      /list_mineral
-- /list_mineral_products: Lists all metals/elemental non-metals produced by minerals
--      /list_mineral_product
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("list_metals", {
    params = "",
    description = S("Lists all registered metal types"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_metals(name, param)
    end,
})

minetest.register_chatcommand("list_metal", {
    params = "",
    description = S("Lists all registered metal types"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_metals(name, param)
    end,
})

minetest.register_chatcommand("list_metal_sources", {
    params = "",
    description = S("Lists all metals provided by mineral sources"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_metal_sources(name, param)
    end,
})

minetest.register_chatcommand("list_metal_source", {
    params = "",
    description = S("Lists all metals provided by mineral sources"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_metal_sources(name, param)
    end,
})

minetest.register_chatcommand("list_nonmetals", {
    params = "",
    description = S("Lists all registered elemental non-metal types"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_nonmetals(name, param)
    end,
})

minetest.register_chatcommand("list_nonmetal", {
    params = "",
    description = S("Lists all registered elemental non-metal types"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_nonmetals(name, param)
    end,
})

minetest.register_chatcommand("list_nonmetal_sources", {
    params = "",
    description = S("Lists all elemental non-metals provided by mineral sources"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_nonmetal_sources(name, param)
    end,
})

minetest.register_chatcommand("list_nonmetal_source", {
    params = "",
    description = S("Lists all elemental non-metals provided by mineral sources"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_nonmetal_sources(name, param)
    end,
})

minetest.register_chatcommand("list_minerals", {
    params = "",
    description = S("Lists all registered mineral types"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_minerals(name, param)
    end,
})

minetest.register_chatcommand("list_mineral", {
    params = "",
    description = S("Lists all registered mineral types"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_minerals(name, param)
    end,
})

minetest.register_chatcommand("list_mineral_products", {
    params = "",
    description = S("Lists all metals/elemental non-metals produced by minerals"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_mineral_products(name, param)
    end,
})

minetest.register_chatcommand("list_mineral_product", {
    params = "",
    description = S("Lists all metals/elemental non-metals produced by minerals"),
    privs = {unilib_tools = true},

    func = function(name, param)
        return do_list_mineral_products(name, param)
    end,
})
