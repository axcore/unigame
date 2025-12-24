---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_fly_take_off = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_fly_take_off.add_to_queue(self)

    -- Adapted from petz.lq_fly()
    -- Called for flying mobs
    -- Gives the mob a slow upwards acceleration, allowing it take off.

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        self.object:set_acceleration({x = 0, y = 1, z = 0})

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_fly_take_off", func)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_fly_take_off.init()

    return {
        description = "Standard high-level mob behaviour: take off from the surface",
        notes = "See also the related behaviour in the \"hqb_fly_take_off\" package",
    }

end
