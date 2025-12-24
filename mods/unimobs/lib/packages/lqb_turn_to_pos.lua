---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_turn_to_pos = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_turn_to_pos.add_to_queue(self, target_pos)

    -- Adapted from mobkit.lq_turn2pos(), duplicated by kitz.lq_turn2pos()
    -- Over several steps, turns the mob in the direction of the specified "target_pos". The
    --      behaviour terminates when facing "target_pos"

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        local pos = self.object:get_pos()
        return unimobs.mobkit_api.turn_to_yaw(
            self, core.dir_to_yaw(vector.direction(pos, target_pos))
        )

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_turn_to_pos", func)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_turn_to_pos.init()

    return {
        description = "Standard low-level mob behaviour: turn towards the target position",
        notes = "The closure function returns true when facing the target position",
    }

end
