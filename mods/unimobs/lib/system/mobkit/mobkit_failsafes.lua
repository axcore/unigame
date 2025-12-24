---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- mobkit_failsafes.lua
--      Failsafe functions for use when essential behaviours are not available (because their
--          packages have not been loaded)
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions (original to unimobs)
---------------------------------------------------------------------------------------------------

function unimobs.mobkit_api.on_die_failsafe(self)

    -- Original to unimobs
    -- Failsafe function for use when unilib.pkg.hqb_die.add_to_queue is not available, also
    --      replacing mobkit.hq_die() / kitz.hq_die()

    unimobs.mobkit_api.apply_brain_death(self)
    self.object:remove()

end
