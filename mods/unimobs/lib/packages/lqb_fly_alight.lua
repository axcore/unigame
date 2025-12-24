---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_fly_alight = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_fly_alight.add_to_queue(self)

    -- Adapted from petz.lq_alight()
    -- Called only for flying mobs
    -- Gives the mob a slow downwards acceleration, allowing it to land

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        self.object:set_acceleration({x = 0, y = -1, z = 0})
        return true

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_fly_alight", func)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_fly_alight.init()

    return {
        description = "Standard low-level mob behaviour: land on the surface",
        notes = "See also the related behaviours in the \"hqb_fly_alight\" and" ..
                " \"mtb_fly_alight\" packages",
    }

end
