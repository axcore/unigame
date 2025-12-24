---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_goto = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_goto.add_to_queue(self, priority, target_pos)

    -- Adapted from mobkit.hq_goto(), duplicated by kitz.hq_goto()
    -- The mob waits until its low-level queue is empty, then moves towards the specified
    --      "target_pos", one waypoint at a time. The behaviour terminates upon arrival

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        if unimobs.mobkit_api.is_low_level_queue_empty(self) and self.isonground then

            local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
            if not stand_pos then
                return true
            end

            if vector.distance(stand_pos, target_pos) > 3 then
                unimobs.mobkit_api.goto_next_waypoint(self, target_pos)
            else
                return true
            end

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_goto", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_goto.init()

    return {
        description = "Standard high-level mob behaviour: go to a position",
        notes = "The closure function returns true on arrival",
    }

end
