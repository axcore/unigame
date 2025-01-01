---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- load_pkg.lua
--      Load package files
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

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

function unilib.load.pkg_load(pkg_name, level)

    -- A function to handle loading a package

    local column = get_column(level)

    -- Check the package file actually exists in one of the specified locations
    local pkg_path
    for _, folder_path in ipairs(unilib.global.pkg_path_list) do

        local this_path = folder_path .. pkg_name .. ".lua"
        if unilib.utils.is_file(this_path) then

            pkg_path = this_path
            break

        end

    end

    if pkg_path == nil then

        unilib.utils.show_error(column .. "Package does not exist", pkg_name, pkg_path)
        return false

    end

    -- Load the file (any syntax errors will cause a crash at this point)
    dofile(pkg_path)

    if unilib.setting.show_pkg_load_flag and unilib.setting.show_msg_flag then
        unilib.utils.show_msg(column .. "Loaded package", pkg_name)
    end

    -- Check that the package specifies its own namespace (a requirement)
    if unilib.pkg[pkg_name] == nil then

        unilib.utils.show_error(column .. "Package does not specify its own namespace", pkg_name)
        return false

    else

        -- Add this to the list of successfully loaded packages
        table.insert(unilib.global.pkg_loaded_list, pkg_name)

        if unilib.global.pkg_setup_table[pkg_name] == nil then

            -- Hard/soft dependency force-loaded after a call from pkg_exec(), so it doesn't appear
            --      in the initial list
            unilib.global.pkg_loaded_table[pkg_name] = ""
            unilib.load.check_table[pkg_name] = ""

        else

            unilib.global.pkg_loaded_table[pkg_name] = unilib.global.pkg_setup_table[pkg_name]

        end

        return true

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- unilib content is fully modularised
-- Each module is called a "package", and consists of a single .lua file. The package name is the
--      same as the name of the file. A single package might provide several related nodes (for
--      example, default stone and default cobble are provided by a single package, named
--      "stone_ordinary")
-- Load each package and check that it specifies its own namespace; if there are no problems, add
--      the package to global variables
for _, pkg_name in ipairs(unilib.global.pkg_setup_list) do

    -- 0 represents the lowest level of recursion
    if not unilib.load.pkg_load(pkg_name, 0) then
        unilib.load.fail_table[pkg_name] = ""
    end

end
