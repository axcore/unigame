---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- global_override.lua
--      Override Minetest settings in code, when required
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

--unilib.setting.log_non_player_actions_flag = false
--unilib.setting.log_chat_cmd_flag = false

--unilib.setting.show_startup_msg_flag = true

--unilib.setting.show_msg_flag = true
--unilib.setting.show_error_flag = true
--unilib.setting.show_warning_flag = true

--unilib.setting.show_pkg_remix_flag = false
--unilib.setting.show_pkg_load_flag = false
--unilib.setting.show_pkg_init_flag = false
--unilib.setting.show_pkg_exec_flag = false
--unilib.setting.show_pkg_post_flag = false
--unilib.setting.show_pkg_debug_flag = false

--unilib.setting.show_csv_duplicate_flag = false

--unilib.setting.show_dependency_simple_flag = false
--unilib.setting.show_dependency_detailed_flag = false
--unilib.setting.show_dependency_combined_flag = false
--unilib.setting.show_dependency_hard_limit_flag = false
--unilib.setting.show_dependency_soft_limit_flag = true

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Remix settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.setting.init_remix_pkg_set = "nothing"

--unilib.setting.force_load_dependent_pkg_flag = true
--unilib.setting.force_load_minimal_pkg_flag = false
--unilib.setting.force_load_optional_pkg_flag = false
--unilib.setting.force_load_suggested_pkg_flag = false

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Base package settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.setting.protect_biomes_flag = false
--unilib.setting.protect_decorations_flag = false
--unilib.setting.protect_ores_flag = false

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- minetest_game settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.setting.mtgame_tweak_flag = false
--unilib.setting.mtgame_disable_abm_lbm_flag = false

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Original mod settings (general)
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.setting.force_replace_flag = false
--unilib.setting.force_unipanes_flag = false

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Original mod settings (specific)
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

-- (3d_armor)
--unilib.setting.armour_init_delay =  2
--unilib.setting.armour_bones_delay = 1
--unilib.setting.armour_update_time = 1
--unilib.setting.armour_drop_flag = true
--unilib.setting.armour_destroy_flag = false
--unilib.setting.armour_level_multiplier = 1
--unilib.setting.armour_heal_multiplier = 1
--unilib.setting.armour_set_bodyparts = "head torso hands legs feet shield"
--unilib.setting.armour_set_multiplier = 1.1
--unilib.setting.armour_water_protect_flag = true
--unilib.setting.armour_fire_protect_flag = false
--unilib.setting.armour_fire_protect_torch_flag = false
--unilib.setting.armour_punch_damage_flag = true
--unilib.setting.armour_transparent_flag = false
--unilib.setting.armour_disable_shield_sound_flag = false

-- (advtrains)
--unilib.setting.advtrains_update_flag = true

-- (beacons)
--unilib.setting.beacons_height_max = 0

-- (beautiflowers)
--unilib.setting.beautiflowers_spawn_ratio = 5

-- (biome_lib)
--unilib.setting.biome_lib_spawn_factor = 0.1
--unilib.setting.biome_lib_fill_ratio = 0.001

-- (cement)
--unilib.setting.concrete_reduce_contrast_flag = false

-- (cheese)
--unilib.setting.cheese_allow_imitation_flag = true

-- (cottages)
--unilib.setting.cottages_slow_flag = false
--unilib.setting.cottages_versatile_pitchfork_flag = false
--unilib.setting.cottages_road_mode = "mesh"

-- (cropocalypse)
--unilib.setting.cropocalypse_infinite_kelp_flag = false

-- (cucina_vegana)
--unilib.setting.cucina_vegana_redo_flag = true

-- (death_compass)
--unilib.setting.death_compass_spooky_flag = false
--unilib.setting.death_compass_duration = 0
--unilib.setting.death_compass_auto_flag = false

-- (drinks)
--unilib.setting.drinks_restrict_original_flag = false
--unilib.setting.drinks_restrict_fruit_flag = false

-- (earthbuild)
--unilib.setting.earthbuild_extend_cutter_flag = false

