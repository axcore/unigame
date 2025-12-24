---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_fly_attack = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_fly_attack.add_to_queue(self, priority, target_obj)

    -- Adapted from petz.hq_flyattack()
    -- Standard attack behaviour for flying mobs
    -- Waits until the low-level queue is empty. Then, if close enough to the specified
    --      "target_obj", the mob attacks it. Otherwise, this behaviour terminates

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or
                not unimobs.mobkit_api.is_object_alive(target_obj) then
            return true
        end

        if unimobs.mobkit_api.is_low_level_queue_empty(self) then

            local pos = self.object:get_pos()
            local target_pos = unimobs.mobkit_api.get_standing_pos(target_obj)
            if not target_pos then
                return true
            end

            local dist = vector.distance(pos, target_pos)

            if dist > 3 then
                return true
            else
                unilib.pkg.lqb_fly_attack.add_to_queue(self, target_obj)
            end

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_fly_attack", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_fly_attack.init()

    return {
        description = "Standard high-level mob behaviour: default attack behaviour for flying mobs",
        notes = "See also the related behaviour in the \"lqb_fly_attack\" package",
        depends = "lqb_fly_attack",
    }

end
