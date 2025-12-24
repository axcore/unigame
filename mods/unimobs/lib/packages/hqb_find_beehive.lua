---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_find_beehive = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_find_beehive.add_to_queue(self, priority)

    -- Adapted from petz.hq_gotobeehive()
    -- Called only for bees
    -- Assuming that the bee hasn't yet found any pollen, launches the "lqb_find_beehive" behaviour
    --      and then waits, terminating when the bee no longer has pollen (because it was
    --      transferred to the beehive)

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or
                not self.has_pollen_flag or
                not self.beehive_pos then
            return true
        end

        unimobs.mobkit_api.do_entity_animation(self, "fly")
        unilib.pkg.lqb_find_beehive.add_to_queue(self)

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_find_beehive", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_find_beehive.init()

    return {
        description = "Standard high-level mob behaviour: find the beehive",
        depends = "lqb_find_beehive",
    }

end
