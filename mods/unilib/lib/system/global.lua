---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- global.lua
--      Initialise global constants and variables, and import Minetest settings
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Minetest settings
---------------------------------------------------------------------------------------------------

-- Minetest settings are specified by the settingtypes.txt file
-- To override Minetest settings, see the ../lib/system/override.lua file

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Log settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

-- Show information messages in the debug file and the chat window
unilib.show_msg_flag = minetest.settings:get_bool("unilib_show_msg_flag", true)
-- Show error messages in the debug file and the chat window
unilib.show_error_flag = minetest.settings:get_bool("unilib_show_error_flag", true)
-- Show warning messages in the debug file and the chat window
unilib.show_warning_flag = minetest.settings:get_bool("unilib_show_warning_flag", true)

-- Show information about package imports (for debugging purposes). Ignored if unilib.show_msg_flag
--      is not set
-- Show information message for every package that appears more than once in the remix(es)
unilib.show_pkg_remix_flag = minetest.settings:get_bool("unilib_show_pkg_remix_flag", false)
-- Show information message for every loaded package
unilib.show_pkg_load_flag = minetest.settings:get_bool("unilib_show_pkg_load_flag", false)
-- Show information message for every initialised package
unilib.show_pkg_init_flag = minetest.settings:get_bool("unilib_show_pkg_init_flag", false)
-- Show information message for every executed package
unilib.show_pkg_exec_flag = minetest.settings:get_bool("unilib_show_pkg_exec_flag", false)
-- Show information message for every post-executed package
unilib.show_pkg_post_flag = minetest.settings:get_bool("unilib_show_pkg_post_flag", false)
-- Show extra debug messages when packages are being imported
unilib.show_pkg_debug_flag = minetest.settings:get_bool("unilib_show_pkg_debug_flag", false)

-- Show simple/detailed analysis about every dependent package that is not specified by a remix (the
--      output can be copied in the remix packages.csv file)
-- HINT: If either of these flags is true, the following flags are automatically set to true
--      (without which, the results would be incomplete):
--          unilib.force_replace_flag
--          unilib.force_load_dependent_pkg_flag
--          unilib.force_load_minimal_pkg_flag
--          unilib.force_load_optional_pkg_flag
--          unilib.force_load_suggested_pkg_flag
unilib.show_dependency_simple_flag =
        minetest.settings:get_bool("unilib_show_dependency_simple_flag", false)
unilib.show_dependency_detailed_flag =
        minetest.settings:get_bool("unilib_show_dependency_detailed_flag", false)
-- Flag set to true, if all specified remixes should be combined in one analysis; false if each
--      specified remix should be analysed separately
unilib.show_dependency_combined_flag =
        minetest.settings:get_bool("unilib_show_dependency_combined_flag", false)
-- Flag set to true, if the dependency analysis should not progress beyond the first hard dependency
--      (the .depends field in each package's entry in unilib.pkg_table) (not recommended)
unilib.show_dependency_hard_limit_flag =
        minetest.settings:get_bool("unilib_show_dependency_hard_limit_flag", false)
-- Flag set to true, if the dependency analysis should not progress beyond the first soft dependency
--      (the .at_least_one, .optional and .suggested fields in each package's entry in
--      unilib.pkg_table) (recommended)
unilib.show_dependency_soft_limit_flag =
        minetest.settings:get_bool("unilib_show_dependency_soft_limit_flag", true)

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Remix settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

-- A string containing one or more remixes, separated by whitespace (e.g. "mtgame bonemeal")
-- Each remix name matches the name of a directory in ../csv/remix
-- N.B. the remix name "everything" is reserved. If specified in this string, all remixes are
--      loaded in alphabetical order. This is intended for testing purposes only; it is not a good
--      way to set up a playable world. Note that even when all remixes are loaded, not all packages
--      will be loaded, as some of them are incompatible with each other
-- N.B. the remix name "nothing" is reserved. If specified in this string, no remixes are loaded;
--      it's the equivalent of commenting out the remix list. "nothing" cancels "everything", if
--      both are specified
-- N.B. the "default" remix contains material from minetest_game's default mod; it is not unilib's
--      default remix
unilib.remix_set = minetest.settings:get("unilib_remix") or "playme"
-- Built-in remixes specify, in their list of packages, all hard and soft dependencies; but no remix
--      is forced to do that
-- Flag set to true if, during the initialisation phase of ../lib/system/import_pkg.lua, any
--      package's hard dependencies should be loaded and initialised, if they haven't already been
unilib.force_load_dependent_pkg_flag =
        minetest.settings:get_bool("unilib_force_load_dependent_pkg_flag", true)
-- Flag set to true if, during the initialisation phase of ../lib/system/import_pkg.lua, any
--      package's minimal ("at least one") dependencies should be loaded and initialised, if they
--      haven't already been
unilib.force_load_minimal_pkg_flag =
        minetest.settings:get_bool("unilib_force_load_minimal_pkg_flag", false)
-- Flag set to true if, during the initialisation phase of ../lib/system/import_pkg.lua, any
--      package's soft dependencies should be loaded and initialised, if they haven't already been
unilib.force_load_optional_pkg_flag =
        minetest.settings:get_bool("force_load_optional_pkg_flag", false)
-- Flag set to true if, during the initialisation phase of ../lib/system/import_pkg.lua, any
--      package's suggested dependencies should be loaded and initialised, if they haven't already
--      been
unilib.force_load_suggested_pkg_flag =
        minetest.settings:get_bool("force_load_suggested_pkg_flag", false)

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Base package settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

-- Flag set to true if packages should be prevented from clearing registered biomes
unilib.protect_biomes_flag = minetest.settings:get_bool("unilib_protect_biomes_flag", false)
-- Flag set to true if packages should be prevented from clearing registered decorations
unilib.protect_decorations_flag =
        minetest.settings:get_bool("unilib_protect_decorations_flag", false)
-- Flag set to true if packages should be prevented from clearing registered ores
unilib.protect_ores_flag = minetest.settings:get_bool("unilib_protect_ores_flag", false)

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- minetest_game settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

-- Flag set to true if code adapted from minetest_game should be allowed to create items which don't
--      exist in the original code (i.e. an apple wood bookshelf exists and is created by the
--      "tree_apple" package, but an aspen wood bookshelf does not exist, yet it is created by the
--      "tree_aspen" package)
-- The value of the flag also applies to tweaks; for example, moreblocks updates some craft recipes
--      from minetest_game; if this flag is true, the updates are applied to unilib as well
unilib.mtgame_tweak_flag = minetest.settings:get_bool("unilib_mtgame_tweak_flag", true)

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Original mod settings (general)
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

-- Flag set to true if all the replace mode "replace" should apply to all source mods, replacing the
--      value specified in ../csv/mods/imported.csv
unilib.force_replace_flag = minetest.settings:get_bool("unilib_force_replace_flag", false)
-- Flag set to true to force unilib panes to use the "unipane" group, rather than the original
--      "pane" group. If false, the "unipane" group is used only when running on top of
--      minetest_game
unilib.force_unipanes_flag = minetest.settings:get_bool("unilib_force_unipanes_flag", false)

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Original mod settings (specific)
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

-- (advtrains)
-- Flag set to true if train platforms should be created for all suitable stone nodes. Automatically
--      set back to false if advtrains is not loaded
unilib.advtrains_update_flag = minetest.settings:get_bool("unilib_advtrains_update_flag", true)

-- (beacons)
-- Max height (in blocks) of a beacon, or 0 for infinite height
unilib.beacons_height_max = minetest.settings:get("unilib_beacons_height_max") or 0

-- (beautiflowers)
-- Amount of flowers to be generated (5 = normal, < 5 few, > 5 many)
unilib.beautiflowers_spawn_ratio = minetest.settings:get("unilib_beautiflowers_spawn_ratio") or 5

-- (biome_lib)
-- The mod provides an API with two functions, both are simulated crudely by unilib decorations
-- Calls to biome_lib.register_on_generate() are simulated by calls to
--      unilib.register_decoration_convertable() (in ../lib/system/register.lua)
-- The decoration's .fill_ratio varies from item to item. Its value is provided by a call to
--      unilib.convert_biome_lib() (in ../lib/shared/utils.lua). See the "bush_branching_yellow"
--      package for an example
-- A factor by which the .fill_ratio is multiplied, so that the decorations are not too numerous
unilib.biome_lib_spawn_factor = minetest.settings:get("unilib_biome_lib_deco_factor") or 0.1
-- Calls to biome_lib.register_active_spawner() are simulated as simple decorations with a
--      static value for the decoration's .fill_ratio (packages are free to use their own value, if
--      convenient)
unilib.biome_lib_fill_ratio = minetest.settings:get("unilib_biome_lib_fill_ratio") or 0.001

-- (cheese)
-- Allow imitation milks such as soy to be used in the cheese production process
unilib.cheese_allow_imitation_flag =
        minetest.settings:get_bool("unilib_cheese_allow_imitation_flag", true)

-- compass mods (various)
-- (death_compass) The number of seconds for which a death compass will remain active. Use 0 to let
--      the compass be active indefinitely
unilib.death_compass_duration = minetest.settings:get("unilib_death_compass_duration") or 0
-- (death_compass) Give a death compass to a player automatically, when they die
unilib.death_compass_auto_flag = minetest.settings:get_bool("unilib_death_compass_auto_flag", false)

-- (cottages)
-- Flag set to true if items from the cottages mode should be tweaked for slower computers
unilib.cottages_slow_flag = minetest.settings:get_bool("unilib_cottages_slow_flag", false)
-- Flag set to true if pitchforks should be able to dig all "fertile" turfs; false if they should
--      dig only ordinary dirt with turf
unilib.cottages_versatile_pitchfork_flag =
        minetest.settings:get_bool("unilib_cottages_versatile_pitchfork_flag", false)
-- The style of country roads to create (when the "road_country" package is loaded): "simple" for
--      full nodes with straight roads and no curves or junctions, "flat" for full nodes with curves
--      and junctions, "nodebox" like flat, but has a nodebox that fits to the node, "mesh" like
--      nodebox, but using a nice, roundish model
unilib.cottages_road_mode = minetest.settings:get("unilib_cottages_road_mode") or "mesh"

-- (cropocalypse)
-- Flag set to true to allow saltwater kelp "farming" in jars, providing a limitless food source
unilib.cropocalypse_infinite_kelp_flag =
        minetest.settings:get_bool("unilib_cropocalypse_infinite_kelp_flag", false)

-- (cucina_vegana)
-- Flag set to false for "farming" mod crops, true for "farming_redo" crops
unilib.cucina_vegana_redo_flag = minetest.settings:get_bool("unilib_cucina_vegana_redo_flag", true)

-- (earthbuild)
-- Flag set to true if the turf cutter can be used on all compatible dirt-with-turf nodes, or false
--      if it can only be used on ordinary dirt with turf (as in the original mod)
unilib.earthbuild_extend_cutter_flag =
        minetest.settings:get_bool("unilib_earthbuild_extend_cutter_flag", true)

