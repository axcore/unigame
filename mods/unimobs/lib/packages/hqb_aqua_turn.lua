---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_aqua_turn = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_aqua_turn.add_to_queue(self, priority, target_yaw, speed)

    -- Adapted from mobkit.hq_aqua_turn(), duplicated by kitz.hq_aqua_turn()
    -- Called only for aquatic mobs
    -- Turns towards the specified "target_yaw" and then sets the mob's velocity to the specified
    --      "speed"

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        local facing_yaw_flag, _ = unimobs.mobkit_api.turn_to_yaw(self, target_yaw)
        unimobs.mobkit_api.set_forward_velocity(self, speed)
        if facing_yaw_flag then
            return true
        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_aqua_turn", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_aqua_turn.init()

    return {
        description = "Standard high-level mob behaviour: turning behaviour for aquatic mobs",
        notes = "Used by the \"hqb_aqua_roam\" and \"hqb_aqua_attack\" behaviours",
    }

end
