---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_fly_turn_to_yaw = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_fly_turn_to_yaw.add_to_queue(self, yaw)

    -- Adapted from petz.lq_turn2yaw()
    -- Turns the mob to the specified "yaw", terminating the behaviour when that yaw is reached

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or
                unimobs.mobkit_api.turn_to_yaw(self, yaw) then
            return true
        end

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_fly_turn_to_yaw", func)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_fly_turn_to_yaw.init()

    return {
        description = "Standard low-level mob behaviour: turn towards the specified yaw",
    }

end
