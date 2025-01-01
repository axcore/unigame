---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_elements = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_show_elements(param)

    if unilib.global.pkg_executed_table["shared_atomic"] == nil then
        return false, S("Periodic table is not available (\"shared_atomic\" package not loaded)")
    elseif param ~= "" and unilib.pkg.shared_atomic.periodic_table[param] == nil then
        return false, S("Element does not exist: @1", param)
    end

    -- unilib.pkg.shared_atomic.periodic_table is stored with element_names as keys; create a list,
    --      storing atomic numbers as keys
    local element_table = {}
    for _, mini_table in pairs(unilib.pkg.shared_atomic.periodic_table) do
        element_table[mini_table.number] = mini_table
    end

    -- Create a table of all elements (i.e. samplings) that can be produced by the atomic
    --      vapouriser, and the input items that are vapourised to produce them
    local vapourise_table = {}
    for group_name, vapourise_list in pairs(unilib.pkg.shared_atomic.vapourise_group_table) do

        for _, mini_list in ipairs(vapourise_list) do

            local element_name = mini_list[1]
            if vapourise_table[element_name] == nil then
                vapourise_table[element_name] = {"group:" .. group_name}
            else
                table.insert(vapourise_table[element_name], "group:" .. group_name)
            end

        end

    end

    for input_name, vapourise_list in pairs(unilib.pkg.shared_atomic.vapourise_item_table) do

        for _, mini_list in ipairs(vapourise_list) do

            local element_name = mini_list[1]
            if vapourise_table[element_name] == nil then
                vapourise_table[element_name] = {input_name}
            else
                table.insert(vapourise_table[element_name], input_name)
            end

        end

    end

    -- Display the periodic table
    unilib.utils.chat_send_player(name, S("Periodic table of elements"))

    local found_count = 0
    local missing_count = 0
    for i = 1, unilib.pkg.shared_atomic.periodic_table_size do

        local mini_table = element_table[i]
        if param == "" or mini_table.name == param then

            if mini_table == true then

                missing_count = missing_count + 1

                unilib.utils.chat_send_player(
                    name,
                    string.format("   %-3i unknown element", i)
                )

            else

                found_count = found_count + 1

                local vapourise_count = 0
                if vapourise_table[mini_table.name] ~= nil then
                    vapourise_count = #vapourise_table[mini_table.name]
                end

                local construct_count = 0
                if unilib.pkg.shared_atomic.construct_table[mini_table.name] ~= nil then
                    construct_count = #unilib.pkg.shared_atomic.construct_table[mini_table.name][1]
                end

                unilib.utils.chat_send_player(
                    name,
                    string.format(
                        "   %-3i %-2s %-30s (%i/%i)",
                        i,
                        mini_table.symbol,
                        mini_table.description,
                        vapourise_count,
                        construct_count
                    )
                )

                if vapourise_count > 0 then

                    unilib.utils.chat_send_player(name, S("       Vapourised from") .. ":")
                    for _, full_name in ipairs(vapourise_table[mini_table.name]) do
                        unilib.utils.chat_send_player(name, "          " .. full_name)
                    end

                end

                if construct_count > 0 then

                    unilib.utils.chat_send_player(name, S("       Constructs") .. ":")
                    local mini_list =
                            unilib.pkg.shared_atomic.construct_table[mini_table.name]
                    for _, full_name in ipairs(mini_list[1]) do

                        unilib.utils.chat_send_player(
                            name,
                            "          " .. full_name .. " [" .. mini_list[2] .. "]"
                        )

                    end

                end

            end

        end

    end

    if missing_count == 0 then

        unilib.utils.chat_send_player(name, S("End of list (elements found: @1)", found_count))

    else

        unilib.utils.chat_send_player(
            name,
            S(
                "End of list (elements found: @1, elements missing: @2)",
                found_count,
                missing_count
            )
        )

    end

end

local function do_show_rare_elements(param)

    if unilib.global.pkg_executed_table["shared_atomic"] == nil then
        return false, S("Periodic table is not available (\"shared_atomic\" package not loaded)")
    end

    -- unilib.pkg.shared_atomic.periodic_table is stored with element_names as keys; create a list,
    --      storing atomic numbers as keys (but exclude elements that are available from
    --      vapourisation)
    local element_table = {}
    for _, mini_table in pairs(unilib.pkg.shared_atomic.periodic_table) do

        if not mini_table.available_flag then
            element_table[mini_table.number] = mini_table
        end

    end

    -- Display the list
    if unilib.utils.get_table_size(element_table) == 0 then

        unilib.utils.chat_send_player(name, S("No rare elements found"))

    else

        unilib.utils.chat_send_player(name, S("List of rare elements"))

        local count = 0
        for i = 1, unilib.pkg.shared_atomic.periodic_table_size do

            local mini_table = element_table[i]
            if mini_table ~= nil and mini_table ~= true then

                count = count + 1
                unilib.utils.chat_send_player(
                    name,
                    string.format("   %-3i %s", i, mini_table.name)
                )

            end

        end

        unilib.utils.chat_send_player(
            name,
            S("End of list (orphaned elements found: @1)", count)
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_elements.init()

    return {
        description = "Chat commands /show_element, /show_elements, /show_rare_element," ..
                " /show_rare_elements",
        notes = "Shows the periodic table (from the \"atomic\" remix)",
        optional = "shared_atomic",
    }

end

function unilib.pkg.chat_show_elements.exec()

    core.register_chatcommand("show_element", {
        params = "[element]",
        description = S("Shows the periodic table (from the \"atomic\" remix)"),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_show_elements(param)
        end,
    })

    core.register_chatcommand("show_elements", {
        params = "[element]",
        description = S("Shows the periodic table (from the \"atomic\" remix)"),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_show_elements(param)
        end,
    })

    core.register_chatcommand("show_rare_element", {
        params = "",
        description = S(
            "Shows elements not directly available from vapourisation (from the \"atomic\" remix)"
        ),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_show_rare_elements(param)
        end,
    })

    core.register_chatcommand("show_rare_elements", {
        params = "",
        description = S(
            "Shows elements not directly available from vapourisation (from the \"atomic\" remix)"
        ),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_show_rare_elements(param)
        end,
    })

end
