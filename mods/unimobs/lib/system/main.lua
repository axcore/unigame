---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- main.lua
--      Initialise global constants and variables, and import Minetest settings
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Create separate namespace for constants, global variables and Minetest settings
unimobs.constant = {}
unimobs.global = {}
unimobs.setting = {}

---------------------------------------------------------------------------------------------------
-- Create global constants (from mobkit/init.lua)
---------------------------------------------------------------------------------------------------

-- Gravity values. The non-negative value (slightly) simplifies some calculations
unimobs.constant.abs_gravity = tonumber(core.settings:get("movement_gravity")) or 9.81
unimobs.constant.gravity = unimobs.constant.abs_gravity * -1
-- Inert entities will slow down when in contact with the ground. The smaller the number, the
--      greater the effect
unimobs.constant.friction = 0.4
-- Note from original mod: a 20 metre fall means death
unimobs.constant.terminal_velocity = math.sqrt(2 * unimobs.constant.abs_gravity * 20)
-- Note from original mod: a 5 metre fall is safe
unimobs.constant.safe_velocity = math.sqrt(2 * unimobs.constant.abs_gravity * 5)

---------------------------------------------------------------------------------------------------
-- Create global constants (original to unimobs)
---------------------------------------------------------------------------------------------------

-- When unimob tool wear is enabled (unimobs.setting.apply_tool_wear_flag is true), the amount of
--      wear applied to unimobs tools, every time they are used
unimobs.constant.tool_wear = 65536 / 64

---------------------------------------------------------------------------------------------------
-- Create global variables (from kitz/engine.lua)
---------------------------------------------------------------------------------------------------

-- Table used only when unimobs.setting.tweak_mobkit_engine_flag is true
unimobs.global.active_mob_table = {}

---------------------------------------------------------------------------------------------------
-- Create global variables (original to unimobs)
---------------------------------------------------------------------------------------------------

-- Table of mobs that must not be spawned naturally; includes mobs like ants and bees which are
--      "spawned" using custom code
-- Table in the form
--      forbidden_spawn_table[mob_type] = true
unimobs.global.forbidden_spawn_table = {}
-- Spawn egg conversion table; converts a mob name into its corresponding spawn egg. Table in the
--      form
--      spawnegg_lookup_table[unilib:mob_duck_normal] = "unilib:spawnegg_duck_normal"
unimobs.global.spawnegg_lookup_table = {}

---------------------------------------------------------------------------------------------------
-- Import engine settings (from mobkit/init.lua)
---------------------------------------------------------------------------------------------------

-- Active block range
unimobs.setting.abr = tonumber(core.get_mapgen_setting("active_block_range")) or 3

---------------------------------------------------------------------------------------------------
-- Import Minetest settings (original to unimobs)
---------------------------------------------------------------------------------------------------

-- unimobs settings

-- If true, then tweaks to the mobkit engine, found in kitz, are applied. If false, only the
--      original mobkit engine code is used
unimobs.setting.tweak_mobkit_engine_flag =
        core.settings:get_bool("unimobs_tweak_mobkit_engine_flag", true)
-- Flag set to true if wear should be applied to unimobs tools (lassos, nets etc); false if not
unimobs.setting.apply_tool_wear_flag = core.settings:get_bool("unimobs_apply_tool_wear_flag", true)
-- Flag set to true, to enable some items to have special abilities in creative mode (the DNA
--      analyser requires no fuel, the sketchbook already contains all mobs, etc)
unimobs.setting.enable_creative_bonus_flag =
        core.settings:get_bool("unimobs_enable_creative_bonus_flag", false)

---------------------------------------------------------------------------------------------------
-- Import Minetest settings ("vis_harm_1nd" mod)
---------------------------------------------------------------------------------------------------

-- If true, visible harm bars are added to players whose health is not at its maximum
unimobs.setting.enable_harm_bar_players_flag =
        core.settings:get_bool("unimobs_enable_harm_bar_players_flag", true)
-- If true, visible harm bars are added to mobs whose health is not at its maximum
unimobs.setting.enable_harm_bar_mobs_flag =
        core.settings:get_bool("unimobs_enable_harm_bar_mobs_flag", true)
-- If true, visible harm bars are only added to petz-compatible mobs which were attacked by players.
--      Ignored if "unimobs_enable_harm_bar_mobs_flag" is false
unimobs.setting.enable_harm_bar_victim_flag =
        core.settings:get_bool("unimobs_enable_harm_bar_victim_flag", true)

---------------------------------------------------------------------------------------------------
-- Import Minetest settings ("wildlife" mod)
---------------------------------------------------------------------------------------------------

-- N.B. The original code used different default values in init.lua and settingtypes.txt; unimobs
--      uses the values from settingtypes.txt

-- Probability of spawning a mob when there are no other mobs in active_block_range around the
--      player
-- Must be a float in the range 0 to 1, where 0 is never, and 1 is always
unimobs.setting.wildlife_spawn_probability =
        tonumber(core.settings:get("unimobs_wildlife_spawn_probability")) or 0.3
-- Spawn probability is reduced by this factor for each mob within active_block_range
-- Must be a float in the range 0 to 1, where larger numbers apply a greater reduction
unimobs.setting.wildlife_spawn_reduction_factor =
        tonumber(core.settings:get("unimobs_wildlife_spawn_reduction_factor")) or 0.2

---------------------------------------------------------------------------------------------------
-- Import Minetest settings ("petz" modpack)
---------------------------------------------------------------------------------------------------

-- N.B. All settings are imported by ../lib/system/petz/petz_settings.lua
