---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_obey_driver = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_obey_driver.add_to_queue(self, priority)

    -- Adapted from petz.hq_mountdriver()
    -- A behaviour called for mobs that are being ridden by a player. Waits until the mob's
    --      low-level queue is empty, then launches the "lqb_obey_driver" behaviour, which responds
    --      to the player's (riding) commands

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or not self.driver then
            return true
        elseif unimobs.mobkit_api.is_low_level_queue_empty(self) then
            unilib.pkg.lqb_obey_driver.add_to_queue(self)
        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_obey_driver", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_obey_driver.init()

    return {
        description = "Standard high-level mob behaviour: handle the mob's behaviour while it is" ..
                " being ridden by a player",
        notes = "See also the related behaviour in the \"lqb_obey_driver\" package",
        depends = "lqb_obey_driver",
    }

end
