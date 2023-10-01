---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- import_pkg.lua
--      Import all packages specified by the remix(es)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- A table of packages which could not be loaded and/or initialised. When a package in this table
--      is marked as a hard or soft dependency for some other package, we don't try to load/
--      initialise it a second time
local fail_table = {}
-- A table of packages; as each package is processed for execution, it is removed from the table (so
--      that no package is processed for execution twice)
local check_table = {}

-- Lists of packages to be executed first, last, or in the middle
local first_list = {}
local middle_list = {}
local last_list = {}
-- List of packages in the order they were actually executed
local exec_list = {}

-- Recursion limit, when checking package dependencies
local recursion_limit = 16

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function show_debug(msg, arg1, arg2)

    -- Wrapper for the function in ../lib/shared/utils

    if unilib.show_pkg_debug_flag then
        unilib.show_msg(msg, arg1, arg2)
    end

end

local function get_column(level)

    -- "level" is the recursion level during the package execution stage
    -- During that stage (but not during the earlier loading or initialisation stages), output in
    --      the chat window/debug file is indented so that recursion can be seen clearly (but only
    --      when debug messages are visible at all)

    local column = ""
    if unilib.show_pkg_debug_flag then
        column = string.rep("  ", level)
    end

    return column

end

local function pkg_load(pkg_name, level)

    -- A function to handle loading a package

    local column = get_column(level)

    -- Check the package file actually exists in any one of three locations. User-created packages
    --      take priority over any "standard" packages with the same name. Development packages have
    --      the lowest priority

    local standard_path = unilib.path_mod .. "/lib/packages/" .. pkg_name .. ".lua"

    -- (User-created packages)
    local path = unilib.path_mod .. "/custom/packages/" .. pkg_name .. ".lua"

    -- ("Standard" packages)
    if not unilib.is_file(path) then
        path = standard_path
    end

    -- (Development packages)
    if not unilib.is_file(path) then
        path = unilib.path_mod .. "/lib/packages/dev/" .. pkg_name .. ".lua"
    end

    if not unilib.is_file(path) then

        unilib.show_error(column .. "Package does not exist", pkg_name, standard_path)
        return false

    end

    -- Load the file (any syntax errors will cause a crash at this point)
    dofile(path)

    if unilib.show_pkg_load_flag and unilib.show_msg_flag then
        unilib.show_msg(column .. "Loaded package", pkg_name)
    end

    -- Check that the package specifies its own namespace (a requirement)
    if unilib.pkg[pkg_name] == nil then

        unilib.show_error(column .. "Package does not specify its own namespace", pkg_name)
        return false

    else

        -- Add this to the list of successfully loaded packages
        table.insert(unilib.pkg_loaded_list, pkg_name)

        if unilib.pkg_setup_table[pkg_name] == nil then

            -- Hard/soft dependency force-loaded after a call from pkg_exec(), so it doesn't appear
            --      in the initial list
            unilib.pkg_loaded_table[pkg_name] = ""
            check_table[pkg_name] = ""

        else

            unilib.pkg_loaded_table[pkg_name] = unilib.pkg_setup_table[pkg_name]

        end

        return true

    end

end

local function pkg_init(pkg_name, level)

    -- A function to handle calling a package's .init() function
    -- The package may be marked non-executable at any point. In either case, the package's
    --      metadata is stored in global variables

    local ns_table = unilib.pkg[pkg_name]
    local data_table = {}
    local column = get_column(level)

    if ns_table.init ~= nil then

        unilib.current_pkg = pkg_name
        data_table = ns_table.init()
        unilib.current_pkg = nil

        if unilib.show_pkg_init_flag and unilib.show_msg_flag then
            unilib.show_msg(column .. "Initialising package", pkg_name)
        end

    elseif unilib.show_pkg_init_flag and unilib.show_msg_flag then

        unilib.show_msg(
            column .. "Failed to initialise package (no .init() function to call)", pkg_name
        )

    end

    -- Set compulsory keys, if not already set
    if data_table.pkg_name == nil then
        data_table.pkg_name = pkg_name
    end

    if data_table.mod_name == nil then
        data_table.mod_name = unilib.pkg_setup_table[pkg_name]
    end

    -- Update global variables
    unilib.pkg_table[pkg_name] = data_table

    -- Check that the source mod is described in imported.csv
    for _, this_mod_name in ipairs(unilib.split_string_by_whitespace(data_table.mod_name, true)) do

        if this_mod_name ~= "" and
                unilib.imported_mod_table[this_mod_name] == nil then

            unilib.show_error(
                column .. "Package specifies a source mod that is not recognised (does not" ..
                        " appear in unilib's ../csv/mods/imported.csv file). To resolve this" ..
                        "  error, add the source mod to that CSV file",
                this_mod_name,
                pkg_name
            )

            unilib.pkg_excluded_table[pkg_name] = true

            return false

        end

    end

    -- Check (in)compatible mods
    for _, this_mod_name in ipairs(unilib.convert_to_list(data_table.mod_excludes)) do

        if minetest.get_modpath(this_mod_name) then

            unilib.show_error(
                column .. "Package excludes a mod that has already been loaded. To resolve this" ..
                        " error,remove the package from the remix, or disable the excluded mod",
                this_mod_name,
                pkg_name
            )

            unilib.pkg_excluded_table[pkg_name] = true

            return false

        end

    end

    for _, this_mod_name in ipairs(unilib.convert_to_list(data_table.mod_depends)) do

        if not minetest.get_modpath(this_mod_name) then

            unilib.show_error(
                column .. "Package requires a mod that has not been loaded. Make sure the mod is" ..
                        " enabled, and make sure it has been added to unilib's mod.conf file",
                this_mod_name,
                pkg_name
            )

            -- (The empty list represents a package excluded by a mod, not by other packages)
            unilib.pkg_excluded_table[pkg_name] = true

            return false

        end

    end

    local main_list = unilib.convert_to_list(data_table.mod_at_least_one)
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

                    if minetest.get_modpath(this_mod_name) then

                        at_least_one_flag = true
                        break

                    end

                end

                if not at_least_one_flag then

                    unilib.show_error(
                        column .. "Package requires at least one mod from a list, none of which" ..
                                " have been loaded. Make sure that at least one of the mods is" ..
                                " enabled and has been added to unilib's mod.conf file",
                        data_table.mod_at_least_one,
                        pkg_name
                    )

                    -- (The empty list represents a package excluded by a mod, not by other
                    --      packages)
                    unilib.pkg_excluded_table[pkg_name] = true
                    return false

                end

            end

        end

    end

    for _, this_mod_name in ipairs(unilib.convert_to_list(data_table.mod_optional)) do

        if not minetest.get_modpath(this_mod_name) then

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
        for _, this_pkg_name in ipairs(unilib.convert_to_list(data_table.excludes)) do

            -- (This double check ensures that when packages A and B both exclude the other, the
            --      first one initialised is still executable)
            if unilib.pkg_table[this_pkg_name] ~= nil and
                    unilib.pkg_excluded_table[this_pkg_name] == nil then

                unilib.pkg_excluded_table[pkg_name] = true
                show_debug(column .. "Package incompatible", pkg_name, this_pkg_name)
                return false

            end

        end

    end

    -- Package initialised
    return true

