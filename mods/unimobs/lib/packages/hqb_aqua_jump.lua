---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_aqua_jump = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_aqua_jump.add_to_queue(self, priority)

    -- Adapted from petz.hq_aqua_jump()
    -- Called for aquatic mobs that have the "can_jump_flag" property
    -- Jumps out of the water briefly, making a satisfying splashing sound

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        local vel_impulse = 2.5
        local vel = {
            x = self.max_speed * (vel_impulse / 3),
            y = self.max_speed * vel_impulse,
            z = self.max_speed * (vel_impulse / 3),
        }

        unilib.pkg.mtb_set_forward_velocity.do_action(self, vel)
        self.object:set_acceleration({x = 1.0, y = vel_impulse, z = 1.0})
        self.status = unimobs.mobkit_api.add_mob_memory(self, "status", "jump")
        unimobs.kitz_api.make_sound(
            "object", self.object, "unilib_splash_petz", unimobs.petz_setting.max_hear_distance
        )

        core.after(1, function()

            if unimobs.mobkit_api.is_object_alive(self.object) then

                self.status = unimobs.mobkit_api.add_mob_memory(self, "status", nil)
                unimobs.mobkit_api.clear_high_level_queue(self)

            end

        end, self, vel)

        return true

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_aqua_jump", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_aqua_jump.init()

    return {
        description = "Standard high-level mob behaviour: jumping behaviour for aquatic mobs",
        depends = "mtb_set_forward_velocity",
    }

end
