---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_order_autonomy = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_order_autonomy.do_action(self)

    -- Adapted from petz.ownthing()
    -- Clears both behaviour queues, then launches the appropriate roaming behaviour for the mob's
    --      current situation

    -- N.B. Fixed obvious error in original code, in which unimobs.mobkit_api.clear_both_queues()
    --      was called AFTER the roaming behaviour was added
    unimobs.mobkit_api.clear_both_queues(self)
    self.status = unimobs.mobkit_api.add_mob_memory(self, "status", nil)

    if self.can_fly_flag and unilib.global.pkg_executed_table["hqb_fly_wander"] ~= nil then

        unilib.pkg.hqb_fly_wander.add_to_queue(self, 0)

    elseif self.can_swim_flag and self.isinliquid and
            unilib.global.pkg_executed_table["hqb_aqua_roam"] ~= nil then

        -- N.B. The true argument is not found in the original code; it fixes the swimming issue
        --      described in the comments in the "hqb_aqua_roam" package
        unilib.pkg.hqb_aqua_roam.add_to_queue(self, 0, self.max_speed, true)

    elseif unilib.global.pkg_executed_table["hqb_roam"] ~= nil then

        unilib.pkg.hqb_roam.add_to_queue(self, 0)

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_order_autonomy.init()

    return {
        description = "Standard mob meta-behaviour: clear behaviour queues, and start roaming",
    }

end
