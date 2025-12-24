---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_dumb_walk = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

-- Localise math functions (for speed)
local abs = math.abs

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_dumb_walk.add_to_queue(self, dest, speed_factor)

    -- Adapted from mobkit.lq_dumbwalk(), duplicated by kitz.lq_dumbwalk()
    -- Moves towards the specified destination "dest", using an appropriate animation. "dest" is
    --      often a waypoint on a route towards some other location, so will be very close to the
    --      mob's current position
    -- "speed_factor" is optional; its default value is 1. Higher or lower values increase or
    --  decrease the creature's walking speed

    -- (Apply default values to optional arguments)
    speed_factor = speed_factor or 1

    -- (Persistent data used to preserve state between calls to the closure below)
    -- Failsafe
    local timer = 3

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        unimobs.mobkit_api.do_entity_animation(self, "walk")
        timer = timer - self.dtime
        if timer < 0 then
            return true
        end

        local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
        if not stand_pos then
            return true
        end

        local y = self.object:get_velocity().y

        if unimobs.mobkit_api.has_reached_destination(
            stand_pos, core.yaw_to_dir(self.object:get_yaw()), dest
        ) then

            -- Prevent uncontrolled fall when velocity is too high
            if not self.isonground or abs(dest.y - stand_pos.y) > 0.1 then
                self.object:set_velocity({x = 0, y = y, z = 0})
            end

            return true

        end

        if self.isonground then

            local dir = vector.normalize(
                vector.direction(
                    {x = stand_pos.x, y = 0, z = stand_pos.z},
                    {x = dest.x, y = 0, z = dest.z}
                )
            )

            dir = vector.multiply(dir, self.max_speed * speed_factor)
            unimobs.mobkit_api.turn_to_yaw(self, core.dir_to_yaw(dir))
            dir.y = y
            self.object:set_velocity(dir)

        end

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_dumb_walk", func)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_dumb_walk.init()

    return {
        description = "Standard low-level mob behaviour: walk towards the destination",
        notes = "Sets the mob's \"walk\" animation",
    }

end
