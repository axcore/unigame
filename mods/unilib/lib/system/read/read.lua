---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- read.lua
--      Read CSVs
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.read = {}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- Upon a fatal error, any of the loaded files can set this flag to true, so that nothing more will
--      be read
unilib.read.fatal_error_flag = false

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Detect any expansion packs that Minetest has loaded, and update global variables
if not unilib.read.fatal_error_flag then
    dofile(unilib.core.path_mod .. "/lib/system/read/read_detect.lua")
end

-- Read standard CSV files in ../csv/mods (and equivalent locations in any expansion packs), and
--      update global variables
if not unilib.read.fatal_error_flag then
    dofile(unilib.core.path_mod .. "/lib/system/read/read_csv_source.lua")
end

if not unilib.read.fatal_error_flag then
    dofile(unilib.core.path_mod .. "/lib/system/read/read_csv_updated.lua")
end

if not unilib.read.fatal_error_flag then
    dofile(unilib.core.path_mod .. "/lib/system/read/read_csv_imported.lua")
end

if not unilib.read.fatal_error_flag then
    dofile(unilib.core.path_mod .. "/lib/system/read/read_csv_compatible.lua")
end

if not unilib.read.fatal_error_flag then
    dofile(unilib.core.path_mod .. "/lib/system/read/read_csv_external.lua")
end

if not unilib.read.fatal_error_flag then
    dofile(unilib.core.path_mod .. "/lib/system/read/read_csv_expansion.lua")
end

-- (If no remixes/packages specified, then there's nothing to parse)
if string.match(unilib.setting.init_remix_pkg_set, "%w") and
        not string.match(unilib.setting.init_remix_pkg_set, "^%s*nothing%s*$") then

    -- Parse the string containing the initial set of remix and package names, then compile an
    --      ordered list of packages to load
    if not unilib.read.fatal_error_flag then
        dofile(unilib.core.path_mod .. "/lib/system/read/read_compile.lua")
    end

    -- Register CSV files provided by individual remixes
    if not unilib.read.fatal_error_flag then
        dofile(unilib.core.path_mod .. "/lib/system/read/read_csv_remix.lua")
    end

    -- Register backup aliases for minetest_game items
    if not unilib.read.fatal_error_flag then
        dofile(unilib.core.path_mod .. "/lib/system/read/read_csv_alias.lua")
    end

end

-- Read complete
-- In case of a fatal error, reset the global variables set by this file, so that no packages are
--      imported at all
-- (Variables are listed here in the same order they're found in
--      ../lib/systems/global/global_variables.lua, with those not actually modified by the code in
--      this file commented out)
if unilib.read.fatal_error_flag then

    unilib.global.source_mod_table = {}
    unilib.global.imported_mod_table = {}
    unilib.global.compatible_mod_table = {}
    unilib.global.external_mod_table = {}
    unilib.global.expansion_mod_table = {}

    unilib.global.init_remix_pkg_list = {}
    unilib.global.init_remix_list = {}
    unilib.global.init_pkg_list = {}

    unilib.global.remix_dir_table = {}
    unilib.global.remix_pkg_table = {}
    unilib.global.remix_pkg_count_table = {}

    unilib.global.pkg_setup_list = {}
    unilib.global.pkg_setup_table = {}
--  unilib.global.pkg_loaded_list = {}
--  unilib.global.pkg_loaded_table = {}

    unilib.global.remix_biome_count_table = {}
    unilib.global.remix_deco_count_table = {}
    unilib.global.remix_ore_count_table = {}

    unilib.global.biome_csv_setup_list = {}
    unilib.global.deco_csv_setup_list = {}
    unilib.global.ore_csv_setup_list = {}

end
