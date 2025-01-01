---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- load_init.lua
--      Execute package .init() functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function show_debug(msg, arg1, arg2)

    -- Wrapper for the function in ../lib/shared/utils/

    if unilib.setting.show_pkg_debug_flag then
        unilib.utils.show_msg(msg, arg1, arg2)
    end

end

local function get_column(level)

    -- "level" is the recursion level during the package execution stage
    -- During that stage (but not during the earlier loading or initialisation stages), output in
    --      the chat window/debug file is indented so that recursion can be seen clearly (but only
    --      when debug messages are visible at all)

    local column = ""
    if unilib.setting.show_pkg_debug_flag then
        column = string.rep("  ", level)
    end

    return column

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.load.pkg_init(pkg_name, level)

    -- A function to handle calling a package's .init() function
    -- The package may be marked non-executable at any point. In either case, the package's
    --      metadata is stored in global variables

    local ns_table = unilib.pkg[pkg_name]
    local data_table = {}
    local column = get_column(level)

    if ns_table.init ~= nil then

        unilib.global.current_pkg = pkg_name
        data_table = ns_table.init()
        unilib.global.current_pkg = nil

        if unilib.setting.show_pkg_init_flag and unilib.setting.show_msg_flag then
            unilib.utils.show_msg(column .. "Initialising package", pkg_name)
        end

    elseif unilib.setting.show_pkg_init_flag and unilib.setting.show_msg_flag then

        unilib.utils.show_msg(
            column .. "Failed to initialise package (no .init() function to call)", pkg_name
        )

    end

    -- Set compulsory keys, if not already set
    if data_table.pkg_name == nil then
        data_table.pkg_name = pkg_name
    end

    if data_table.mod_name == nil then
        data_table.mod_name = unilib.global.pkg_setup_table[pkg_name]
    end

    -- Update global variables
    unilib.global.pkg_table[pkg_name] = data_table

    -- Check that the source mod is described in imported.csv
    for _, this_mod_name in ipairs(
        unilib.utils.split_string_by_whitespace(data_table.mod_name, true)
    ) do

        if this_mod_name ~= "" and
                unilib.global.imported_mod_table[this_mod_name] == nil then

            unilib.utils.show_error(
                column .. "Package specifies a source mod that is not recognised (does not" ..
                        " appear in unilib's ../csv/mods/imported.csv file). To resolve this" ..
                        "  error, add the source mod to that CSV file",
                this_mod_name,
                pkg_name
            )

            unilib.global.pkg_excluded_table[pkg_name] = true

            return false

        end

    end

    -- Check (in)compatible mods
    for _, this_mod_name in ipairs(unilib.utils.convert_to_list(data_table.mod_excludes)) do

        if core.get_modpath(this_mod_name) then

            show_debug(
                column .. "Package excludes a mod that has already been loaded. To resolve this" ..
                        " error,remove the package from the remix, or disable the excluded mod",
                this_mod_name,
                pkg_name
            )

            unilib.global.pkg_excluded_table[pkg_name] = true

            return false

        end

    end

    for _, this_mod_name in ipairs(unilib.utils.convert_to_list(data_table.mod_depends)) do

        if not core.get_modpath(this_mod_name) then

            show_debug(
                column .. "Package requires a mod that has not been loaded. Make sure the mod is" ..
                        " enabled, and make sure it has been added to unilib's mod.conf file",
                this_mod_name,
                pkg_name
            )

            -- (The empty list represents a package excluded by a mod, not by other packages)
            unilib.global.pkg_excluded_table[pkg_name] = true

            return false

        end

    end

    local main_list = unilib.utils.convert_to_list(data_table.mod_at_least_one)
    if #main_list > 0 then

        -- .mod_at_least_one can be a simple list of mod names, i.e. {a, b, c}, in which case we
        --      require at least one of the mods to be available
        -- Alternatively, it can be a list of mini-lists, e.g. { {a, b, c}, {d, e, f} }, in which
        --      case we require at least one mod from each mini-list to be available
        if type(main_list[1]) ~= "table" then

            -- To keep the code simple, convert a simple list into a list of mini-lists
            main_list = { main_list }

        end

        for _, mini_list in ipairs(main_list) do

            -- Ignore any value that's not a mini-list, e.g. "d" in { {a, b, c}, d }
            if type(mini_list) == "table" then

                local at_least_one_flag = false
                for _, this_mod_name in ipairs(mini_list) do

                    if core.get_modpath(this_mod_name) then

                        at_least_one_flag = true
                        break

                    end

                end

                if not at_least_one_flag then

                    show_debug(
                        column .. "Package requires at least one mod from a list, none of which" ..
                                " have been loaded. Make sure that at least one of the mods is" ..
                                " enabled and has been added to unilib's mod.conf file",
                        data_table.mod_at_least_one,
                        pkg_name
                    )

                    -- (The empty list represents a package excluded by a mod, not by other
                    --      packages)
                    unilib.global.pkg_excluded_table[pkg_name] = true
                    return false

                end

            end

        end

    end

    for _, this_mod_name in ipairs(unilib.utils.convert_to_list(data_table.mod_optional)) do

        if not core.get_modpath(this_mod_name) then

            show_debug(
                column .. "Package references a mod that has not been loaded. Make sure the" ..
                        " mod is enabled, and make sure it has been added to unilib's mod.conf" ..
                        " file",
                this_mod_name,
                pkg_name
            )

        end

    end

    -- Check (in)compatible packages
    if data_table.excludes ~= nil then

        -- If any incompatible packages have been loaded, then this package must not be executed
        -- N.B. It is allowed (though useless) for a package to declare it is incompatible with
        --      itself
        for _, this_pkg_name in ipairs(unilib.utils.convert_to_list(data_table.excludes)) do

            -- (This double check ensures that when packages A and B both exclude the other, the
            --      first one initialised is still executable)
            if unilib.global.pkg_table[this_pkg_name] ~= nil and
                    unilib.global.pkg_excluded_table[this_pkg_name] == nil then

                unilib.global.pkg_excluded_table[pkg_name] = true
                show_debug(column .. "Package incompatible", pkg_name, this_pkg_name)
                return false

            end

        end

    end

    -- Package initialised
    return true

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Call each package's .init() function, in the same order specified by the remix
-- The function returns a table of metadata, used to update the global variable
--      unilib.global.pkg_table (see the comments in global.lua for the table format)
-- Some packages may not specify an .init() function, in which case, we update
--      unilib.global.pkg_table using values supplied by the remix
-- Besides returning metadata, it is permitted for the .init() function to execute other code; but
--      this code must not affect any other package
-- If the package is incompatible with other mods, or incompatible with other loaded packages, it
--      is marked as non-executable
for _, pkg_name in ipairs(unilib.global.pkg_loaded_list) do

    -- 0 represents the lowest level of recursion
    if not unilib.load.pkg_init(pkg_name, 0) then
        unilib.load.fail_table[pkg_name] = ""
    end

end
