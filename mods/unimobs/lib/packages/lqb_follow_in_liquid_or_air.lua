---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_follow_in_liquid_or_air = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_follow_in_liquid_or_air.add_to_queue(self, target_obj)

    -- Adapted from petz.lq_followliquidair()
    -- Called only for flying and swimming mobs
    -- Calls the "mtb_fly_to" behaviour, terminating immediately afterwards

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        unilib.pkg.mtb_fly_to.do_action(self, target_obj)
        return true

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_follow_in_liquid_or_air", func)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_follow_in_liquid_or_air.init()

    return {
        description = "Standard low-level mob behaviour: a flying/swimming mob follows something",
        notes = "See also the related behaviour in the \"hqb_follow_in_liquid_or_air\" package",
        depends = "mtb_fly_to",
    }

end
