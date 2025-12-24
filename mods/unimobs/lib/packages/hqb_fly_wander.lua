---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_fly_wander = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_fly_wander.add_to_queue(self, priority)

    -- Adapted from petz.hq_wanderfly()
    -- The default roaming behaviour for flying creatures. The mob waits until the low-level queue
    --      is empty, then launches "lqb_fly_wander"

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        if unimobs.mobkit_api.is_low_level_queue_empty(self) then
            unilib.pkg.lqb_fly_wander.add_to_queue(self, 0.6)
        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_fly_wander", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_fly_wander.init()

    return {
        description = "Standard high-level mob behaviour: default roaming behaviour for flying" ..
                " mobs",
        depends = "lqb_fly_wander",
    }

end