end

local function pkg_exec(pkg_name, level)

    -- A function to handle a call to a package's .exec() function
    -- If the package is already marked as non-executable, nothing happens
    -- The package may be marked non-executable at any point. If so, its .exec() function is not
    --      called
    --
    -- Return true if the package is executed (or if it has already been executed), false if the
    --      package is not executable

    local data_table = unilib.pkg_table[pkg_name]
    local column = get_column(level)

    if unilib.show_pkg_exec_flag and unilib.show_msg_flag then
        unilib.show_msg(column .. "Executing package", pkg_name)
    end

    -- Basic checks
    if unilib.pkg_loaded_table[pkg_name] == nil then

        show_debug(column .. "Package not loaded, so not executed", pkg_name)
        return false

    elseif unilib.pkg_table[pkg_name] == nil then

        show_debug(column .. "Package not initialised, so not executed", pkg_name)
        return false

    elseif unilib.pkg_excluded_table[pkg_name] ~= nil then

        show_debug(column .. "Package already marked non-executable", pkg_name)
        return false

    elseif check_table[pkg_name] == nil then

        show_debug(column .. "Package already processed for execution", pkg_name)
        return true

    elseif unilib.pkg_table[pkg_name]["adult_flag"] == true and
            not unilib.enable_adult_content_flag then

        show_debug(column .. "Package not executed because of age-inappropriate content", pkg_name)
        return false

    end

    -- Check that this package is (in principle) executable
    -- data_table.mod_name might include a single or multiple source mods, separated by whitespace
    --      (or an empty string when the source mod is not known)
    -- If the replace mode for the first mod is "defer", and if that mod has been loaded, then the
    --      package is non-executable
    -- If the replace mode for any subsequent mods is "defer", then the package is still
    --      executable; it's up to the package code itself to check the replace modes for those mods
    local mod_list = unilib.split_string_by_whitespace(data_table.mod_name, true)
    if mod_list[1] ~= nil and
            mod_list[1] ~= "" and
            unilib.imported_mod_table[mod_list[1]]["replace_mode"] == "defer" and
            minetest.get_modpath(mod_list[1]) then

        unilib.pkg_excluded_table[pkg_name] = true
        show_debug(
            column .. "Package not executable due to the its source mod (which Minetest has" ..
                    " loaded) having the replace mode \"defer\"",
            pkg_name,
            mod_list[1]
        )

        return false

    end

    -- Guard against the possibility of any package declaring itself as a dependency by updating the
    --      check table now
    check_table[pkg_name] = nil

    -- Process for execution any dependent packages. If they are non-executable, then this package
    --      is also non-executable
    for _, this_pkg_name in ipairs(unilib.convert_to_list(data_table.depends)) do

        -- If a hard dependency has not been loaded/initialised (is not mentioned in the remix),
        --      and if required to do so, try to force-load it
        if not unilib.pkg_table[this_pkg_name] and
                fail_table[this_pkg_name] == nil and
                unilib.force_load_dependent_pkg_flag then

            if not pkg_load(this_pkg_name, (level + 1)) or
                    not pkg_init(this_pkg_name, (level + 1)) then

                fail_table[this_pkg_name] = ""
                unilib.pkg_excluded_table[pkg_name] = true
                show_debug(
                    column .. "Package has hard dependency which could not be force-loaded",
                    pkg_name,
                    this_pkg_name
                )

                return false

            end

        end

        -- Try to execute the hard dependency
        if pkg_exec(this_pkg_name, (level + 1)) == false then

            unilib.pkg_excluded_table[pkg_name] = true
            show_debug(column .. "Package has missing dependency", pkg_name, this_pkg_name)
            return false

        end

    end

    -- Process for execution any dependent packages, at least one of which must have been loaded. If
    --      all specified packages are non-executable, then this package is also non-executable
    local main_list = unilib.convert_to_list(data_table.at_least_one)
    if #main_list > 0 then

        -- .at_least_one can be a simple list of package names, i.e. {a, b, c}, in which case we
        --      require at least one of the packages to be available
        -- Alternatively, it can be a list of mini-lists, e.g. { {a, b, c}, {d, e, f} }, in which
        --      case we require at least one package from each mini-list to be available
        if type(main_list[1]) ~= "table" then

            -- To keep the code simple, convert a simple list into a list of mini-lists
            main_list = { main_list }

        end

        for _, mini_list in ipairs(main_list) do

            -- Ignore any value that's not a mini-list, e.g. "d" in { {a, b, c}, d }
            if type(mini_list) == "table" then

                local at_least_one_flag = false
                for _, this_pkg_name in ipairs(mini_list) do

                    -- If a minimal dependency has not been loaded/initialised (is not mentioned in
                    --      the remix), and if required to do so, try to force-load it
                    if not unilib.pkg_table[this_pkg_name] and
                            fail_table[this_pkg_name] == nil and
                            unilib.force_load_minimal_pkg_flag then

                        if not pkg_load(this_pkg_name, (level + 1)) or
                                not pkg_init(this_pkg_name, (level + 1)) then

                            fail_table[this_pkg_name] = ""
                            unilib.pkg_excluded_table[pkg_name] = true
                            show_debug(
                                column .. "Package has minimal dependency which could not be" ..
                                        " force-loaded",
                                pkg_name,
                                this_pkg_name
                            )

                            return false

                        end

                    end

                    -- Try to execute the minimal dependency
                    if pkg_exec(this_pkg_name, (level + 1)) == true then
                        at_least_one_flag = true
                    end

                end

                if not at_least_one_flag then

                    unilib.pkg_excluded_table[pkg_name] = true
                    show_debug(
                        column .. "Package has missing minimal dependencies",
                        pkg_name,
                        unilib.convert_to_string(data_table.at_least_one)
                    )

                    return false

                end

            end

        end

    end

    -- Process for execution any optional packages. This package's .exec() function check for itself
    --      that any optional packages were actually executed
    for _, this_pkg_name in ipairs(unilib.convert_to_list(data_table.optional)) do

        -- If a soft dependency has not been loaded/initialised (is not mentioned in the remix),
        --      and if required to do so, try to force-load it
        if not unilib.pkg_table[this_pkg_name] and
                fail_table[this_pkg_name] == nil and
                unilib.force_load_optional_pkg_flag then

            if not pkg_load(this_pkg_name, (level + 1)) or
                    not pkg_init(this_pkg_name, (level + 1)) then

                fail_table[this_pkg_name] = ""
                unilib.pkg_excluded_table[pkg_name] = true
                show_debug(
                    column .. "Package has soft dependency which could not be force-loaded",
                    pkg_name,
                    this_pkg_name
                )

                return false

            end

        end

        -- Try to execute the soft dependency
        pkg_exec(this_pkg_name, (level + 1))

    end

    -- Process for execution any suggested packages. This package's .exec() function check for
    --      itself that any suggested packages were actually executed
    for _, this_pkg_name in ipairs(unilib.convert_to_list(data_table.suggested)) do

        -- If a suggested dependency has not been loaded/initialised (is not mentioned in the
        --      remix), and if required to do so, try to force-load it
        if not unilib.pkg_table[this_pkg_name] and
                fail_table[this_pkg_name] == nil and
                unilib.force_load_suggested_pkg_flag then

            if not pkg_load(this_pkg_name, (level + 1)) or
                    not pkg_init(this_pkg_name, (level + 1)) then

                fail_table[this_pkg_name] = ""
                unilib.pkg_excluded_table[pkg_name] = true
                show_debug(
                    column .. "Package has suggested dependency which could not be force-loaded",
                    pkg_name,
                    this_pkg_name
                )

                return false

            end

        end

        -- Try to execute the suggested dependency
        pkg_exec(this_pkg_name, (level + 1))

    end

    -- From this point on, the package is considered "executed" (even if it's .exec() function
    --      doesn't exist)
    table.insert(exec_list, pkg_name)

    -- Call the .exec() function, if it exists
    local ns_table = unilib.pkg[pkg_name]
    if ns_table.exec ~= nil then

        unilib.current_pkg = pkg_name
        ns_table.exec()
        unilib.current_pkg = nil

        if unilib.show_pkg_exec_flag and unilib.show_msg_flag then

            -- (Extra space so the text lines up with "Executing package " above)
            unilib.show_msg(column ..  "Executed package", pkg_name)

        end

    elseif unilib.show_pkg_exec_flag and unilib.show_msg_flag then

        unilib.show_msg(column ..  "Executed package (no .exec() to call)", pkg_name)

    end

    -- Update global variables. The false value means that we have not tried to call the package's
    --      .post() function yet
    unilib.pkg_executed_table[pkg_name] = false

    return true

end

local function adjust_chain_list(chain_list, new_pkg_name, dependency_mode)

    -- Called by check_dependencies()
    -- Creates a new copy of the package chain, adding the most recent package to it

    local new_list = {}
    for _, mini_list in ipairs(chain_list) do
        table.insert(new_list, mini_list)
    end

    table.insert(new_list, { new_pkg_name, dependency_mode })

    return new_list

end

local function adjust_chain_check_table(chain_check_table, new_pkg_name)

    -- Called by check_dependencies()
    -- Creates a new copy of the package chain's check table (which checks for duplicate packages
    --      in the chain), adding the most recent package to it

    local new_table = {}
    for k, v in pairs(chain_check_table) do
        new_table[k] = v
    end

    new_table[new_pkg_name] = true

    return new_table

