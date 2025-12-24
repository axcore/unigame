---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_order_stand = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_order_stand.do_action(self)

    -- Adapted from petz.stand()
    -- Commonly called after the meta-behaviours "mtb_order_guard" and "mtb_order_stand_here" are
    --      executed
    -- Sets the mob's velocity and acceleration to zero

    if not unimobs.mobkit_api.is_behaviour_safe(self) then
        return
    end

    self.object:set_velocity({x = 0, y = 0, z = 0})
    self.object:set_acceleration({x = 0, y = 0, z = 0})

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_order_stand.init()

    return {
        description = "Standard mob meta-behaviour: stop moving",
    }

end
