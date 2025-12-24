---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_fly_take_off = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_fly_take_off.add_to_queue(self, priority)

    -- Adapted from petz.hq_fly()
    -- A flying mob on the ground empties its high-level queue, then takes off by launching
    --      "lqb_fly_take_off"

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        unimobs.mobkit_api.do_entity_animation(self, "fly")
        unilib.pkg.lqb_fly_take_off.add_to_queue(self)
        unimobs.mobkit_api.clear_high_level_queue(self)

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_fly_take_off", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_fly_take_off.init()

    return {
        description = "Standard high-level mob behaviour: take off from the surface",
        notes = "See also the related behaviour in the \"lqb_fly_take_off\" package",
        depends = "lqb_fly_take_off",
    }

end
