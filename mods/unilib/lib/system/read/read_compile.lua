---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- read_compile.lua
--      Compile an ordered list of packages to load
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- A table of remix names that have been handled via a call to parse_init_remix(); we don't handle
--      the same remix more than once
main_remix_check_table = {}
-- A list of package names that have been handled via a call to parse_init_pkg() or add_package();
--      we don't handle the same package more than once
main_pkg_check_table = {}

-- A table of remixes that were excluded, because in unilib.setting.init_remix_pkg_set they were
--      preceded by the special character "!"
remix_excluded_table = {}
-- A table of packages that were excluded, because in unilib.setting.init_remix_pkg_set they were
--      preceded by the special character "!"
pkg_excluded_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_remix_path(remix_name)

    -- Check that the specified remix is a valid remix by checking whether its compulsory
    --      "packages.csv" file exists, or not
    -- If found, update global variables and return true; if not found, show a warning and return
    --      false

    for _, folder_path in ipairs(unilib.global.remix_path_list) do

        local sub_folder_path = folder_path .. remix_name
        if unilib.utils.is_file(sub_folder_path .. "/packages.csv") then

            table.insert(unilib.global.init_remix_list, remix_name)
            unilib.global.remix_dir_table[remix_name] = sub_folder_path

            return true

        end

    end

    unilib.utils.show_warning(
        "../lib/system/read/read_compile.lua, register_remix_path(): Missing CSV file", remix_name
    )

    return false

end

local function check_package(packages_path, i, orig_mod_str, pkg_name, mini_check_table)

    -- Check the package file actually exists in any one of three locations

    for _, orig_mod_name in ipairs(unilib.utils.split_string_by_whitespace(orig_mod_str, true)) do

        if orig_mod_name == nil or orig_mod_name == "" then

            unilib.utils.show_warning(
                "../lib/system/read/read_compile.lua, check_package():" ..
                        " Invalid package definition in remix",
                packages_path,
                i
            )

            return false

        elseif unilib.global.source_mod_table[orig_mod_name] == nil then

            unilib.utils.show_warning(
                "../lib/system/read/read_compile.lua, check_package():" ..
                        " Unrecognised source mod in remix",
                packages_path,
                i
            )

            return false

        elseif mini_check_table[pkg_name] ~= nil then

            unilib.utils.show_warning(
                "../lib/system/read/read_compile.lua, check_package():" ..
                        " Duplicate package in remix",
                packages_path,
                i
            )

            return false

        end

        for _, folder_path in ipairs(unilib.global.pkg_path_list) do

            if unilib.utils.is_file(folder_path .. pkg_name .. ".lua") then
                return true
            end

        end

        unilib.utils.show_warning(
            "../lib/system/read/read_compile.lua, check_package(): Missing package file",
            packages_path,
            i
        )

        return false

    end

end

local function quick_check_package(pkg_name)

    -- Slimmed-down version of check_package(), for when a package name is specified directly in
    --      unilib.setting.init_remix_pkg_set

    for _, folder_path in ipairs(unilib.global.pkg_path_list) do

        if unilib.utils.is_file(folder_path .. pkg_name .. ".lua") then
            return true
        end

    end

    unilib.utils.show_warning(
        "../lib/system/read/read_compile.lua, quick_check_package(): Missing package file",
        pkg_name
    )

    return false

end

local function warn_about_recurring_package(packages_path, i, orig_mod_str, pkg_name)

    if not unilib.utils.test_equivalence_of_lists(
        unilib.utils.split_string_by_whitespace(orig_mod_str, true),
        unilib.utils.split_string_by_whitespace(
            unilib.global.pkg_setup_table[pkg_name], true
        )
    ) then
        unilib.utils.show_msg(
            "../lib/system/read/read_compile.lua, warn_about_recurring_package():" ..
                    " Package is specified by a different remix, and with a different set of" ..
                    " source mods",
            packages_path,
            i
        )

    end

    if unilib.setting.show_pkg_remix_flag then

        unilib.utils.show_msg(
            "../lib/system/read/read_compile.lua, warn_about_recurring_package():" ..
                    " Package already specified by another remix (or specified directly)",
            packages_path,
            i
        )

    end

