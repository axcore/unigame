---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- main.lua
--      Main setup
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Load files - ../lib/system
---------------------------------------------------------------------------------------------------

-- Set up utility functions, so they're available for anything that follows
dofile(unilib.core.path_mod .. "/lib/system/utils/utils.lua")

-- Initialise global constants and variables, and import Minetest settings
dofile(unilib.core.path_mod .. "/lib/system/global/global.lua")

-- Register privileges, set up random seeds and set up sound effects
dofile(unilib.core.path_mod .. "/lib/system/intro/intro.lua")
dofile(unilib.core.path_mod .. "/lib/system/sound/sound.lua")

-- Set up registration functions, including replacements for several Minetest registration functions
dofile(unilib.core.path_mod .. "/lib/system/register/register.lua")

-- Set up the unilib HUD
dofile(unilib.core.path_mod .. "/lib/system/hud/hud.lua")

---------------------------------------------------------------------------------------------------
-- Load files - ../lib/shared
---------------------------------------------------------------------------------------------------

-- Set up miscellaneous functions
dofile(unilib.core.path_mod .. "/lib/shared/misc/misc.lua")
-- Make either minetest_game/player_api, or its unilib equivalent, available
dofile(unilib.core.path_mod .. "/lib/shared/player_api/player_api.lua")

-- Set up stone
dofile(unilib.core.path_mod .. "/lib/shared/stone/stone.lua")
-- Set up dirt
dofile(unilib.core.path_mod .. "/lib/shared/dirt/dirt.lua")
-- Set up liquids
dofile(unilib.core.path_mod .. "/lib/shared/liquids/liquids.lua")

-- Set up metals
dofile(unilib.core.path_mod .. "/lib/shared/metals/metals.lua")
-- Set up minerals
dofile(unilib.core.path_mod .. "/lib/shared/minerals/minerals.lua")

-- Set up shared functions for various types of flora
dofile(unilib.core.path_mod .. "/lib/shared/flora/flora.lua")
-- Set up trees
dofile(unilib.core.path_mod .. "/lib/shared/trees/trees.lua")
-- Set up bushes
dofile(unilib.core.path_mod .. "/lib/shared/bushes/bushes.lua")
-- Set up flowers
dofile(unilib.core.path_mod .. "/lib/shared/flowers/flowers.lua")
-- Set up coral
dofile(unilib.core.path_mod .. "/lib/shared/coral/coral.lua")

-- Set up farming
dofile(unilib.core.path_mod .. "/lib/shared/farming/farming.lua")
-- Set up fishing
dofile(unilib.core.path_mod .. "/lib/shared/fishing/fishing.lua")

-- Set up doors, trapdoors and (fence) gates
dofile(unilib.core.path_mod .. "/lib/shared/access/access.lua")
-- Set up armour
dofile(unilib.core.path_mod .. "/lib/shared/armour/armour.lua")
-- Set up calendars
dofile(unilib.core.path_mod .. "/lib/shared/calendars/calendars.lua")
-- Set up dyes
dofile(unilib.core.path_mod .. "/lib/shared/dyes/dyes.lua")
-- Set up fertiliser
dofile(unilib.core.path_mod .. "/lib/shared/fertiliser/fertiliser.lua")
-- Set up furniture
dofile(unilib.core.path_mod .. "/lib/shared/furniture/furniture.lua")
-- Set up juice
dofile(unilib.core.path_mod .. "/lib/shared/juice/juice.lua")
-- Set up ladders
dofile(unilib.core.path_mod .. "/lib/shared/ladders/ladders.lua")
-- Set up panes
dofile(unilib.core.path_mod .. "/lib/shared/panes/panes.lua")
-- Set up tools
dofile(unilib.core.path_mod .. "/lib/shared/tools/tools.lua")

-- Set up fire
dofile(unilib.core.path_mod .. "/lib/shared/fire/fire.lua")

-- Set up stairs
dofile(unilib.core.path_mod .. "/lib/shared/stairs/stairs.lua")
-- Set up carvings
dofile(unilib.core.path_mod .. "/lib/shared/carvings/carvings.lua")
-- Set up walls
dofile(unilib.core.path_mod .. "/lib/shared/walls/walls.lua")

-- Set up pseudo-biomes
dofile(unilib.core.path_mod .. "/lib/shared/pbiomes/pbiomes.lua")
dofile(unilib.core.path_mod .. "/lib/shared/jbiomes/jbiomes.lua")
dofile(unilib.core.path_mod .. "/lib/shared/dynamic/dynamic.lua")

---------------------------------------------------------------------------------------------------
-- Load files - ../lib/effects
---------------------------------------------------------------------------------------------------

-- Set up advanced cuisine
dofile(unilib.core.path_mod .. "/lib/effects/cuisine/cuisine.lua")
-- Set up hydration/thirst
dofile(unilib.core.path_mod .. "/lib/effects/hydration/hydration.lua")
--Set up hunger and sprinting fatigue
dofile(unilib.core.path_mod .. "/lib/effects/stamina/stamina.lua")

---------------------------------------------------------------------------------------------------
-- Load files - ../lib/system
---------------------------------------------------------------------------------------------------

-- Read CSVs
dofile(unilib.core.path_mod .. "/lib/system/read/read.lua")
-- Load packages
dofile(unilib.core.path_mod .. "/lib/system/load/load.lua")

---------------------------------------------------------------------------------------------------
-- Load files - ../lib/effects
---------------------------------------------------------------------------------------------------

-- Set up player alarms
dofile(unilib.core.path_mod .. "/lib/effects/alarms/alarms.lua")

-- Apply special effects to Minetest builtin entities
dofile(unilib.core.path_mod .. "/lib/effects/builtin/builtin.lua")

-- Set up various debug effects
dofile(unilib.core.path_mod .. "/lib/effects/debug/debug.lua")

-- Set up flooding and flushing effects
dofile(unilib.core.path_mod .. "/lib/effects/flooding/flooding.lua")

-- Set the hotbar size for each player
dofile(unilib.core.path_mod .. "/lib/effects/hotbar/hotbar.lua")

-- Set up the HUD window identifying the pointed-at node
dofile(unilib.core.path_mod .. "/lib/effects/identify/identify.lua")

-- Set up Minecraft-style item drop/get
dofile(unilib.core.path_mod .. "/lib/effects/magnet/magnet.lua")

-- Set up player biographical/activity statistics
dofile(unilib.core.path_mod .. "/lib/effects/stats/stats.lua")

-- Set up wielded light effects
dofile(unilib.core.path_mod .. "/lib/effects/wield_light/wield_light.lua")

-- Set up the wield_view effect
dofile(unilib.core.path_mod .. "/lib/effects/wield_view/wield_view.lua")

---------------------------------------------------------------------------------------------------
-- Load files - ../lib/system
---------------------------------------------------------------------------------------------------

-- Run finalisation code
dofile(unilib.core.path_mod .. "/lib/system/final/final.lua")
