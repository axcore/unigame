---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- override.lua
--      Override Minetest settings
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Notes
---------------------------------------------------------------------------------------------------

-- To override a setting, uncomment the line (by removing the first two hyphens), and then change
--      the value

---------------------------------------------------------------------------------------------------
-- Override settings
---------------------------------------------------------------------------------------------------

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Log settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.show_msg_flag = true
--unilib.show_error_flag = true
--unilib.show_warning_flag = true

--unilib.show_pkg_remix_flag = false
--unilib.show_pkg_load_flag = false
--unilib.show_pkg_init_flag = false
--unilib.show_pkg_exec_flag = false
--unilib.show_pkg_post_flag = false
--unilib.show_pkg_debug_flag = false

--unilib.show_dependency_simple_flag = false
--unilib.show_dependency_detailed_flag = false
--unilib.show_dependency_combined_flag = false
--unilib.show_dependency_hard_limit_flag = false
--unilib.show_dependency_soft_limit_flag = true

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Remix settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.remix_set = "playme"

--unilib.force_load_dependent_pkg_flag = true
--unilib.force_load_minimal_pkg_flag = false
--unilib.force_load_optional_pkg_flag = false
--unilib.force_load_suggested_pkg_flag = false

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Base package settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.protect_biomes_flag = false
--unilib.protect_decorations_flag = false
--unilib.protect_ores_flag = false

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- minetest_game settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.mtgame_tweak_flag = true

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Original mod settings (general)
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.force_replace_flag = false
--unilib.force_unipanes_flag = false

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Original mod settings (specific)
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

-- (advtrains)
--unilib.advtrains_update_flag = true

-- (beacons)
-- unilib.beacons_height_max = 0

-- (beautiflowers)
-- unilib.beautiflowers_spawn_ratio = 5

-- (biome_lib)
-- unilib.biome_lib_spawn_factor = 0.1
-- unilib.biome_lib_fill_ratio = 0.001

-- (cheese)
-- unilib.cheese_allow_imitation_flag = true

-- (compass mods - various)
--unilib.death_compass_duration = 0
--unilib.death_compass_auto_flag = false

-- (cottages)
--unilib.cottages_slow_flag = false
--unilib.cottages_versatile_pitchfork_flag = false
--unilib.cottages_road_mode = "mesh"

-- (cropocalypse)
-- unilib.cropocalypse_infinite_kelp_flag = false

-- (cucina_vegana)
--unilib.cucina_vegana_redo_flag = true

-- (earthbuild)
--unilib.earthbuild_extend_cutter_flag = true

-- (ethereal-ng)
--unilib.ethereal_fishing_time = 45
--unilib.ethereal_fishing_hard_flag = false

-- (facade, mymillwork)
--unilib.protect_machines_flag = false

-- (fachwerk)
--unilib.fachwerk_all_frames_flag = false
--unilib.fachwerk_extra_nodes_flag = false

-- (flowerpot)
--unilib.flowerpot_add_flowers_flag = true
--unilib.flowerpot_add_mushrooms_flag = false
--unilib.flowerpot_add_plants_flag = false
--unilib.flowerpot_add_saplings_flag = false

-- (GLEM)
--unilib.glem_dirt_on_demand_flag = true
--unilib.glem_biome_blend_flag = true

-- (hangglider)
--unilib.hangglider_no_fly_time = 3

-- (mesecons)
--unilib.mesecons_door_flag = true
--unilib.mesecons_trapdoor_flag = true

-- (nettle)
--unilib.nettle_damage_factor = 1

-- (nsspf)
--unilib.nsspf_scarcity_factor = 1
--unilib.nsspf_exposed_truffle_flag = false

-- (pedology)
--unilib.pedology_drip_mode = "none"
--unilib.pedology_dry_light = 13

-- (plantlife)
--unilib.plantlife_long_grass_flag = false
--unilib.plantlife_poison_ivy_unfussy_flag = false
--unilib.plantlife_poison_ivy_light_flag = false
--unilib.plantlife_poison_ivy_poison_flag = false

-- (real_torch)
--unilib.real_torch_min_time = 480
--unilib.real_torch_max_time = 600

-- (sickles)
--unilib.sickles_replant_flag = true
--unilib.sickles_override_pitchfork_flag = false

-- (snow)
--unilib.snow_reduce_snowflakes_flag = true

-- (technic)
--unilib.technic_update_flag = true
--unilib.technic_extra_flag = true
--unilib.grind_metal_ratio = 2
--unilib.grind_mineral_ratio = 2
--unilib.grind_stone_ratio = 1

-- (toolranks)
--unilib.toolranks_enable_flag = true
--unilib.toolranks_max_levels = 10
--unilib.toolranks_level_digs = 500
--unilib.toolranks_speed_multiplier = 2.0
--unilib.toolranks_use_multiplier = 2.0

--unilib.toolranks_announce_flag = false
--unilib.toolranks_progressive_flag = true
--unilib.toolranks_countdown_flag = true

-- (towercrane)
--unilib.crane_max_height = 32
--unilib.crane_max_width = 32
--unilib.crane_rope_length = 40

-- (trash can)
--unilib.trash_can_throw_flag = true

-- (tsm_pyramids)
--unilib.tsm_pyramids_real_trap_flag = true

-- (underch, uchu)
--unilib.underch_tweak_flag = true
--unilib.underch_override_abm_flag = true
--unilib.underch_overstack_condensed_flag = true

