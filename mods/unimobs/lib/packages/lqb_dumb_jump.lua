---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_dumb_jump = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

-- Localise math functions (for speed)
local sqrt = math.sqrt

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_dumb_jump.add_to_queue(self, height, anim)

    -- Adapted from mobkit.lq_dumbjump(), duplicated by kitz.lq_dumbjump()
    -- The mob, standing on the ground, jumps towards the specified "height" (relative to feet
    --      level), using the specified animation
    --
    -- Notes from original code:
    -- Initial velocity for jump height h, v=a*sqrt(h*2/a), add 20%

    -- (Apply default values to optional arguments)
    anim = anim or "stand"

    -- (Persistent data used to preserve state between calls to the closure below)
    local jump_flag = true

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        local yaw = self.object:get_yaw()
        if self.isonground then

            if jump_flag then

                unimobs.mobkit_api.do_entity_animation(self, anim)
                local dir = core.yaw_to_dir(yaw)
                dir.y = unimobs.constant.abs_gravity *
                        sqrt((height + 0.35) * 2 / unimobs.constant.abs_gravity)
                self.object:set_velocity(dir)
                jump_flag = false

            else

                -- Landed
                return true

            end

        else

            local dir = core.yaw_to_dir(yaw)
            local velocity = self.object:get_velocity()
            if self.last_velocity_table.y < 0.9 then
                dir = vector.multiply(dir, 3)
            end

            dir.y = velocity.y
            self.object:set_velocity(dir)

        end

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_dumb_jump", func)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_dumb_jump.init()

    return {
        description = "Standard low-level mob behaviour: while on the ground, jump",
        notes = "The specified height is relative to the mob's feet level. The mob's \"stand\"" ..
                " animation is set",
    }

end
