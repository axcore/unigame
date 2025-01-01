---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- global_variables.lua
--      Initialise other global variables
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Global variables - mods, remixes and packages
---------------------------------------------------------------------------------------------------

-- Table of valid unilib expansion packs
-- Table in the form
--      ext_pack_table[ext_pack_name] = full_path_to_directory
-- Table populated by code in ../lib/system/read/read_detect.lua
unilib.global.ext_pack_table = {}
-- An ordered list of valid unilib expansion packs, in the order in which they were loaded
unilib.global.ext_pack_list = {}

-- List of paths to folders where packages can be found. When looking for a package with a certain
--      name, these folders are checked in order; the first package found is the one loaded
-- A list of possible locations in expansion packs
unilib.global.ext_pkg_path_list = {"/lib/packages/"}
-- A list of possible locations in unilib
unilib.global.base_pkg_path_list = {
    "/custom/packages/",
    "/lib/packages/dev/",
    "/lib/packages/",
}
-- Code in ../lib/system/read/read_detect.lua combines those two lists, expansion pack paths first,
--      followed by base paths. The last location in the list must exist; all the others are
--      optional
unilib.global.pkg_path_list = {}

-- Lists of paths to folders where remixes can be found
unilib.global.ext_remix_path_list = {"/csv/remixes/"}
unilib.global.base_remix_path_list = {"/csv/remixes/"}
unilib.global.remix_path_list = {}

-- List of paths to folders where mod information can be found
unilib.global.ext_info_path_list = {"/csv/mods/"}
unilib.global.base_info_path_list = {"/csv/mods/"}
unilib.global.info_path_list = {}

-- All source mods are listed in a CSV file (../csv/mods/source.csv), and also registered as a table
-- Table in the form
--      source_mod_table[mod_name] = data_table
-- "data_table" consists of the following compulsory key-value pairs:
--      .mod_name = The mod's name, e.g. "default"
--      .modpack_name = The name of the modpack, if any, e.g. "minetest_game"
--      .date = Date on which the mod was downloaded, before its code/media was imported. Date as a
--          string in the form "YYYYMMDD"
--      .update_date = Date on which the updated mod was downloaded, before changes were
--          incorporated into unilib. If applicable, a string in the form "YYYYMMDD"
--      .url = URL from which the mod was downloaded
--      .author = The lead author(s), e.g. "celeron55/Perttu Ahola"
--      .code = The code licence, e.g. "LGPL 2.1"
--      .media = The media licence, e.g. "CC BY-SA 3.0"
--      .notes = A brief summary of what has been imported (may contain spoilers)
--      .update_notes = A brief summary of how imported code has been updated
-- Table populated by code in ../lib/system/read/read_csv_source.lua
unilib.global.source_mod_table = {}

-- All source mods are also listed in a second CSV file (../csv/mods/imported.csv). Any mod listed
--      in these files are expected to appear in unilib's mod.conf
-- imported.csv specifies two modes for each listed mod
-- "Detect mode" is "detect" if unilib should check whether the mod has actually been loaded, or
--      "ignore" if not
-- "Replace mode" specifies what happens when both unilib and the mod are loaded, supplying
--      equivalent nodes/craftitems (e.g. "default:stone" and "unilib:stone_ordinary"). If the mode
--      is "add", the unilib node/craftitem ("unilib:stone_ordinary") is added in addition to the
--      original one ("default:stone"). If the mode is "defer", the unilib node/craftitem is not
--      added at all. If the mode is "replace", the original node/craftitem is removed, and the
--      unilib node/craftitem is used instead
-- In Minetest versions before v5.4.1, some original nodes could not be removed without causing a
--      crash. Due to that problem, the mode could be "hide" which marked the nodes as hidden rather
--      than deleting them (added to a unilib registry of hidden items, and given the
--      "not_in_creative_inventory" group). The "hide" value is still available, though probably not
--      so useful any nmore
--
-- The two modes are used to compile the following table in the form
--      imported_mod_table[mod_name] = data_table
-- "data_table" consists of the following compulsory key-value pairs:
--      .mod_name = The mod's name, e.g. "default"
--      .detect_mode = "detect" or "ignore", taken from the .csv file
--      .replace_mode = "add", "defer", "replace" or "hide", taken directly from the .csv file
--      .add_mode = "add", "defer", "replace" or "hide". This is a copy of "replace_mode", except
--          that the values "replace" and "hide" are converted to "add" if the original mod hasn't
--          actually been loaded. To guard against the possibility that the original mod hasn't been
--          loaded, packages mainly use "add_mode" rather than "replace_mode" directly
--      .hide_mode = "add", "defer" or "hide". This is a copy of "add_mode", except that the value
--          "replace" is converted to "hide". Packages can use "hide_mode" instead of "add_mode"
--          when some node/craftitem/tool cannot be removed from the game without causing an issue
--      .loaded_flag = true if the mod has actually been loaded, false if not
--      .notes = Any additional importation notes
-- Table populated by code in ../lib/system/read/read_csv_imported.lua
unilib.global.imported_mod_table = {}

