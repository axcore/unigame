---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_fly_liquid_recovery = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_fly_liquid_recovery.add_to_queue(self, priority)

    -- Adapted from petz.hq_liquid_recovery_flying()
    -- Called by flying mobs in water
    -- On a continual loop, sets the mob's velocity and acceleration, terminating the behaviour only
    --      when the mob is no longer in a liquid

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        self.object:set_acceleration({x = 0, y = 0.125, z = 0})
        self.object:set_velocity({x = 1.0, y = 1.0, z = 1.0})

        if not unimobs.petz_api.is_mob_in_liquid(self) then

            self.object:set_acceleration({x = 0, y = 0, z = 0})
            return true

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_fly_liquid_recovery", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_fly_liquid_recovery.init()

    return {
        description = "Standard high-level mob behaviour: recover flying mobs from water",
    }

end