-- (ethereal-ng)
--unilib.setting.ethereal_fishing_time = 45
--unilib.setting.ethereal_fishing_hard_flag = false

-- (facade, mymillwork)
--unilib.setting.protect_machines_flag = false

-- (fachwerk)
--unilib.setting.fachwerk_all_frames_flag = false
--unilib.setting.fachwerk_extra_nodes_flag = false

-- (flowerpot)
--unilib.setting.flowerpot_add_flowers_flag = true
--unilib.setting.flowerpot_add_mushrooms_flag = false
--unilib.setting.flowerpot_add_plants_flag = false
--unilib.setting.flowerpot_add_saplings_flag = false

-- (GLEM)
--unilib.setting.glem_biome_blend_flag = true

-- (hangglider)
--unilib.setting.hangglider_warning_time = 3

-- (mesecons)
--unilib.setting.mesecons_door_flag = true
--unilib.setting.mesecons_trapdoor_flag = true

-- (moreblocks)
--unilib.setting.moreblocks_hidden_trap_flag = false

-- (nettle)
--unilib.setting.nettle_damage_factor = 1.0

-- (nsspf)
--unilib.setting.nsspf_scarcity_factor = 1
--unilib.setting.nsspf_exposed_truffle_flag = false

-- (pedology)
--unilib.setting.pedology_drip_mode = "none"
--unilib.setting.pedology_dry_light = 13

-- (plantlife)
--unilib.setting.plantlife_long_grass_flag = false
--unilib.setting.plantlife_poison_ivy_unfussy_flag = false
--unilib.setting.plantlife_poison_ivy_light_flag = false
--unilib.setting.plantlife_poison_ivy_poison_flag = false

-- (real_torch)
--unilib.setting.real_torch_min_time = 480
--unilib.setting.real_torch_max_time = 600

-- (scaffolding)
--unilib.setting.scaffolding_quick_remove_flag = false

-- (sickles)
--unilib.setting.sickles_replant_flag = true
--unilib.setting.sickles_override_pitchfork_flag = false

-- (snow)
--unilib.setting.snow_reduce_snowflakes_flag = true

-- (technic)
--unilib.setting.technic_update_flag = true
--unilib.setting.technic_extra_flag = true
--unilib.setting.technic_grind_metal_ratio = 2
--unilib.setting.technic_grind_mineral_ratio = 2
--unilib.setting.technic_grind_stone_ratio = 1

-- (toolranks)
--unilib.setting.toolranks_enable_flag = false
--unilib.setting.toolranks_max_levels = 10
--unilib.setting.toolranks_nodes_per_level= 500
--unilib.setting.toolranks_speed_multiplier = 2.0
--unilib.setting.toolranks_use_multiplier = 2.0

--unilib.setting.toolranks_announce_flag = false
--unilib.setting.toolranks_progressive_flag = true
--unilib.setting.toolranks_countdown_flag = true

-- (towercrane)
--unilib.setting.crane_max_height = 32
--unilib.setting.crane_max_width = 32
--unilib.setting.crane_rope_length = 40

-- (trash can)
--unilib.setting.trash_can_throw_flag = false

-- (tsm_pyramids)
--unilib.setting.tsm_pyramids_real_trap_flag = true

-- (underch, uchu)
--unilib.setting.underch_tweak_flag = false
--unilib.setting.underch_override_abm_flag = false

-- (unifieddyes)
--unilib.setting.unifieddyes_update_flag = true

-- (unified_inventory)
--unilib.setting.unified_inventory_update_flag = true

-- (xdecor)
--unilib.setting.xdecor_glow_flag = false
--unilib.setting.xdecor_painting_count = 20

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Biome/decoration/ore settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.setting.random_seed_offset_flag = false
--unilib.setting.mapgen_seed_offset_flag = false

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Environment settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.setting.super_stone_set = "desert ordinary"
--unilib.setting.super_dirt_set = "dry ordinary"
--unilib.setting.super_tree_set = "acacia aspen apple jungle pine"

