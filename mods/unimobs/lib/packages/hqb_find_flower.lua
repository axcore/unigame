---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_find_flower = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_find_flower.add_to_queue(self, priority, target_pos)

    -- Adapted from petz.hq_gotopollen()
    -- Called only for bees.
    -- This behaviour launches the "lqb_find_flower" behaviour and then waits, terminating only
    --      when the bee arrives at a flower

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or self.has_pollen_flag then
            return true
        end

        unimobs.mobkit_api.do_entity_animation(self, "fly")
        unilib.pkg.lqb_find_flower.add_to_queue(self, target_pos)

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_find_flower", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_find_flower.init()

    return {
        description = "Standard high-level mob behaviour: find flowers",
        depends = "lqb_find_flower",
    }

end
