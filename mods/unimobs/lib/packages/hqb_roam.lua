---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_roam = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_roam.add_to_queue(self, priority)

    -- Adapted from mobkit.hq_roam(), duplicated by kitz.hq_roam()
    -- The default behaviour for many terrestrial mobs. The mob chooses a neighbouring node at
    --      random, and calls the "mtb_dumb_step" behaviour to go there, continuing indefinitely

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        if unimobs.mobkit_api.is_low_level_queue_empty(self) and self.isonground then

            local neighbour_num = random(8)

            local height, target_pos, liquid_flag =
                    unimobs.mobkit_api.is_neighbour_node_reachable(self, neighbour_num)
            if height and not liquid_flag then
                unilib.pkg.mtb_dumb_step.do_action(self, height, target_pos, 0.3)
            end

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_roam", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_roam.init()

    return {
        description = "Standard high-level mob behaviour: default roaming behaviour on land",
        notes = "The function never returns true (or false)",
        depends = "mtb_dumb_step",
    }

end
