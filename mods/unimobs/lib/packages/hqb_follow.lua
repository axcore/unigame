---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_follow = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_follow.add_to_queue(self, priority, target_obj)

    -- Adapted from mobkit.hq_follow(), duplicated by kitz.hq_follow()
    -- The mob follows the specified "target_obj" (which might be a player), one waypoint at a time,
    --      until the target becomes inactive
    -- When close enough to "target_obj", the mob launches "lqb_idle" and this behaviour continues,
    --      with the mob ready to continue following "target_obj" as soon as it moves away

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or
                not unimobs.mobkit_api.is_object_alive(target_obj) then
            return true
        end

        if unimobs.mobkit_api.is_low_level_queue_empty(self) and self.isonground then

            local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
            if not stand_pos then
                return true
            end

            local target_pos = target_obj:get_pos()
            if vector.distance(stand_pos, target_pos) > 3 then
                unimobs.mobkit_api.goto_next_waypoint(self, target_pos)
            else
                unilib.pkg.lqb_idle.add_to_queue(self, 1)
            end

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_follow", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_follow.init()

    return {
        description = "Standard high-level mob behaviour: follow something",
        notes = "The closure function returns true if the target object becomes inactive",
        depends = "lqb_idle",
    }

end
