---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_approach_beehive = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_approach_beehive.add_to_queue(self)

    -- Adapted from petz.lq_approach_beehive()
    -- Called only for bees which have roamed too far from their hives. The bee moves back in the
    --      direction of its hive

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or not self.beehive_pos then
            return true
        end

        local target_pos = self.beehive_pos
        if unimobs.mobkit_api.move_towards_pos(
            self, target_pos, 1.5, 6.28, (self.view_range / 4)
        ) then

            unimobs.mobkit_api.clear_high_level_queue(self)
            return true

        end

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_approach_beehive", func)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_approach_beehive.init()

    return {
        description = "Standard low-level mob behaviour: bees move closer to their beehive, if" ..
                " they have flown too far away",
        notes = "See also the related behaviour in the \"hqb_approach_beehive\" package",
    }

end
