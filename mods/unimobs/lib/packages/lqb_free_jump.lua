---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_free_jump = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_free_jump.add_to_queue(self)

    -- Adapted from mobkit.lq_freejump(), kitz.lq_freejump()
    -- An unconditional jump in the direction in which the creature is facing. ("Unconditional"
    --      means that even mobs without the "can_jump_flag" property can call it)
    -- This behaviour is useful, for example, for getting out of water. The behaviour terminates
    --      when the jump apex has been reached, allowing for a controlled landing
    -- This behaviour is almost identical to the "lqb_short_jump" behaviour, but the magnitude of
    --      the jump is slightly bigger

    -- (Persistent data used to preserve state between calls to the closure below)
    local phase = 1

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        local vel = self.object:get_velocity()
        if phase == 1 then

            vel.y = vel.y + 6
            self.object:set_velocity(vel)
            phase = 2

        else

            if vel.y <= 0.01 then
                return true
            end

            local dir = core.yaw_to_dir(self.object:get_yaw())
            dir.y = vel.y
            self.object:set_velocity(dir)

        end

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_free_jump", func)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_free_jump.init()

    return {
        description = "Standard low-level mob behaviour: jump unconditionally",
        notes = "This behaviour is useful, for example, for getting out of water. The function" ..
                " returns when the jump apex has been reached",
    }

end
