---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_api.lua
--      Provide the API from the "petz/petz" mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Create separate namespace for petz API functions/constants/settings
unimobs.petz_api = {}
unimobs.petz_const = {}
unimobs.petz_global = {}
unimobs.petz_setting = {}
unimobs.petz_msetting = {}

---------------------------------------------------------------------------------------------------
-- Set up constants
---------------------------------------------------------------------------------------------------

-- Was petz.settings.visual
unimobs.petz_const.visual = "mesh"
-- Was petz.settings.visual_size
unimobs.petz_const.visual_size = {x = 10, y = 10}
-- Was petz.settings.rotate
unimobs.petz_const.rotate = 0

-- Was petz.colors
-- Used in formspecs (see petz_formspecs.lua); the original red colour has been tweaked, to make it
--      easier to read on the black-ish background
unimobs.petz_const.colour_table = {
    green = "#3ADF00",
--  red = "#DF013A",
    red = "#ec421d",
}

---------------------------------------------------------------------------------------------------
-- Set up global vars
---------------------------------------------------------------------------------------------------

-- Original to unimobs
-- List of mob types created by loaded packages (matching the .mod_table.mod_type value, e.g.
--      "lion_normal")
-- Each such package should call unimobs.petz_api.register_mob() to update this list
unimobs.petz_global.mob_list = {}
-- Table of mob types and data associated with them
-- Table in the form
--      mob_table[mob_type] = data_table
-- ...where "data_table" contains the following key-value pairs:
--      .mob_name
--          - Matches the entity name, e.g. "unilib:mob_lion_normal"
--      .description
--          - Matches the entity description, e.g. "Lion (Normal)"
--      .collisionbox, .genetic_init_list, .mesh, .skin_init_list, .visual_size
--          - Copies of the data stored in mob entities, used for initialisation tasks
--      .genetic_range_table
--          - Derived from .genetic_init_list, a lookup table with minimum/maximum values for each
--              gene of the category "range", in the form
--                  genetic_range_table[gene_type] = {
--                      initial_min = value,
--                      initial_max = value,
--                      overall_min = value,
--                      overall_max = value,
--                  }
--          - Use the convenience function unimobs.petz_api.get_genetic_range_table() to quickly
--              access these values
--      .insertion_table
--          - Table providing substitutions for visible translated text, in the form described in
--              petz_register.lua
--      .version
--          - Code version for this mob. Code in petz_init_prop.lua checks the value so that, in
--              case of any major changes to the mob, old mob entities can be updated. When first
--              written, mobs should have a .version with the value 1; later changes should be
--              numbered 2, 3 etc
unimobs.petz_global.mob_table = {}
-- List of strings matching the name (or mob type) for any mob that should be removed from the game
--      (so both "lion" and "lion_nor" would remove "unilib:mob_lion_normal")
-- When strings are added to this list, corresponding packages are still loaded (if that package is
--      specified by a remix) and unilib.register_entity() is still called, but the corresponding
--      spawn egg is not created
-- In addition, code in unimobs.petz_api.set_initial_properties() will remove any matching entities
--      from the world
-- Any code can add items to this list. Note that items added to the Minetest setting
--      "unimobs_petz_remove_list" setting are automatically extracted and added to this list
unimobs.petz_global.mob_remove_list = {}

-- Was petz.pet
-- Table of players who currently have a formspec open, and the mob entity that's being displayed in
--      those formspec. The table is required for any code that needs the entity but doesn't know it
--      (for example, unimobs.petz_api.handle_mob_death() )
-- Table in the form
--      formspec_player_table[player_name] = entity_reference
unimobs.petz_global.formspec_player_table = {}

---------------------------------------------------------------------------------------------------
-- Import files
---------------------------------------------------------------------------------------------------

dofile(unimobs.path_mod .. "/lib/system/petz/petz_settings.lua")

dofile(unimobs.path_mod .. "/lib/system/petz/petz_breed.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_capture.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_clutching.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_collisionbox.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_convert.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_death.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_dung.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_eggs.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_env_damage.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_formspecs.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_init_prop.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_lifespan.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_mount.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_nametag.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_on_deactivate.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_on_punch.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_on_rightclick.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_on_step.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_particles.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_register.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_replenish.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_sleep.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_spawn.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_tamagotchi.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_tame.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_teleport.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_textures.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_utils.lua")
