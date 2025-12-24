---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_fly_alight = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_fly_alight.do_action(self, priority, end_status)

    -- Adapted from petz.alight()
    -- Called only for flying mobs
    -- Clears both behaviour queues, updates the mob's animation if necessary, then launches the
    --      "hqb_fly_alight" behaviour to attempt a landing

    -- N.B. Even though this function's original name is not in the form petz.bh_X(), it is closer
    --      to a type of meta-behaviour than to a general function, so it has been imported into a
    --      meta-behaviour package

    unimobs.mobkit_api.clear_both_queues(self)

    local below_node = unimobs.petz_api.get_node_at_named_location(self, "below")
    if not below_node or below_node.name ~= "air" then
        unimobs.mobkit_api.do_entity_animation(self, "fly")
    end

    unilib.pkg.hqb_fly_alight.add_to_queue(self, priority, end_status)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_fly_alight.init()

    return {
        description = "Standard mob meta-behaviour: prepare to land",
        notes = "See also the related behaviours in the \"hqb_fly_alight\" and" ..
                " \"lqb_fly_alight\" packages",
        depends = "hqb_fly_alight",
    }

end
