---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_approach_beehive = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local abs = math.abs

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_approach_beehive.add_to_queue(self, priority)

    -- Adapted from petz.hq_approach_beehive()
    -- Called only for bees to stop them roaming too far from their hives
    -- Launches the "lqb_approach_beehive" behaviour and then waits, terminating only when the bee
    --      is a reasonable distance from its hive

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        local pos = self.object:get_pos()
        if abs(pos.x - self.beehive_pos.x) <= (self.view_range / 2) or
                abs(pos.z - self.beehive_pos.z) <= (self.view_range / 2) then

            unimobs.mobkit_api.clear_both_queues(self)
            return true

        end

        unilib.pkg.lqb_approach_beehive.add_to_queue(self)

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_approach_beehive", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_approach_beehive.init()

    return {
        description = "Standard high-level mob behaviour: bees move closer to their beehive, if" ..
                " they have flown away too far",
        notes = "See also the related behaviour in the \"lqb_approach_beehive\" package",
        depends = "lqb_approach_beehive",
    }

end
