---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- liquids_other.lua
--      Other liquid registry functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register melting ice/snow
---------------------------------------------------------------------------------------------------

function unilib.liquids._register_ice_snow_melting(full_name, data_table)

    -- Original to unilib
    -- Ice/snow items that are capable of melting into water should call this function, so that
    --      suitable ABMs can act on them
    --
    -- Args:
    --      full_name (str): e.g. "unilib:snow_soft_block"
    --      data_table (table): Table containing the keys .source and .flowing, the full names of
    --          the pair of water nodes. If not specified, "unilib:liquid_water_ordinary_source"
    --          and "unilib:liquid_water_ordinary_flowing" are used

    unilib.global.ice_snow_melting_table[full_name] = data_table

end

---------------------------------------------------------------------------------------------------
-- Register lava
---------------------------------------------------------------------------------------------------

function unilib.liquids._register_lava(data_table)

    -- Original to unilib
    -- Registers a type of lava in global variables, as well as the stone node produced when the
    --      lava cools
    -- Lava items are also registered like any other type of liquid, with calls to
    --      unilib.register_liquid() and unilib.register_node()
    --
    -- data_table compulsory fields:
    --      data_table.cooled_name (str): e.g. "unilib:stone_obsidian"
    --      data_table.lava_name (str): e.g. "unilib:liquid_lava_ordinary_source"

    -- (Lava cooling is handled by an ABM, after all packages have been loaded)
    unilib.global.lava_cooling_table[data_table.lava_name] = data_table.cooled_name

end