--unilib.setting.squeezed_stone_flag = false
--unilib.setting.squeezed_gravel_flag = false
--unilib.setting.squeezed_dirt_flag = false
--unilib.setting.squeezed_sand_flag = false
--unilib.setting.squeezed_metal_flag = false
--unilib.setting.squeezed_leaves_flag = false
--unilib.setting.squeezed_technic_flag = true
--unilib.setting.squeezed_overstack_flag = false

--unilib.setting.real_stone_hardness_flag = false
--unilib.setting.sandstone_cobble_rubble_flag = false
--unilib.setting.gravel_sand_bonus_rate = 16

--unilib.setting.caves_chop_dirt_flag = true
--unilib.setting.overgrown_turf_flag = false
--unilib.setting.unfussy_turf_flag = false
--unilib.setting.dirt_on_demand_flag = true
--unilib.setting.show_covered_dirt_flag = true

--unilib.setting.disable_grass_drop_flag = false

--unilib.setting.weak_tree_flag = false
--unilib.setting.weak_slim_tree_flag = false
--unilib.setting.auto_rotate_wood_flag = false
--unilib.setting.reduced_wood_flag = false
--unilib.setting.rendered_leaves_flag = false
--unilib.setting.plantlike_leaves_flag = false
--unilib.setting.walkable_leaves_flag = false
--unilib.setting.regrow_fruit_flag = false
--unilib.setting.leaves_drop_sticks_flag = false
--unilib.setting.tree_to_log_factor = 0.1

--unilib.setting.sapling_grow_min = 300
--unilib.setting.sapling_grow_max = 1500
--unilib.setting.sapling_grow_default = 300
--unilib.setting.sapling_grow_retry = 300
--unilib.setting.sapling_quick_grow_flag = false
--unilib.setting.sapling_variable_grow_flag = false
--unilib.setting.sapling_override_flag = true
--unilib.setting.sapling_everywhere_flag = false
--unilib.setting.sapling_grow_hint_flag = false
--unilib.setting.sapling_grow_hint_omit_flag = true

--unilib.setting.farming_grow_default = 160.0

--unilib.setting.floodable_flora_flag = false
--unilib.setting.flushable_flora_flag = false

--unilib.setting.blocking_papyrus_flag = true
--unilib.setting.walkable_waterlilies_flag = true

--unilib.setting.abm_spread_factor = 1.0

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Non-environment settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.setting.auto_rotate_brick_flag = false

--unilib.setting.dye_from_crops_flag = false
--unilib.setting.dye_from_fruit_flag = false
--unilib.setting.dye_from_produce_flag = false

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Stair/wall/carving settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.setting.add_stairs_basic_flag = true
--unilib.setting.show_stairs_basic_flag = false
--unilib.setting.show_stairs_super_flag = true

--unilib.setting.add_stairs_stairs_redo_flag = false
--unilib.setting.show_stairs_stairs_redo_flag = false
--unilib.setting.add_stairs_stairsplus_flag = false
--unilib.setting.show_stairs_stairsplus_flag = false
--unilib.setting.add_stairs_moreblocks_flag = false
--unilib.setting.show_stairs_moreblocks_flag = false
--unilib.setting.add_stairs_plantlife_flag = false
--unilib.setting.show_stairs_plantlife_flag = false
--unilib.setting.add_stairs_castle_flag = false
--unilib.vshow_stairs_castle_flag = false

--unilib.setting.convert_stairs_on_drop_flag = true
--unilib.setting.reduce_stair_light_flag = true
--unilib.setting.advanced_stair_rotation_flag = true

--unilib.setting.add_walls_flag = true

--unilib.setting.add_carvings_column_flag = true
--unilib.setting.show_carvings_column_flag = false
--unilib.setting.add_carvings_facade_flag = false
--unilib.setting.show_carvings_facade_flag = false
--unilib.setting.add_carvings_millwork_flag = false
--unilib.setting.show_carvings_millwork_flag = false
--unilib.setting.add_carvings_farlands_flag = false
--unilib.setting.show_carvings_farlands_flag = false

