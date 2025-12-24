---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_look_at = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_look_at.do_action(self, priority, player_pos)

    -- Adapted from petz.bh_look_at()
    -- Decides whether it's appropriate for the mob to look at a nearby player at the specified
    --      "player_pos". If so, launches the "hqb_look_at" behaviour with the specified priority

    if not unimobs.petz_setting.enable_look_at_behaviour_flag or
            not self.head_prop_table or
            not unimobs.petz_api.is_mob_standing_still(self) or
            unimobs.mobkit_api.is_behaviour_in_high_level_queue(self, "hqb_look_at") or
            random(1, unimobs.petz_setting.look_at_behaviour_chance) ~= 1 or
            (self.is_mountable_flag and self.driver) then
        return
    end

    unilib.pkg.hqb_look_at.add_to_queue(self, priority, player_pos)
    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_look_at.init()

    return {
        description = "Standard mob meta-behaviour: looks at a player",
        notes = "See also the related behaviour in the \"hqb_look_at\" package",
        depends = "hqb_look_at",
    }

end