end

local function compile_chain_output(mini_list)

    -- Called by display_formatted_dependency_list(), after all calls to check_dependencies() are
    --      complete
    -- Formats two strings representing a single missing dependency, ready for display
    --
    -- Args:
    --      mini_list (list): A list in the form
    --          [remix_name, recursion_level, recursion_result, chain_list], as described below

    local msg1 = "   [" .. mini_list[1] .. "]"
    if mini_list[3] == "missing" then
        msg1 = msg1 .. " missing dependency"
    elseif mini_list[3] == "default" then
        msg1 = msg1 .. " missing dependency (with no dependencies of its own)"
    elseif mini_list[3] == "limit" then
        msg1 = msg1 .. " recursion limit reached"
    else
        msg1 = msg1 .. " package recurs in dependency chain"
    end

    local msg2 = "      "
    local count = 0
    for _, mini_mini_list in ipairs(mini_list[4]) do

        count = count + 1
        if count > 1 then
            msg2 = msg2 .. " > "
        end

        if mini_mini_list[2] == "depends" then
            msg2 = msg2 .. "[d] "
        elseif mini_mini_list[2] == "optional" then
            msg2 = msg2 .. "[o] "
        elseif mini_mini_list[2] == "at_least_one" then
            msg2 = msg2 .. "[a] "
        elseif mini_mini_list[2] == "suggested" then
            msg2 = msg2 .. "[s] "
        end

        msg2 = msg2 .. mini_mini_list[1]

    end

    return msg1, msg2

