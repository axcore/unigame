---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_climb_tree = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_climb_tree.add_to_queue(self, priority)

    -- Adapted from petz.hq_climb()
    -- Should be called only for mobs that have the "can_climb_trees_flag" property
    -- If the mob is not facing a tree node (including both trunks and leaves), the behaviour
    --      terminates immediately
    -- Otherwise, waits for the low-level queue to be empty, then launches the "lqb_climb_tree"
    --      behaviour to climb the tree

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        if not unimobs.petz_api.check_tree(self) then

            self.status = unimobs.mobkit_api.add_mob_memory(self, "status", nil)
            unimobs.mobkit_api.clear_both_queues(self)
            return true

        end

        if unimobs.mobkit_api.is_low_level_queue_empty(self) then

            self.status = unimobs.mobkit_api.add_mob_memory(self, "status", "climb")
            unilib.pkg.lqb_climb_tree.add_to_queue(self)

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_climb_tree", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_climb_tree.init()

    return {
        description = "Standard high-level mob behaviour: climb the adjacent tree",
        notes = "See also the related behaviours in the \"mtb_climb_tree\" and" ..
                " \"lqb_climb_tree\" packages",
        depends = "lqb_climb_tree",
    }

end
