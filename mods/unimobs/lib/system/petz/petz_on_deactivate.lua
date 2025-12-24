---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_on_deactivate.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_on_deactivate.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.on_deactivate_callback(self)

    -- From petz.on_deactivate()
    -- Standard .on_deactivate() callback for all petz-compatible mob entities

    unimobs.kitz_api.unregister_active_mob(self)

end