end

local function check_dependencies(
    remix_name, orig_pkg_name, this_pkg_name, recursion_level, chain_list, chain_check_table,
    remix_check_table, output_list
)
    -- A function, called by analyse_remix() and then by itself recursively, to compare the explicit
    --      list of packages in a remix, with all dependencies of those packages, so that any
    --      missing dependencies can be added to "output_list", and then displayed by the original
    --      calling code
    --
    -- "output_list" is a list of mini-lists. Each mini-list represents a package that is explicitly
    --      mentioned in the remix, and a chain of dependent packages, with each package in the
    --      chain dependent on the previous one
    -- When recursion ends, a new mini-list is added to "output_list". Recursion ends when no
    --      further information is needed about the package that is currently the last one in the
    --      chain, "this_pkg_name"
    -- Each mini-list in "output_list" is in the form
    --      [remix_name, recursion_level, recursion_result, chain_list]
    --
    -- ...in which:
    --      - remix_name: The name of the remix being checked (e.g. "mtgame")
    --      - recursion_level: The level of recursion, with the initial call to this function having
    --          the level 0
    --      - recursion_result: A string representing the reason for the end of recursion: "default"
    --          if the final package in the chain has no dependencies, "missing" if the final #
    --          package has a dependency not explicitly mentioned in the remix, "duplicate" if the
    --          final package has a dependency already added to the chain, "limit" if the recursion
    --          limit was reached
    --      - chain_list: A chain of package dependencies. A list of mini-lists, each in the form
    --          [pkg_name, dependency_mode]. The first item in the list represents a package
    --          explicitly mentioned in the remix (corresponding to the argument "orig_pkg_name").
    --          Each subsequent item represents a package on which the previous package depends.
    --          "dependency_mode" is one of the following strings: "orig" (for the first package
    --          in the chain), "depends", "optional", "at_least_one", "suggested"
    --
    -- Note that the calling code below does one set of recursion for every remix mentioned in
    --      unilib.remix_set; a different "remix_check_table" applies for each remix (but
    --      "output_list" is shared between all remixes)
    --
    -- Args:
    --      remix_name (str): The name of the remix being checked (e.g. "mtgame")
    --      orig_pkg_name (str): The name of a package explicitly mentioned in that remix, e.g.
    --          "stone_ordinary"
    --      this_pkg_name (str): The name of the package whose dependencies are to be checked in
    --          this function call. "this_pkg_name" is a dependency of the last item in
    --          "chain_list"
    --      recursion_level (int): The level of recursion, with the first call to this function
    --          using the value 0
    --      chain_list (list): A chain of packages dependencies, as described above
    --      chain_check_table (table): A table of package names, one for each package represented
    --          in "chain_list". The keys are package names, the corresponding values are true
    --      remix_check_table (table): A table of package names, including all packages that are
    --          explicitly mentioned in the remix, as well as all packages that have already been
    --          checked via a call to this function. The keys are package names, the corresponding
    --          values are the four values used above: "depends", "optional", "at_least_one",
    --          "suggested"
    --      output_list (list): The output to display when recursion is complete, as described above
    --
    -- Return values:
    --      The updated "remix_check_table" and "output_list"

    local update_flag = false

    -- If the package "this_pkg_name" has been loaded, check for its dependencies
    local data_table = unilib.pkg_table[this_pkg_name]
    if data_table ~= nil then

        -- Hard dependencies
        for _, other_pkg_name in ipairs(unilib.convert_to_list(data_table["depends"])) do

            local update_flag = true

            if remix_check_table[other_pkg_name] == "optional" or
                    remix_check_table[other_pkg_name] == "suggested" then

                -- This package was previously handled as a soft dependency, but now handle it as a
                --      hard dependency
                remix_check_table[other_pkg_name] = nil

            end

            if remix_check_table[other_pkg_name] ~= nil or
                    chain_check_table[other_pkg_name] ~= nil then

                -- The "other_pkg_name" package has already been handled, so we end recursion here
                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "duplicate",
                        chain_list,
                    }
                )

            elseif recursion_level >= recursion_limit then

                -- Recursion limit reached
                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "limit",
                        adjust_chain_list(chain_list, other_pkg_name, "depends"),
                    }
                )

            else

                -- This hard dependency is not mentioned in the remix, but should be
                remix_check_table[other_pkg_name] = "depends"

                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "missing",
                        adjust_chain_list(chain_list, other_pkg_name, "depends"),
                    }
                )

                if not unilib.show_dependency_hard_limit_flag then

                    -- Add this package to the chain, and continue recursion
                    remix_check_table, output_list = check_dependencies(
                        remix_name,
                        orig_pkg_name,
                        other_pkg_name,
                        recursion_level + 1,
                        adjust_chain_list(chain_list, other_pkg_name, "depends"),
                        adjust_chain_check_table(chain_check_table, other_pkg_name),
                        remix_check_table,
                        output_list
                    )

                end

            end

        end

        -- Minimal dependencies
        local main_list = unilib.convert_to_list(data_table["at_least_one"])
        if #main_list > 0 then

            local update_flag = true

            -- .at_least_one can be a simple list of package names, i.e. {a, b, c}, in which
            --      case we require at least one of the packages to be available
            -- Alternatively, it can be a list of mini-lists, e.g. { {a, b, c}, {d, e, f} }, in
            --      which case we require at least one package from each mini-list to be
            --      available
            if type(main_list[1]) ~= "table" then

                -- To keep the code below simple, convert a simple list into a list of mini-lists
                main_list = { main_list }

            end

            for _, mini_list in ipairs(main_list) do

                -- Ignore any value that's not a mini-list, e.g. { {a, b, c}, d }
                if type(mini_list) == "table" then

                    for _, other_pkg_name in ipairs(mini_list) do

                        if remix_check_table[other_pkg_name] == "optional" or
                                remix_check_table[other_pkg_name] == "suggested" then

                            -- This package was previously handled as a soft dependency, but now
                            --      handle it as a hard dependency
                            remix_check_table[other_pkg_name] = nil

                        end

                        if remix_check_table[other_pkg_name] ~= nil or
                                chain_check_table[other_pkg_name] ~= nil then

                            -- The "other_pkg_name" package has already been handled, so we end
                            --      recursion here
                            table.insert(
                                output_list,
                                {
                                    remix_name,
                                    recursion_level,
                                    "duplicate",
                                    chain_list,
                                }
                            )

                        elseif recursion_level >= recursion_limit then

                            -- Recursion limit reached
                            table.insert(
                                output_list,
                                {
                                    remix_name,
                                    recursion_level,
                                    "limit",
                                    adjust_chain_list(chain_list, other_pkg_name, "at_least_one"),
                                }
                            )

                        else

                            -- This minimal dependency is not mentioned in the remix, but should be
                            remix_check_table[other_pkg_name] = "at_least_one"

                            table.insert(
                                output_list,
                                {
                                    remix_name,
                                    recursion_level,
                                    "missing",
                                    adjust_chain_list(chain_list, other_pkg_name, "at_least_one"),
                                }
                            )

                            if not unilib.show_dependency_soft_limit_flag then

                                -- Add this package to the chain, and continue recursion
                            remix_check_table, output_list = check_dependencies(
                                    remix_name,
                                    orig_pkg_name,
                                    other_pkg_name,
                                    recursion_level + 1,
                                    adjust_chain_list(chain_list, other_pkg_name, "at_least_one"),
                                    adjust_chain_check_table(chain_check_table, other_pkg_name),
                                    remix_check_table,
                                    output_list
                                )

                            end

                        end

                    end

                end

            end

        end

        -- Optional dependencies
        for _, other_pkg_name in ipairs(unilib.convert_to_list(data_table["optional"])) do

            local update_flag = true

            if remix_check_table[other_pkg_name] ~= nil or
                    chain_check_table[other_pkg_name] ~= nil then

                -- The "other_pkg_name" package has already been handled, so we end recursion here
                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "duplicate",
                        chain_list,
                    }
                )

            elseif recursion_level >= recursion_limit then

                -- Recursion limit reached
                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "limit",
                        adjust_chain_list(chain_list, other_pkg_name, "optional"),
                    }
                )

            else

                -- This optional dependency is not mentioned in the remix, but should be
                remix_check_table[other_pkg_name] = "optional"

                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "missing",
                        adjust_chain_list(chain_list, other_pkg_name, "optional"),
                    }
                )

                if not unilib.show_dependency_soft_limit_flag then

                    -- Add this package to the chain, and continue recursion
                    remix_check_table, output_list = check_dependencies(
                        remix_name,
                        orig_pkg_name,
                        other_pkg_name,
                        recursion_level + 1,
                        adjust_chain_list(chain_list, other_pkg_name, "optional"),
                        adjust_chain_check_table(chain_check_table, other_pkg_name),
                        remix_check_table,
                        output_list
                    )

                end

            end

        end

        -- Suggested dependencies
        for _, other_pkg_name in ipairs(unilib.convert_to_list(data_table["suggested"])) do

            local update_flag = true

            if remix_check_table[other_pkg_name] ~= nil or
                    chain_check_table[other_pkg_name] ~= nil then

                -- The "other_pkg_name" package has already been handled, so we end recursion here
                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "duplicate",
                        chain_list,
                    }
                )

            elseif chain_check_table[other_pkg_name] ~= nil then

                -- The "other_pkg_name" package has already been added to the package chain; to
                --      prevent infinite recursion, we must end recursion here
                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "duplicate",
                        chain_list,
                    }
                )

            elseif recursion_level >= recursion_limit then

                -- Recursion limit reached
                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "limit",
                        adjust_chain_list(chain_list, other_pkg_name, "suggested"),
                    }
                )

            else

                -- This suggested dependency is not mentioned in the remix, but should be
                remix_check_table[other_pkg_name] = "suggested"

                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "missing",
                        adjust_chain_list(chain_list, other_pkg_name, "suggested"),
                    }
                )

                if not unilib.show_dependency_soft_limit_flag then

                    -- Add this package to the chain, and continue recursion
                    remix_check_table, output_list = check_dependencies(
                        remix_name,
                        orig_pkg_name,
                        other_pkg_name,
                        recursion_level + 1,
                        adjust_chain_list(chain_list, other_pkg_name, "suggested"),
                        adjust_chain_check_table(chain_check_table, other_pkg_name),
                        remix_check_table,
                        output_list
                    )

                end

            end

        end

    end

    if not update_flag and remix_check_table[this_pkg_name] == nil then

        -- This package has no further dependencies, is not explicitly mentioned in the remix, and
        --      has not already been handled during the recursion process
        table.insert(
            output_list,
            {
                remix_name,
                recursion_level,
                "default",
                chain_list,
            }
        )

    end

    return remix_check_table, output_list

