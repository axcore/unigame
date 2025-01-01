---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_abm.lua
--      Register ABMs using a replacement for the Minetest registration function
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register ABMs
---------------------------------------------------------------------------------------------------

function unilib.register_abm(def_table)

    -- Original to unilib
    -- N.B. There is no unilib.register._register_abm()
    --
    -- Packages should call this function to register an ABM, rather than calling
    --      core.register_abm() directly
    --
    -- Args:
    --      def_table (table): Usual definition table for the ABM

    -- (At the moment this function is a simple wrapper, but that might change later)
    core.register_abm(def_table)

end

function unilib.register_obsolete_abm(data_table)

    -- Original unilib
    -- Mark an ABM from minetest_game to be disabled, so it doesn't duplicate the action of a
    --      unilib ABM
    -- Code in ../lib/system/final/final_abm_lbm.lua will try to find a matching ABM and to disable
    --      it
    -- (This function should be called by the code that creates the unilib ABM)
    --
    -- N.B. There is no unilib.register._register_obsolete_abm()
    --
    -- data_table compulsory fields:
    --      mod_origin (str): e.g. "default"
    --
    -- data_table optional fields:
    --      name (str): not specified by any minetest_game ABM, but available nonetheless
    --      label (str): e.g. "Lava cooling"

    table.insert(unilib.global.obsolete_abm_list, data_table)

end
