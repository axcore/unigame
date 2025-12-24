---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_find_flower = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local abs = math.abs

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_find_flower.add_to_queue(self, target_pos)

    -- Adapted from petz.lq_search_flower()
    -- Called only for worker bees
    -- Moves towards a flower at the specified "target_pos". On arrival, the bee's "has_pollen_flag"
    --      property is set to true

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or not target_pos then
            return true
        end

        local pos = self.object:get_pos()
        local y_distance = target_pos.y - pos.y
        local abs_y_distance = abs(y_distance)
        if abs_y_distance > 1 and abs_y_distance < self.view_range then

            unilib.pkg.mtb_set_forward_velocity.do_action(
                self, {x = 0, y = y_distance, z = 0}
            )

        end

        if unimobs.mobkit_api.move_towards_pos(self, target_pos, 1.5, 6.28, 0.5) then

            self.has_pollen_flag = unimobs.mobkit_api.add_mob_memory(self, "has_pollen_flag", true)
            unimobs.petz_api.show_standard_particles(self.object:get_pos(), "pollen")
            return true

        end

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_find_flower", func)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_find_flower.init()

    return {
        description = "Standard low-level mob behaviour: find flowers and collect pollen",
        depends = "mtb_set_forward_velocity",
    }

end
