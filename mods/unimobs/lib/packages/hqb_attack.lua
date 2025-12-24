---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_attack = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_attack.add_to_queue(self, priority, target_obj)

    -- Adapted from mobkit.hq_attack(), duplicated by kitz.hq_attack() and petz.hq_attack()
    -- Standard attack behaviour for terrestrial mobs
    -- Waits until the low-level queue is empty. Then, if close enough to the specified
    --      "target_obj", attacks it. Otherwise, this behaviour terminates.

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or
                not unimobs.mobkit_api.is_object_alive(target_obj) then
            return true
        end

        if unimobs.mobkit_api.is_low_level_queue_empty(self) then

            local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
            local target_pos = unimobs.mobkit_api.get_standing_pos(target_obj)
            if not stand_pos or not target_pos then
                return true
            end

            local dist = vector.distance(stand_pos, target_pos)

            if dist > 3 then

                return true

            else

                unilib.pkg.lqb_turn_to_pos.add_to_queue(self, target_pos)

                local height = (target_obj:is_player() and 0.35) or
                        (target_obj:get_luaentity().height * 0.6)
                if target_pos.y + height > stand_pos.y then

                    unilib.pkg.lqb_jump_attack.add_to_queue(
                        self, (target_pos.y + height - stand_pos.y), target_obj
                    )

                else

                    unilib.pkg.lqb_dumb_walk.add_to_queue(
                        self,
                        unimobs.mobkit_api.shift_pos_by_vector(
                            target_pos,
                            {x = random() - 0.5, z = random() - 0.5}
                        )
                    )

                end

            end

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_attack", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_attack.init()

    return {
        description = "Standard high-level mob behaviour: default attack behaviour",
        notes = "Turn towards the target object and leap at it. The closure function returns" ..
                " true when the target object is out of range",
        depends = {"lqb_dumb_walk", "lqb_jump_attack", "lqb_turn_to_pos"},
    }

end
