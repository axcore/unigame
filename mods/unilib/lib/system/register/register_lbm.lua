---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_lbm.lua
--      Register LBMs using a replacement for the Minetest registration function
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register LBMs
---------------------------------------------------------------------------------------------------

function unilib.register_lbm(def_table)

    -- Original to unilib
    -- N.B. There is no unilib.register._register_lbm()
    --
    -- Packages should call this function to register an LBM, rather than calling
    --      core.register_lbm() directly
    --
    -- Args:
    --      def_table (table): Usual definition table for the LBM

    -- (At the moment this function is a simple wrapper, but that might change later)
    core.register_lbm(def_table)

end

function unilib.register_obsolete_lbm(data_table)

    -- Original unilib
    -- Mark an LBM from minetest_game to be disabled, so it doesn't duplicate the action of a
    --      unilib LBM
    -- Code in ../lib/system/final/final_abm_lbm.lua will try to find a matching LBM and to disable
    --      it
    -- (This function should be called by the code that creates the unilib LBM)
    --
    -- N.B. There is no unilib.register._register_obsolete_lbm()
    --
    -- data_table compulsory fields:
    --      mod_origin (str): e.g. "default"
    --
    -- data_table optional fields:
    --      name (str): e.g. "default:3dtorch"
    --      label (str): not specified by most minetest_game LBMs, but available nonetheless

    table.insert(unilib.global.obsolete_lbm_list, data_table)

end
