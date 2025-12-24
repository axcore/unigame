---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_flee_player = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_flee_player.do_action(self, priority, player)

    -- Original to unimobs
    -- Sets a new animation, then launches the appropriate behaviour for fleeing the specified
    --      player

    if self.can_fly_flag and not self.is_plucked_flag then

        unimobs.mobkit_api.do_entity_animation(self, "fly")
        unilib.pkg.hqb_evade_in_liquid_or_air.add_to_queue(self, priority, player)

    elseif self.can_swim_flag and self.isinliquid then

        unimobs.mobkit_api.do_entity_animation(self, "def")
        unilib.pkg.hqb_evade_in_liquid_or_air.add_to_queue(self, priority, player)

    else

        unilib.pkg.hqb_evade.add_to_queue(self, priority, player)

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_flee_player.init()

    return {
        description = "Standard mob meta-behaviour: flee from players",
        depends = {"hqb_evade", "hqb_evade_in_liquid_or_air"},
    }

end