-- (ethereal-ng)
-- Maximum fishing time, in seconds (the minimum is a third of this value; the maximum can be
--      further reduced by 20 seconds using bait, so don't use a value lower than 25)
unilib.ethereal_fishing_time = minetest.settings:get("unilib_ethereal_fishing_time") or 45
-- Flag set to true if fishing should produce fewer fish, and more junk items (makes fishing harder)
unilib.ethereal_fishing_hard_flag =
        minetest.settings:get_bool("unilib_ethereal_fishing_hard_flag", false)

-- (facade, mymillwork)
-- Flag for carving and milling machines. Set to true if only the owner can use them, set to false
--      if everyone can use them. Even when false, only the owner can remove the machine
unilib.protect_machines_flag = minetest.settings:get_bool("unilib_protect_machines_flag", false)

-- (fachwerk)
-- Fachwerk provides some timber-frame nodes that are actually duplicates, once they have been
--      adjusted with a screwdriver. Flag set to true to omit the duplicates, or false to provide
--      all timber-frame nodes
unilib.fachwerk_all_frames_flag =
        minetest.settings:get_bool("unilib_fachwerk_all_frames_flag", false)
-- unilib packages based on fachwerk can create a large number of timber-frame nodes that weren't
--      present in the original (using baked clay and various glass nodes). Flag set to true to
--      allow this, or false to not
unilib.fachwerk_extra_nodes_flag =
        minetest.settings:get_bool("unilib_fachwerk_extra_nodes_flag", false)

-- (flowerpot)
-- Flag set to true if all suitable flowers can be added to compatible flowerpots
unilib.flowerpot_add_flowers_flag
        = minetest.settings:get_bool("unilib_flowerpot_add_flowers_flag", true)
-- Flag set to true if all suitable mushrooms can be added to compatible flowerpots
unilib.flowerpot_add_mushrooms_flag
        = minetest.settings:get_bool("unilib_flowerpot_add_mushrooms_flag", false)
-- Flag set to true if all suitable ferns, grasses and plants can be added to compatible flowerpots
unilib.flowerpot_add_plants_flag
        = minetest.settings:get_bool("unilib_flowerpot_add_plants_flag", false)
-- Flag set to true if all suitable saplings can be added to compatible flowerpots
unilib.flowerpot_add_saplings_flag
        = minetest.settings:get_bool("unilib_flowerpot_add_saplings_flag", false)

-- (GLEM)
-- Flag set to true if custom dirts should be created on demand (i.e. when used in a custom biome),
--      or false if all possible custom dirts should be created
unilib.glem_dirt_on_demand_flag =
        minetest.settings:get_bool("unilib_glem_dirt_on_demand_flag", true)
-- Flag set to true if GLEM biome blending should be enabled
unilib.glem_biome_blend_flag = minetest.settings:get_bool("unilib_glem_biome_blend_flag", true)

-- (hangglider)
-- Warning time before hanggliders are shot down in no-fly zones
unilib.hangglider_no_fly_time = minetest.settings:get("unilib_hangglider_no_fly_time") or 3

-- (mesecons)
-- Flag set to true if mesecon circuits should automatically open/close doors
unilib.mesecons_door_flag = minetest.settings:get_bool("unilib_mesecons_door_flag", true)
-- Flag set to true if mesecon circuits should automatically open/close trapdoors
unilib.mesecons_trapdoor_flag = minetest.settings:get_bool("unilib_mesecons_trapdoor_flag", true)

-- (nettle)
-- Damage factor for nettles (default value is 1)
unilib.nettle_damage_factor = minetest.settings:get("unilib_nettle_damage_factor") or 1

-- (nsspf)
-- Scarcity factor. In the original code, mushrooms/fungi are extremely common (and therefore food
--      is easy to find). Increase this value to make NSSPF mushrooms/fungi more scarce
unilib.nsspf_scarcity_factor = minetest.settings:get("unilib_nsspf_scarcity_factor") or 1
-- Flag set to true if truffles can be found on the surface (ideal for servers); false if they are
--      found just beneath the surface (ideal for single player worlds)
unilib.nsspf_exposed_truffle_flag =
        minetest.settings:get_bool("unilib_nsspf_exposed_truffle_flag", true)

-- (pedology)
-- Drip mode (applies to certain items from pedology): "none" - don't use water drips, "entity" -
--      use entity-based water drips, "particle" - use particle-based water drips
unilib.pedology_drip_mode = minetest.settings:get("unilib_pedology_drip_mode") or "none"
-- Minimum light level at which permeable nodes dry out from direct sunlight
unilib.pedology_dry_light = minetest.settings:get("unilib_pedology_dry_light") or 13

-- (plantlife)
-- Use larger textures for ordinary grass (i.e. default:grass_1, etc)
unilib.plantlife_long_grass_flag =
        minetest.settings:get_bool("unilib_plantlife_long_grass_flag", false)
-- Flag set to true is poison ivy grows on a range of suitable surfaces, false if it grows only on a
--      small selection of nodes (as in the original code)
unilib.plantlife_poison_ivy_unfussy_flag =
        minetest.settings:get_bool("unilib_plantlife_poison_ivy_unfussy_flag", false)
-- Flag set to true if poison ivy requires light (but not too much) to grow, false if poison ivy
--      grows in all all conditions
unilib.plantlife_poison_ivy_light_flag =
        minetest.settings:get_bool("unilib_plantlife_poison_ivy_light_flag", false)
-- Flag set to true if poison ivy is actually poisonous, false if it is harmless (as in the original
--      mod)
-- (The damage is a multiple of unilib.nettle_damage_factor)
unilib.plantlife_poison_ivy_poison_flag =
        minetest.settings:get_bool("unilib_plantlife_poison_ivy_poison_flag", false)

-- (real_torch)
-- Minimum time (in seconds) after which an ordinary torch burns out, becoming an unlit torch
--      (N.B. two default values in original code - 480 and 1200)
unilib.real_torch_min_time = minetest.settings:get("unilib_real_torch_min_time") or 480
-- Maximum time (in seconds) after which an ordinary torch burns out, becoming an unlit torch
--      (N.B. two default values in original code - 600 and 1800)
unilib.real_torch_max_time = minetest.settings:get("unilib_real_torch_max_time") or 600

-- (sickles)
-- Flag set to true if scythes should use the mechanic from the sickles mod (replant crops/produce
--      in the surrounding soil), false if scythes should use the mechanic from the farming_redo mod
--      (harvested crops/produce and seeds are dropped to the ground)
unilib.sickles_replant_flag = minetest.settings:get_bool("unilib_sickles_replant_flag", true)
-- Flag set to true if the sickle mechanic should override the pitchfork mechanic inherited from
--      the cottages mod ("tool_pitchfork" package)
unilib.sickles_override_pitchfork_flag =
        minetest.settings:get_bool("unilib_sickles_override_pitchfork_flag", false)

-- (snow)
-- Flag set to true to reduce the system resources required to produce falling snowflakes
unilib.snow_reduce_snowflakes_flag =
        minetest.settings:get_bool("unilib_snow_reduce_snowflakes_flag", true)

-- (technic)
-- Flag set to true if technic should be given grinding recipes for suitable stone types/metal
--      lumps/mineral lumps. Automatically set back to false if technic is not loaded
unilib.technic_update_flag = minetest.settings:get_bool("unilib_technic_update_flag", true)
-- Flag set to true if technic should be given additional recipes, mostly for foods and ingredients
--      (this may include grinder recipes)
unilib.technic_extra_flag = minetest.settings:get_bool("unilib_technic_extra_flag", true)
-- How much powder is produced when grinding metal ores (minimum 1, recommended 2)
unilib.grind_metal_ratio = minetest.settings:get("unilib_grind_metal_ratio") or 2
-- How much powder is produced when grinding mineral ores (minimum 1, recommended 2)
unilib.grind_mineral_ratio = minetest.settings:get("unilib_grind_mineral_ratio") or 2
-- How much powder is produced when grinding stone (minimum 1, recommended 1)
unilib.grind_stone_ratio = minetest.settings:get("unilib_grind_stone_ratio") or 1

-- (toolranks)
-- Flag set to true if toolranks should be enabled for compatible tools
unilib.toolranks_enable_flag = minetest.settings:get_bool("unilib_toolranks_enable_flag", true)
-- Number of levels for toolranks
unilib.toolranks_max_levels = minetest.settings:get("unilib_toolranks_max_levels") or 10
-- Number of nodes that need to be dug to reach the next tool level
unilib.toolranks_nodes_per_level = minetest.settings:get("unilib_toolranks_nodes_per_level") or 500
-- Maximum dig speed multiplier for toolranks (1.0 to disable)
unilib.toolranks_speed_multiplier =
        minetest.settings:get("unilib_toolranks_speed_multiplier") or 2.0
-- Maximum durability multiplier for toolranks (1.0 to disable)
unilib.toolranks_use_multiplier =
        minetest.settings:get("unilib_toolranks_use_multiplier") or 2.0

-- Flag set to true if the server's most advanced tool should be announced in chat
unilib.toolranks_announce_flag = minetest.settings:get_bool("unilib_toolranks_announce_flag", false)
-- Flag set to true if levelling should be progressive (each new level takes 50% more time than the
--      previous one)
unilib.toolranks_progressive_flag =
    minetest.settings:get_bool("unilib_toolranks_progressive_flag", true)
-- Flag set to true if the tool's description should show how long until level-up
unilib.toolranks_countdown_flag
    = minetest.settings:get_bool("unilib_toolranks_countdown_flag", true)

-- (towercrane)
-- Maximum crane height in nodes (8..n)
unilib.crane_max_height = minetest.settings:get("unilib_crane_max_height") or 32
-- Maximum crane width in nodes (8..n)
unilib.crane_max_width = minetest.settings:get("unilib_crane_max_width") or 32
-- Crane rope length in nodes (max_height .. max_height+x). If the rope length is larger than the
--      crane height, the crane can be placed on buildings and the player still reaches the ground
unilib.crane_rope_length = minetest.settings:get("unilib_crane_rope_length") or 40

-- (trash_can)
-- Allow player to throw items into rubbish bin / dumpster (requires some additional processing
--      time)
unilib.trash_can_throw_flag = minetest.settings:get_bool("unilib_trash_can_throw_flag", true)

-- (tsm_pyramids)
-- Flag set to true if sandstone traps collapse under the player, false if they are merely
--      decorative
unilib.tsm_pyramids_real_trap_flag =
        minetest.settings:get_bool("unilib_tsm_pyramids_real_trap_flag", true)

-- (underch, uchu)
-- Flag set to true if code adapted from underch should be modified to include updates in uchu
unilib.underch_tweak_flag = minetest.settings:get_bool("unilib_underch_tweak_flag", true)
-- Flag set to true if flowing ordinary lava should cool into basalt, rather than cooling into
--      ordinary stone (i.e. set to true to apply the underch override)
unilib.underch_override_abm_flag =
        minetest.settings:get_bool("unilib_underch_override_abm_flag", true)
-- Flag set to true if condensed cobble/rubble nodes should have a maximum stack size of 999
unilib.underch_overstack_condensed_flag
        = minetest.settings:get_bool("unilib_underch_overstack_condensed_flag", true)

-- (unifieddyes)
-- Flag set to true if suitable items can be dyed. Automatically set back to false if unifieddyes is
--      not loaded
unilib.unifieddyes_update_flag = minetest.settings:get_bool("unilib_unifieddyes_update_flag", true)

-- (unified_inventory)
-- Flag set to true if unified_inventory should be given textures for group craft recipes.
--      Automatically set back to false if unified_inventory is not loaded
unilib.unified_inventory_update_flag
        = minetest.settings:get_bool("unilib_unified_inventory_update_flag", true)

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Biome/decoration/ore settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

-- Flag set to true if a seed offset is applied to decorations and ores, so that distributions are
--      different in each world
unilib.random_seed_offset_flag = minetest.settings:get_bool("unilib_random_seed_offset_flag", false)

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Environment settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

-- Super stones - a set of stone types that can be used to craft derivative products (for example,
--      we don't create timber-framed nodes from every available stone, but only from super stones).
--      Note that some items may not be available in every stone type (e.g. sandstones, stones of a
--      hardness that could produce cobble/rubble variants, but don't). If the set contains the word
--      "everything", then all suitable stones are super stones. If the set contains the word
--      "nothing", then no stones are super stones, overriding "everything"
-- Note that unilib creates a full range of stairs and carvings for super stones (depending on
--      whether the stairs/carvings settings below are enabled). For all other stones, only basic
--      stairs are created for smoothstone, cobble and rubble nodes, and walls are created for
--      cobble nodes
unilib.super_stone_set = minetest.settings:get("unilib_super_stone_set") or "desert ordinary"
-- Super trees - a set of tree types that can be used to craft derivative products (for example,
--      we don't create bookshelves out of every available tree, but only from super trees). Note
--      that some items may not be available in every tree type (e.g. wooden boats). Note also that
--      fences/gates are created for every tree, when possible. If the set contains the word
--      "everything", then all suitable trees are super trees (some trees are not suitable, usually
--      because they have no wood nodes). If the set contains the word "nothing", then no trees are
--      super trees, overriding "everything"
-- Note that unilib creates a range of stairs and carvings for super stone woods (depending on
--      whether the stairs/carvings settings below are enabled). For all other wood noes, only basic
--      stairs are created
unilib.super_tree_set = minetest.settings:get("unilib_super_tree_set") or
        "acacia aspen apple jungle pine"

-- In the original mods, some stones have unrealistic hardnesses (e.g. sandstones in
--      minetest_game). Flag set to true if these should be replaced by a "real-world" hardness
unilib.real_stone_hardness_flag =
        minetest.settings:get_bool("unilib_real_stone_hardness_flag", false)
-- Sandstones should not produce cobble or rubble when dug, by default. When the original mod
--      specifies a cobble or rubble, that choice is respected. Otherwise, cobble or rubble is
--      produced only when this flag is true
unilib.sandstone_cobble_rubble_flag =
        minetest.settings:get_bool("unilib_caves_chop_dirt_flag", false)

-- Flag set to true if caves chop through (most) dirt nodes, including dirt-with-turf nodes
unilib.caves_chop_dirt_flag = minetest.settings:get_bool("unilib_caves_chop_dirt_flag", false)
-- Flag set to true if dirt-with-turf nodes should use the top texture on all sides (except the
--      bottom); if false, both the turf and the dirt is usually visible on the sides
unilib.overgrown_turf_flag = minetest.settings:get_bool("unilib_overgrown_turf_flag", false)

-- Flag set to true if wooden planks, when placed in the world, should be auto-rotated to face a
--      standard direction
unilib.auto_rotate_wood_flag = minetest.settings:get_bool("unilib_auto_rotate_wood_flag", false)
-- Flag set to true if leaves should be 3d-rendered in the player's inventory and when wielded,
--      false if not. (You may find it easier to distinguish leaves in the inventory when they are
--      not 3d-rendered)
unilib.rendered_leaves_flag = minetest.settings:get_bool("unilib_rendered_leaves_flag", false)
-- Flag set to true if trees should have plant-like leaves (which can improve frame rates for some
--      users, without restoring to making leaves opaque)
unilib.plantlike_leaves_flag = minetest.settings:get_bool("unilib_plantlike_leaves_flag", false)
-- Flag set to true if the player can walk on leaves, false if not
unilib.walkable_leaves_flag = minetest.settings:get_bool("unilib_walkable_leaves_flag", false)
-- Flag set to true if most fruit, nuts, cones etc should regrow after being picked
unilib.regrow_fruit_flag = minetest.settings:get_bool("unilib_regrow_fruit_flag", true)
-- Flag set to true if most leaves should drop ordinary sticks (as well as saplings)
unilib.leaves_drop_sticks_flag = minetest.settings:get_bool("unilib_leaves_drop_sticks_flag", false)

-- Minimum sapling growth time. Actual time is a random value between the minimum/maximum times
unilib.sapling_grow_min = minetest.settings:get("unilib_sapling_grow_min") or 300
-- Maxium sapling growth time. Actual time is a random value between the minimum/maximum times
unilib.sapling_grow_max = minetest.settings:get("unilib_sapling_grow_max") or 1500
-- Standard growth time, when a non-random value is required
unilib.sapling_grow_default = minetest.settings:get("unilib_sapling_grow_default") or 300
-- Sapling sapling growth retry time (if growth cannot occur, the time before trying again)
unilib.sapling_grow_retry = minetest.settings:get("unilib_sapling_grow_retry") or 300
-- Flag set to true if sapling growth times should be replaced with very short values (5 seconds)
--      for testing purposes. If true, overrides the growth settings above
unilib.sapling_quick_grow_flag = minetest.settings:get_bool("unilib_sapling_quick_grow_flag", false)
-- Flag set to true if tree sapling growth times should be adjusted, based on the height of the tree
--      (so redwoods take much longer to grow, on average, than acacia trees). Does not work with
--      trees using custom or LBM code; does not work with bushes, ignored when
--      unilib.sapling_quick_grow_flag is enabled
unilib.sapling_variable_grow_flag =
        minetest.settings:get_bool("unilib_sapling_variable_grow_flag", false)
-- Flag set to true if a sapling that requires specific dirts can grow on any dirt, if the specific
--      dirts have not been loaded
unilib.sapling_override_flag = minetest.settings:get_bool("unilib_sapling_override_flag", true)
-- Flag set to true if all saplings should grow on all dirts, overriding package preferences
unilib.sapling_everywhere_flag = minetest.settings:get_bool("unilib_sapling_everywhere_flag", false)

-- Standard growth time for a stage of crop/produce growth, in seconds
unilib.crop_produce_grow_default =
        minetest.settings:get("unilib_crop_produce_grow_default") or 160.0

-- Flag set to true if flora should be floodable (items are destroyed by a flowing liquid). This
--      setting applies to most flowers, plants, mushrooms, ferns, crops, produce (even those from
--      other mods)
unilib.floodable_flora_flag = minetest.settings:get_bool("unilib_floodable_flora_flag", false)
-- Flag set to true if flora should be flushable (items are uprooted by a flowing liquid, as in
--      Minecraft). If the floodable flag is also true, this one takes precedence
unilib.flushable_flora_flag = minetest.settings:get_bool("unilib_flushable_flora_flag", false)

-- Flag set to true if papyrus should be impassable
unilib.blocking_papyrus_flag = minetest.settings:get_bool("unilib_blocking_papyrus_flag", true)
-- Flag set to true if waterlilies should be walkable
unilib.walkable_waterlilies_flag =
    minetest.settings:get_bool("unilib_walkable_waterlilies_flag", true)

-- ABM Spread factor. If 1, flora, mushrooms and turf spread at their normal rate. If 2, they spread
--      twice as quickly. If 0.5, they spread twice as slowly
unilib.abm_spread_factor = minetest.settings:get("unilib_abm_spread_factor") or 1

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Non-environment settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

-- Flag set to true to disable unilib's standard ABMs/LBMs. If false, the standard ABMs/LBMs are
--      enabled only when a suitable base package like "base_mtgame" asks for them to be enabled
unilib.disable_standard_abm_lbm_flag =
        minetest.settings:get_bool("unilib_disable_standard_abm_lbm_flag", false)
-- Flag set to true to enable unilib's standard ABMs/LBMs, even if no suitable base package like
--      "base_mtgame" has asked for them to be enabled. However, this flag is IGNORED if the
--      disable setting just above is true
unilib.enable_standard_abm_lbm_flag =
        minetest.settings:get_bool("unilib_enable_standard_abm_lbm_flag", false)

-- Flag set to true if brick blocks (including decorative bricks), when placed in the world, should
--      be auto-rotated to face a standard direction
unilib.auto_rotate_brick_flag = minetest.settings:get_bool("unilib_auto_rotate_brick_flag", false)

-- Flag to allow player to craft dyes from crops, fruit etc. (Note that almost all flowers can be
--      used to craft dyes, by default)
unilib.dye_from_crops_flag = minetest.settings:get_bool("unilib_dye_from_crops_flag", false)
unilib.dye_from_fruit_flag = minetest.settings:get_bool("unilib_dye_from_fruit_flag", false)
unilib.dye_from_produce_flag = minetest.settings:get_bool("unilib_dye_from_produce_flag", false)

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Stair/wall/carving settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

-- Flag set to true if suitable nodes (stone, wood etc) should be given basic stairs
unilib.add_stairs_basic_flag = minetest.settings:get_bool("unilib_add_stairs_basic_flag", true)
-- Flag set to true if basic stairs should appear in the creative inventory
unilib.show_stairs_basic_flag = minetest.settings:get_bool("unilib_show_stairs_basic_flag", false)
-- Flag set to true if suitable nodes should be given stairs from the stairs_redo mod
unilib.add_stairs_stairs_redo_flag =
        minetest.settings:get_bool("unilib_add_stairs_stairs_redo_flag", false)
-- Flag set to true if stairs from stairs_redo should appear in the creative inventory
unilib.show_stairs_stairs_redo_flag =
        minetest.settings:get_bool("unilib_show_stairs_stairs_redo_flag", false)
-- Flag set to true if suitable nodes should be given stairs from the stairsplus mod
unilib.add_stairs_stairsplus_flag =
        minetest.settings:get_bool("unilib_add_stairs_stairsplus_flag", false)
-- Flag set to true if stairs from stairsplus should appear in the creative inventory
unilib.show_stairs_stairsplus_flag =
        minetest.settings:get_bool("unilib_show_stairs_stairsplus_flag", false)
-- Flag set to true if suitable nodes should be given stairs from the moreblocks mod
unilib.add_stairs_moreblocks_flag =
        minetest.settings:get_bool("unilib_add_stairs_moreblocks_flag", false)
-- Flag set to true if stairs from moreblocks should appear in the creative inventory
unilib.show_stairs_moreblocks_flag =
    minetest.settings:get_bool("unilib_show_stairs_moreblocks_flag", false)
-- Flag set to true if suitable nodes should be given stairs from the plantlife mod
unilib.add_stairs_plantlife_flag =
        minetest.settings:get_bool("unilib_add_stairs_plantlife_flag", false)
-- Flag set to true if stairs from plantlife should appear in the creative inventory
unilib.show_stairs_plantlife_flag =
    minetest.settings:get_bool("unilib_show_stairs_plantlife_flag", false)
-- Flag set to true if suitable nodes should be given stairs from the castle modpack
unilib.add_stairs_castle_flag = minetest.settings:get_bool("unilib_add_stairs_castle_flag", false)
-- Flag set to true if stairs from the castle modpack should appear in the creative inventory
unilib.show_stairs_castle_flag = minetest.settings:get_bool("unilib_show_stairs_castle_flag", false)
-- Flag set to true if suitable nodes should be given stairs from the pkarcs modpack
unilib.add_stairs_pkarcs_flag = minetest.settings:get_bool("unilib_add_stairs_pkarcs_flag", false)
-- Flag set to true if stairs from the pkarcs modpack should appear in the creative inventory
unilib.show_stairs_pkarcs_flag = minetest.settings:get_bool("unilib_show_stairs_pkarcs_flag", false)

-- Flag set to true if stairs made from smooth stone just drop stairs made from cobblestone, when
--      dug (applies to all suitable stair nodes)
unilib.convert_stairs_on_drop_flag =
        minetest.settings:get_bool("unilib_convert_stairs_on_drop_flag", true)
-- Flag set to true if the amount of light generated by stairs as light sources reduces by volume,
--      false if not (the effect is more drastic than for moreblocks)
unilib.reduce_stair_light_flag = minetest.settings:get_bool("unilib_reduce_stair_light_flag", true)
-- Flag set to true if node roation is handled as it is in moreblocks; false when node rotation is
--      is handled as it is minetest_game/stairs. Note that moreblocks-style rotation is not applied
--      to stair types from plantlife. Note also that separate code handles rotation for stair types
--      from pkarcs, ignoring other settings
unilib.advanced_stair_rotation_flag =
        minetest.settings:get_bool("unilib_advanced_stair_rotation_flag", true)

-- Flag set to true if suitable nodes (mostly stone) should be given walls
unilib.add_walls_flag = minetest.settings:get_bool("unilib_add_walls_flag", true)

-- Flag set to true if suitable nodes (stone, wood etc) should be given column carvings
unilib.add_carvings_column_flag =
        minetest.settings:get_bool("unilib_add_carvings_column_flag", true)
-- Flag set to true if column carvings should appear in the creative inventory
unilib.show_carvings_column_flag =
        minetest.settings:get_bool("unilib_show_carvings_column_flag", false)
-- Flag set to true if suitable nodes (stone, wood etc) should be given facade carvings
unilib.add_carvings_facade_flag =
        minetest.settings:get_bool("unilib_add_carvings_facade_flag", true)
-- Flag set to true if facade carvings should appear in the creative inventory
unilib.show_carvings_facade_flag =
        minetest.settings:get_bool("unilib_show_carvings_facade_flag", false)
-- Flag set to true if suitable nodes (stone, wood etc) should be given millwork carvings
unilib.add_carvings_millwork_flag =
        minetest.settings:get_bool("unilib_add_carvings_millwork_flag", true)
-- Flag set to true if millwork carvings should appear in the creative inventory
unilib.show_carvings_millwork_flag =
        minetest.settings:get_bool("unilib_show_carvings_millwork_flag", false)

-- Flag set to true if the amount of light generated by carvings as light sources reduces by volume,
--      false if not (the effect is less drastic than for stair nodes in moreblocks)
unilib.reduce_carving_light_flag =
        minetest.settings:get_bool("unilib_reduce_carving_light_flag", true)

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Player effects settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

-- Flag set to true if the player should be warned that their tool is about to break
unilib.toolranks_warn_break_flag =
        minetest.settings:get_bool("unilib_toolranks_warn_break_flag", true)

-- Flag set to true to make (most) beds bouncy
unilib.effects_bouncy_beds_flag =
        minetest.settings:get_bool("unilib_effects_bouncy_beds_flag", true)
-- Flag set to true if bright items, when wielded, illuminate the player's surroundings
unilib.effects_wield_light_flag =
        minetest.settings:get_bool("unilib_effects_wield_light_flag", true)

-- Flag set to true to pick up items automatically (Minecraft-style)
unilib.magnet_auto_get_flag = minetest.settings:get_bool("unilib_magnet_auto_get_flag", false)
-- Flag set to true to drop items automatically, when dug (Minecraft-style)
unilib.magnet_auto_drop_flag = minetest.settings:get_bool("unilib_magnet_auto_drop_flag", false)
-- Flag set to true if a key should be pressed to auto-get items
unilib.magnet_get_key_flag = minetest.settings:get_bool("unilib_magnet_get_key_flag", true)
-- Flag set to true if a key should NOT be pressed in order to auto-get items
unilib.magnet_no_get_key_flag = minetest.settings:get_bool("unilib_magnet_no_get_key_flag", true)
-- The auto-get keytype
unilib.magnet_get_key_type = minetest.settings:get("unilib_magnet_get_key_type") or "Use"
-- The volume of the auto-get sound
unilib.magnet_auto_get_volume = minetest.settings:get("unilib_magnet_auto_get_volume") or 0.4
-- Flag set to true to display particles on auto-get
unilib.magnet_auto_get_particle_flag =
        minetest.settings:get_bool("unilib_magnet_auto_get_particle_flag", true)
-- The magnet radius (in blocks) in which auto-get works
unilib.magnet_auto_get_radius = minetest.settings:get("unilib_magnet_auto_get_radius") or 0.75
-- The magnet radius (in blocks) in which items fly towards the player. Set to -1 to disable item
--      flying
unilib.magnet_auto_fly_radius = minetest.settings:get("unilib_magnet_auto_fly_radius") or -1
-- Maximum item flight duration (in seconds). After the time has elapsed, items are added to the
--      player's inventory
unilib.magnet_auto_fly_time = minetest.settings:get("unilib_magnet_auto_fly_time") or 5.0
-- Time delay (in seconds) before auto-getting an item if it's dropped by a player
unilib.magnet_auto_get_delay = minetest.settings:get("unilib_magnet_auto_get_delay") or 0.5
-- Flag set to true if getting an item using a mouse click is enabled
unilib.magnet_click_get_flag = minetest.settings:get_bool("unilib_magnet_click_get_flag", true)

-- Hotbar size, a value between 1 and 32. Use 0 if you don't want to interfere with the hotbar size
unilib.hotbar_size = minetest.settings:get("unilib_hotbar_size") or 8

-- Flag set to true to enabled advanced cuisine (eating the same food types reduces their satiating
--      effect; drinks improve hydration if enabled, otherwise behave as foods)
unilib.cuisine_advanced_flag = minetest.settings:get_bool("unilib_cuisine_advanced_flag", true)
-- Size of the cuisine history (a list of food groups, so the actual number of food items eaten may
--      be fewer). The larger the number, the more a player must vary their diet
unilib.cuisine_history_max_size = minetest.settings:get("unilib_cuisine_history_max_size") or 10
-- Satiation bonus, applied when the player eats something new (ignored if player activity
--      statistics are disabled). Use 2 to double the satiation for eating a new food, or 0.5 to
--      halve it. Bonus does not apply to poisonous/zero-satiation items, or to drinks when
--      hydration is enabled
unilib.cuisine_novelty_factor = minetest.settings:get("unilib_cuisine_novelty_factor") or 1.5

-- Flag set to true to enable player hunger
unilib.hunger_enable_flag = minetest.settings:get_bool("unilib_hunger_enable_flag", true)
-- Hunger factor - use 2 to double the rate at which the player becomes hungry, or 0.5 to halve it
unilib.hunger_factor = minetest.settings:get("unilib_hunger_factor") or 1.0
-- Flag set to true to enable player hunger due to sprinting
unilib.hunger_on_sprint_flag = minetest.settings:get_bool("unilib_hunger_on_sprint_flag", true)
-- Sprinting factor - use 2 to double the rate at which the player becomes hungry due to sprinting,
--      or 0.5 to halve it
unilib.hunger_on_sprint_factor = minetest.settings:get("unilib_hunger_on_sprint_factor") or 1.0

-- Flag set to true to enable player hydration/thirst
unilib.thirst_enable_flag = minetest.settings:get_bool("unilib_thirst_enable_flag", false)
-- Thirst factor - use 2 to double the rate at which the player becomes thirsty, or 0.5 to halve it
unilib.thirst_factor = minetest.settings:get("unilib_thirst_factor") or 1.0

-- Flag set to true to enable HUD windows identifying the node at which the mouse is pointed. The
--       window is shown or hidden when the player types /what
unilib.identify_enable_hud_flag
        = minetest.settings:get_bool("unilib_identify_enable_hud_flag", true)
-- Flag set to true to optimise the HUD window for servers (only appears when a node is punched)
unilib.identify_optimise_hud_flag
        = minetest.settings:get_bool("unilib_identify_optimise_hud_flag", false)
-- Flag set to true to show the parent unilib package, rather than the mod name, when possible
unilib.identify_package_name_flag
        = minetest.settings:get_bool("unilib_identify_package_name_flag", false)

-- Flag set to true to enable daily alarms
unilib.alarm_enable_flag = minetest.settings:get_bool("unilib_alarm_enable_flag", true)

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Player effects settings (statistics and calendars)
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

-- Flag set to true, if player's biographical data (births, deaths etc) should be stored in player
--      attributes
-- (N.B. data is deserialised and stored in unilib.player_stats)bio_table, while the player is
--      connected)
unilib.stats_bio_flag = minetest.settings:get_bool("unilib_stats_bio_flag", true)
-- Flag set to true, if player's activity data (nodes dug/placed etc) should be stored in player
--      attributes
-- (N.B. data is deserialised and stored in unilib.player_stats_activity_table, while the player is
--      connected)
unilib.stats_activity_flag = minetest.settings:get_bool("unilib_stats_activity_flag", true)

-- Calendar offsets, specifying the date at which the calendar starts. Positive integers only,
--      invalid values are reset to 1 (in ../lib/effets/calendar.lua)
unilib.calendar_year_offset = minetest.settings:get("unilib_calendar_year_offset") or 1000
unilib.calendar_month_offset = minetest.settings:get("unilib_calendar_month_offset") or 1
unilib.calendar_day_offset = minetest.settings:get("unilib_calendar_day_offset") or 1
-- Calendar system; a string describing the date system. An empty string is acceptable, in which
--      case the system isn't added to a date string
unilib.calendar_system = minetest.settings:get("unilib_calendar_system") or S("A.D.")
-- Flag set to true if leap years are in effect, false if not. If true, a leap day is added to
--      the second month of the year
unilib.calendar_leap_year_flag = minetest.settings:get_bool("unilib_calendar_leap_year_flag", true)
-- Standard date string format, in which certain values are substituted (see the comments in the
--      unilib.format_date() function, in ../lib/effects/calendar.lua)
unilib.calendar_format_string = minetest.settings:get("unilib_calendar_format_string") or
        "%D, %d %M %y %S %E %T"
-- Flag set to true if calendar tooltips are enabled. If false, the tooltip text can be viewed by
--      clicking on each day's button
unilib.calendar_enable_tooltips_flag =
        minetest.settings:get_bool("unilib_calendar_enable_tooltips_flag", true)
-- Offset controlling which day the calendar week starts, e.g. 0 for Sunday, 1 for Monday, etc
unilib.calendar_week_start_offset = minetest.settings:get("unilib_calendar_week_start_offset") or 1

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Age-appropriate settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

-- Flag set to true if packages providing alcoholic drinks are enabled. If false, any such package
--      is not executed, even when it is specified by a remix. Note that unilib treats these items
--      like ordinary drinks; there are no game mechanics simulating intoxication. Note also that
--      unilib does not provide any other controlled substances (such as tobacco or narcotics)
unilib.enable_adult_content_flag
        = minetest.settings:get_bool("unilib_enable_adult_content_flag", false)

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Debug settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

-- Flag set to true to remove the not_in_creative_inventory group from all nodes, craftitems and
--      tools
unilib.debug_all_inventory_flag =
        minetest.settings:get_bool("unilib_debug_all_inventory_flag", false)
-- Flag set to true if the full name of a node/craftitem/tool should be added to its description, so
--      that it is visible in the inventory
unilib.debug_add_name_flag = minetest.settings:get_bool("unilib_debug_add_name_flag", false)
-- Flag set to true if the original name of a node/craftitem/tool should be added to its
--      description, so that it is visible in the inventory. Applies only to unilib items
unilib.debug_add_orig_name_flag =
        minetest.settings:get_bool("unilib_debug_add_orig_name_flag", false)
-- Ambient light level, an integer in the range 0-14. If above 0, all (unilib) nodes emit at least
--      that amount of light. Recommended values: 0 or 4-5
unilib.debug_force_light_source = minetest.settings:get("unilib_debug_force_light_source") or 0
-- Flag set to true to make all stone transparent, and disable falling nodes (used for checking ore
--      distributions)
-- N.B. This setting disables decorations (both in unilib, and in the original mod)
-- N.B. It is recommended that the debug ambient light setting be increased from 0
-- N.B. See also the /trench command
unilib.debug_xray_flag = minetest.settings:get_bool("unilib_debug_xray_flag", false)
-- Flag set to true if all biomes, decorations and ores should be checked for valid values of
--      .y_max and .y_min
unilib.debug_check_heights_flag =
        minetest.settings:get_bool("unilib_debug_check_heights_flag", false)
-- Forced biome. If set, only the specified unilib biome will be created, and its height/heat/
--      humidity parameters will be reset, so that it occurs all over the world
unilib.debug_forced_biome = minetest.settings:get("unilib_debug_forced_biome") or ""

---------------------------------------------------------------------------------------------------
-- Global variables - mods, remixes and packages
---------------------------------------------------------------------------------------------------

-- All source mods are listed in a CSV file (../csv/mods/source.csv), and also registered as a table
-- Table in the form
--      source_mod_table[mod_name] = data_table
-- "data_table" consists of the following compulsory key-value pairs:
--      .mod_name = The mod's name, e.g. "default"
--      .modpack_name = The name of the modpack, if any, e.g. "minetest_game"
--      .date = Date on which the mod was downloaded, before its code/media was imported. Date as a
--          string in the form "YYYYMMDD"
--      .url = URL from which the mod was downloaded
--      .author = The lead author(s), e.g. "celeron55/Perttu Ahola"
--      .code = The code licence, e.g. "LGPL 2.1"
--      .media = The media licence, e.g. "CC BY-SA 3.0"
--      .notes = A brief summary of what has been imported (may contain spoilers)
-- Table populated by code in ../lib/system/read_csv.lua
unilib.source_mod_table = {}

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
-- Table populated by code in ../lib/system/read_csv.lua
unilib.imported_mod_table = {}

-- All mods which are directly compatible with unilib (and which are not already listed in
--      source.csv) are listed in a single CSV file (../csv/mods/compatible.csv). Any mod listed in
--      this file is expected to appear in unilib's mod.conf
-- "Directly compatible" means that unilib interacts with the mod in some way, for example by
--      providing new craft recipes (or by using the mod's items in unilib craft recipes)
-- Note that unilike unilib.source_mod_table and unilib.imported_mod_table, this table is for
--      information only, and has no dependent code
-- Table in the form
--      compatible_mod_table[mod_name] = data_table
-- "data_table" consists of the following compulsory key-value pairs:
--      .mod_name = The name of the mod or modpack, e.g. "technic"
--      .modpack_name = The name of the modpack, if any, e.g. "technic" (popuplar modpacks often
--          include a mod with the same name)
--      .url = URL from which the mod(pack) can be downloaded
--      .notes = A brief summary of how unilib interacts with the mod (may contain spoilers)
-- Table populated by code in ../lib/system/read_csv.lua
unilib.compatible_mod_table = {}

-- Some items (e.g. "unilib:chain_steel_link") have been imported from another mod
--      ("basic_materials:chainlink_steel"), using code which was in turn imported from a third mod
--      ("glooptest:chainlink")
-- All mods from which code or media has been imported indirectly, via one of the mods listed in
--      source.csv or compatible.csv, are listed in a single CSV file (../csv/mods/external.csv).
--      Any mod listed in this file is expected to appear in unilib's mod.conf
-- Like unilib.compatible_mod_table, this table is for information only, and has no dependent code.
-- In most cases, when a unilib item replaces an item from another mod, it also replaces the
--      corresponding item in any external mods (e.g. "unilib:chain_steel_link" can replace both
--      "basic_materials:chainlink_steel" and "glooptest:chainlink", if they both exist. See the
--      "chain_steel" package for some example code)
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
-- Table populated by code in ../lib/system/read_csv.lua
unilib.external_mod_table = {}

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
-- A list of remixes, compiled from the value of unilib.remix_set (above) and preserving the same
--      order
-- List populated by code in ../lib/system/read_csv.lua
unilib.remix_list = {}
-- A table of paths remix folders, one for each remix in unilib.remix_list. unilib first looks for a
--      remix in ../custom/remixes, and if the remix is not found, it looks in ../csv/remixes
-- Table in the form
--      remix_path_table[remix_name] = full_path_to_remix_folder
-- Table populated by code in ../lib/system/read_csv.lua
unilib.remix_dir_table = {}
-- A table of remixes, showing the packages specified by each (not including duplicate packages)
-- Table in the form
--      remix_pkg_table[remix_name] = list_of_pkg_names
-- Table populated by code in ../lib/system/read_csv.lua
unilib.remix_pkg_table = {}
-- A table of remixes, showing the number of packages specified by each (not including duplicate
--      packages). The data is shown as a confirmation message by init.lua
-- Table in the form
--      remix_pkg_count_table[remix_name] = number_of_pkgs
-- Table populated by code in ../lib/system/read_csv.lua
unilib.remix_pkg_count_table = {}

-- A list of package names specified by the loaded remixes, preserving the order in which they're
--      specified, but with duplicate packages already eliminated
-- Note that this list (and the equivalent table below) don't include hard/soft dependent packages
--      forced-loaded during the execution stage
-- List populated by code in ../lib/system/read_csv.lua
unilib.pkg_setup_list = {}
-- A table of package names, containing every package in unilib.pkg_setup_list
-- Table in the form
--      pkg_setup_table[pkg_name] = source_mod
-- ...where the "source_mod" is usually specified by the remix (but is an empty string, if not)
-- Table populated by code in ../lib/system/read_csv.lua
unilib.pkg_setup_table = {}
-- The same list of package names, but with any packages that could not be loaded at all eliminated
--      (otherwise preserving the order of the original)
-- List populated by code in ../lib/system/import_pkg.lua
unilib.pkg_loaded_list = {}
-- A table of package names, containing every package in unilib.pkg_loaded_list
-- Table in the form
--      pkg_loaded_table[pkg_name] = source_mod
-- Table populated by code in ../lib/system/import_pkg.lua
unilib.pkg_loaded_table = {}

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
--          unilib.force_load_suggested_pkg_flag is set. Ideally, remix writers should add the
--          suggested packages to their remix, as and when they need them, so that they are loaded
--          in all cases. "pkg_name" can be either a string or a list)
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
-- Table populated by code in ../lib/system/import_pkg.lua
unilib.pkg_table = {}
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
-- Table populated by code in ../lib/system/import_pkg.lua
unilib.pkg_excluded_table = {}
-- A table of packages that have already been executed. Since both functions are optional, this
--      table includes packages whose .exec() and .post() functions would have been called, had they
--      existed
-- Table in the form
--      pkg_executed_table[pkg_name] = false  [if .exec() was called, or would have been called]
--      pkg_executed_table[pkg_name] = true   [if .post() was called, or would have been called]
-- Table populated by code in ../lib/system/import_pkg.lua
unilib.pkg_executed_table = {}

---------------------------------------------------------------------------------------------------
-- Global variables - biomes, decorations and ores
---------------------------------------------------------------------------------------------------

-- If several remixes are specified, more than one package may try to clear registered biomes,
--      decorations and/or ores
-- To prevent later packages clearing the biomes/decorations/ores or earlier packages, call
--      unilib.clear_biomes(), .clear_decorations() and .clear_ores()
-- These functions first check the value of these flags, to ensure that biomes/decorations/ores are
--      not cleared more than once
unilib.biomes_cleared_flag = false
unilib.decorations_cleared_flag = false
unilib.ores_cleared_flag = false

-- Biomes can be defined in package code, or loaded from a biomes.csv file in one or more remix
--      folders
-- A table of remixes, showing the number of biomes specified by each (not including duplicate
--      biomes). The data is shown as a confirmation message by init.lua
-- Table in the form
--      remix_biome_count_table[remix_name] = number_of_biomes
-- Table populated by code in ../lib/system/read_csv.lua
unilib.remix_biome_count_table = {}
-- A list of biome definitions specified by the loaded remixes, preserving the order in which
--      they're specified, but with duplicate biomes already eliminated
-- Note that the contents of this list is not checked for validity until the biomes are actually
--      defined during the call to unilib.register_biome_from_csv()
-- A list of tables, each of which defines a biome. Keys in the table are:
--
--      remix_name
--      biome_name dust top_str fill_str stone water_top_str water river riverbed_str cave_liquid
--          dungeon dungeon_alt dungeon_stair y_max y_min blend heat humidity
--
-- The .biome_name key is compulsory, all others are optional
-- List populated by code in ../lib/system/read_csv.lua. It is acceptable for packages to modify
--      the tables in this list directly, when appropriate
unilib.biome_setup_list = {}

-- Table of every biome created
-- Table in the form
--      biome_table[biome_name] = data_table
-- "data_table" consists of the following compulsory key-value pairs (all but .biome_name are given
--      default values if not specified directly)
--          .biome_name = biome_name
--          .description = A basic biome description; defaults to the same value as .biome_name
--          .y_max = upper_limit_for_biome, default unilib.y_max (range unilib.y_min to
--              unilib.y_max)
--          .y_min = lower_limit_for_biome, default unilib.y_min (range unilib.y_min to
--              unilib.y_max)
--          .heat_point = characteristic_temperature_of_biome, default 50 (range 0-100)
--          .humidity_point = characteristic_humidity_of_biome, default 50 (range 0-100)
--          .place_on = node_name (the biome's "node_top", if it is defined, or the "node_filler"
--              otherwise)
-- Packages should call unilib.register_biome() to update this table
unilib.biome_table = {}

-- Generic definition tables for decorations are usually created by the related package (e.g. for
--      aspen trees, in the "tree_aspen" package), in a call to unilib.register_decoration()
-- These generic tables, with default values for the fields .biomes, .num_spawn_by, .place_on,
--      .spawn_by, .y_max and .y_min, are stored in this global variable, until needed
-- Packages in the "deco" category (e.g. "deco_default_tree_aspen") call
--      unilib.register_decoration_now() with a specific definition table, typically including some
--      or all of the fields above with non-generic values. This code is normally inside the
--      package's .post() function
-- unilib.register_decoration_now() then calls minetest.register_decoration() with a new composite
--      definition table, based on the generic table, but overwritten by the specific table
-- In some cases, the "deco" package will specify both a generic and specific definition table is
--      successive calls to unilib.register_decoration() and unilib.register_decoration_now() (for
--      example, when a mod creates a new decoration based on an item supplied by a different mod)
-- The generic name is expected to be in format
--      REMIX-NAME_ITEM-NAME_N
-- ...where ITEM-NAME is either the name of the item to be placed, or a name for a schematic to be
--      placed (following the parent package name, as far as possible), and where N is an optional
--      numerica component (for example, when the same item is placed in two different biomes by
--      two different decorations)
-- Table in the form
--      generic_deco_table{generic_name] = generic_def_table
-- Packages should call unilib.register_decoration() to update this table
unilib.generic_deco_table = {}

-- Decorations can be defined in package code, or loaded from a decorations.csv file in one or more
--      remix folders
-- A table of remixes, showing the number of decorations specified by each. The data is shown as a
---     confirmation message by init.lua
-- Table in the form
--      remix_deco_count_table[remix_name] = number_of_decorations
-- Table populated by code in ../lib/system/read_csv.lua
unilib.remix_deco_count_table = {}
-- A list of decoration definitions specified by the loaded remixes, preserving the order in which
--      they're specified
-- Note that the contents of this list is not checked for validity until the decorations are
--      actually defined during the call to unilib.register_decoration_from_csv()
-- A list of tables, each of which defines a decoration. Keys in the table are:
--
--      remix_name
--      deco_name deco_type biomes fill_ratio flags height_max num_spawn_by place_on sidelen
--          spawn_by y_max y_min
--
-- The .remix_name, .deco_type and .deco_name keys are compulsory, all others are optional
-- .deco_type is one of the values "simple", "schematic" or "schematic_no_rotate". For schematics,
--      .deco_name is the name of the schematic (in unilib's ../mts folder), e.g.
--      "default_grass_jungle"; for nodes, it is the full_name of a node, e.g. "unilib:grass_jungle"
-- The values of .deco_name, .biomes , .place_on and .spawn_by can be a simple string, or a string
--      of whitespace-separated values (e.g. "unilib:foo unilib:bar unilib:baz"). unilib will
--      automatically convert them into a real list. EXCEPTION: when .deco_type is "schematic" or
--      "schematic_no_rotate", .deco_name cannot be a list
-- If specified, the value .height_max is only used for the .deco_type "simple"; for other values it
--      is ignored
-- If specified, the values .flags and .sidelen are only used for the .deco_type "schematic" and
--      "schematic_no_rotate"; for other values it is ignored
-- In ordinary Minetest decoration definitions, .flags is typically a value like
--      "place_center_x, place_center_z". Using a comma is not acceptable in a CSV, so just separate
--      the values by whitespace; unilib will insert commas into this field. (In case the separator
--      has been set as some other character, then it's acceptable but not recommended to use
--      commas in this field)
-- List populated by code in ../lib/system/read_csv.lua. It is acceptable for packages to modify
--      the tables in this list directly, when appropriate
unilib.deco_setup_list = {}

-- Ores can be defined in package code, or loaded from one of several CSV files in one or more remix
--      folders:
--          ore_scatter.csv ore_sheet.csv ore_puff.csv ore_blob.csv ore_vein.csv ore_stratum.csv
-- A table of remixes, showing the total number of ores specified by each. The data is shown as a
---     confirmation message by init.lua
-- Table in the form
--      remix_ore_count_table[remix_name] = total_number_of_ores
-- Table populated by code in ../lib/system/read_csv.lua
unilib.remix_ore_count_table = {}
-- A list of ore definitions specified by the loaded remixes, preserving the order in which they're
--      specified
-- Note that the contents of this list is not checked for validity until the ores are actually
--      defined during the call to unilib.register_ore_from_csv()
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
-- List populated by code in ../lib/system/read_csv.lua. It is acceptable for packages to modify
--      the tables in this list directly, when appropriate
unilib.ore_setup_list = {}

-- Ore distributions are created in the following order:
--      "stratum" "sheet" "vein" "puff" "blob" "scatter"
-- Ore definition tables created by various packages are stored here temporarily until
--      ../lib/system/import_pkg.lua's consolidation stage, when they are passed to Minetest
-- Lists in the form
--      ore_table.stratum_list = list_of_ore_definitions
--      ore_table.sheet_list = list_of_ore_definitions
--      ...
--      ore_table.scatter_list = list_of_ore_definitions
-- Packages should call unilib.register_ore() to update this table
unilib.ore_table = {}
-- (Mini-lists within the main table)
unilib.ore_table.stratum_list = {}
unilib.ore_table.sheet_list = {}
unilib.ore_table.vein_list = {}
unilib.ore_table.puff_list = {}
unilib.ore_table.blob_list = {}
unilib.ore_table.scatter_list = {}

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
--      fictional_flag = bool
--          If true, this stone does not exist in reality. This classification applies in the
--              broadest sense; ordinary stone from minetest_game is classified as fictional, but
--              silver sandstone is not (because sandstone itself is not fictional)
--      grinder_flag = bool
--          If true, technic grinder recipes are added for the smooth, cobble and compressed
--              variants of this stone type

--      grinder_powder (str): The grinder output, when using smooth stone as the input. If not
--          specified or the output is not available, then "unilib:stone_ordinary_powder" is the
--          output. Ignored if grinder_flag is false
--      grinder_gravel (str): The grinder output, when using cobble/compressed cobble as the input.
--          If not specified or the output is not available, then "unilib:gravel_ordinary" is the
--          output. Ignored if grinder_flag is false
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
--          If true, the stone type can be used in the moss-growth ABM. Note that this will only
--              work if the cobble variant has the group "cobble"
--      no_smooth_flag = bool
--          If true, there is no smooth stone variant for this stone type
--      platform_list = list_of_full_names or nil
--          List of full node names (typically the smooth, block and brick variants) that can be
--              used, in a call to advtrains, to create train platforms
--      super_flag = true for super stones, false for everything else
-- Packages should call unilib.register_stone() to update this table
unilib.stone_table = {}
-- Table of super stones (see the comments above), populated by ../lib/system/override.lua
-- Table in the form
--      super_stone_table[stone_type] = true
-- Note that the table can include the key "everything", meaning that all suitable stones are super
--      stones, but if unilib.super_stone_set contained the word "nothing", then this table is empty
-- Note also that stone packages can exclude themselves from this table, if they are unsuitable (in
--      which case, a key-value pair is deleted)
-- Note finally that (unlike unilib.stone_table), stones in this table might not actually exist (in
--      other words, their packages might not have been executed)
unilib.super_stone_table = {}
-- When unilib.super_stone_set contains the word "everything", or "nothing" (which overrides
--      "everything)", then this variable is set to the value "everything" or "nothing", and it's
--      the responsibility of unilib.register_stone() to populate unilib.super_stone_table (rather
--      than the code in ../lib/system/update.lua)
unilib.super_stone_mode = "default"

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
--          List of keys in unilib.metal_table, specifying the metals that can be smelted using
--              this mineral (an empty list, if none)
--      no_lump_flag = bool
--          If true, no lump variant exists
--      non_metal_list = list_of_part_names
--          List of keys in unilib.non_metal_table, specifying elemental non-metals that can be
--              baked using this mineral (an empty list, if none)
--      powder_flag = bool
--          If true, a powder variant exists
--      rock_flag = bool
--          If true, a rock-mineral variant exists (a whole node, not a craftitem)
-- Packages should call unilib.register_mineral() to update this table
unilib.mineral_table = {}

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
--              broadest sense; "unilib:metal_tin_real_lump" is not regarded as fictional, because
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
unilib.metal_table = {}
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
unilib.non_metal_table = {}

-- Table of "fertile" dirts, on which turf can be grown (does not include any dirts on which turf
--      can't be grown, such as "unilib:dirt_ordinary_with_litter_coniferous")
-- Note that dirts not in the "fertile" category might still be capable of being converted to soil
--      with a hoe, in the normal way
-- Table in the form
--      fertile_dirt_table[part_name] = full_name
-- ...e.g. for "unilib:dirt_ordinary", the part_name "dirt_ordinary"
-- Packages should call unilib.register_fertile_dirt() to update this table
unilib.fertile_dirt_table = {}
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
--      snow. See ../shared/dirts.lua for a longer explanation
-- Packages should call unilib.register_dirt_with_turf() to update this table
unilib.dirt_with_turf_table = {}
-- Table of turf seeder items (mostly grasses, but also items like ordinary snow) that, due to the
--      action of the "turf_spread" ABM, convert the dirt node immediately below into a
--      dirt-with-turf node
-- Initially, each turf seeder item can be represented as a full node name (e.g.
--      "unilib:snow_ordinary") or a group (e.g. "group:dry_grass")
-- After all packages have been executed, code in ../lib/system/import_pkg.lua will remove the items
--      represented as a group, replacing them with actual node names, e.g. "unilib:grass_dry_1"
-- Table in the form
--      turf_seeder_table[seeder_name] = data_table
-- ...where each data_table is in the form
--      data_table[dirt_name] = dirt_with_turf_name
-- Packages should call unilib.register_dirt_with_turf() to update this table
unilib.turf_seeder_table = {}

-- Table of tree types, in the form
--      tree_table[tree_type] = data_table
-- "data_table" consists of the following compulsory key-value pairs:
--      part_name = tree_type, e.g. "aspen"
--      description = e.g. S("Aspen Wood"), sometimes including the word "Tree", e.g.
--          S("Jungle Tree Wood")
--      super_flag = true for super trees, false for everything else
-- "data_table" consists of the following optional key-value pairs:
--      burnlevel = value in the range 1-5, corresponding to unilib.tree_burn_table
-- Packages should call unilib.register_tree() to update this table
unilib.tree_table = {}
-- Table of super trees (see the comments above), populated by ../lib/system/override.lua
-- Table in the form
--      super_tree_table[tree_type] = true
-- Note that the table can include the key "everything", meaning that all suitable trees are super
--      trees, but if unilib.super_tree_set contained the word "nothing", then this table is empty
-- Note also that tree packages can exclude themselves from this table, if they are unsuitable (in
--      which case, a key-value pair is deleted)
-- Note finally that (unlike unilib.tree_table), trees in this table might not actually exist (in
--      other words, their packages might not have been executed)
unilib.super_tree_table = {}
-- When unilib.super_tree_set contains the word "everything", or "nothing" (which overrides
--      "everything"), then this variable is set to the value "everything" or "nothing", and it's
--      the responsibility of unilib.register_tree() to populate unilib.super_tree_table (rather
--      than the code in ../lib/system/update.lua)
unilib.super_tree_mode = "default"
-- Burn times for wooden items depend on wood density. For items imported from minetest_game, that
--      corresponds to the order of wood colour darkness:
--          1. aspen (shortest burn), 2. pine, 3.apple, 4. acacia, 5. jungle tree (longest burn)
-- Calls to functions in ../lib/shared/trees.lua can specify a burntime directly, or they can
--      specify a burn level in the range 1-5
-- Note that ../lib/system/crafting.lua provides craft recipes for tree groups, using values from
--      burn level 3
-- A table of tree burn levels (which are constant values)
unilib.tree_burn_table = {
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
unilib.bush_burn_table = {
    stem = {6, 7, 8},
    sapling = {2, 3, 4},
}

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
unilib.grow_stage_table = {}

-- Table of tree/bush saplings. Every tree/bush which is grown from a sapling must have an entry
-- Table in the form
--      sapling_table[full_name] = data_table
-- "data_table" consists of the following mostly optional key-value pairs:
--      part_name = value
--          e.g. "aspen" for aspen tree saplings. This value is compulsory
--      sapling_type = "tree" or "bush". This value is compulsory
--      grow_func = function
--          A function called by unilib.grow_tree_sapling() and
--              unilib.grow_bush_sapling(), when special handling is required to convert a sapling
--              into a tree/bush. Overrides schematics and L-system trees
--      ltree_table = table
--          Table used to grow L-system trees (instead of using schematics); not used with bushes
--      min_height = value
--          Minimum vertical space required to grow the sapling. If a sapling has no entry in the
--              table, the code does not check for vertical obstructions. If specified, the minimum
--              value is 1
--      min_light = value
--          Minimum light level required to grow the sapling. If a sapling has no entry in the
--              table, the minimum light is specified by the constant variable
--              unilib.light_min_grow_sapling below (default 13)
--      offset_list = list
--          x/y/z adjustments used in the call to minetest.place_schematic()
--      schem_list = list
--          A list of schematics, one of which is chosen at random when the tree/bush is grown from
--              a sapling. If using a non-conventional schematic name, then the list can consist of
--              one item (which is therefore always chosen)
--          Each item in the list is a mini list, in the form
--          [schematic_name, x, y, z]
--          ...where "schematic_name" is a file in ../mts/, and x/y/z match the values in the
--              .offset_list field
--      replace_func = function
--          A function that returns a replacement table for the minetest.place_schematic() call
--              (see the comments in unilib.register_tree_sapling() )
--      under_list = list_of_nodes
--          A list of nodes on which the sapling can grow. If a sapling has no entry in the table,
--              it can grow on any node with the "soil" group. If "list_of_nodes" is empty, the
--              sapling cannot grow on anything. Note that this behaviour is independent of
--              decoration placement. See also the Minetest settings for sapling growth
-- Packages should call unilib.register_tree_sapling() to update this table
unilib.sapling_table = {}

-- Table of full names of flowers (and other plants) that are compatible with flowerpots
-- Flowerpot packages like "flowerpot_normal" should define an empty flowerpot in their .exec()
--      function, and then use code in their .post() function to register every plant on this list
-- Table in the form
--      flowerpot_compat_table[full_name] = orig_name
-- ...where both the key and value are the full names of flower/plant/etc nodes
-- Packages should call unilib.register_flower_in_pot(), unilib.register_mushroom_in_pot(),
--      unilib.register_plant_in_pot() or unilib.register_sapling_in_pot() to update this table
-- See also the Minetest settings above, unilib.flowerpot_add_flowers_flag etc
unilib.flowerpot_compat_table = {}

-- Table of full names of any items (cactus, papyrus etc) that require special code when a
--      fertiliser (bonemeal, etc) is used on them, and the functions providing that code
-- Table in the form
--      special_fertiliser_table[full_name] = function
-- Packages should call unilib.register_special_fertilise() to update this table
unilib.special_fertiliser_table = {}

-- Table of items that should not be repairable (for example, by the anvil provided by the
--      "machine_anvil_simple" package; but this table available for any code that wants it)
-- Table in the form
--      tool_no_repair_table[full_name] = error_message
-- ...where "error_message" is something like "The hammer is too complex for repairing"
-- Packages should call unilib.register_tool_no_repair() to update this table
unilib.tool_no_repair_table = {}
-- Table of items that should not be affected by scythes (e.g. beanpoles and trellises)
-- Table in the form
--      tool_no_scythe_table[full_name] = true
-- Packages should call unilib.register_tool_no_scythe() to update this table
unilib.tool_no_scythe_table = {}
-- Table of shovels that can dig original nodes in the "crumbly" group (e.g. dirt with turf,
--      instead of dirt, as with most shovels). For examples, see the crystallinum shovel from
--      ethereal and the pounamu shovel from aotearoa
-- Table in the form
--      special_shovel_table[full_name] = true
-- Packages should call unilib.register_special_shovel() to update this table
unilib.special_shovel_table = {}

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
unilib.generic_bucket_table = {}
-- Table converting a full bucket (e.g. "unilib:bucket_steel_with_water_ordinary") into its
--      equivalent empty bucket (e.g. "unilib:bucket_steel_empty")
-- Packages should call unilib.register_liquid_in_bucket() to update this table
unilib.empty_bucket_table = {}
-- During a multiple-step crafting process, in which the first step uses a filled bucket, and in
--      which the final step returns an empty bucket, there is currently no way to tell which kind
--      of bucket was originally used
-- In that case, this bucket should be returned to the player. It is set to the first empty bucket
--      created in a call to unilib.register_bucket(). For an example, see the "food_jam_blueberry"
--      package
-- N.B. Unfortunately, this allows a player to convert (cheap) wooden buckets into (expensive)
--      steel buckets. The only workaround is to arrange your remixes, such that the cheapest
--      bucket package is executed first
unilib.fallback_empty_bucket = nil
-- Lists of items that can be used in a replacement table in any craft recipe with
--      group:craftable_bucket, group:potable_bucket or group:water_bucket (for an example, see the
--      "material_stucco" package)
-- Specifically, when unilib.register_liquid() is called with .craftable_flag = true,
--      .potable_flag = true and/or .water_flag = true, then items are added to these lists
-- List of lists. Each mini-list is in the form {full_bucket, empty_bucket}, e.g.
--      {"unilib:bucket_steel_with_water_ordinary", "unilib:bucket_steel_empty"}
unilib.craftable_bucket_list = {}
unilib.potable_bucket_list = {}
unilib.water_bucket_list = {}

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
--      "bucket_steel_with_bones" and "liquid_molten_gold" packages for examples)
-- Packages should call unilib.register_liquid() to update this table
unilib.generic_liquid_table = {}
-- Reverse lookup table for liquids
-- Table in the form
--      reverse_liquid_table[full_name] = liquid_name
-- ...where "full name" is the full node name (e.g. "unilib:liquid_water_ordinary_source"), and
--      "liquid_name" is the corresponding key in unilib.generic_liquid_table (e.g.
--      "water_ordinary")
-- Note that there are entries for both source and flowing nodes. For both keys, the corresponding
--      values are identical
-- Packages should call unilib.register_liquid() to update this table
unilib.reverse_liquid_table = {}
-- Table used to cool lava nodes into stone nodes. Once all packages have been imported, we use a
--      shared lava-cooling ABM in ../lib/system/abms.lua
-- Table in the form
--      lava_table[lava_full_name] = stone_full_name
-- Packages should call unilib.register_lava() to update this table
unilib.lava_cooling_table = {}
-- Table used to melt ice/snow nodes into water nodes. Once all packages have been imported, we use
---     a shared ice/snow-melting ABM in ../lib/system/abms.lua
-- Table in the form
--      ice_snow_melting_table[ice_snow_node] = data_table
--  ...where "data_table" contains the following key-value pairs:
--          .source = the source water node. If not specified, "unilib:liquid_water_ordinary_source"
--              is used
--          .flowing = the source water node. If not specified,
--              "unilib:liquid_water_ordinary_flowing" is used
-- Packages should call unilib.register_ice_snow_melting() to update this table
unilib.ice_snow_melting_table = {}
-- Table of generic definition tables for juices (squeezed from fruits in the press defined by the
--      "machine_press_fruit" package)
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
-- Packages should call unilib.register_juice() and unilib.register_juice_duplicate() to update
--      this table (for a working example, see the "fruit_banana" package)
unilib.generic_juice_table = {}

-- Table of dyes, used for creating derivative items, which need to be named with the correct
--      translated colour (minetest_game/dye makes a table available globally; this is unilib's
--      equivalent)
-- Table in the form
--      dye_table[part_name] = translated_name
-- ...where "part_name" is "dark_grey" (etc), and "translated_name" is S("Dark Grey"), etc
-- Packages should call unilib.register_dye() to update this table
unilib.dye_table = {}
-- Corresponding table of baked clays, used for creating derivative items
-- Table in the form
--      clay_baked_table[part_name] = translated_name
-- ...where "part_name" is "dark_grey" (etc), and "translated_name" is S("Dark Grey"), etc
-- Packages should call unilib.register_clay_baked() to update this table
unilib.clay_baked_table = {}

-- Three lists of items caught when fishing, specifying fish, bonus items and junk items
-- Each list contains a number of tables, in the form
--      { full_name, biome_name, rod_name }
-- "full_name" is the item to be caught, "rod_name" is the full name of the fishing rod
-- If a specific biome/rod names are not required, then those values are nil
-- Packages should call unilib.register_fishing_fish() to update this list
unilib.fishing_fish_list = {}
-- Packages should call unilib.register_fishing_bonus() to update this list
unilib.fishing_bonus_list = {}
-- Packages should call unilib.register_fishing_junk() to update this list
unilib.fishing_junk_list = {}

---------------------------------------------------------------------------------------------------
-- Global variables - ABMs / LBMs / sounds
---------------------------------------------------------------------------------------------------

-- Table of ABM replacment functions
-- ../system/abms.lua contains some standard ABMs, each represented by a key-value pair in this
--      table. If the value is nil, the standard ABM code is executed; otherwise the value is a
--      function to be called instead, which defines a modified ABM
-- If several packages try to modify the same standard ABM, then only the function from the last
--      package is called
-- There is no wrapper function; packages can add key-value pairs to this table directly
--[[
unilib.abm_replace_table = {
    cactus_grow = nil,
    crop_grow = nil,
    dirt_soak = nil,
    flame_ignite = nil,     -- Receives arguments: fire_enabled_flag
    flame_remove = nil,     -- Receives arguments: fire_enabled_flag
    flora_spread = nil,
    ice_snow_melt = nil,
    lava_cool = nil,        -- Receives arguments: node_list
    moss_grow = nil,        -- Receives arguments: moss_flag, moss_table
    moss_spread = nil,      -- Receives arguments: moss_flag, moss_table
    mushroom_spread = nil,
    oil_ignite = nil,       -- Receives arguments: fire_enabled_flag
    soil_farm = nil,
    tnt_ignite = nil,
    torch_extinguish = nil,
    turf_kill = nil,
    turf_spread = nil,      -- Receives arguments: fertile_dirt_list
    water_freeze = nil,
}
]]--
unilib.abm_replace_table = {}
-- Equivalent table of LBM replacment functions
-- There is no wrapper function; packages can add key-value pairs to this table directly
--[[
unilib.lbm_replace_table = {
    pane_rotate = nil,
}
]]--
unilib.lbm_replace_table = {}

-- Definition tables for sound effects are stored in a global table
-- When nodes specify a sound effect, they can just look up the definition table, rather than
--      creating a new table from scratch (as most Minetest mods tend to do)
-- If required, the functions in ../lib/system/sounds.lua can be called directly instead
-- Table in the form
--      unilib.sound_table[name] = def_table
-- Table populated by code in ../lib/system/sounds.lua
unilib.sound_table = {}

---------------------------------------------------------------------------------------------------
-- Global variables - stairs, walls, carvings etc
---------------------------------------------------------------------------------------------------

-- Flag set to true if any of the values of unilib.add_stairs_basic_flag,
--      unilib.add_stairs_stairs_redo_flag, unilib.add_stairs_stairsplus_flag or
--      unilib.add_stairs_moreblocks_flag are true (set in ../lib/system/override.lua)
unilib.add_stairs_any_flag = false
-- Flag set to true if any of the values of unilib.show_stairs_basic_flag,
--      unilib.show_stairs_stair_redo_flag, unilib.show_stairs_stairsplus_flag or
--      unilib.show_stairs_moreblocks_flag are true (set in ../lib/system/override.lua)
unilib.show_stairs_any_flag = false
-- Flag set to true if any of the values of unilib.add_carvings_column_flag,
--      unilib.add_carvings_facade_flag or unilib.add_carvings_millwork_flag are true (set in
--      ../lib/system/override.lua)
unilib.add_carvings_any_flag = false
-- Flag set to true if any of the values of unilib.show_carvings_column_flag,
--      unilib.show_carvings_facade_flag or unilib.show_carvings_millwork_flag are true (set in
--      ../lib/system/override.lua)
unilib.add_carvings_show_flag = false

-- Global variables used (mainly) by circular saws in the package "machine_saw_circular"
-- Table of nodes which have been used to create stair nodes via a call to unilib.register_stairs()
--      (or unilib.register_stairs_all() directly)
-- Table in the form
--      stair_convert_table[original_full_name] = list_of_stair_full_names
unilib.stair_convert_table = {}
-- Table of stair nodes and the original nodes from which they were crafted
-- Table in the form
--      stair_deconvert_table[stair_full_name] = original_full_name
unilib.stair_deconvert_table = {}
-- Table of stair types (created by ../lib/shared/stairs.lua), and the cost in microblocks (cubes
--      comprising an eighth of a block)
-- Table in the form
--      stair_cost_table[stair_type] = cost
-- ...for example
--      stair_cost_table["_stair_simple"] = 6
unilib.stair_cost_table = {}
-- Table containing ordered lists of stair types, one for each circular saw version (in the range
--      1 to 3)
-- Table in the form
--      stair_ordered_table[version] = ordered_list_of_stair_types
unilib.stair_ordered_table = {}

-- Corresponding global variables used by carvings
-- Table of nodes which have been used to create carving nodes via a call to
--      unilib.register_carvings() (or unilib.register_carvings_all() directly)
-- Table in the form
--      carving_convert_table[original_full_name] = list_of_carving_full_names
unilib.carving_convert_table = {}
-- Table of carving nodes and the original nodes from which they were crafted
-- Table in the form
--      carving_deconvert_table[carving_full_name] = original_full_name
unilib.carving_deconvert_table = {}
-- Table of carving types (created by ../lib/shared/carvings.lua), and the number of output nodes
--      per input node
-- Table in the form
--      carving_output_table[carving_type] = output_ratio
-- ...for example
--      carving_output_table["_facade_bannerstone"] = 1
unilib.carving_output_table = {}

---------------------------------------------------------------------------------------------------
-- Global variables - misc tables
---------------------------------------------------------------------------------------------------

-- Player statistics tables (stored in a table while the player is connected, then serialised as
--      a player attribute when they leave)
unilib.player_stats_bio_table = {}
unilib.player_stats_activity_table = {}

-- Conversion tables
-- Code should call unilib.register_node(), unilib.register_craftitem() and unilib.register_tool()
--      rather than calling the corresponding Minetest functions directly
-- There is one exception: when creating an item that uses multiple nodes (such as a door),
--      unilib.register_node() should only be called to register the item that appears in the
--      player's inventory; the supplementary items should be registered with
--      minetest.register_node() as usual
--
-- Note that, in all three tables, there may be multiple keys for which the corresponding value is
--      "unilib:stone_ordinary", etc (reflecting the fact that the same node may have been used by
--      multiple mods)
--
-- Tables that convert a node from an original mod (e.g. "default:stone") into the equivalent
--      unilib node (e.g. "unilib:stone_ordinary"), or vice-versa
-- Note that these tables do not include stairs created by ../lib/shared/stairs.lua or carvings
--      created by ../lib/shared/carvings, but do include wall nodes created by
--      ../lib/shared/walls.lua
-- Tables in the form
--      node_convert_table[orig_name] = full_name
--      node_deconvert_table[full_name] = orig_name_list
unilib.node_convert_table = {}
unilib.node_deconvert_table = {}
-- Equivalent tables for craftitems, using the same format
-- Tables in the form
--      craftitem_convert_table[orig_name] = full_name
--      craftitem_deconvert_table[full_name] = orig_name_list
unilib.craftitem_convert_table = {}
unilib.craftitem_deconvert_table = {}
-- Equivalent tables for tools, using the same format
-- Table in the form
--      tool_convert_table[orig_name] = full_name
--      tool_deconvert_table[full_name] = orig_name_list
unilib.tool_convert_table = {}
unilib.tool_deconvert_table = {}
-- A table mapping unilib nodes, craftitems and tools onto their minetest_game equivalents. This
--      data is read from a pre-generated CSV file (../csv/convert/convert.csv), and is used to
--      generate aliases when minetest_game mods are loaded, their replace mode is "defer", and
--      equivalent unilib nodes have not been created
-- (This allows other parts of the code to function correctly, without having to reference both
--      names)
-- Table in the form
--      mtgame_convert_table[mtgame_name] = unilib_name
--      mtgame_deconvert_table[unilib_name] = mtgame_name
unilib.mtgame_convert_table = {}
unilib.mtgame_deconvert_table = {}

-- Origin tables
-- Assuming that unilib.register_node(), etc, have been called, then these tables provide quick
--      access to the name of the package that created them
-- Note that some items (such as buckets containing liquids) might be created outside the package
--      initialisation/execution/post-execution stages, in which case those items are not added to
--      these tables
-- Tables in the form
--      table[full_name] = pkg_name
unilib.node_parent_table = {}
unilib.craftitem_parent_table = {}
unilib.tool_parent_table = {}
-- A value set temporarily whenever a package is being initialised, executed or post-executed
unilib.current_pkg = nil

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
unilib.external_ingredient_table = {}

-- Table of hidden items (nodes, craftitems and tools for which the duplication mode "hide" was
--      applied; used to show hidden items in chat commands)
-- Table in the form
--      hidden_item_table[orig_name] = full_name
-- Table populated by code in ../lib/system/register.lua
unilib.hidden_item_table = {}

---------------------------------------------------------------------------------------------------
-- Global variables - misc values
---------------------------------------------------------------------------------------------------

-- unilib replicates the functionality of minetest_game/player_api, so that unilib isn't dependent
--      on it. This replicating code can be found in ../shared/player_api.lua
-- However, if minetest_game/player_api is available, then unilib uses it, rather than its own code.
--      ../shared/player_api_wrapper.lua provides an API that matches the one in
--      ../shared/player_api.lua, but redirecting all calls to minetest_game/player_api
-- Neither of these two files is loaded until actually needed. If a package needs to use
--      player_api, it should first call unilib.load_player_api(), which will load the correct
--      package
-- This flag is set to true if one of the twos files has been loaded, so that we don't try to load
--      it again
unilib.player_api_loaded_flag = false

-- Local copy of the enable_tnt setting; used by code in ../lib/system/abms.lua,
--      ../lib/shared/tnt.lua and various packages
unilib.enable_tnt_flag = minetest.settings:get_bool("enable_tnt")
if unilib.enable_tnt_flag == nil then
    unilib.enable_tnt_flag = minetest.is_singleplayer()
end

-- Flag set to true if unilib.force_unipanes_flag is true, or if unilib is running on top of
--      minetest_game (set in ../lib/system/override.lua)
unilib.use_unipanes_flag = false

-- Group used with "admin" items. In creative mode, they should be visible in the player's
--      inventory; otherwise, they should be hidden
unilib.show_admin_item_group = 1
if minetest.settings:get_bool("creative_mode") then
    unilib.show_admin_item_group = nil
end

-- Flag that can be set to true by a call to unilib.activate_standard_abm_lbm() by base package,
--      that wants to activate unilib standard ABMs/LBMs (replacing the ABMs/LBMs from the original
--      source game/modpack/mod, which either provided a "default" mod, or had code that acted like
--      a "default" mod)
-- Whether standard ABMs/LBMs are actually enabled, or not, depends on Minetest settings
unilib.activate_standard_abm_lbm_flag = false

---------------------------------------------------------------------------------------------------
-- Global variables - chat command modifiers
---------------------------------------------------------------------------------------------------

-- List of craft recipe conflicts which are deliberate
-- Used in ../lib/cmds/conflict.lua as a list of exceptions (ignored by the chat commands)
-- Every item in the list is a mini-list of two items, e.g.
--      { ... {"unilib:item_stick_ordinary 4", "unilib:material_charcoal_artificial_lump 8"} ... }
-- Packages can add new items to the list by calling unilib.register_craft_conflicts()
unilib.craft_recipe_conflict_list = {}

-- List of craft recipes which have missing ingredients deliberately
-- Used in ../lib/cmds/missing.lua as a list of exceptions (ignored by the chat commands)
-- Every item in the list is a mini-list of two items, e.g.
--      { ... {"unilib:dye_grey_dark", "group:flower,color_grey_dark"} ... }
-- Packages can add new items to the list by calling unilib.register_craft_missing_ingredients()
unilib.craft_recipe_missing_ingredient_list = {}

---------------------------------------------------------------------------------------------------
-- Global constants (unilib)
---------------------------------------------------------------------------------------------------

-- The name of the game on top of which unilib is running (for minetest_game, the value "minetest")
unilib.current_game = Settings(unilib.path_world .. DIR_DELIM .. 'world.mt'):get('gameid')

-- The standard separator for CSV files
unilib.separator = "|"

-- Default values for detect/replace modes, in case some part of the code doesn't specify them
unilib.default_detect_mode = "detect"
unilib.default_replace_mode = "defer"

-- For compatibility with default, a maximum light setting
unilib.light_max = 14
-- Standard minimum light for saplings (also used for grass, plants, etc)
unilib.light_min_grow_sapling = 13
-- Standard minimum light crops/produce
unilib.light_min_grow_crop = 12

-- Default values for leaves type/scale. These values are overwritten if the MT setting
--      unilib.plantlike_leaves_flag is true
unilib.leaves_drawtype = "allfaces_optional"
unilib.leaves_visual_scale = 1

-- World size limits (use these values instead of literal 31000 / -31000 values)
unilib.x_max = 31000
unilib.x_min = -31000
unilib.y_max = 31000
unilib.y_min = -31000
unilib.z_max = 31000
unilib.z_min = -31000

-- Standard error message for chat commands
unilib.chat_offline_msg = S("This command is not available to offline players")

---------------------------------------------------------------------------------------------------
-- Global constants (mod-specific)
---------------------------------------------------------------------------------------------------

-- Maximum number of pseudo-biomes created by packages calling code in ../shared/pbiomes.lua or
--      ../shared/jbiomes.lua
unilib.underch_max_biomes = 62
-- Scale all damage caused by underch nodes by a given factor
unilib.underch_damage_scaling_factor = 1