end

local function display_list_section(msg, pkg_list)

    -- Called by display_simple_dependency_list() to display one of the four sections of the
    --      package list

    unilib.show_msg(msg)

    table.sort(pkg_list)
    for _, pkg_name in ipairs(pkg_list) do

        if unilib.pkg_table[pkg_name] == nil or
                unilib.pkg_table[pkg_name]["mod_name"] == nil then

            unilib.show_msg("      " .. pkg_name .. "|?")

        else

            unilib.show_msg(
                "      " .. pkg_name .. "|" .. unilib.pkg_table[pkg_name]["mod_name"]
            )

        end

    end

end

local function display_simple_dependency_list(output_list, main_check_table, first_order_flag)

    -- Called analyse_remix(), to display a simple list of package dependencies that are not
    --      specified in one or more remixes
    --
    -- Args:
    --      output_list (list): The list described in check_dependencies()
    --      main_check_table (table): A table whose keys are all packages specified in one or more
    --          remixes
    --      first_order_flag (bool): True to display only first-order dependencies (e.g. the package
    --          b, in a > b > c > d > e); false to display all dependencies (e.g. everything except
    --          a in a > b > c > d > e)

    local depends_table = {}
    local optional_table = {}
    local at_least_one_table = {}
    local suggested_table = {}

    -- mini_list in the form [remix_name, recursion_level, recursion_result, chain_list]
    for _, mini_list in ipairs(output_list) do

        if mini_list[3] == "missing" or mini_list[3] == "default" then

            local chain_list = mini_list[4]
            if chain_list[2] ~= nil then

                -- this_mini_list in the form [pkg_name, dependency_mode]
                local stop = 2
                if not first_order_flag then
                    stop = #chain_list
                end

                for i = 2, stop do

                    local this_mini_list = chain_list[i]

                    if main_check_table[this_mini_list[1]] == nil then

                        -- If a single package is both a hard and soft dependency to some other
                        --      package, then the hard dependency takes priority in the displayed
                        --      output
                        if this_mini_list[2] == "depends" then

                            depends_table[this_mini_list[1]] = true
                            at_least_one_table[this_mini_list[1]] = nil
                            optional_table[this_mini_list[1]] = nil
                            suggested_table[this_mini_list[1]] = nil

                        elseif this_mini_list[2] == "at_least_one" then

                            at_least_one_table[this_mini_list[1]] = true
                            optional_table[this_mini_list[1]] = nil
                            suggested_table[this_mini_list[1]] = nil

                        elseif this_mini_list[2] == "optional" then

                            optional_table[this_mini_list[1]] = true
                            suggested_table[this_mini_list[1]] = nil

                        elseif this_mini_list[2] == "suggested" then

                            suggested_table[this_mini_list[1]] = true

                        end

                    end

                end

            end

        end

    end

    unilib.show_msg("Simple list of dependent package(s) missing in remix(es)")

    if first_order_flag then
        unilib.show_msg("(First-order dependencies, e.g. b in a > b > c > d > e)")
    else
        unilib.show_msg("(All dependencies, e.g. everything but a in a > b > c > d > e)")
    end

    local depends_list = unilib.sort_table(depends_table)
    local at_least_one_list = unilib.sort_table(at_least_one_table)
    local optional_list = unilib.sort_table(optional_table)
    local suggested_list = unilib.sort_table(suggested_table)

    if #depends_list > 0 then
        display_list_section("   .depends", depends_list)
    end

    if #at_least_one_list > 0 then
        display_list_section("   .at_least_one", at_least_one_list)
    end

    if #optional_list > 0 then
        display_list_section("   .optional", optional_list)
    end

    if #suggested_list > 0 then
        display_list_section("   .suggested", suggested_list)
    end

    if #depends_list == 0 and
            #optional_list == 0 and
            #at_least_one_list == 0 and
            #suggested_list == 0 then
        display_list_section("   [none found]", suggested_list)
    end

    unilib.show_msg("End of list")

