---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_other_packages = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function process_item_of_unknown_type(msg, item, other_table)

    -- Called recursively to handle the package's .at_least_one field, which can be a string, list,
    --      or list of lists

    if type(item) == "table" then

        for _, other_item in ipairs(item) do
            other_table = process_item_of_unknown_type(msg, other_item, other_table)
        end

    else

        if unilib.global.pkg_loaded_table[item] == nil then

            local this_msg = msg .. ": " .. pkg_name
            if other_table[item] == nil then
                other_table[item] = {this_msg}
            else
                table.insert(other_table[item], this_msg)
            end

        end

    end

    return other_table

end

local function do_list_other_packages(pname, param)

    if unilib.utils.is_table_empty(unilib.global.pkg_loaded_list) then

        return false, S("No packages have been loaded")

    else

        local count = 0
        local other_table = {}

        for pkg_name, mini_table in pairs(unilib.global.pkg_table) do

            for _, other_pkg_name in ipairs(unilib.utils.convert_to_list(mini_table.depends)) do

                if unilib.global.pkg_loaded_table[other_pkg_name] == nil then

                    local msg = S("Hard dependency (all packages) of") .. ": " .. pkg_name
                    if other_table[other_pkg_name] == nil then
                        other_table[other_pkg_name] = {msg}
                    else
                        table.insert(other_table[other_pkg_name], msg)
                    end

                end

            end

            --[[
            for _, other_pkg_name in ipairs(
                unilib.utils.convert_to_list(mini_table.at_least_one)
            ) do

                if unilib.global.pkg_loaded_table[other_pkg_name] == nil then

                    local msg = S("Hard dependency (at least one package) of") .. ": " .. pkg_name
                    if other_table[other_pkg_name] == nil then
                        other_table[other_pkg_name] = {msg}
                    else
                        table.insert(other_table[other_pkg_name], msg)
                    end

                end

            end
            ]]--
            -- N.B. .at_least_one can be a string, list, or list of lists, so it requires special
            --      handling
            for _, item in ipairs(unilib.utils.convert_to_list(mini_table.at_least_one)) do

                other_table = process_item_of_unknown_type(
                    S("Hard dependency (at least one package) of"), item, other_table
                )

            end

            for _, other_pkg_name in ipairs(unilib.utils.convert_to_list(mini_table.optional)) do

                if unilib.global.pkg_loaded_table[other_pkg_name] == nil then

                    local msg = S("Optional dependency of") .. ": " .. pkg_name
                    if other_table[other_pkg_name] == nil then
                        other_table[other_pkg_name] = {msg}
                    else
                        table.insert(other_table[other_pkg_name], msg)
                    end

                end

            end

            for _, other_pkg_name in ipairs(unilib.utils.convert_to_list(mini_table.suggested)) do

                if unilib.global.pkg_loaded_table[other_pkg_name] == nil then

                    local msg = S("Suggested dependency of") .. ": " .. pkg_name
                    if other_table[other_pkg_name] == nil then
                        other_table[other_pkg_name] = {msg}
                    else
                        table.insert(other_table[other_pkg_name], msg)
                    end

                end

            end

        end

        if unilib.utils.is_table_empty(other_table) then

            unilib.utils.chat_send_player(pname, S("All package dependencies have been loaded"))

        else

            unilib.utils.chat_send_player(
                pname, S("List of dependent packages which have not been loaded")
            )

            local pkg_list = unilib.utils.sort_table(other_table)
            for _, pkg_name in ipairs(pkg_list) do

                local mini_list = other_table[pkg_name]
                unilib.utils.chat_send_player(pname, "   " .. pkg_name)
                for _, msg in ipairs(mini_list) do
                    unilib.utils.chat_send_player(pname, "      " .. msg)
                end

                count = count + 1

            end

            unilib.utils.chat_send_player(
                pname, S("End of list (unloaded packages list: @1)", count)
            )

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_other_packages.init()

    return {
        description = "Chat command /list_other_packages",
        notes = "Lists all non-loaded packages which are mentioned by loaded packages",
    }

end

function unilib.pkg.chat_list_other_packages.exec()

    core.register_chatcommand("list_other_packages", {
        params = "",
        description = S(
            "Lists all non-loaded packages which are mentioned by loaded packages (as optional" ..
                    " or suggested dependencies)"
        ),
        privs = {unilib_tools = true},

        func = function(pname, param)
            return do_list_other_packages(pname, param)
        end,
    })

end
