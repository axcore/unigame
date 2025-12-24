---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_order_follow = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_order_follow.do_action(self, player)

    -- Adapted from petz.follow()
    -- Follows the specified player, launching the appropriate behaviour for the mob's current
    --      situation

    unimobs.mobkit_api.clear_both_queues(self)

    self.status = unimobs.mobkit_api.add_mob_memory(self, "status", "follow")

    -- In case none of these behaviour packages are loaded, the mob will do nothing (its behaviour
    --      queues having been emptied)
    if self.can_fly_flag and
            unilib.global.pkg_executed_table["hqb_follow_in_liquid_or_air"] ~= nil then

        unimobs.mobkit_api.do_entity_animation(self, "fly")
        unilib.pkg.hqb_follow_in_liquid_or_air.add_to_queue(self, 100, player)

    elseif self.can_swim_flag and
            self.isinliquid and
            unilib.global.pkg_executed_table["hqb_follow_in_liquid_or_air"] ~= nil then

        unimobs.mobkit_api.do_entity_animation(self, "def")
        unilib.pkg.hqb_follow_in_liquid_or_air.add_to_queue(self, 100, player)

    elseif unilib.global.pkg_executed_table["hqb_follow"] ~= nil then

        unilib.pkg.hqb_follow.add_to_queue(self, 100, player)

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_order_follow.init()

    return {
        description = "Standard mob meta-behaviour: follow the player",
    }

end