-- All mods which are directly compatible with unilib (and which are not already listed in
--      source.csv) are listed in a single CSV file (../csv/mods/compatible.csv). Any mod listed in
--      this file is expected to appear in unilib's mod.conf
-- "Directly compatible" means that unilib interacts with the mod in some way, for example by
--      providing new craft recipes (or by using the mod's items in unilib craft recipes)
-- Note that unilike unilib.global.source_mod_table and unilib.global.imported_mod_table, this table
--      is for information only, and has no dependent code
-- Table in the form
--      compatible_mod_table[mod_name] = data_table
-- "data_table" consists of the following compulsory key-value pairs:
--      .mod_name = The name of the mod or modpack, e.g. "technic"
--      .modpack_name = The name of the modpack, if any, e.g. "technic" (popuplar modpacks often
--          include a mod with the same name)
--      .url = URL from which the mod(pack) can be downloaded
--      .notes = A brief summary of how unilib interacts with the mod (may contain spoilers)
-- Table populated by code in ../lib/system/read/read_csv_compatible.lua
unilib.global.compatible_mod_table = {}

-- Some items (e.g. "unilib:hardware_chainlink_steel") have been imported from another mod
--      ("basic_materials:chainlink_steel"), using code which was in turn imported from a third mod
--      ("glooptest:chainlink")
-- All mods from which code or media has been imported indirectly, via one of the mods listed in
--      source.csv or compatible.csv, are listed in a single CSV file (../csv/mods/external.csv).
--      Any mod listed in this file is expected to appear in unilib's mod.conf
-- Like unilib.global.compatible_mod_table, this table is for information only, and has no
--      dependent code
-- In most cases, when a unilib item replaces an item from another mod, it also replaces the
--      corresponding item in any external mods (e.g. "unilib:hardware_chainlink_steel" can replace
--      both "basic_materials:chainlink_steel" and "glooptest:chainlink", if they both exist. See
--      the "hardware_chainlink_steel" package for some example code)
-- Note that mods like basic_materials sometimes refer to items that no longer exist in their
--      external mods (e.g. "pipeworks:gear"), in which case the external mod has not been added to
--      external.csv
-- Table in the form
--      external_mod_table[mod_name] = data_table
-- "data_table" consists of the following compulsory key-value pairs:
--      .mod_name = The name of the mod or modpack, e.g. "glooptest"
--      .modpack_name = The name of the modpack, if any, e.g. "glooptest" (popuplar modpacks often
--          include a mod with the same name)
--      .url = URL from which the mod(pack) can be downloaded
--      .notes = Any additional notes
-- Table populated by code in ../lib/system/read/read_csv_external.lua
unilib.global.external_mod_table = {}

-- unilib expansion packs are separate mods, providing additional remixes and packages that, for one
--      reason or another, are not included in unilib itself (see the README for more details)
-- "Official" expansion packs are listed in a single CSV file (../csv/mods/expansion.csv). All
--      expansion packs, official or not, must be added to unilib's mod.conf before they can be
--      loaded
-- Table in the form
--      expansion_mod_table[mod_name] = data_table
-- "data_table" consists of the following compulsory key-value pairs:
--      .mod_name = The name of the mod, e.g. "unitest"
--      .url = URL from which the mod can be downloaded
--      .notes = Any additional notes
-- Table populated by code in ../lib/system/read/read_csv_expansion.lua
unilib.global.expansion_mod_table = {}

-- unilib content is fully modularised
-- Each module is called a "package", and consists of a single .lua file. The package name is the
--      same as the name of the file. A single package might provide several related nodes (for
--      example, default stone and default cobble are provided by a single package, named
--      "stone_ordinary")
-- A remix is a list of packages in a packages.csv, in its own folder inside ../csv/remixes. Other
--      files required by the remix (for example, additional .csv files) can be stored in the same
--      folder
-- In packages.csv, any line beginning with # is treated as a comment (and ignored). Any line
--      beginning with @ is treated as a remix name; the contents of that remix's packages.csv is
--      read immediately, before resuming reading the rest of the parent remix's packages.csv. No
--      remix's packages.csv is read more than once
-- The user can specify one or more remixes; all packages listed by the remix(es) are loaded on
--      startup, in the specified order. (Duplicate packages are not loaded multiple times)
-- (As noted above, the remix names "everything" and "nothing" are reserved)
--
-- A list of remixes and packages, compiled from the value of unilib.setting.init_remix_pkg_set
--      (above) and preserving the same order. Each item in the list is preceded by a special
--      character, "@" for remix names or "+" for package names (regardless of whether the special
--      characters were specified or omitted in unilib.setting.init_remix_pkg_set)
-- List populated by code in ../lib/system/read/read_compile.lua
unilib.global.init_remix_pkg_list = {}
-- A subset of unilib.global.init_remix_pkg_list containing only the remixes (and with the initial
--      "@" character removed)
-- List populated by code in ../lib/system/read/read_compile.lua
unilib.global.init_remix_list = {}
-- A subset of unilib.global.init_remix_pkg_list containing only the directly-specified packages
--      (and with the initial "+" character removed)
-- List populated by code in ../lib/system/read/read_compile.lua
unilib.global.init_pkg_list = {}

-- A table of paths remix folders, one for each remix in unilib.global.init_remix_list
-- unilib first looks for a remix in ../custom/remixes, and if the remix is not found, it looks in
--      ../csv/remixes
-- Table in the form
--      remix_path_table[remix_name] = full_path_to_remix_folder
-- Table populated by code in ../lib/system/read/read_compile.lua
-- N.B. When retrieving the path to a file in a remix folder, it's usually better to call
--      unilib.utils.get_remix_dir() (which returns the actual path, or the default location of the
--      remix folder). You can then check whether the file path exists, or not
unilib.global.remix_dir_table = {}
-- A table of remixes, showing the packages specified by each (not including duplicate packages)
-- Table in the form
--      remix_pkg_table[remix_name] = list_of_pkg_names
-- Table populated by code in ../lib/system/read/read_compile.lua
unilib.global.remix_pkg_table = {}
-- A table of remixes, showing the number of packages specified by each (not including duplicate
--      packages). The data is shown as a confirmation message by init.lua
-- Table in the form
--      remix_pkg_count_table[remix_name] = number_of_pkgs
-- Table populated by code in ../lib/system/read/read_compile.lua
unilib.global.remix_pkg_count_table = {}

-- A list of package names specified by the loaded remixes, preserving the order in which they're
--      specified, but with duplicate packages already eliminated
-- Note that this list (and the equivalent table below) don't include hard/soft dependent packages
--      forced-loaded during the execution stage
-- List populated by code in ../lib/system/read/read_compile.lua
unilib.global.pkg_setup_list = {}
-- A table of package names, containing every package in unilib.global.pkg_setup_list
-- Table in the form
--      pkg_setup_table[pkg_name] = source_mod
-- ...where the "source_mod" is usually specified by the remix (but is an empty string, if not)
-- Table populated by code in ../lib/system/read/read_compile.lua
unilib.global.pkg_setup_table = {}
-- The same list of package names, but with any packages that could not be loaded at all eliminated
--      (otherwise preserving the order of the original)
-- List populated by code in ../lib/system/load/load_pkg.lua
unilib.global.pkg_loaded_list = {}
-- A table of package names, containing every package in unilib.global.pkg_loaded_list
-- Table in the form
--      pkg_loaded_table[pkg_name] = source_mod
-- Table populated by code in ../lib/system/load/load_pkg.lua
unilib.global.pkg_loaded_table = {}

-- Each package, after a call to its .init() function, provides a table of metadata, available for
--      any part of the code to use
-- The metadata table contains two compulsory key/value pairs, and any number of optional ones
-- Most packages will not specify the two compulsory key/value pairs directly, in which case the
--      values of those pairs are those specified by the remix
-- The compulsory key/value pairs are:
--      .pkg_name = pkg_name (e.g. "stone_ordinary")
--      .mod_name = names of the source mod(s), separated by whitespace, e.g. "default" or
--          "default vessels". If not known or not available, an empty string. The order is
--          important; if the first mod's replace mode is "defer", the package is not executed; but
--          if subsequent mods' replace modes are "defer", the package is executed (and is expected
--          to check those replace modes itself)
-- Any number of optional key/value pairs may be specified by any package. Standard ones include:
--      .description = brief_description_of_pkg (e.g. "Apple tree")
--      .notes = additional_info (e.g. "Produces edible apples")
--      .first = any_value (if the key is specified, this package's .exec() function must be called
--          before any other package which does not specify the "first" key. "any_value" is
--              typically true)
--      .last = any_value (if the key is specified, this package's .exec() function must be called
--          after any other package which does not specify the "last" key. "any_value" is typically
--          true. If both "first" and "last" are specified, then only "first" is used)
--      .excludes = pkg_name (specifies a package which is incompatible with this package. If the
--          incompatible package has been loaded, then the bulk of this package is not executed (its
--          .exec() and .post() functions are not called, and no error is produced). "pkg_name" can
--          be either a string or a list
--      .depends = pkg_name (specifies a dependent package, whose .exec() function must be called
--          before this package's .exec() function. If "pkg_name" has not been loaded, this
--          package's .exec() function is not called and an error is produced. .depends is not
--          processed until .excludes has been processed. "pkg_name" can be either a string or a
--          list)
--      .at_least_one = pkg_name, pkg_list or list_of_lists (specifies one or more dependent
--          packages, at least one of which must have been loaded. If a string, that package must
--          have been loaded. If a list of packages, at least one must have been loaded. If a list
--          of lists, in which each mini-list is a list of packages, at least one package from each
--          mini list must have been loaded, e.g. packages "a" and "d" in { {a, b, c}, {d, e, f} }.
--          On failure, this package's .exec() function is not called and an error is produced.
--          The .exec() function of any specified package which has been loaded is called first.
--          .at_least_one is not processed until .excludes and .depends have been processed
--      .optional = pkg_name (specifies an optional dependent package. If the optional package has
--          been loaded, its .exec() function is called first; if not, this package's .exec()
--          function is called and no error is produced. .optional is not processed until .excludes,
--          .depends and .at_least_one have been processed. "pkg_name" can be either a string or a
--          list)
--      .suggested = pkg_name (specifies a suggested dependent package. Used mostly in drink, food
--          and ingredient packages, whose craft recipes have ingredients that are often groups
--          rather than specific items, e.g. group:food_sugar rather than
--          unilib:ingredient_sugar_normal. Suggested packages are only loaded if
--          unilib.setting.force_load_suggested_pkg_flag is set. Ideally, remix writers should add
--          the suggested packages to their remix, as and when they need them, so that they are
--          loaded in all cases. "pkg_name" can be either a string or a list)
--      .mod_excludes = mod_name
--      .mod_depends = mod_name
--      .mod_at_least_one = mod_name
--      .mod_optional = mod_name
--          (specifies mod(s) with which the package is (in)compatible. These fields behave exactly
--          as the equivalent package fields above. Ideally, any dependent mod(s) should be added to
--          unilib's mod.conf file, to guarantee that they are loaded first. "mod_name" can be
--          either a string or a list)
--      .adult_flag = true (for any package providing drinkable alcohol. The package is only
--          executed if the corresponding Minetest setting is enabled)
-- Table in the form
--      pkg_table[pkg_name] = metadata_table
-- Table populated by code in ../lib/system/load/load_init.lua
unilib.global.pkg_table = {}
-- A table of packages which were not executed, or which must not be executed. (A package is
--      considered "executed" when its .exec() function is ready to be called, even if it doesn't
--      specify an .exec() function)
-- When a package is marked not executable, neither its .exec() nor .post() functions are ever
--      called
-- Table in the form
--      pkg_excluded_table[pkg_name] = true
-- Two packages, A and B, may be mutually exclusive (A is incompatible with B, and B is incompatible
--      with A), in which case both may specify the other as incompatible. If both are loaded, then
--      the second one to be initialised is automatically marked non-executable
-- However, it's more common for B to specify that A is incompatible, but for A to be unaware of
--      this fact. If both are loaded, then A is executable, but B is not
-- If a package declares that it is incompatible with itself, then it is automatically marked
--      non-executable
-- Table populated by code in ../lib/system/load/load_init.lua
unilib.global.pkg_excluded_table = {}
-- A table of packages that have already been executed. Since both functions are optional, this
--      table includes packages whose .exec() and .post() functions would have been called, had they
--      existed
-- Table in the form
--      pkg_executed_table[pkg_name] = false  [if .exec() was called, or would have been called]
--      pkg_executed_table[pkg_name] = true   [if .post() was called, or would have been called]
-- Table populated by code in ../lib/system/load/load_exec.lua
unilib.global.pkg_executed_table = {}

---------------------------------------------------------------------------------------------------
-- Global variables - biomes, decorations and ores
---------------------------------------------------------------------------------------------------

-- If several remixes are specified, more than one package may try to clear registered biomes,
--      decorations and/or ores
-- To prevent later packages clearing the biomes/decorations/ores or earlier packages, call
--      unilib.clear_biomes(), .clear_decorations() and .clear_ores()
-- These functions first check the value of these flags, to ensure that biomes/decorations/ores are
--      not cleared more than once
unilib.global.biomes_cleared_flag = false
unilib.global.decorations_cleared_flag = false
unilib.global.ores_cleared_flag = false

-- Biomes can be defined in package code, or loaded from a biomes.csv file in one or more remix
--      folders
-- A table of remixes, showing the number of biomes specified by each remix's CSV file(s) (not
--      including duplicate biomes). The data is shown as a confirmation message by init.lua
-- Table in the form
--      remix_biome_count_table[remix_name] = number_of_biomes
-- Table populated by code in ../lib/system/read/read_csv_remix.lua
unilib.global.remix_biome_count_table = {}
-- Decorations can be defined in package code, or loaded from a decorations.csv file in one or more
--      remix folders
-- A table of remixes, showing the number of decorations specified by each remix's CSV file(s) (not
--      including duplicate biomes). The data is shown as a confirmation message by init.lua
-- Table in the form
--      remix_deco_count_table[remix_name] = number_of_decorations
-- Table populated by code in ../lib/system/read/read_csv_remix.lua
unilib.global.remix_deco_count_table = {}
-- Ores can be defined in package code, or loaded from one of several CSV files in one or more remix
--      folders:
--          ore_scatter.csv ore_sheet.csv ore_puff.csv ore_blob.csv ore_vein.csv ore_stratum.csv
-- A table of remixes, showing the number of ores specified by each remix's CSV file(s) (not
--      including duplicate biomes). The data is shown as a confirmation message by init.lua
-- Table in the form
--      remix_ore_count_table[remix_name] = total_number_of_ores
-- Table populated by code in ../lib/system/read/read_csv_remix.lua
unilib.global.remix_ore_count_table = {}

