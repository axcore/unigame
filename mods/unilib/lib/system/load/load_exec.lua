---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- load_exec.lua
--      Execute package .exec() functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Lists of packages to be executed first, last, or in the middle
local first_list = {}
local middle_list = {}
local last_list = {}

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

local function pkg_exec(pkg_name, level)

    -- A function to handle a call to a package's .exec() function
    -- If the package is already marked as non-executable, nothing happens
    -- The package may be marked non-executable at any point. If so, its .exec() function is not
    --      called
    --
    -- Return true if the package is executed (or if it has already been executed), false if the
    --      package is not executable

    local data_table = unilib.global.pkg_table[pkg_name]
    local column = get_column(level)

    if unilib.setting.show_pkg_exec_flag and unilib.setting.show_msg_flag then
        unilib.utils.show_msg(column .. "Executing package", pkg_name)
    end

    -- Basic checks
    if unilib.global.pkg_loaded_table[pkg_name] == nil then

        show_debug(column .. "Package not loaded, so not executed", pkg_name)
        return false

    elseif unilib.global.pkg_table[pkg_name] == nil then

        show_debug(column .. "Package not initialised, so not executed", pkg_name)
        return false

    elseif unilib.global.pkg_excluded_table[pkg_name] ~= nil then

        show_debug(column .. "Package already marked non-executable", pkg_name)
        return false

    elseif unilib.load.check_table[pkg_name] == nil then

        show_debug(column .. "Package already processed for execution", pkg_name)
        return true

    elseif unilib.global.pkg_table[pkg_name]["adult_flag"] == true and
            not unilib.setting.enable_adult_content_flag then

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
    local mod_list = unilib.utils.split_string_by_whitespace(data_table.mod_name, true)
    if mod_list[1] ~= nil and
            mod_list[1] ~= "" and
            unilib.global.imported_mod_table[mod_list[1]]["replace_mode"] == "defer" and
            core.get_modpath(mod_list[1]) then

        unilib.global.pkg_excluded_table[pkg_name] = true
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
    unilib.load.check_table[pkg_name] = nil

    -- Process for execution any dependent packages. If they are non-executable, then this package
    --      is also non-executable
    for _, this_pkg_name in ipairs(unilib.utils.convert_to_list(data_table.depends)) do

        -- If a hard dependency has not been loaded/initialised (is not mentioned in the remix),
        --      and if required to do so, try to force-load it
        if not unilib.global.pkg_table[this_pkg_name] and
                unilib.load.fail_table[this_pkg_name] == nil and
                unilib.setting.force_load_dependent_pkg_flag then

            if not unilib.load.pkg_load(this_pkg_name, (level + 1)) or
                    not unilib.load.pkg_init(this_pkg_name, (level + 1)) then

                unilib.load.fail_table[this_pkg_name] = ""
                unilib.global.pkg_excluded_table[pkg_name] = true
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

            unilib.global.pkg_excluded_table[pkg_name] = true
            show_debug(column .. "Package has missing dependency", pkg_name, this_pkg_name)
            return false

        end

    end

    -- Process for execution any dependent packages, at least one of which must have been loaded. If
    --      all specified packages are non-executable, then this package is also non-executable
    local main_list = unilib.utils.convert_to_list(data_table.at_least_one)
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
                    if not unilib.global.pkg_table[this_pkg_name] and
                            unilib.load.fail_table[this_pkg_name] == nil and
                            unilib.setting.force_load_minimal_pkg_flag then

                        if not unilib.load.pkg_load(this_pkg_name, (level + 1)) or
                                not unilib.load.pkg_init(this_pkg_name, (level + 1)) then

                            unilib.load.fail_table[this_pkg_name] = ""
                            unilib.global.pkg_excluded_table[pkg_name] = true
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

                    unilib.global.pkg_excluded_table[pkg_name] = true
                    show_debug(
                        column .. "Package has missing minimal dependencies",
                        pkg_name,
                        unilib.utils.convert_to_string(data_table.at_least_one)
                    )

                    return false

                end

            end

        end

    end

    -- Process for execution any optional packages. This package's .exec() function check for itself
    --      that any optional packages were actually executed
    for _, this_pkg_name in ipairs(unilib.utils.convert_to_list(data_table.optional)) do

        -- If a soft dependency has not been loaded/initialised (is not mentioned in the remix),
        --      and if required to do so, try to force-load it
        if not unilib.global.pkg_table[this_pkg_name] and
                unilib.load.fail_table[this_pkg_name] == nil and
                unilib.setting.force_load_optional_pkg_flag then

            if not unilib.load.pkg_load(this_pkg_name, (level + 1)) or
                    not unilib.load.pkg_init(this_pkg_name, (level + 1)) then

                unilib.load.fail_table[this_pkg_name] = ""
                unilib.global.pkg_excluded_table[pkg_name] = true
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
    for _, this_pkg_name in ipairs(unilib.utils.convert_to_list(data_table.suggested)) do

        -- If a suggested dependency has not been loaded/initialised (is not mentioned in the
        --      remix), and if required to do so, try to force-load it
        if not unilib.global.pkg_table[this_pkg_name] and
                unilib.load.fail_table[this_pkg_name] == nil and
                unilib.setting.force_load_suggested_pkg_flag then

            if not unilib.load.pkg_load(this_pkg_name, (level + 1)) or
                    not unilib.load.pkg_init(this_pkg_name, (level + 1)) then

                unilib.load.fail_table[this_pkg_name] = ""
                unilib.global.pkg_excluded_table[pkg_name] = true
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
    table.insert(unilib.load.exec_list, pkg_name)

    -- Call the .exec() function, if it exists
    local ns_table = unilib.pkg[pkg_name]
    if ns_table.exec ~= nil then

        unilib.global.current_pkg = pkg_name
        ns_table.exec()
        unilib.global.current_pkg = nil

        if unilib.setting.show_pkg_exec_flag and unilib.setting.show_msg_flag then

            -- (Extra space so the text lines up with "Executing package " above)
            unilib.utils.show_msg(column ..  "Executed package", pkg_name)

        end

    elseif unilib.setting.show_pkg_exec_flag and unilib.setting.show_msg_flag then

        unilib.utils.show_msg(column ..  "Executed package (no .exec() to call)", pkg_name)

    end

    -- Update global variables. The false value means that we have not tried to call the package's
    --      .post() function yet
    unilib.global.pkg_executed_table[pkg_name] = false

    return true

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Call each package's .exec() function (if one is specified). The order in which packages are
--      executed varies, depending on each package's dependencies
-- The .exec() function contains the main body of code for the package

-- The .init() and .post() functions are called in a fixed order, but the order of calling of
--      .exec() functions varies. Dependent packages are executed before any depending packages
for _, pkg_name in ipairs(unilib.global.pkg_loaded_list) do

    local data_table = unilib.global.pkg_table[pkg_name]

    unilib.load.check_table[pkg_name] = ""

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
