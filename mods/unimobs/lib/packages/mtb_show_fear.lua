---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_show_fear = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_show_fear.do_action(self, target_pos)

    -- Adapted from petz.bh_afraid()
    -- Turns away from the player or creature at the specified "target_pos", also setting the mob's
    --      vertical velocity to zero

    if not unimobs.mobkit_api.is_behaviour_safe(self) then
        return
    end

    unilib.pkg.mtb_turn_away_from_danger.do_action(self, target_pos)

    local x = self.object:get_velocity().x
    local z = self.object:get_velocity().z
    self.object:set_velocity({x = x, y = 0, z = z})

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_show_fear.init()

    return {
        description = "Standard mob meta-behaviour: turn away from potential danger",
        depends = "mtb_turn_away_from_danger",
    }

end
