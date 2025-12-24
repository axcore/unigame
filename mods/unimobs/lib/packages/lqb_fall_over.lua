---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_fall_over = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_fall_over.add_to_queue(self)

    -- Adapted from mobkit.lq_fallover(), duplicated by kitz.lq_fallover()
    -- Usually launched by the **hqb_die** behaviour upon a mob's death
    -- Flips the mob over on its side, terminating when the rotation is complete

    -- (Persistent data used to preserve state between calls to the closure below)
    local init_flag = true
    local z_rotation = 0

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        if init_flag then

            local velocity = self.object:get_velocity()
            self.object:set_velocity(unimobs.mobkit_api.shift_pos_by_vector(velocity, {y = 1}))
            unimobs.mobkit_api.do_entity_animation(self, "stand")
            init_flag = false

        end

        z_rotation = z_rotation + (math.pi * 0.05)

        local rotation_table = self.object:get_rotation()
        self.object:set_rotation({x = rotation_table.x, y = rotation_table.y, z = z_rotation})
        if z_rotation >= (math.pi * 0.5) then
            return true
        end

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_fall_over", func)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_fall_over.init()

    return {
        description = "Standard low-level mob behaviour: fall over",
        notes = "Gradually rotates the mob's rotation on the z-axis from 0 to pi/2",
    }

end