end

local function add_package(orig_mod_str, pkg_name)

    -- (It is permitted for the .csv file not to specify the source mod)
    if orig_mod_str == nil then
        orig_mod_str = ""
    end

    -- Update local variables
    main_pkg_check_table[pkg_name] = ""
    -- Update global variables
    table.insert(unilib.global.pkg_setup_list, pkg_name)
    unilib.global.pkg_setup_table[pkg_name] = orig_mod_str

end

local function parse_init_set()

    -- Parse the string containing the initial set of remix and package names,
    --      unilib.setting.init_remix_pkg_set

    if unilib.setting.init_remix_pkg_set == nil then

        unilib.utils.show_error(
            "../lib/system/read/read_compile.lua, parse_init_set():" ..
                    " No remix(es) specified in Minetest settings"
        )

        unilib.read.fatal_error_flag = true
        return

    end

    -- Note that duplicate remixes are eliminated by the call to this function
    local word_list =
            unilib.utils.split_string_by_whitespace(unilib.setting.init_remix_pkg_set, true)

    -- The remix names "everything" and "nothing" are reserved
    -- "everything" loads all remixes, in alphabetical order. "nothing" loads no remixes; it's
    --      the equivalent of commenting out the remix list. "nothing" cancels "everything", if both
    --      are specified
    -- Any special characters preceding "everything" and/or "nothing" are ignored
    for _, word in pairs(word_list) do

        if string.find(word, "^[!@+]*nothing$") ~= nil then
            return
        end

    end

    for _, word in pairs(word_list) do

        if string.find(word, "^[!@+]*everything$") ~= nil then

            -- Every remix has its own sub-folder, in one of several locations. Don't add remixes
            --      with duplicate names
            local remix_name_list = {}
            local remix_dir_table = {}

            for _, folder_path in ipairs(unilib.global.remix_path_list) do

                for _, remix_name in pairs(core.get_dir_list(folder_path, true)) do

                    if remix_dir_table[remix_name] == nil then

                        table.insert(remix_name_list, remix_name)
                        remix_dir_table[remix_name] = folder_path .. remix_name

                    end

                end

            end

            table.sort(remix_name_list)
            for _, remix_name in pairs(remix_name_list) do

                -- Check this is a valid remix by checking whether its compulsory "packages.csv"
                --      file exists, or not
                -- Unlike the code below, don't show any warnings; just move on to the next
                --      remix
                if unilib.utils.is_file(remix_dir_table[remix_name] .. "/packages.csv") then

                    table.insert(unilib.global.init_remix_list, remix_name)
                    table.insert(unilib.global.init_remix_pkg_list, "@" .. remix_name)
                    unilib.global.remix_dir_table[remix_name] = remix_dir_table[remix_name]

                end

            end

            return

        end

    end

    -- Remove remixes/packages preceded by the special character "!", and mark them as excluded
    local filtered_list = {}
    for _, word in pairs(word_list) do

        local special_char, name = string.match(word, "^!([@+]?)([%w_]+)$")
        if name ~= nil then

            if special_char == "+" then
                pkg_excluded_table[name] = true
            else
                remix_excluded_table[name] = true
            end

        else

            table.insert(filtered_list, word)

        end

    end

    -- The surviving remix/package names are added to global variables
    for _, word in ipairs(filtered_list) do

        local first_char = string.sub(word, 1, 1)

        -- Package names, always preceded by "+"
        if first_char == "+" then

            table.insert(unilib.global.init_remix_pkg_list, word)
            table.insert(unilib.global.init_pkg_list, string.sub(word, 2))

        -- Remix names, optionally preceded by "@"
        else

            if first_char == "@" then

                -- Register each (real) remix in turn, first checking that it is valid
                if register_remix_path(string.sub(word, 2)) then
                    table.insert(unilib.global.init_remix_pkg_list, word)
                end

            else

                if register_remix_path(word) then
                    table.insert(unilib.global.init_remix_pkg_list, "@" .. word)
                end

            end

        end

    end

end

