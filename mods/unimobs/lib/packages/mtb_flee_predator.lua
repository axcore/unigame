---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_flee_predator = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_flee_predator.do_action(self, priority)

    -- Adapted from petz.bh_runaway_from_predator()
    -- Checks whether one of the mob's predators is nearby. If so, sets a new animation, then
    --      launches the appropriate fleeing behaviour

    local predator_list = unimobs.petz_api.get_msetting(self.mob_type, "predator_list")
    if predator_list == nil then
        return
    end

    for _, mob_name in ipairs(predator_list) do

        -- Is this mob nearby?
        local target_obj = unimobs.mobkit_api.get_closest_entity(self, mob_name)
        if target_obj then

            if vector.distance(self.object:get_pos(), target_obj:get_pos()) <= self.view_range then

                -- N.B. Original code doesn't expect birds/fish to escape predators
                if self.can_fly_flag and not self.is_plucked_flag then

                    unimobs.mobkit_api.do_entity_animation(self, "fly")
                    unilib.pkg.hqb_evade_in_liquid_or_air.add_to_queue(self, priority, target_obj)

                elseif self.can_swim_flag and self.isinliquid then

                    unimobs.mobkit_api.do_entity_animation(self, "def")
                    unilib.pkg.hqb_evade_in_liquid_or_air.add_to_queue(self, priority, target_obj)

                else

                    unilib.pkg.hqb_evade.add_to_queue(self, priority, target_obj)

                end

                return true

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_flee_predator.init()

    return {
        description = "Standard mob meta-behaviour: flee from nearby predators",
        depends = {"hqb_evade", "hqb_evade_in_liquid_or_air"},
    }

end
