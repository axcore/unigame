---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_hunt = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_hunt.add_to_queue(self, priority, target_obj)

    -- Adapted from mobkit.hq_hunt(), duplicated by kitz.hq_hunt() and petz.hq_hunt()
    -- Standard hunting behaviour for terrestrial mobs
    -- Waits until the low-level queue is empty. Then, if close enough to the specified
    --      "target_obj", the mob attacks it. Otherwise it moves towards (or follows) the target,
    --      one waypoint at a time
    -- The behaviour returns when "target_obj" is too far away or inactive.

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
            local dist = vector.distance(stand_pos, target_pos)

            if dist > self.view_range then
                return true
            elseif dist > 3 then
                unimobs.mobkit_api.goto_next_waypoint(self, target_pos)
            else
                unilib.pkg.hqb_attack.add_to_queue(self, priority + 1, target_obj)
            end

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_hunt", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_hunt.init()

    return {
        description = "Standard high-level mob behaviour: follow the target object and, when" ..
                " close enough, attack it",
        notes = "When close enough, the \"hqb_attack\" behaviour is initiated. The closure" ..
                " function returns true when the target object becomes inactive",
        depends = "hqb_attack",
    }

end