end

local function display_formatted_dependency_list(output_list, not_loaded_list)

    -- Called by analyse_remix(), to display a simple list of package dependencies that are not
    --      specified in one or more remixes
    --
    -- Args:
    --      output_list (list): The list described in check_dependencies()
    --      not_loaded_list (list): A list of package names which have not been loaded (for
    --          display in a separate list)

    unilib.show_msg(
        "Detailed list of dependent package(s) missing in remix(es) (d = hard dependency," ..
                " o = optional, a = at least one, s = suggested)"
    )

    local count = 0
    for _, mini_list in ipairs(output_list) do

        -- (We don't need to display infinite recursions in the package dependency chain,
        --      e.g. a > b > c > d > e > c > d > e... )
        if mini_list[3] ~= "duplicate" then

            local msg1, msg2 = compile_chain_output(mini_list)
            unilib.show_msg(msg1)
            unilib.show_msg(msg2)
            count = count + 1

        end

    end

    unilib.show_msg(string.format("End of list (missing dependencies found: %d)", count))

    if not unilib.is_table_empty(not_loaded_list) then

        unilib.show_msg("Unloaded packages whose dependencies were not checked:")
        for _, pkg_name in ipairs(not_loaded_list) do
            unilib.show_msg("   " .. pkg_name)
        end

        unilib.show_msg(string.format("End of list (unchecked packages: %d)", #not_loaded_list))

    end

end

local function analyse_remix(remix_list)

    -- Called by the code below, to analyse one or more remixes for their package dependencies
    -- If more than one remix is specifie, then it is treated as though it were a single remix
    --      (and a combined list of package dependencies is displayed)

    local output_list = {}
    local not_loaded_list = {}
    local main_check_table = {}

    for _, remix_name in ipairs(remix_list) do

        local check_list = {}
        local check_table = {}

        -- Compile a table of packages that are explicitly mentioned by the remix
        for _, pkg_name in ipairs(unilib.remix_pkg_table[remix_name]) do

            -- (We can't check the dependencies of packages that were not loaded, so they are
            --      displayed in a separate list)
            if unilib.pkg_table[pkg_name] ~= nil then

                table.insert(check_list, pkg_name)
                check_table[pkg_name] = "default"
                main_check_table[pkg_name] = true

            else

                table.insert(not_loaded_list, pkg_name)

            end

        end

        -- Recursively check the dependencies for each of those packages, making a note of any which
        --      are not explicitly mentioned elsewhere in the remix
        for _, pkg_name in ipairs(check_list) do

            check_table, output_list = check_dependencies(
                remix_name,
                pkg_name,
                pkg_name,
                0,
                { {pkg_name, "orig"} },
                { pkg_name = true },
                check_table,
                output_list
            )

        end

    end

    if not unilib.is_table_empty(output_list) then

        unilib.show_msg(
            "Package dependency analysis for remixes: " .. unilib.convert_to_string(remix_list)
        )

        if unilib.show_dependency_simple_flag then

            -- Display simple lists of dependencies that are not explicitly mentioned by the remix
            display_simple_dependency_list(output_list, main_check_table, true)
            display_simple_dependency_list(output_list, main_check_table, false)

        end

        if unilib.show_dependency_detailed_flag then

            -- Display formatted list of dependencies that are not explicitly mentioned by the remix
            display_formatted_dependency_list(output_list, not_loaded_list)

        end

    else

        unilib.show_msg(
            "Checked package dependencies; all of them are specified by remixes: " ..
            unilib.convert_to_string(remix_list)
        )

    end

end

---------------------------------------------------------------------------------------------------
-- Load package files
---------------------------------------------------------------------------------------------------

-- unilib content is fully modularised
-- Each module is called a "package", and consists of a single .lua file. The package name is the
--      same as the name of the file. A single package might provide several related nodes (for
--      example, default stone and default cobble are provided by a single package, named
--      "stone_ordinary")
-- Load each package and check that it specifies its own namespace; if there are no problems, add
--      the package to global variables
for _, pkg_name in ipairs(unilib.pkg_setup_list) do

    -- 0 represents the lowest level of recursion
    if not pkg_load(pkg_name, 0) then
        fail_table[pkg_load] = ""
    end

end

---------------------------------------------------------------------------------------------------
-- Execute .init() functions
---------------------------------------------------------------------------------------------------

-- Call each package's .init() function, in the same order specified by the remix
-- The function returns a table of metadata, used to update the global variable unilib.pkg_table
--      (see the comments in global.lua for the table format)
-- Some packages may not specify an .init() function, in which case, we update unilib.pkg_table
--      using values supplied by the remix
-- Besides returning metadata, it is permitted for the .init() function to execute other code; but
--      this code must not affect any other package
-- If the package is incompatible with other mods, or incompatible with other loaded packages, it
--      is marked as non-executable
for _, pkg_name in ipairs(unilib.pkg_loaded_list) do

    -- 0 represents the lowest level of recursion
    if not pkg_init(pkg_name, 0) then
        fail_table[pkg_load] = ""
    end

end

---------------------------------------------------------------------------------------------------
-- Execute .exec() functions
---------------------------------------------------------------------------------------------------

-- Call each package's .exec() function (if one is specified). The order in which packages are
--      executed varies, depending on each package's dependencies
-- The .exec() function contains the main body of code for the package

-- The .init() and .post() functions are called in a fixed order, but the order of calling of
--      .exec() functions varies. Dependent packages are executed before any depending packages
for _, pkg_name in ipairs(unilib.pkg_loaded_list) do

    local data_table = unilib.pkg_table[pkg_name]

    check_table[pkg_name] = ""

    if data_table.first then
        table.insert(first_list, pkg_name)
    elseif data_table.last then
        table.insert(last_list, pkg_name)
    else
        table.insert(middle_list, pkg_name)
    end

end

-- Now call each package's .exec() function, in the correct order. The second arguments shows the
--      level of recursion
for _, pkg_name in ipairs(first_list) do
    pkg_exec(pkg_name, 0)
end

for _, pkg_name in ipairs(middle_list) do
    pkg_exec(pkg_name, 0)
end

for _, pkg_name in ipairs(last_list) do
    pkg_exec(pkg_name, 0)
end

---------------------------------------------------------------------------------------------------
-- Consolidation code
---------------------------------------------------------------------------------------------------

-- After all package .exec() functions have been called, but before .post() functions have been
--      called, we do some consolidation

-- Having defined both liquids and empty buckets, we now set up liquids in buckets, so those items
--      are ready for use by the .post() functions
for bucket_type, _ in pairs(unilib.generic_bucket_table) do

    for liquid_name, _ in pairs(unilib.generic_liquid_table) do

        unilib.register_liquid_in_bucket({
            bucket_type = bucket_type,
            liquid_name = liquid_name,
        })

    end

end

-- Prune the lists of fishing catches, to remove any items which don't exist (or which don't match
--      a biome/fishing rod that exists)
unilib.fishing_fish_list = unilib.prune_fishing_list(unilib.fishing_fish_list)
unilib.fishing_bonus_list = unilib.prune_fishing_list(unilib.fishing_bonus_list)
unilib.fishing_junk_list = unilib.prune_fishing_list(unilib.fishing_junk_list)

-- Call advtrains to create any requested train platforms (adapted from underch/stone.lua)
if unilib.advtrains_update_flag then

    for part_name, data_table in pairs(unilib.stone_table) do

        if data_table.platform_list ~= nil then

            for _, full_name in ipairs(data_table.platform_list) do
                advtrains.register_platform("unilib", full_name)
            end

        end

    end

end

-- Call technic to create any requested grinder recipes (adapted from gravelcraft/init.lua)
if unilib.technic_update_flag then

    for part_name, data_table in pairs(unilib.stone_table) do

        if data_table.grinder_flag == true then

            local smooth_name = "unilib:stone_" .. part_name
            local cobble_name = "unilib:stone_" .. part_name .. "_cobble"
            local compressed_name = "unilib:stone_" .. part_name .. "_cobble_compressed"

            if minetest.registered_nodes[smooth_name] ~= nil then

                if data_table.grinder_powder ~= nil and
                        minetest.registered_nodes[data_table.grinder_powder] ~= nil then

                    technic.register_grinder_recipe({
                        output = data_table.grinder_powder .. " " ..
                                tostring(unilib.grind_stone_ratio),
                        input = {smooth_name},
                    })

                elseif minetest.registered_nodes["unilib:stone_ordinary_powder"] ~= nil then

                    technic.register_grinder_recipe({
                        output = "unilib:stone_ordinary_powder " ..
                                tostring(unilib.grind_stone_ratio),
                        input = {smooth_name},
                    })

                end

            end

            if minetest.registered_nodes[cobble_name] ~= nil then

                if data_table.grinder_gravel ~= nil and
                        minetest.registered_nodes[data_table.grinder_gravel] ~= nil then

                    technic.register_grinder_recipe({
                        output = data_table.grinder_gravel,
                        input = {cobble_name},
                    })

                elseif minetest.registered_nodes["unilib:gravel_ordinary"] ~= nil then

                    technic.register_grinder_recipe({
                        output = "unilib:gravel_ordinary",
                        input = {cobble_name},
                    })

                end

            end

            if minetest.registered_nodes[compressed_name] ~= nil then

                if data_table.grinder_gravel ~= nil and
                        minetest.registered_nodes[data_table.grinder_gravel] ~= nil then

                    technic.register_grinder_recipe({
                        output = data_table.grinder_gravel .. " 9",
                        input = {compressed_name},
                    })

                elseif minetest.registered_nodes["unilib:gravel_ordinary"] ~= nil then

                    technic.register_grinder_recipe({
                        output = "unilib:gravel_ordinary 9",
                        input = {compressed_name},
                    })

                end

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Execute .post() functions
---------------------------------------------------------------------------------------------------

-- Call each package's .post() function (if one is specified), in the same order in which .init()
--      functions were called
-- The .post() function contains any code that must only be executed once all package .exec()
--      functions have been called

for _, pkg_name in ipairs(exec_list) do

    local ns_table = unilib.pkg[pkg_name]

    -- If this package has no .post() function, or if the package was not executed earlier, then
    --      don't try to post-execute it
    if ns_table.post ~= nil and unilib.pkg_executed_table[pkg_name] ~= nil then

        unilib.current_pkg = pkg_name
        data_table = ns_table.post()
        unilib.current_pkg = nil

        if unilib.show_pkg_post_flag and unilib.show_msg_flag then
            unilib.show_msg("Post-executed package", pkg_name)
        end

    elseif unilib.show_pkg_post_flag and unilib.show_msg_flag then

        unilib.show_msg("Post-executed package (no .post() to call)", pkg_name)

    end

end

---------------------------------------------------------------------------------------------------
-- Finalisation functions
---------------------------------------------------------------------------------------------------

-- After all package .post() functions have been called, we do some finalisation

-- Create aliases, mapping any unilib nodes/craftitems/tools which have not been created onto their
--      minetest_game equivalents
for orig_name, unilib_name in pairs(unilib.mtgame_convert_table) do

    if minetest.registered_items[unilib_name] == nil then
        minetest.register_alias(unilib_name, orig_name)
    end

end

-- Create any biomes loaded from a remix biome table (when used in a package, they usually appear
--      in the .post() function)
for _, biome_name in ipairs(unilib.biome_setup_list) do
    unilib.register_biome_from_csv(biome_name)
end

-- Create any decorations loaded from a remix decoration table (when used in a package, they usually
--      appear in the .post() function)
for _, mini_table in ipairs(unilib.deco_setup_list) do
    unilib.register_decoration_from_csv(mini_table)
end

-- Create any ores loaded from a remix ore table (when used in a package, they usually appear in the
--      .post() function)
for _, mini_table in ipairs(unilib.ore_setup_list) do
    unilib.register_ore_from_csv(mini_table)
end

-- Having divided ore distributions into their categories, we now create them in a sensible order
for _, ore_type in ipairs({"stratum", "sheet", "vein", "puff", "blob", "scatter"}) do

    for _, def_table in ipairs(unilib.ore_table[ore_type .. "_list"]) do
        unilib.register_ore_now(def_table)
    end

end

-- Update sapling growth requirements according to Minetest settings
unilib.update_sapling_growth_requirements()

-- Set up growth of crop/produce items using code imported from the farming_redo mod
unilib.register_crop_and_produce_growth()

-- Update the table of turf seeder items, unilib.turf_seeder_table, replacing items represented as
--      groups (e.g. "group:dry_grass") with actual node names (e.g. "unilib:grass_dry_1")
unilib.update_turf_seeder_items()

---------------------------------------------------------------------------------------------------
-- Optional checks
---------------------------------------------------------------------------------------------------

-- If Minetest settings allow, check the list of packages in each remix. If the remix does not also
--      specify all dependent packages (both compulsory and optional), then we can display a list of
--      affected packages
if unilib.show_dependency_simple_flag or unilib.show_dependency_detailed_flag then

    if not unilib.show_dependency_combined_flag then

        for _, remix_name in ipairs(unilib.remix_list) do
            analyse_remix( { remix_name } )
        end

    else

        analyse_remix(unilib.remix_list)

    end

end