--unilib.setting.reduce_carving_light_flag = true

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Player effects settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.setting.builtin_entity_effects_flag = false

--unilib.setting.tool_warn_break_flag = true
--unilib.setting.tool_repair_factor = 0.075
--unilib.setting.tool_limit_repair_factor = 0.0

--unilib.setting.bed_respawn_flag = true
--unilib.setting.bed_bouncy_flag = true

--unilib.setting.wield_light_flag = false

--unilib.setting.magnet_auto_get_flag = false
--unilib.setting.magnet_auto_drop_flag = false
--unilib.setting.magnet_get_key_flag = true
--unilib.setting.magnet_no_get_key_flag = true
--unilib.setting.magnet_get_key_type = "Use"
--unilib.setting.magnet_auto_get_volume = 0.4
--unilib.setting.magnet_auto_get_particle_flag = true
--unilib.setting.magnet_auto_get_radius = 0.75
--unilib.setting.magnet_auto_fly_radius = -1.0
--unilib.setting.magnet_auto_fly_time = 5.0
--unilib.setting.magnet_auto_get_delay = 0.5
--unilib.setting.magnet_click_get_flag = true

--unilib.setting.hud_standard_posn = "middle"
--unilib.setting.hud_standard_colour_flag = true
--unilib.setting.hotbar_size = 8

--unilib.setting.cuisine_advanced_flag = false
--unilib.setting.cuisine_history_max_size = 10
--unilib.setting.cuisine_novelty_factor = 1.5

--unilib.setting.hunger_enable_flag = false
--unilib.setting.hunger_factor = 1.0
--unilib.setting.hunger_on_sprint_flag = true
--unilib.setting.hunger_on_sprint_factor = 1.0

--unilib.setting.thirst_enable_flag = false
--unilib.setting.thirst_factor = 1.0

--unilib.setting.identify_enable_hud_flag = true
--unilib.setting.identify_hud_mode = "fixed"
--unilib.setting.identify_optimise_hud_flag = false
--unilib.setting.identify_package_name_flag = false

--unilib.setting.wield_view_enable_flag = true
--unilib.setting.wield_view_update_time = 2
--unilib.setting.wield_view_node_tiles_flag = false

--unilib.setting.alarm_enable_flag = true

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Player effects settings (statistics and calendars)
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.setting.stats_bio_flag = false
--unilib.setting.stats_activity_flag = false

--unilib.setting.calendar_year_offset = 1000
--unilib.setting.calendar_month_offset = 1
--unilib.setting.calendar_day_offset = 1
--unilib.setting.calendar_system = S("A.D.")
--unilib.setting.calendar_leap_year_flag = true
--unilib.setting.calendar_format_string = "%D, %d %M %y %S %E %T"
--unilib.setting.calendar_enable_tooltips_flag = true
--unilib.setting.calendar_week_start_offset = 1

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Age-appropriate settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.setting.enable_adult_content_flag = false

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --
-- Debug settings
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --

--unilib.setting.debug_disable_effects_flag = false
--unilib.setting.debug_enable_effects_flag = false

--unilib.setting.debug_warn_duplicate_line_flag = false

--unilib.setting.debug_all_inventory_flag = false

--unilib.setting.debug_add_name_flag = false
--unilib.setting.debug_add_orig_name_flag = false

--unilib.setting.debug_force_light_source = 0
--unilib.setting.debug_xray_flag = false

--unilib.setting.debug_check_heights_flag = false
--unilib.setting.debug_forced_biome = ""
--unilib.setting.debug_biome_filter = ""

--unilib.setting.debug_sapling_failure_flag = false

--unilib.setting.debug_biome_showcase_flag = false
--unilib.setting.debug_biome_showcase_size = 25
--unilib.setting.debug_biome_showcase_exclude_flag = false
--unilib.setting.debug_biome_showcase_min_height = 1
--unilib.setting.debug_biome_showcase_max_height = 31000