local function parse_init_remix(remix_name)

    -- From the named remix, compile an ordered list of packages that must be imported, ignoring any
    --      duplicates

    -- Don't parse excluded remixes
    if remix_excluded_table[remix_name] ~= nil then

        if unilib.setting.show_pkg_debug_flag then

            unilib.utils.show_msg(
                "../lib/system/read/read_compile.lua, parse_init_remix():" ..
                        " Remix is directly excluded by the initial remix/package set",
                remix_name
            )

        end

        return

    end

    -- Don't read packages from the same remix more than once
    if main_remix_check_table[remix_name] ~= nil then
        return
    else
        main_remix_check_table[remix_name] = true
    end

    if unilib.global.remix_dir_table[remix_name] == nil then

        -- This function was called, after "remix_name" was mentioned in another remix. Update
        --      global variables, is if "remix_name" was one of those specified in
        --      unilib.setting.init_remix_pkg_set
        if not register_remix_path(remix_name) then

            -- This remix does not exist
            return

        end

    end

    local packages_path = unilib.global.remix_dir_table[remix_name] .. "/packages.csv"
    local pkg_count = 0

    local mini_check_list = {}
    local mini_check_table = {}

    for i, csv_table in ipairs(unilib.utils.read_csv(packages_path)) do

        local pkg_name, orig_mod_str = unpack(csv_table)
        if pkg_name ~= nil and string.find(pkg_name, "%a") then

            if string.sub(pkg_name, 1, 1) == "@" then

                -- Call this function to read packages from the named remix, before continuing to
                --      read packages from this remix
                -- Don't read packages from the same remix more than once
                local other_remix_name = string.sub(pkg_name, 2)
                if other_remix_name ~= "" and main_remix_check_table[other_remix_name] == nil then
                    parse_init_remix(other_remix_name)
                end

            elseif check_package(packages_path, i, orig_mod_str, pkg_name, mini_check_table) then

                table.insert(mini_check_list, pkg_name)
                mini_check_table[pkg_name] = ""

                if main_pkg_check_table[pkg_name] ~= nil then

                    -- Package already specified, either directly or in a previous remix; show
                    --      warnings when necessary
                    warn_about_recurring_package(packages_path, i, orig_mod_str, pkg_name)

                else

                    -- This package can be loaded
                    add_package(orig_mod_str, pkg_name)
                    pkg_count = pkg_count + 1

                end

            end

        end

    end

    -- Valid remix, update global variables
    unilib.global.remix_pkg_table[remix_name] = mini_check_list
    unilib.global.remix_pkg_count_table[remix_name] = pkg_count

end

local function parse_init_pkg(pkg_name)

    -- From the named package, perform checks and then add it to the ordered list of packages that
    --      must be imported, ignoring any duplicates

    -- Don't parse excluded packages
    if pkg_excluded_table[pkg_name] ~= nil then

        if unilib.setting.show_pkg_debug_flag then

            unilib.utils.show_msg(
                "../lib/system/read/read_compile.lua, parse_init_pkg():" ..
                        " Package is directly excluded by the initial remix/package set",
                pkg_name
            )

        end

        return

    end

    -- Parse the package
    if quick_check_package(pkg_name) then

        if main_pkg_check_table[pkg_name] ~= nil then

            -- Package already specified, either directly or in a previous remix; show
            --      warnings when necessary
            warn_about_recurring_package(nil, pkg_name)

        else

            -- This package can be loaded
            add_package(nil, pkg_name)

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Parse the string containing the initial set of remix and package names
parse_init_set()

-- Compile an ordered list of packages to load
if not unilib.read.fatal_error_flag then

    for _, name in ipairs(unilib.global.init_remix_pkg_list) do

        if string.sub(name, 1, 1) == "@" then
            parse_init_remix(string.sub(name, 2))
        elseif string.sub(name, 1, 1) == "+" then
            parse_init_pkg(string.sub(name, 2))
        end

    end

end

-- Conserve memory by resetting local variables
main_remix_check_table = {}
main_pkg_check_table = {}
remix_excluded_table = {}
pkg_excluded_table = {}
