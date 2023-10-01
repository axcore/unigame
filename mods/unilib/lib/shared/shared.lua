---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- shared.lua
--      Set up unilib shared functions. This file contains a reference list of shared functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib
local path = unilib.path_mod .. "/lib/shared/"

---------------------------------------------------------------------------------------------------
-- Set up shared functions
---------------------------------------------------------------------------------------------------

-- Set up shared functions for clearing registered biomes/decorations/ores, replacing Minetest
--      clear_registered() calls
dofile(path .. "clear.lua")

-- Set up shared functions for base packages
dofile(path .. "base.lua")

-- Set up shared functions for beds
dofile(path .. "beds.lua")

-- Set up shared functions for boats
dofile(path .. "boats.lua")

-- Set up shared functions for bricks
dofile(path .. "bricks.lua")

-- Set up shared functions for bushes
dofile(path .. "bushes.lua")

-- Set up shared functions for cacti
dofile(path .. "cactus.lua")

-- Set up shared functions for candles
dofile(path .. "candles.lua")

-- Set up shared functions for carpets
dofile(path .. "carpets.lua")

-- Set up shared functions for items made from multiple types of wood (not already covered by
--      ../shared/trees.lua)
dofile(path .. "carpentry.lua")

-- Set up shared functions for carvings (from mods "columnia", "facade" and "mymillwork")
dofile(path .. "carvings.lua")

-- Set up shared functions for clays
dofile(path .. "clays.lua")

-- Set up shared functions for coral
dofile(path .. "coral.lua")

-- Set up shared functions for items in the "crop" and "produce" categories
dofile(path .. "crops.lua")
-- Set up shared functions for statistical functions imported from farming_redo
dofile(path .. "statistical.lua")

-- Set up shared functions for dirt and turf nodes
dofile(path .. "dirts.lua")

-- Set up shared functions for doors, trapdoors and fence gates
dofile(path .. "doors.lua")

-- Set up shared functions for dyes
dofile(path .. "dyes.lua")

-- Set up dynamic flooders and extenders
dofile(path .. "dynamic.lua")

-- Set up shared functions for fertilisers
dofile(path .. "fertiliser.lua")

-- Set up shared functions for fire
dofile(path .. "fire.lua")

-- Set up shared functions for fishing
dofile(path .. "fishing.lua")

-- Set up shared functions for flora (mainly trees and bushes)
dofile(path .. "flora.lua")

-- Set up shared functions for flowers (including mushrooms and waterlilies)
dofile(path .. "flowers.lua")

-- Set up shared functions for gateways
dofile(path .. "gateways.lua")

-- Set up shared functions for juice
dofile(path .. "juice.lua")

-- Set up shared functions for ladders
dofile(path .. "ladders.lua")

-- Set up shared functions for liquids
dofile(path .. "liquids.lua")

-- Set up shared functions for metals
dofile(path .. "metals.lua")

-- Set up shared functions for minerals
dofile(path .. "minerals.lua")

-- Set up miscellaneous shared functions
dofile(path .. "misc.lua")

-- Set up shared functions for panes
dofile(path .. "panes.lua")

-- Set up shared functions for creating pseudo-biomes
dofile(path .. "pbiomes.lua")
-- Set up shared functions for creating pseudo-biomes
dofile(path .. "jbiomes.lua")

-- These files are loaded if needed, via a call to unilib.load_player_api() (see below)
--dofile(path .. "player_api.lua")
--dofile(path .. "player_api_wrapper.lua")

-- Set up shared functions for signs
dofile(path .. "signs.lua")

-- Set up shared functions for stairs
dofile(path .. "stairs.lua")

-- Set up shared functions for stone
dofile(path .. "stone.lua")

-- Set up shared functions for tools
dofile(path .. "tools.lua")

-- Set up shared functions for traps
dofile(path .. "traps.lua")

-- Set up shared functions for trees
dofile(path .. "trees.lua")

-- Set up shared functions for walls
dofile(path .. "walls.lua")

-- Set up shared functions for wools
dofile(path .. "wools.lua")

---------------------------------------------------------------------------------------------------
-- Make either minetest_game/player_api, or its unilib equivalent, available
---------------------------------------------------------------------------------------------------

function unilib.load_player_api()

    -- Original to unilib

    -- Only load the file  once
    if not unilib.player_api_loaded_flag then

        if minetest.get_modpath("player_api") then
            dofile(path .. "player_api_wrapper.lua")
        else
            dofile(path .. "player_api.lua")
        end

        unilib.player_api_loaded_flag = true

    end

end
