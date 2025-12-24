---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_goto_liquid = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_goto_liquid.add_to_queue(self, priority, target_pos)

    -- Adapted from kitz.hq_gotoliquid() (but appears in the petz/petz mod, not the petz/kitz mod)
    -- "target_pos" should be a liquid. The mob waits until its low-level queue is empty, then moves
    --      towards "target_pos", one waypoint at a time

    local jump_flag = false

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        if unimobs.mobkit_api.is_low_level_queue_empty(self) then

            local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
            if not stand_pos then
                return true
            end

            -- N.B. Tweaked original code so that swimming creatures will jump into water, but other
            --      creatures will stop just short
            --[[
            if vector.distance(stand_pos, target_pos) > 3 then
                unimobs.mobkit_api.goto_next_waypoint(self, target_pos)
            else
                return true
            end
            ]]--
            if jump_flag then

                -- Low-level behaviour queue is empty, so the jump must be complete
                unimobs.kitz_api.make_sound(
                    "object",
                    self.object,
                    "unilib_splash_petz",
                    unimobs.petz_setting.max_hear_distance
                )

                return true

            elseif vector.distance(stand_pos, target_pos) > 1 then

                unimobs.mobkit_api.goto_next_waypoint(self, target_pos)

            elseif self.can_swim_flag and not self.isinliquid then

                unilib.pkg.lqb_turn_to_pos.add_to_queue(self, target_pos)
                unilib.pkg.lqb_short_jump.add_to_queue(self)
                -- Jump only once, and don't look for any more waypoints, allowing this behaviour
                --      to terminate
                jump_flag = true

            else

                return true

            end

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_goto_liquid", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_goto_liquid.init()

    return {
        description = "Standard high-level mob behaviour: moves towards nearby liquid, and jump in",
        depends = {"lqb_short_jump", "lqb_turn_to_pos"},
    }

end
