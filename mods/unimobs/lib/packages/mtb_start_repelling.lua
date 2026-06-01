---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_start_repelling = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_start_repelling.do_action(self, priority, player)

    -- Original to unimobs
    -- Checks whether the specified player is wielding one of the items that repels this mob
    -- If so, launches the appropriate evasion behaviour

    if not player then
        return
    end

    local wielded_name = player:get_wielded_item():get_name()

    if unimobs.petz_api.check_lookup_table_in_msetting_by_group(
        self.mob_type, "repel_item_table", wielded_name
    ) and vector.distance(self.object:get_pos(), player:get_pos()) <= self.view_range then

        self.status = unimobs.mobkit_api.add_mob_memory(self, "status", "repel")
        if self.can_fly_flag then

            unimobs.mobkit_api.do_entity_animation(self, "fly")
            unilib.pkg.hqb_evade_in_liquid_or_air.add_to_queue(self, priority, player)

        elseif self.can_swim_flag and self.isinliquid then

            unimobs.mobkit_api.do_entity_animation(self, "def")
            unilib.pkg.hqb_evade_in_liquid_or_air.add_to_queue(self, priority, player)

        else

            unilib.pkg.hqb_evade.add_to_queue(self, priority, player)

        end

        -- Register the discovery of the correct repelling item
        unimobs.kitz_api.register_discovered_item(player, self.mob_type, "repel", wielded_name)

        -- Update awards, if available
        if unilib.global.pkg_executed_table["award_zoologist"] ~= nil then
            unilib.pkg.award_zoologist.on_mob_repel(player, self)
        end

        -- Action complete
        return true

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_start_repelling.init()

    return {
        description = "Standard mob meta-behaviour: the mob starts being repelled by something",
        notes = "See also the related behaviour in the \"mtb_stop_repelling\" package",
        depends = {"hqb_evade", "hqb_evade_in_liquid_or_air"},
    }

end
