---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_evade_in_liquid_or_air = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_evade_in_liquid_or_air.add_to_queue(self, priority, target_obj)

    -- Original to unimobs, based on mobkit.hq_runfrom()
    -- Called only for flying and swimming mobs
    -- Waits until the low-level queue is empty, and the mob is not on the ground. Then moves away
    --      from the specified "target_obj", one waypoint at a time

    -- (Persistent data used to preserve state between calls to the closure below)
    local init_flag = true
    local timer = 6

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or
                not unimobs.mobkit_api.is_object_alive(target_obj) then
            return true
        end

        if init_flag then

            timer = timer - self.dtime
            if timer <= 0 or vector.distance(self.object:get_pos(), target_obj:get_pos()) < 8 then

                unimobs.mobkit_api.do_entity_sound(self, "scared")
                init_flag = false

            end

            return

        end

        if unimobs.mobkit_api.is_low_level_queue_empty(self) and not self.isonground then

            local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
            if not stand_pos then
                return true
            end

            local target_pos = target_obj:get_pos()
            -- N.B. Using a view range that's bigger than the one used in the "hqb_evade" package;
            --      assume that birds/fish have a better view of player-wielded items
            if vector.distance(stand_pos, target_pos) < (self.view_range * 1.5) then

                local waypoint_pos = {
                    x = (2 * stand_pos.x) - target_pos.x,
                    y = target_pos.y,
                    z = (2 * stand_pos.z) - target_pos.z,
                }

                unimobs.mobkit_api.goto_next_waypoint(self, waypoint_pos)

            else

                self.object:set_velocity({x = 0, y = 0, z = 0})
                return true

            end

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_evade_in_liquid_or_air", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_evade_in_liquid_or_air.init()

    return {
        description = "Standard high-level mob behaviour: flee from a player or creature",
        notes = "The closure function returns true when sufficiently far away from the target" ..
                " object",
    }

end
