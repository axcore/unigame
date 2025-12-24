---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_order_stand_here = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_order_stand_here.do_action(self)

    -- Adapted from petz.standhere()
    -- Commonly called after the player clicks a button in the main mob formspec (but can be called
    --      by anything)
    -- Sets the correct animation, set's the mob's "status" property, and then calls
    --      "mtb_order_stand" to set velocity and acceleration to zero

    unimobs.mobkit_api.clear_both_queues(self)

    if self.can_fly_flag then

        local below_node = unimobs.petz_api.get_node_at_named_location(self, "below")
        if below_node and below_node.name == "air" then
            unimobs.mobkit_api.do_entity_animation(self, "fly")
        else
            unimobs.mobkit_api.do_entity_animation(self, "stand")
        end

    elseif self.can_swim_flag and unimobs.petz_api.is_mob_in_liquid(self) then

        unimobs.mobkit_api.do_entity_animation(self, "def")

    else

        if self.animation_table["sit"] and not unimobs.petz_api.is_mob_in_liquid(self) then
            unimobs.mobkit_api.do_entity_animation(self, "sit")
        else
            unimobs.mobkit_api.do_entity_animation(self, "stand")
        end

    end

    self.status = unimobs.mobkit_api.add_mob_memory(self, "status", "stand")
    unilib.pkg.mtb_order_stand.do_action(self)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_order_stand_here.init()

    return {
        description = "Standard mob meta-behaviour: stop all behaviours and stand still",
        depends = "mtb_order_stand",
    }

end