-- (unifieddyes)
--unilib.unifieddyes_update_flag = true

-- (unified_inventory)
--unilib.unified_inventory_update_flag = true

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Biome/decoration/ore settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.random_seed_offset_flag = false

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Environment settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.super_stone_set = "desert ordinary"
--unilib.super_tree_set = "acacia aspen apple jungle pine"

--unilib.sandstone_cobble_rubble_flag = false
--unilib.real_stone_hardness_flag = false

--unilib.overgrown_turf_flag = false
--unilib.caves_chop_dirt_flag = true

--unilib.auto_rotate_wood_flag = false
--unilib.rendered_leaves_flag = false
--unilib.plantlike_leaves_flag = false
--unilib.walkable_leaves_flag = false
--unilib.regrow_fruit_flag = true
--unilib.leaves_drop_sticks_flag = false

--unilib.sapling_grow_min = 300
--unilib.sapling_grow_max = 1500
--unilib.sapling_grow_default = 300
--unilib.sapling_grow_retry = 300
--unilib.sapling_quick_grow_flag = false
--unilib.sapling_variable_grow_flag = false
--unilib.sapling_override_flag = true
--unilib.sapling_everywhere_flag = false

-- unilib.crop_produce_grow_default = 160.0

--unilib.floodable_flora_flag = false
--unilib.flushable_flora_flag = false

--unilib.blocking_papyrus_flag = true
--unilib.walkable_waterlilies_flag = true

--unilib.abm_spread_factor = 1

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Non-environment settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.disable_standard_abm_lbm_flag = false
--unilib.enable_standard_abm_lbm_flag = false

--unilib.auto_rotate_brick_flag = false

--unilib.dye_from_crops_flag = false
--unilib.dye_from_fruit_flag = false
--unilib.dye_from_produce_flag = false

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Stair/wall/carving settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.add_stairs_basic_flag = true
--unilib.show_stairs_basic_flag = false
--unilib.add_stairs_stairs_redo_flag = false
--unilib.show_stairs_stairs_redo_flag = false
--unilib.add_stairs_stairsplus_flag = false
--unilib.show_stairs_stairsplus_flag = false
--unilib.add_stairs_moreblocks_flag = false
--unilib.show_stairs_moreblocks_flag = false
--unilib.add_stairs_plantlife_flag = false
--unilib.show_stairs_plantlife_flag = false
--unilib.add_stairs_castle_flag = false
--unilib.show_stairs_castle_flag = false

--unilib.convert_stairs_on_drop_flag = true
--unilib.reduce_stair_light_flag = true
--unilib.advanced_stair_rotation_flag = true

--unilib.add_walls_flag = true

--unilib.add_carvings_column_flag = true
--unilib.show_carvings_column_flag = false
--unilib.add_carvings_facade_flag = false
--unilib.show_carvings_facade_flag = false
--unilib.add_carvings_millwork_flag = false
--unilib.show_carvings_millwork_flag = false

--unilib.reduce_carving_light_flag = true

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Player effects settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.toolranks_warn_break_flag = true

--unilib.effects_bouncy_beds_flag = true
--unilib.effects_wield_light_flag = true

--unilib.magnet_auto_get_flag = false
--unilib.magnet_auto_drop_flag = false
--unilib.magnet_get_key_flag = true
--unilib.magnet_no_get_key_flag = true
--unilib.magnet_get_key_type = "Use"
--unilib.magnet_auto_get_volume = 0.4
--unilib.magnet_auto_get_particle_flag = true
--unilib.magnet_auto_get_radius = 0.75
--unilib.magnet_auto_fly_radius = -1
--unilib.magnet_auto_fly_time = 5.0
--unilib.magnet_auto_get_delay = 0.5
--unilib.magnet_click_get_flag = true

--unilib.hotbar_size = 8

--unilib.cuisine_advanced_flag = true
--unilib.cuisine_history_max_size = 10
--unilib.cuisine_novelty_factor = 1.5

--unilib.hunger_enable_flag = true
--unilib.hunger_factor = 1.0
--unilib.hunger_on_sprint_flag = true
--unilib.hunger_on_sprint_factor = 1.0

--unilib.thirst_enable_flag = false
--unilib.thirst_factor = 1.0

--unilib.identify_enable_hud_flag = true
--unilib.identify_optimise_hud_flag = false
--unilib.identify_package_name_flag = false

--unilib.alarm_enable_flag = true

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Player effects settings (statistics and calendars)
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.stats_bio_flag = true
--unilib.stats_activity_flag = true

--unilib.calendar_year_offset = 1000
--unilib.calendar_month_offset = 1
--unilib.calendar_day_offset = 1
--unilib.calendar_system = S("A.D.")
--unilib.calendar_leap_year_flag = true
--unilib.calendar_format_string = "%D, %d %M %y %S %E %T"
--unilib.calendar_enable_tooltips_flag = true
--unilib.calendar_week_start_offset = 1

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Age-appropriate settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.enable_adult_content_flag = false

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Debug settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.debug_all_inventory_flag = false
--unilib.debug_add_name_flag = false
--unilib.debug_add_orig_name_flag = false
--unilib.debug_force_light_source = 0
--unilib.debug_xray_flag = false
--unilib.debug_check_heights_flag = false
--unilib.debug_forced_biome = ""
