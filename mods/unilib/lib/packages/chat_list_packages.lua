---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_packages = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_packages(pname, param)

    if unilib.utils.is_table_empty(unilib.global.pkg_loaded_list) then

        return false, S("No packages have been loaded")

    elseif param ~= nil and param ~= "" then

        -- Ignore multiple package names, if specified
        local pkg_list = unilib.utils.split_string_by_whitespace(param)
        local pkg_name = pkg_list[1]

        if pkg_name == nil or pkg_name == "" or unilib.global.pkg_table[pkg_name] == nil then

            return false, S("Unrecognised package, try /list_packages")

        else

            local mini_table = unilib.global.pkg_table[pkg_name]

            unilib.utils.chat_send_player(pname, S("Metadata for package \"@1\"", pkg_name))

            if mini_table.mod_name and mini_table.mod_name ~= "" then

                unilib.utils.chat_send_player(
                    pname, "   " .. S("Source mods") .. ": " .. mini_table.mod_name
                )

            end

            if mini_table.description and mini_table.description ~= "" then

                unilib.utils.chat_send_player(
                    pname, "   " .. S("Description") .. ": " .. mini_table.description
                )

            end

            if mini_table.notes and mini_table.notes ~= "" then

                unilib.utils.chat_send_player(
                    pname, "   " .. S("Notes") .. ": " .. mini_table.notes
                )

            end

            if mini_table.first and mini_table.first ~= "" then
                unilib.utils.chat_send_player(pname, "   " .. S("Must be executed first: YES"))
            end

            if mini_table.last and mini_table.last ~= "" then
                unilib.utils.chat_send_player(pname, "   " .. S("Must be executed last: YES"))
            end

            if mini_table.excludes and mini_table.excludes ~= "" then

                unilib.utils.chat_send_player(
                    pname,
                    "   " .. S("Incompatible packages") .. ": " ..
                            unilib.utils.convert_to_string(mini_table.excludes)
                )

           end

            if mini_table.depends and mini_table.depends ~= "" then

                unilib.utils.chat_send_player(
                    pname,
                    "   " .. S("Hard dependency (all packages)") .. ": " ..
                            unilib.utils.convert_to_string(mini_table.depends)
                )

            end

            if mini_table.at_least_one and mini_table.at_least_one ~= "" then

                unilib.utils.chat_send_player(
                    pname,
                    "   " .. S("Hard dependency (at least one package)") .. ": " ..
                            unilib.utils.convert_to_string(mini_table.at_least_one)
                )

            end

            if mini_table.optional and mini_table.optional ~= "" then

                unilib.utils.chat_send_player(
                    pname,
                    "   " .. S("Optional dependency (packages)") .. ": " ..
                            unilib.utils.convert_to_string(mini_table.optional)
                )

            end

            if mini_table.suggested and mini_table.suggested ~= "" then

                unilib.utils.chat_send_player(
                    pname,
                    "   " .. S("Suggested dependency (packages)") .. ": " ..
                            unilib.utils.convert_to_string(mini_table.suggested)
                )

            end

            if mini_table.mod_excludes and mini_table.mod_excludes ~= "" then

                unilib.utils.chat_send_player(
                    pname,
                    "   " .. S("Incompatible mods") .. ": " ..
                            unilib.utils.convert_to_string(mini_table.mod_excludes)
                )

            end

            if mini_table.mod_depends and mini_table.mod_depends ~= "" then

                unilib.utils.chat_send_player(
                    pname,
                    "   " .. S("Hard dependency (all mods)") .. ": " ..
                            unilib.utils.convert_to_string(mini_table.mod_depends)
                )

            end

            if mini_table.mod_at_least_one and mini_table.mod_at_least_one ~= "" then

                unilib.utils.chat_send_player(
                    pname,
                    "   " .. S("Hard dependency (at least one mod)") .. ": " ..
                            unilib.utils.convert_to_string(mini_table.mod_at_least_one)
                )

            end

            if mini_table.mod_optional and mini_table.mod_optional ~= "" then

                unilib.utils.chat_send_player(
                    pname,
                    "   " .. S("Optional dependency (mods)") .. ": " ..
                            unilib.utils.convert_to_string(mini_table.mod_optional)
                )

            end

            if mini_table.adult_flag and mini_table.adult_flag == true then
                unilib.utils.chat_send_player(pname, "   " .. S("Adult content: YES"))
            end

            unilib.utils.chat_send_player(pname, S("End of package metadata"))

        end

    else

        unilib.utils.chat_send_player(
            pname,
            S("Loaded packages (I = initialised, E = executed, X = excluded) [original mods]")
        )

        local count = 0
        for _, pkg_name in ipairs(unilib.global.pkg_loaded_list) do

            local column = " "
            if unilib.global.pkg_table[pkg_name] ~= nil then
                column = column .. "I"
            else
                column = column .. " "
            end

            if unilib.global.pkg_executed_table[pkg_name] ~= nil then
                column = column .. "E"
            else
                column = column .. " "
            end

            if unilib.global.pkg_excluded_table[pkg_name] ~= nil then
                column = column .. "X"
            else
                column = column .. " "
            end

            -- The remix specifies the original mod(s) for each package. If a hard/soft dependency
            --      doesn't appear in any loaded remix, it is force-loaded, meaning that its
            --      original mod(s) are not available
            if unilib.global.pkg_loaded_table[pkg_name] == nil or
                    unilib.global.pkg_loaded_table[pkg_name] == "" then

                unilib.utils.chat_send_player(
                    pname, column .. " " .. pkg_name .. " <" .. S("unavailable") .. ">"
                )

            else

                unilib.utils.chat_send_player(
                    pname,
                    column .. " " .. pkg_name .. " [" ..
                            unilib.global.pkg_loaded_table[pkg_name] .. "]"
                )

            end

            count = count + 1

        end

        unilib.utils.chat_send_player(pname, S("End of list (packages loaded: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_packages.init()

    return {
        description = "Chat commands /list_packages, /list_package",
        notes = "Lists all loaded packages, or details for the specified package",
    }

end

function unilib.pkg.chat_list_packages.exec()

    core.register_chatcommand("list_packages", {
        params = "[package_name]",
        description = S("Lists all loaded packages, or details for the specified package"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_packages(name, param)
        end,
    })

    core.register_chatcommand("list_package", {
        params = "[packag_name]",
        description = S("Lists all loaded packages, or details for the specified package"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_packages(name, param)
        end,
    })

end
