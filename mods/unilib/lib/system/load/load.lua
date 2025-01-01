---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- load.lua
--      Load packages
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

-- N.B. The unilib.pkg namespace has already been declared (in init.lua)
unilib.load = {}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- A table of packages which could not be loaded and/or initialised. When a package in this table
--      is marked as a hard or soft dependency for some other package, we don't try to load/
--      initialise it a second time
unilib.load.fail_table = {}
-- A table of packages; as each package is processed for execution, it is removed from the table (so
--      that no package is processed for execution twice)
unilib.load.check_table = {}
-- List of packages in the order they were actually executed
unilib.load.exec_list = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Load package files
if unilib.global.pkg_setup_list then
    dofile(unilib.core.path_mod .. "/lib/system/load/load_pkg.lua")
end

if unilib.global.pkg_loaded_list then

    -- Execute package .init() functions
    dofile(unilib.core.path_mod .. "/lib/system/load/load_init.lua")
    -- Execute package .exec() functions
    dofile(unilib.core.path_mod .. "/lib/system/load/load_exec.lua")

    -- Execute consolidation code before package .post() functions are called
    dofile(unilib.core.path_mod .. "/lib/system/load/load_consolidate_general.lua")
    if unilib.setting.advtrains_update_flag then
        dofile(unilib.core.path_mod .. "/lib/system/load/load_consolidate_advtrains.lua")
    end

    if unilib.setting.technic_update_flag then
        dofile(unilib.core.path_mod .. "/lib/system/load/load_consolidate_technic.lua")
    end

    -- Execute package .post() functions
    if #unilib.load.exec_list > 0 then
        dofile(unilib.core.path_mod .. "/lib/system/load/load_post.lua")
    end

end

-- Execute finalisation code (some of which is not dependent on packages)
dofile(unilib.core.path_mod .. "/lib/system/load/load_finalisation.lua")

-- Perform optional checks
if unilib.setting.show_dependency_simple_flag or unilib.setting.show_dependency_detailed_flag then
    dofile(unilib.core.path_mod .. "/lib/system/load/load_optional.lua")
end

-- Release memory in shared variables
unilib.load.fail_table = {}
unilib.load.check_table = {}
unilib.load.exec_list = {}