-- A list of biome specifications specified by the loaded remixes, preserving the order in which
--      they're specified, but with duplicate biomes already eliminated
-- Note that the contents of this list is not checked for validity until the actual biome
--      definitions are created during the call to unilib.register_biome_from_csv()
-- A list of tables, each of which defines a biome. Keys in the table are:
--
--      remix_name
--      biome_name dust top_str fill_str stone water_top_str water river riverbed_str cave_liquid
--          dungeon dungeon_alt dungeon_stair y_max y_min blend heat humidity
--
-- The .biome_name key is compulsory, all others are optional
-- List populated by code in ../lib/system/read/read_csv_remix.lua. It is acceptable for packages to
--      modify the tables in this list directly, when appropriate
-- N.B. This list is reset by ../lib/system/load/load_finalisation.lua when setup is completed
unilib.global.biome_csv_setup_list = {}
-- A list of decoration specifications specified by the loaded remixes, preserving the order in
--      which they're specified
-- Note that the contents of this list is not checked for validity until the actual decoration
--      definitions are created during the call to unilib.register_decoration_from_csv()
-- A list of tables, each of which defines a decoration. Keys in the table are:
--
--      remix_name
--      deco_name deco_type biomes fill_ratio flags height_max num_spawn_by place_on sidelen
--          spawn_by y_max y_min
--
-- The .remix_name, .deco_type and .deco_name keys are compulsory, all others are optional
-- .deco_type is one of the values "simple", "schematic", "schematic_no_rotate" or "treelog". For
--      "simple", .deco_type is the full_name of one or more nodes, e.g. "unilib:grass_jungle". For
--      schematics, it is the names of one or more schematics (in unilib's ../mts folder), e.g.
--      "default_grass_jungle". For "treelog", it contains one or more node full_names and
--      schematics, in any order; the full_names are used to construct logs (e.g.
--      "unilib:tree_apple_trunk") and the accompanying schematics are the corresponding trees (e.g.
--      the one created by the "tree_apple" package)
-- The values of .deco_name, .biomes , .place_on and .spawn_by can be a simple string, or a string
--      of whitespace-separated values (e.g. "unilib:foo unilib:bar unilib:baz"). unilib will
--      automatically convert them into a real list
-- If specified, the value .height_max is only used for the .deco_type "simple"; for other values it
--      is ignored
-- If specified, the values .flags and .sidelen are only used for the .deco_type "schematic",
--      "schematic_no_rotate" and "treelog"; for other values it is ignored
-- In ordinary Minetest decoration definitions, .flags is typically a value like
--      "place_center_x, place_center_z". Using a comma is not acceptable in a CSV, so just separate
--      the values by whitespace; unilib will insert commas into this field. (In case the separator
--      has been set as some other character, then it's acceptable but not recommended to use
--      commas in this field)
-- List populated by code in ../lib/system/read/read_csv_remix.lua. It is acceptable for packages to
--      modify the tables in this list directly, when appropriate
-- N.B. This list is reset by ../lib/system/load/load_finalisation.lua when setup is completed
unilib.global.deco_csv_setup_list = {}
-- A list of ore specifications specified by the loaded remixes, preserving the order in which
--      they're specified
-- Note that the contents of this list is not checked for validity until the actual ores definitions
--      are created during the call to unilib.register_ore_from_csv()
-- A list of tables, each of which defines a ore. Some key-value pairs apply to all ores, some only
--      apply to ores of a particular type. Keys in the table are:
--
--      remix_name
--      (All ore types)
--      ore_type, ore, ore_param2, wherein, clust_scarcity, clust_num_ores, clust_size, y_max,
--          y_min, flags, noise_threshold, np_offset, np_scale, np_spread, np_seed, np_octaves,
--          np_persist, biomes
--      ("sheet" only)
--      column_height_max, column_height_min, column_midpoint_factor
--      ("puff" only)
--      nppt_offset, nppt_scale, nppt_spread, nppt_seed, nppt_octaves, nppt_persist,
--          nppb_offset, nppb_scale, nppb_spread, nppb_seed, nppb_octaves, nppb_persist
--      ("vein" only)
--      random_factor
--      ("stratum" only)
--      npst_offset, npst_scale, npst_spread, npst_seed, npst_octaves, npst_persist,
--          stratum_thickness
--
-- The .remix_name, .ore_type and .ore keys are compulsory, all others are optional
-- .ore_type is one of the values "scatter", "sheet", "puff", "blob", "vein" or "stratum"
--
-- All other values are numbers, with the following exceptions:
-- .wherein, .biomes are a string of one or more items, separated by whitespace, for example
--      "unilib:stone_ordinary unilib:sand_ordinary unilib:sand_desert"
-- .clust_scarcity can be a string in the form "n * n * n", e.g. "5 * 5 * 5", which is stored as the
--      result of the product, e.g. 125. Everything except the numbers is ignored, so
--      "5 times 5 times 5" would also be parsed correctly. A simple numerical value like 125 is
--      also acceptable
-- In ordinary Minetest ore definitions, .flags is typically a value like
--      "liquid_surface, force_placement, all_floors, all_ceilings". Using a comma is not
--      acceptable in a CSV, so just separate the values by whitespace; unilib will insert
--      commas into this field. (In case the separator  has been set as some other character, then
--      it's acceptable but not recommended to use commas in this field)
-- List populated by code in ../lib/system/read/read_csv_remix.lua. It is acceptable for packages to
--      modify the tables in this list directly, when appropriate
-- N.B. This list is reset by ../lib/system/load/load_finalisation.lua when setup is completed
unilib.global.ore_csv_setup_list = {}

-- The Minetest engine will ignore any biomes specified in core.register_decoration() and
--      core.register_ore() calls, if they don't exist at the time of the call. Therefore we don't
--      call those functions until we're sure that all core.register_biome() calls have been
--      completed
-- This is done by storing the definitions for all biomes, decorations and ores until the end, at
--      which time ../lib/system/load/load_finalisation.lua registers all of them together
-- There are two list for each type: one for biomes/decorations/ores created by CSV, and one for
--      all other biomes/decorations/ores. This guarantees that the CSV definitions are registered
--      with the engine first, and then all other definitions are registered in the order in which
--      they were created
-- N.B. These lists are reset by ../lib/system/load/load_finalisation.lua when setup is completed
unilib.global.biome_csv_final_list = {}
unilib.global.biome_other_final_list = {}
unilib.global.deco_csv_final_list = {}
unilib.global.deco_other_final_list = {}
-- Ore distributions are created in the following order:
--      "stratum" "sheet" "vein" "puff" "blob" "scatter"
-- Thus for ores, we use a table rather than a list. Each table contains those keys, with
--      corresponding values being a list of ore definitions
-- N.B. These tables are reset by ../lib/system/load/load_finalisation.lua when setup is completed
unilib.global.ore_csv_final_table = {}
unilib.global.ore_other_final_table = {}
for _, ore_type in ipairs({"stratum", "sheet", "vein", "puff", "blob", "scatter"}) do

    unilib.global.ore_csv_final_table[ore_type] = {}
    unilib.global.ore_other_final_table[ore_type] = {}

end
-- Temporary table containing the names of any biomes that have been added to
--      unilib.global.biome_csv_final_list and unilib.global.biome_other_final_list
-- Table in the form
--      biome_name_check_table[biome_name] = true
-- N.B. This table is reset by ../lib/system/load/load_finalisation.lua when setup is completed
unilib.global.biome_name_check_table = {}
-- Temporary table containing the names of any decorations that have been added to
--      unilib.global.deco_csv_final_list and unilib.global.deco_other_final_list
-- Table in the form
--      deco_name_check_table[decoration_name] = true
-- N.B. This table is reset by ../lib/system/load/load_finalisation.lua when setup is completed
unilib.global.deco_name_check_table = {}

-- Table of every biome created
-- Table in the form
--      biome_table[biome_name] = data_table
-- "data_table" consists of the following compulsory key-value pairs (all but .biome_name are given
--      default values if not specified directly)
--          .biome_name = biome_name
--          .description = A basic biome description; defaults to the same value as .biome_name
--          .y_max = upper_limit_for_biome, default unilib.constant.y_max (range
--              unilib.constant.y_min to unilib.constant.y_max)
--          .y_min = lower_limit_for_biome, default unilib.constant.y_min (range
--              unilib.constant.y_min to unilib.constant.y_max)
--          .heat_point = characteristic_temperature_of_biome, default 50 (range 0-100)
--          .humidity_point = characteristic_humidity_of_biome, default 50 (range 0-100)
--          .place_on = node_name (the biome's "node_top", if it is defined, or the "node_filler"
--              otherwise)
-- Packages should call unilib.register_biome() to update this table
unilib.global.biome_info_table = {}
-- Pseudo-biomes are created by packages like "mapgen_hades", "mapgen_hades_jit", "mapgen_underch"
--      and "mapgen_underch_jit". They replace ordinary stone with a variety of other stones,
--      usually underground, but also in the interiors of mountains
-- These packages, when executed, act on every node that's generated. This is not a significant
--      problem for most (overground) biomes, which only replace a few nodes near the surface,
--      leaving everything below as ordinary stone. However, for the "gaia" and "glemr11" remixes,
--      whose biomes replace everything down to a depth of y=-192, it's a significant waste of
--      processor time
-- This value specifies an upper limit below which pseudo-biomes are generated. By default, they are
--      generated at all heights; this value can be changed by the "gaia"/"glemr11" remixes when
--      their packages are loaded, or by any other code
-- If this value is changed, it should be the bottom of a Minetest map block (e.g. y=-192). Map
--      blocks are 80 nodes in size, so y=-112, y=-272, y=-352 are also good values
unilib.global.pseudo_biome_limit = unilib.constant.y_max

-- Generic definition tables for decorations are usually created by the related package (e.g. for
--      aspen trees, in the "tree_aspen" package), in a call to unilib.register_decoration_generic()
-- These generic tables, with default values for the fields .biomes, .num_spawn_by, .place_on,
--      .spawn_by, .y_max and .y_min, are stored in this global variable, until needed
-- Packages in the "deco" category (e.g. "deco_default_tree_aspen") call
--      unilib.register_decoration_complete() with a specific definition table, typically including
--      some or all of the fields above with non-generic values. This code is normally inside the
--      package's .post() function
-- unilib.register_decoration_complete() then calls core.register_decoration() with a new composite
--      definition table, based on the generic table, but overwritten by the specific table
-- In some cases, the "deco" package will specify both a generic and specific definition table is
--      successive calls to unilib.register_decoration_generic() and
--      unilib.register_decoration_complete() (for example, when a mod creates a new decoration
--      based on an item supplied by a different mod)
-- The generic name is expected to be in format
--      REMIX-NAME_ITEM-NAME_N
-- ...where ITEM-NAME is either the name of the item to be placed, or a name for a schematic to be
--      placed (following the parent package name, as far as possible), and where N is an optional
--      numerica component (for example, when the same item is placed in two different biomes by
--      two different decorations)
-- Table in the form
--      generic_deco_table{generic_name] = generic_def_table
-- Packages should call unilib.register_decoration_generic() to update this table
unilib.global.generic_deco_table = {}
-- When a package registers a generic decoration using both a schematic and a .place_offset_y field,
--      we store its value here so it's available to any other code that needs to retrieve it (for
--      example, in the case of decorations loaded from a remix's decorations.csv file)
-- (Note that "simple" decorations are not added to this table; any single node decorations which
--      require a .place_offset_y should be specified by a package, not by a decorations.csv file;
--      see the "deco_gaia_ice_thin" package for a working example)
-- Table in the form
--      deco_schem_offset_table[node_or_schematic_name] = place_offset_y
unilib.global.deco_schem_offset_table = {}

---------------------------------------------------------------------------------------------------
-- Global variables - item registries
---------------------------------------------------------------------------------------------------

-- Table of basic stone types. Table in the form
--      stone_table[part_name] = data_table
-- "data_table" consists of the following mostly optional key-value pairs:
--      part_name = value
--          e.g. "ordinary" for unilib:stone_ordinary and its derivatives. This value is compulsory
--      description = value
--          e.g. "Ordinary Stone". This value is compulsory
--      category = value
--          "intrusive" for igneous intrusive rocks, "extrusive" for igneous extrusive rocks,
--              "sedimentary" for sedimentary rocks, "metamorphic" for metamorphic rocks,
--              "clay_dirt" for clay/dirt stones like laterite, "other" for rocks that don't fit
--              into those categories (usually because they are fictional, e.g. ordinary stone)
--      colour = value
--          An RGB value like "#615E5D", representing a characteristic colour of this stone type; it
--              can be used to create other nodes based on the stone type. If not specified by the
--              call to unilib.register_stone(), the characteristic colour of ordinary stone is used
--      fictional_flag = bool
--          If true, this stone does not exist in reality. This classification applies in the
--              broadest sense; ordinary stone from minetest_game is classified as fictional, but
--              silver sandstone is not (because sandstone itself is not fictional)
--      grinder_flag = bool
--          If true, technic grinder recipes are added for the smooth, cobble and compressed
--              variants of this stone type
--      grinder_powder = value
--          The grinder output, when using smooth stone as the input. If not specified or the output
--          is not available, then "unilib:stone_ordinary_powder" is the output. Ignored if
--          grinder_flag is false
--      grinder_gravel = value
--          The grinder output, when using cobble/compressed cobble as the input. If not specified
--          or the output is not available, then "unilib:gravel_ordinary" is the output. Ignored if
--          grinder_flag is false
--      hardness = value
--          Value in the range 1-5, corresponding to the PFAA classification:
--              UNILIB  PFAA            CRACKY      NOTES
--              1       weak            3           Default value. Digging usually produces rubble
--              2       medium          2           Digging usually produces cobble
--              3       strong          1           Digging usually produces cobble
--              4       very strong     1           Digging usually produces smooth stone
--              5       n/a             1           Digging usually produces smooth stone
--          N.B. Hardness 5 is intended mostly for fictional stones, like obscurite, that need
--              special handling
--          N.B. The product of digging follows these rules, unless the original mod behaves in a
--              different way; in which case, the equivalent unilib code usually does the same thing
--      hardness_real = value
--          A hardness, also in the range 1-5, matching the real-world properties of a stone. The
--              value is available to any code that wants to programmatically override each stone's
--              default behaviour. In most cases, the values of .hardness and .hardness_real will be
--              the same; when they differ, it is usually because the original mod's code has
--              specified an unrealistic hardness
--      moss_flag = bool
--          If true, the stone type can be used in moss-growth ABMs. Note that this will only work
--              if the cobble variant has the group "cobble"
--      no_smooth_flag = bool
--          If true, there is no smooth stone variant for this stone type
--      platform_list = list_of_full_names or nil
--          List of full node names (typically the smooth, block and brick variants) that can be
--              used, in a call to advtrains, to create train platforms
--      super_flag = true for super stones, false for everything else
-- Packages should call unilib.register_stone() to update this table
unilib.global.stone_table = {}
-- Table of super stones (see the comments above), populated by
--      ../lib/system/global/global_update.lua
-- Table in the form
--      super_stone_table[stone_type] = true
-- Note that the table can include the key "everything", meaning that all suitable stones are super
--      stones, but if unilib.setting.super_stone_set contained the word "nothing", then this table
--      is empty
-- Note also that stone packages can exclude themselves from this table, if they are unsuitable (in
--      which case, a key-value pair is deleted)
-- Note finally that (unlike unilib.global.stone_table), stones in this table might not actually
--      exist (in other words, their packages might not have been executed)
unilib.global.super_stone_table = {}
-- When unilib.setting.super_stone_set contains the word "everything", or "nothing" (which overrides
--      "everything)", then this variable is set to the value "everything" or "nothing", and it's
--      the responsibility of unilib.register_stone() to populate unilib.global.super_stone_table
--      (rather than the code in ../lib/system/global/global_update.lua)
unilib.global.super_stone_mode = "default"

-- Table of mineral types. Table in the form
--      mineral_table[part_name] = data_table
-- "data_table" consists of the following mostly optional key-value pairs:
--      part_name = value
--          e.g. "cinnabar" for unilib:mineral_cinnabar_lump and its derivatives. This value is
--              compulsory
--      description = value
--          e.g. "Cinnabar". This value is compulsory
--      combustible_flag = bool
--          If true, can be used as a fuel in a furnace
--      fictional_flag = bool
--          If true, this mineral does not exist in reality. This classification applies in the
--              broadest sense; "unilib:mineral_amethyst_dark_lump" is not regarded as fictional,
--              because amethyst itself is not fictional
--      gem_flag = bool
--          If true, a gem variant exists
--      hardness = value
--          Value of the hardness of the mineral ore in the range 1-5, corresponding to the PFAA
--              classification:
--                  UNILIB  PFAA            CRACKY
--                  1       weak            3
--                  2       medium          2
--                  3       strong          1
--                  4       very strong     1
--                  5       n/a             0
--          N.B. Currently, no minerals have strength 4 or 5. Strength 5 is intended for fictional
--              minerals that require special tools
--      metal_list = list_of_part_names
--          List of keys in unilib.global.metal_table, specifying the metals that can be smelted
--              using this mineral (an empty list, if none)
--      no_lump_flag = bool
--          If true, no lump variant exists
--      non_metal_list = list_of_part_names
--          List of keys in unilib.global.non_metal_table, specifying elemental non-metals that can
--              be baked using this mineral (an empty list, if none)
--      powder_flag = bool
--          If true, a powder variant exists
--      rock_flag = bool
--          If true, a rock-mineral variant exists (a whole node, not a craftitem)
-- Packages should call unilib.register_mineral() to update this table
unilib.global.mineral_table = {}

-- Table of metal types. Table in the form
--      metal_table[part_name] = data_table
-- "data_table" consists of the following mostly optional key-value pairs:
--      part_name = value
--          e.g. "tin" for unilib:metal_tin_lump" and its derivatives. This value is compulsory
--      description = value
--          e.g. "Tin". This value is compulsory
--      alloy_flag = bool
--          If true, this metal is an alloy. Alloy is used in the losest sense, so that even wrought
--              iron qualifies as an alloy. Code creating ores from various metals should not create
--              them using alloys
--      fictional_flag = bool
--          If true, this metal does not exist in reality. This classification applies in the
--              broadest sense; "unilib:metal_tin_rare_lump" is not regarded as fictional, because
--              tin itself is not fictional
--      hardness = value
--          Value of the hardness of the metal ore in the range 1-5, corresponding to the PFAA
--              classification:
--                  UNILIB  PFAA            CRACKY
--                  1       weak            3
--                  2       medium          2
--                  3       strong          1
--                  4       very strong     1
--                  5       n/a             0
--          N.B. Currently, no metals have strength 4, and strength 5 is intended for fictional
--              metals that require special tools (such as those from the xtraores mod)
--          N.B. Metals that can be produced only artificially, and in small quantities, and which
--              are extremely unlikely to be used in an ore, have been given a hardness value of 1
--          N.B. Alloys such as brass and bronze have been given a hardness value, even though they
--              are never used in ores
--      powder_flag = bool
--          If true, a powder variant exists
-- Packages should call unilib.register_metal() to update this table
unilib.global.metal_table = {}
-- Corresponding table of elemental non-metal types, usually available in a game as samples
-- Table in the form
--      non_metal_table[part_name] = data_table
-- "data_table" consists of the following compulsory key-value pairs:
--      part_name = value
--          e.g. "nitrogen" for unilib:substance_nitrogen_sample" and its derivatives. This value is
--              compulsory
--      description = value
--          e.g. "Nitrogen". This value is compulsory
-- Packages should call unilib.register_non_metal() to update this table
unilib.global.non_metal_table = {}

-- List of "matrix" stones (temporary nodes placed by remixes such as "underch" and "hades",
--      initially replacing unilib:stone_ordinary. The matrix stone is then converted to some other
--      node as the map is generated)
-- Packages should call unilib.register_matrix_stone() to update this table
unilib.global.matrix_stone_list = {}

-- Table of "fertile" dirts, on which turf can be grown (does not include any dirts on which turf
--      can't be grown, such as "unilib:dirt_ordinary_with_litter_coniferous", but does include
--      other items occasionally combined with turfs, e.g. "unilib:clay_red")
-- Note that dirts not in the "fertile" category might still be capable of being converted to soil
--      with a hoe, in the normal way
-- Table in the form
--      fertile_dirt_table[dirt_part_name] = full_name
-- ...e.g. for "unilib:dirt_ordinary", the part_name "dirt_ordinary"
-- Packages should call unilib.register_fertile_dirt() to update this table
unilib.global.fertile_dirt_table = {}
-- Table of dirt-with-turf nodes, in the form
--      dirt_with_turf_table[full_name] = data_table
-- "data_table" consists of the following compulsory key-value pairs:
--      dirt_part_name = value
--          e.g. "dirt_ordinary" for "unilib:dirt_ordinary_with_turf"
--      turf_part_name = value
--          e.g. "turf_dry" for "unilib:dirt_ordinary_with_turf_dry"
--      turf_description = value
--          e.g. "Dry Turf"
-- Note the example of "unilib:dirt_ordinary_with_cover_snow"; in that case, .turf_part_name is
--      "turf_ordinary" instead of "cover_snow", because we don't want the turf cutter to "cut"
--      snow. See ../lib/shared/dirt/dirt_base.lua for a longer explanation
-- Packages should call unilib.register_dirt_with_turf() to update this table
unilib.global.dirt_with_turf_table = {}
-- Reverse dirt-with-turf node table, in the form
--      dirt_with_turf_reverse_table[dirt_part_name] = list_of_dirt_with_turf_nodes
unilib.global.dirt_with_turf_reverse_table = {}
-- Table of turf seeder items (mostly grasses, but also items like ordinary snow) that, due to the
--      action of the turf spread ABMs, convert the dirt node immediately below into a
--      dirt-with-turf node
-- Initially, each turf seeder item can be represented as a full node name (e.g.
--      "unilib:snow_ordinary") or a group (e.g. "group:dry_grass")
-- After all packages have been executed, code in ../lib/system/load/load_finalisation.lua will
--      remove the items represented as a group, replacing them with actual node names, e.g.
--      "unilib:grass_dry_1"
-- Table in the form
--      turf_seeder_table[seeder_name] = data_table
-- ...where each data_table is in the form
--      data_table[dirt_name] = dirt_with_turf_name
-- Packages should call unilib.register_dirt_with_turf() to update this table
unilib.global.turf_seeder_table = {}
-- Table of super dirts (see the comments above), populated by
--      ../lib/system/global/global_update.lua
-- Table in the form
--      super_dirt_table[dirt_part_name] = true
-- ...e.g. for "unilib:dirt_ordinary", the dirt_part_name "dirt_ordinary"
-- ...e.g. for "unilib:clay_red", the dirt_part_name "clay_red"
-- Note that the table can include the key "everything", meaning that all suitable dirts are super
--      dirts, but if unilib.setting.super_dirt_set contained the word "nothing", then this table is
--      empty
-- Note also that dirt packages can exclude themselves from this table, if they are unsuitable (in
--      which case, a key-value pair is deleted)
-- Note finally that many dirts in this table might not actually exist. In some cases, their
--      packages will not have been executed. In other cases, the node may not exist at all; for
--      example, a super-dirt "foobar" is added to this table both as "foobar" and "dirt_foobar".
--      Therefore, it's vital to check that the node actually exists, before using it as an
--      ingredient in some craft recipe
unilib.global.super_dirt_table = {}
-- When unilib.setting.super_dirt_set contains the word "everything", or "nothing" (which overrides
--      "everything)", then this variable is set to the value "everything" or "nothing", and it's
--      the responsibility of unilib.register_fertile_dirt() or unilib.register_infertile_dirt() to
--      populate unilib.global.super_dirt_table (rather than the code in
--      ../lib/system/global/global_update.lua)
unilib.global.super_dirt_mode = "default"

-- Table of tree types, in the form
--      tree_table[tree_type] = data_table
-- "data_table" consists of the following compulsory key-value pairs:
--      part_name = tree_type, e.g. "aspen"
--      description = e.g. S("Aspen Wood"), sometimes including the word "Tree", e.g.
--          S("Jungle Tree Wood")
--      incomplete_flag = true for packages that don't define a complete tree, e.g. "tree_gold"
--      slim_flag = true for trees whose trunks are smaller than a full block
--      super_flag = true for super trees, false for everything else
-- "data_table" consists of the following optional key-value pairs:
--      burnlevel = value in the range 1-5, corresponding to unilib.global.tree_burn_table
-- Packages should call unilib.register_tree() to update this table
unilib.global.tree_table = {}
-- Table of super trees (see the comments above), populated by
--      ../lib/system/global/global_update.lua
-- Table in the form
--      super_tree_table[tree_type] = true
-- Note that the table can include the key "everything", meaning that all suitable trees are super
--      trees, but if unilib.setting.super_tree_set contained the word "nothing", then this table is
--      empty
-- Note also that tree packages can exclude themselves from this table, if they are unsuitable (in
--      which case, a key-value pair is deleted)
-- Note finally that (unlike unilib.global.tree_table), trees in this table might not actually exist
--      (in other words, their packages might not have been executed)
unilib.global.super_tree_table = {}
-- When unilib.setting.super_tree_set contains the word "everything", or "nothing" (which overrides
--      "everything"), then this variable is set to the value "everything" or "nothing", and it's
--      the responsibility of unilib.register_tree() to populate unilib.global.super_tree_table
--      (rather than the code in ../lib/system/global/global_update.lua)
unilib.global.super_tree_mode = "default"
-- Burn times for wooden items depend on wood density. For items imported from minetest_game, that
--      corresponds to the order of wood colour darkness:
--          1. aspen (shortest burn), 2. pine, 3.apple, 4. acacia, 5. jungle tree (longest burn)
-- Calls to functions in ../lib/shared/trees/ can specify a burntime directly, or they can specify a
--      burn level in the range 1-5
-- Note that ../lib/system/final/final_fuel.lua provides craft recipes for tree groups, using values
--      from burn level 3
-- A table of tree burn levels (which are constant values)
unilib.global.tree_burn_table = {
    trunk = {22, 26, 30, 34, 38},
    wood = {5, 6, 7, 8, 9},
    sapling = {4, 5, 5, 6, 6},
    panel = {22, 26, 30, 34, 38},
    fence = {5, 6, 7, 8, 9},
    fence_rail = {3, 4, 5, 6, 7},
    fence_gate = {5, 6, 7, 8, 9},
    bookshelf = {22, 26, 30, 34, 38},
    vessels_shelf = {22, 26, 30, 34, 38},
    utility_shelf = {11, 13, 15, 17, 19},
    boat = {14, 17, 20, 23, 26},
    door = {10, 12, 14, 16, 18},
    ladder = {5, 6, 7, 8, 9},
}
-- Equivalent table for bushes, this time using burn levels in the range 1-3. minetest_game
--      provides:
--          1. pine (shortest burn) 2. ordinary 3. acacia (longest_burn)
-- A table of bush burn levels (which are constant values)
unilib.global.bush_burn_table = {
    stem = {6, 7, 8},
    sapling = {2, 3, 4},
}

-- Table of tree/bush saplings. Every tree/bush which is grown from a sapling must have an entry
-- Table in the form
--      sapling_table[full_name] = data_table
-- "data_table" consists of the following mostly optional key-value pairs:
--      part_name = value
--          e.g. "aspen" for aspen tree saplings. This value is compulsory
--      sapling_type = "tree" or "bush". This value is compulsory
--      can_grow_func = function
--          A function called by the sapling's .on_timer() callback, when a non-standard check must
--          be performed before growing the sapling. The specified function should return a true or
--          false value
--      grow_func = function
--          A function called by unilib.trees.grow_sapling() and
--              unilib.bushes.grow_sapling(), when special handling is required to convert a sapling
--              into a tree/bush. Overrides schematics and L-system trees
--      grow_fail_func = function
--          A function called by the sapling's .om_timer() callback, when special handling is
--              required for a sapling that could not be grown
--      ltree_table = table
--          Table used to grow L-system trees (instead of using schematics); not used with bushes
--      min_height = value
--          Minimum vertical space required to grow the sapling. If a sapling has no entry in the
--              table, the code does not check for vertical obstructions. If specified, the minimum
--              value is 1
--      min_light = value
--          Minimum light level required to grow the sapling. If a sapling has no entry in the
--              table, the minimum light is specified by the constant variable
--              unilib.constant.light_min_grow_sapling below (default 13)
--      offset_list = list
--          x/y/z adjustments used in the call to core.place_schematic()
--      schem_list = list
--          A list of schematics, one of which is chosen at random when the tree/bush is grown from
--              a sapling. If using a non-conventional schematic name, then the list can consist of
--              one item (which is therefore always chosen)
--          Each item in the list is a mini list, in the form
--          [schematic_name, x, y, z]
--          ...where "schematic_name" is a file in ../mts/, and x/y/z match the values in the
--              .offset_list field
--      replace_func = function
--          A function that returns a replacement table for the core.place_schematic() call (see the
--              comments in unilib.register_tree_sapling() )
--      under_list = list_of_nodes
--          A list of nodes on which the sapling can grow. If a sapling has no entry in this table,
--              it can grow on any node with the "soil" group. If "list_of_nodes" is empty, the
--              sapling cannot grow on anything. If .under_list is nil, the sapling can grow on
--              anything in the "soil" group (including most dirts). Note that this behaviour is
--              independent of decoration placement. See also the Minetest settings for sapling
--              growth
-- Packages should call unilib.register_tree_sapling() to update this table
unilib.global.sapling_table = {}

-- Table of Lua schematics for treelogs; generated when required (by code in
--      ../lib/shared/trees/trees_generate_log.lua), once for each tree type
-- Table in the form
--      flowerpot_compat_table[trunk_full_name] = lua_schematic_table
unilib.global.treelog_schem_table = {}

-- Default values for leaves type/scale. These values are overwritten if the MT setting
--      unilib.setting.plantlike_leaves_flag is true
unilib.global.leaves_drawtype = "allfaces_optional"
unilib.global.leaves_visual_scale = 1

-- Table of all crops/produce, and also grasses/plants (but usually not flowers/mushrooms) that grow
--      using multiple growth stages
-- Table in the form
--      grow_stage_table[full_name] = data_table
-- ...where "full_name" is a single growth stage for a node, e.g. "unilib:crop_wheat_grow_5" or
--      "unilib:crop_wheat_grow_8", and "data_table" consists of the following key-value pairs:
--
--      base_name
--          The node name with the numeric component removed, e.g. "unilib:crop_wheat_grow"
--      mode = value
--          "mtgame" if the crop was created by a call to unilib.register_crop_mtgame()
--          "fredo" if the crop was created by a call to unilib.register_crop_fredo()
--          "produce" if the produce was created by a call to unilib.register_produce_fredo()
--          "other" for other growing items, such as grasses
--      stage = value
--          The current growth stage, e.g. 5 for "unilib:crop_wheat_grow_5"
--      stage_max = value
--          The total number of growth stages, e.g. 8
unilib.global.grow_stage_table = {}

-- Table of full names of flowers (and other plants) that are compatible with flowerpots
-- Flowerpot packages like "flowerpot_normal" should define an empty flowerpot in their .exec()
--      function, and then use code in their .post() function to register every plant on this list
-- Table in the form
--      flowerpot_compat_table[full_name] = orig_name
-- ...where both the key and value are the full names of flower/plant/etc nodes
-- Packages should call unilib.register_flower_in_pot(), unilib.register_mushroom_in_pot(),
--      unilib.register_plant_in_pot() or unilib.register_sapling_in_pot() to update this table
-- See also the Minetest settings above, unilib.setting.flowerpot_add_flowers_flag etc
unilib.global.flowerpot_compat_table = {}

-- Table of full names of any items (cactus, papyrus etc) that require special code when a
--      fertiliser (bonemeal, etc) is used on them, and the functions providing that code
-- Table in the form
--      special_fertiliser_table[full_name] = function
-- Packages should call unilib.fertiliser.register_special() to update this table
unilib.global.special_fertiliser_table = {}

-- Table of items that should not be repairable (for example, by the anvil provided by the
--      "machine_anvil_simple" package; but this table available for any code that wants it)
-- Table in the form
--      tool_no_repair_table[full_name] = error_message
-- ...where "error_message" is something like "The hammer is too complex for repairing"
-- Packages should call unilib.tools.register_no_repair() to update this table
unilib.global.tool_no_repair_table = {}
-- Table of items that should not be affected by scythes (e.g. beanpoles and trellises)
-- Table in the form
--      tool_no_scythe_table[full_name] = true
-- Packages should call unilib.tools.register_no_scythe() to update this table
unilib.global.tool_no_scythe_table = {}
-- Table of special shovels that can dig an original node, rather than the item specified in that
--      node's .drop field. Specifically, it can dig nodes in the "crumbly" and "coral" groups
--      (e.g. digs dirt with turf, instead of dirt; digs coral, rather than coral skeletons)
-- For working examples, see the "tool_shovel_crystallite" and the "tool_shovel_pounamu" packages
-- Table in the form
--      special_shovel_table[full_name] = true
-- Packages should call unilib.register_special_shovel() to update this table
unilib.global.special_shovel_table = {}

-- Table of generic definition tables for buckets (used for setting up buckets with various liquids)
-- Table in the form
--      generic_bucket_table[bucket_type] = data_table
-- ...where "bucket_type" usually matches the package name (e.g. "bucket_steel", "bucket_wood") and
--      "data_table" contains the following key-value pairs:
--          .burntime = burntime (usually 0 for metal buckets, non-zero for wooden buckets)
--          .description = node_description
--          .group_table = e.g. {tool = 1}. These groups are applied both to the empty bucket and
--              all its filled variants
-- Packages should call unilib.register_bucket() to update this table
unilib.global.generic_bucket_table = {}
-- Table of data for each full bucket, in the form
--      full_bucket_table[full_name] = data_table
--  ...where "full_name" is a full bucket, e.g. "unilib:bucket_steel_with_water_ordinary", and
--      "data_table" contains the following key-value pairs:
--          .bucket_type = usually matches the package name, e.g. "bucket_steel"
--          .liquid_type = matches a key in unilib.global.generic_liquid_table, e.g.
--              "water_ordinary"
--          .empty_bucket = the corresponding empty bucket, e.g. "unilib:bucket_steel_empty"
--          .craftable_flag, .potable_flag, .water_flag = flags matching the value of the
--              "liquid_type" in unilib.global.generic_liquid_table
unilib.global.full_bucket_table = {}
-- Table of empty buckets, in the form
--      empty_bucket_table[full_name] = bucket_type, e.g. converts "unilib:bucket_steel_empty"
--          into "bucket_steel"
unilib.global.empty_bucket_table = {}
-- During a multiple-step crafting process, in which the first step uses a filled bucket, and in
--      which the final step returns an empty bucket, there is currently no way to tell which kind
--      of bucket was originally used
-- In that case, this bucket should be returned to the player. It is set to the first empty bucket
--      created in a call to unilib.register_bucket(). For an example, see the "food_jam_blueberry"
--      package
-- N.B. Unfortunately, this allows a player to convert (cheap) wooden buckets into (expensive)
--      steel buckets. The only workaround is to arrange your remixes, such that the cheapest
--      bucket package is executed first
unilib.global.fallback_empty_bucket = nil
-- Lists of items that can be used in a replacement table in any craft recipe with
--      group:craftable_bucket, group:potable_bucket or group:water_bucket (for an example, see the
--      "material_stucco" package)
-- Specifically, when unilib.register_liquid() is called with .craftable_flag = true,
--      .potable_flag = true and/or .water_flag = true, then items are added to these lists
-- List of lists. Each mini-list is in the form {full_bucket, empty_bucket}, e.g.
--      {"unilib:bucket_steel_with_water_ordinary", "unilib:bucket_steel_empty"}
unilib.global.craftable_bucket_list = {}
unilib.global.potable_bucket_list = {}
unilib.global.water_bucket_list = {}

-- Table of generic definition tables for liquids
-- Table in the form
--      generic_liquid_table[liquid_type] = data_table
-- ...where "liquid_type" matches a part of the source/flowing node names (e.g. "water_ordinary" for
--      the nodes created by the "liquid_water_ordinary" package), and "def_table" contains the
--      following key-value pairs:
--          .source_name = e.g. "unilib:liquid_water_ordinary_source"
--          .flowing_name = e.g. "unilib:liquid_water_ordinary_flowing"
--          .burntime = burntime (usually 0 for water, non-zero for lava)
--          .craftable_flag = true for water suitable for general use in craft recipes (including,
--              for example, some muddy waters, but not dyed water); false for all other types of
--              liquid
--          .description = node_description
--          .force_renew_flag = Set to true to override the "liquid_renewable = false". See the
--              notes in the "liquid_water_river" package for an example
--          .group_table = e.g. {tool = 1}
--          .potable_flag = true for water suitable for drinking, and for use in food recipes; false
--              for all other types of water
--          .water_flag = true for water, false for other types of liquid
-- N.B. The "override_unilib_salt_water" package overrides ordinary water to make it non-potable, in
--      order to simulate salt-water oceans from which can't be drunk or used in craft recipes for
--      foods
-- N.B. Filled buckets are automatically given the groups .craftable_bucket, .potable_bucket and
--      .water_bucket, when appropriate. The groups .molten_liquid and .inactive_bucket are
--      standard, and should be specified by the packages themselves (see the
--      "bucket_steel_with_bones" and "metal_gold" packages for examples)
-- Packages should call unilib.register_liquid() to update this table
unilib.global.generic_liquid_table = {}
-- Reverse lookup table for liquids
-- Table in the form
--      reverse_liquid_table[full_name] = liquid_name
-- ...where "full name" is the full node name (e.g. "unilib:liquid_water_ordinary_source"), and
--      "liquid_name" is the corresponding key in unilib.global.generic_liquid_table (e.g.
--      "water_ordinary")
-- Note that there are entries for both source and flowing nodes. For both keys, the corresponding
--      values are identical
-- Packages should call unilib.register_liquid() to update this table
unilib.global.reverse_liquid_table = {}
-- Table used to cool lava nodes into stone nodes. Once all packages have been imported, we use a
--      shared lava-cooling ABM in the "abm_standard_lava_cool" package
-- Table in the form
--      lava_table[lava_full_name] = stone_full_name
-- Packages should call unilib.register_lava() to update this table
unilib.global.lava_cooling_table = {}
-- Table used to melt ice/snow nodes into water nodes. Once all packages have been imported, we use
---     a shared ice/snow-melting ABM in the "abm_standard_ice_snow_melt" package
-- Table in the form
--      ice_snow_melting_table[ice_snow_node] = data_table
--  ...where "data_table" contains the following key-value pairs:
--          .source = the source water node. If not specified, "unilib:liquid_water_ordinary_source"
--              is used
--          .flowing = the source water node. If not specified,
--              "unilib:liquid_water_ordinary_flowing" is used
-- Packages should call unilib.register_ice_snow_melting() to update this table
unilib.global.ice_snow_melting_table = {}
-- Table of generic definition tables for juices (squeezed from fruits in the press defined by the
--      "machine_press_juice" package)
-- Table in the form
--      generic_juice_table[juice_type] = data_table
-- ...where "juice_type" matches a component in the fruit's full name, e.g. "apple" for
--      "unilib:fruit_apple" (note that in some cases, the original code used a "juice_type" like
--      "blueberries", whereas we use "blueberry"; in those cases, .orig_flag is false)
-- ...where "data_table" contains the following key-value pairs:
--          .health = e.g. 2 (the number of health points, when the user drinks the juice)
--          .ingredient_list = e.g. {"unilib:fruit_apple"}. A list of one or more ingredients that
--              produces this juice type
--          .juice_description = e.g. "Apple"
--          .orig_flag = true if the original "drinks" mod specifies vessels using (exactly) the
--              same "juice_type", false if this "juice_type" is original to unilib
--          .rgb = e.g. "#ecff56". No new textures are required for vessels containing different
--              types of juice, everything is handled with a single RGB
-- Packages should call unilib.register_juice() and unilib.juice.register_duplicate() to update
--      this table (for a working example, see the "fruit_banana" package)
unilib.global.generic_juice_table = {}

-- Table of dyes, used for creating derivative items, which need to be named with the correct
--      translated colour (minetest_game/dye makes a table available globally; this is unilib's
--      equivalent)
-- Table in the form
--      dye_description_table[part_name] = translated_name
-- ...where "part_name" is "dark_grey" (etc), and "translated_name" is S("Dark Grey"), etc
-- Packages should call unilib.register_dye() to update this table
unilib.global.dye_description_table = {}
-- Table of dyes and their position in the standard palette, unilib_palette_dye_basic.png
-- Table in the form
--      dye_palette_table[full_name] = position
-- ...where "position" is an integer in the range 0-15
unilib.global.dye_palette_table = {}
-- Corresponding table of baked clays, used for creating derivative items
-- Table in the form
--      clay_baked_table[part_name] = translated_name
-- ...where "part_name" is "dark_grey" (etc), and "translated_name" is S("Dark Grey"), etc
-- Packages should call unilib.register_clay_baked() to update this table
unilib.global.clay_baked_table = {}

-- Three lists of items caught when fishing, specifying fish, bonus items and junk items
-- Each list contains a number of tables, in the form
--      table.full_name, e.g. "unilib:tool_sword_steel" [compulsory]
--      table.biome_part_name, e.g. "ethereal_grassland", "ocean" [or nil]
--      table.rod_name, e.g. "unilib:item_rod_fishing" [or nil]
--      table.tool_wear, e.g. 12000 [or nil]
-- Packages should call unilib.fishing.register_fish() to update this list
unilib.global.fishing_fish_list = {}
-- Packages should call unilib.fishing.register_bonus() to update this list
unilib.global.fishing_bonus_list = {}
-- Packages should call unilib.fishing.register_junk() to update this list
unilib.global.fishing_junk_list = {}

---------------------------------------------------------------------------------------------------
-- Global variables - sounds
---------------------------------------------------------------------------------------------------

-- Definition tables for sound effects are stored in a global table
-- When nodes specify a sound effect, they can just look up the definition table, rather than
--      creating a new table from scratch (as most Minetest mods tend to do)
-- If required, the functions in ../lib/system/intro/intro_sound.lua can be called directly instead
-- Table in the form
--      sound_table[name] = def_table
-- Table populated by code in ../lib/system/intro/intro_sound.lua
unilib.global.sound_table = {}

---------------------------------------------------------------------------------------------------
-- Global variables - stairs, walls, carvings etc
---------------------------------------------------------------------------------------------------

-- Flag set to true if any of the values of unilib.setting.add_stairs_basic_flag,
--      unilib.setting.add_stairs_stairs_redo_flag, unilib.setting.add_stairs_stairsplus_flag or
--      unilib.setting.add_stairs_moreblocks_flag are true (set in
--      ../lib/system/global/global_update.lua)
unilib.global.add_stairs_any_flag = false
-- Flag set to true if any of the values of unilib.setting.show_stairs_basic_flag,
--      unilib.show_stairs_stair_redo_flag, unilib.setting.show_stairs_stairsplus_flag or
--      unilib.setting.show_stairs_moreblocks_flag are true (set in
--      ../lib/system/global/global_update.lua)
unilib.global.show_stairs_any_flag = false
-- Flag set to true if any of the values of unilib.setting.add_carvings_column_flag,
--      unilib.setting.add_carvings_facade_flag, unilib.setting.add_carvings_millwork_flag or
--      unilib.setting.add_carvings_farlands_flag are true (set in
--      ../lib/system/global/global_update.lua)
unilib.global.add_carvings_any_flag = false
-- Flag set to true if any of the values of unilib.setting.show_carvings_column_flag,
--      unilib.setting.show_carvings_facade_flag, unilib.setting.show_carvings_millwork_flag or
--      unilib.setting.show_carvings_farlands_flag are true (set in
--      ../lib/system/global/global_update.lua)
unilib.global.show_carvings_any_flag = false

-- Global variables used (mainly) by circular saws in the package "machine_saw_circular"
-- Table of nodes which have been used to create stair nodes via a call to unilib.register_stairs()
--      (or unilib.register_stairs_all() directly)
-- Table in the form
--      stair_convert_table[original_full_name] = list_of_stair_full_names
unilib.global.stair_convert_table = {}
-- Table of stair nodes and the original nodes from which they were crafted
-- Table in the form
--      stair_deconvert_table[stair_full_name] = original_full_name
unilib.global.stair_deconvert_table = {}
-- Table of stair types (created by ../lib/shared/stairs/stairs_populate_tables.lua), and the cost
--      in microblocks (cubes comprising an eighth of a block)
-- Table in the form
--      stair_cost_table[stair_type] = cost
-- ...for example
--      stair_cost_table["_stair_simple"] = 6
unilib.global.stair_cost_table = {}
-- Table containing ordered lists of stair types, one for each circular saw version (in the range
--      1 to 3)
-- Table in the form
--      stair_ordered_table[version] = ordered_list_of_stair_types
unilib.global.stair_ordered_table = {}

-- Corresponding global variables used by carvings
-- Table of nodes which have been used to create carving nodes via a call to
--      unilib.register_carvings() (or unilib.register_carvings_all() directly)
-- Table in the form
--      carving_convert_table[original_full_name] = list_of_carving_full_names
unilib.global.carving_convert_table = {}
-- Table of carving nodes and the original nodes from which they were crafted
-- Table in the form
--      carving_deconvert_table[carving_full_name] = original_full_name
unilib.global.carving_deconvert_table = {}
-- Table of carving types (created by ../lib/shared/carvings/carvings_populate_tables.lua), and the
--      number of output nodes per input node
-- Table in the form
--      carving_output_table[carving_type] = output_ratio
-- ...for example
--      carving_output_table["_facade_bannerstone"] = 1
unilib.global.carving_output_table = {}

---------------------------------------------------------------------------------------------------
-- Global variables - misc tables
---------------------------------------------------------------------------------------------------

-- Player statistics tables (stored in a table while the player is connected, then serialised as
--      a player attribute when they leave)
unilib.global.player_stats_bio_table = {}
unilib.global.player_stats_activity_table = {}

-- Lists of minetest_game ABMs/LBMs for which unilib equivalents exist. If the Minetest setting is
--      enabled, the original ABMs/LBMs are disabled
-- List of mini-tables, each in the form
--      {mod_origin = MOD, name = NAME, label = LABEL}
-- Note that the .mod_name fields are compulsory, the others are optional
-- Note that minetest_game has a few ABMs/LBMs for backwards compatibility; as they don't duplicate
--      unilib code, they are NOT disabled
-- Table populated by code in ../lib/system/register/register_abm.lua
unilib.global.obsolete_abm_list = {}
-- Table populated by code in ../lib/system/register/register_lbm.lua
unilib.global.obsolete_lbm_list = {}

-- Conversion tables
-- Code should call unilib.register_node(), unilib.register_craftitem() and unilib.register_tool()
--      rather than calling the corresponding Minetest functions directly
-- There is one exception: when creating an item that uses multiple nodes (such as a door),
--      unilib.register_node() should only be called to register the item that appears in the
--      player's inventory; the supplementary items should be registered with
--      core.register_node() as usual
--
-- Note that, in all three tables, there may be multiple keys for which the corresponding value is
--      "unilib:stone_ordinary", etc (reflecting the fact that the same node may have been used by
--      multiple mods)
--
-- Tables that convert a node from an original mod (e.g. "default:stone") into the equivalent
--      unilib node (e.g. "unilib:stone_ordinary"), or vice-versa
-- Note that these tables do not include stairs created by ../lib/shared/stairs/ or carvings created
--      by ../lib/shared/carvings/, but do include wall nodes created by ../lib/shared/walls/
-- Tables in the form
--      node_convert_table[orig_name] = full_name
--      node_deconvert_table[full_name] = orig_name_list
unilib.global.node_convert_table = {}
unilib.global.node_deconvert_table = {}
-- Equivalent tables for craftitems, using the same format
-- Tables in the form
--      craftitem_convert_table[orig_name] = full_name
--      craftitem_deconvert_table[full_name] = orig_name_list
unilib.global.craftitem_convert_table = {}
unilib.global.craftitem_deconvert_table = {}
-- Equivalent tables for tools, using the same format
-- Table in the form
--      tool_convert_table[orig_name] = full_name
--      tool_deconvert_table[full_name] = orig_name_list
unilib.global.tool_convert_table = {}
unilib.global.tool_deconvert_table = {}
-- A table mapping unilib nodes, craftitems and tools onto their minetest_game equivalents. This
--      data is read from a pre-generated CSV file (../csv/convert/convert.csv), and is used to
--      generate aliases when minetest_game mods are loaded, their replace mode is "defer", and
--      equivalent unilib nodes have not been created
-- (This allows other parts of the code to function correctly, without having to reference both
--      names)
-- Table in the form
--      mtgame_convert_table[mtgame_name] = unilib_name
--      mtgame_deconvert_table[unilib_name] = mtgame_name
unilib.global.mtgame_convert_table = {}
unilib.global.mtgame_deconvert_table = {}

-- Origin tables
-- Assuming that unilib.register_node(), etc, have been called, then these tables provide quick
--      access to the name of the package that created them
-- Note that some items (such as buckets containing liquids) might be created outside the package
--      initialisation/execution/post-execution stages, in which case those items are not added to
--      these tables
-- Tables in the form
--      table[full_name] = pkg_name
unilib.global.node_parent_table = {}
unilib.global.craftitem_parent_table = {}
unilib.global.tool_parent_table = {}
-- A value set temporarily whenever a package is being initialised, executed or post-executed
unilib.global.current_pkg = nil

-- Some packages have craft recipes that require items from other mods, but we can't say in advance
--      which mods will supply those items. These typically include meat, milk and eggs used as
--      ingredients for food items
-- Ideally, such craft recipes should use "group:food_egg", rather than an actual item name like
--      "mobs:egg", so that all mods providing eggs can be used as ingredients
-- Affected packages should call unilib.register_external_ingredient(), which updates the following
--      table. The player can then use the chat command /check_ingredients, once the game has
--      started, to check that the external ingredients required by various craft recipes are
--      actually available
-- (We don't check external ingredients directly, so that the user isn't forced to add all possible
--      external mods to unilib's mod.conf)
-- Table in the form
--      external_ingredient_table[full_name] = ingredient_list
-- ...where "full_name" is the unilib item whose craft recipe requires external ingredients, and
--      "ingredient_list" is a list that might include one or more things like "group:food_egg"
--      and/or "mobs:egg"
unilib.global.external_ingredient_table = {}

-- Table of hidden items (nodes, craftitems and tools for which the duplication mode "hide" was
--      applied; used to show hidden items in chat commands)
-- Table in the form
--      hidden_item_table[orig_name] = full_name
-- Table populated by code in ../lib/system/register/register_support_item.lua
unilib.global.hidden_item_table = {}

---------------------------------------------------------------------------------------------------
-- Global variables - miscellaneous values
---------------------------------------------------------------------------------------------------

-- Flag set to true (by update.lua) when all Minetest mods have been loaded
unilib.global.mods_loaded_flag = false

-- Local copy of the Minetest "enable_fire" setting, available for use by all packages. The value is
--      set in ../lib/system/global/global_update.lua
unilib.global.enable_fire_flag = nil
-- Local copy of the Minetest "enable_tnt" setting, available for use by all packages. The value is
--      set in ../lib/system/global/global_update.lua
unilib.global.enable_explosives_flag = nil

-- Flag set to true if unilib.setting.force_unipanes_flag is true, or if unilib is running on top of
--      minetest_game (set in ../lib/system/global/global_update.lua)
unilib.global.use_unipanes_flag = false

-- Group used with "admin" items. In creative mode, they should be visible in the player's
--      inventory; otherwise, they should be hidden
unilib.global.show_admin_item_group = 1
if core.settings:get_bool("creative_mode") then
    unilib.global.show_admin_item_group = nil
end

-- Max stack size of "squeezed" (compressed/condensed/compacted) blocks; later set to 999 if
--      unilib.setting.squeezed_overstack_flag is set. A nil value provides Minetest's default stack
--      size (99)
-- N.B. For stones, applied to the condensed variant, not the compressed variant
unilib.global.squeezed_stack_max = nil

---------------------------------------------------------------------------------------------------
-- Global variables - chat command modifiers
---------------------------------------------------------------------------------------------------

-- List of craft recipe conflicts which are deliberate
-- Used by the "chat_check_group_conflicts" package (and several others) as a list of exceptions
--      (ignored by those chat commands)
-- Every item in the list is a mini-list of two items, e.g.
--      { ... {"unilib:item_stick_ordinary 4", "unilib:material_charcoal_artificial_lump 8"} ... }
-- Packages can add new items to the list by calling unilib.register_craft_conflicts()
unilib.global.craft_recipe_conflict_list = {}

-- List of craft recipes which have missing ingredients deliberately
-- Used by the "chat_check_broken_recipes" and "chat_count_broken_recipes" packages as a list of
--      exceptions (ignored by thoses chat commands)
-- Every item in the list is a mini-list of two items, e.g.
--      { ... {"unilib:dye_grey_dark", "group:flower,colour_grey_dark"} ... }
-- Packages can add new items to the list by calling unilib.register_craft_missing_ingredients()
unilib.global.craft_recipe_missing_ingredient_list = {}
