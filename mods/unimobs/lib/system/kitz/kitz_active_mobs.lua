---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- kitz_active_mobs.lua
--      Shared API functions from the petz/kitz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

local _id = 0

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/kitz/api/api_log.lua)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.register_active_mob(self)

    -- Was kitz.logon_mob()
    -- Adds a mob to the unimobs table of active mobs (used only by code imported from kitz)

    _id = _id + 1
    self._id = _id
    unimobs.global.active_mob_table[_id] = self

end

function unimobs.kitz_api.unregister_active_mob(self)

    -- Was kitz.logout_mob()
    -- Removs a mob from the unimobs table of active mobs (used only by code imported from kitz)

    unimobs.global.active_mob_table[self._id] = nil

end
