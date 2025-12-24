---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_aqua_attack = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_aqua_attack.add_to_queue(self, priority, target_obj, speed)

    -- Adapted from mobkit.hq_aqua_attack(), duplicated by kitz.hq_aqua_attack()
    -- Standard attack behaviour for aquatic mobs
    -- Attacks the specified "target_obj", turning towards it when necessary

    -- (Persistent data used to preserve state between calls to the closure below)
    local init_flag = true
    local prev_scan_pos = {x = 0, y = 0, z = 0}
    local target_cbox = target_obj:get_properties().collisionbox
    local target_yaw = 0

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or
                not unimobs.mobkit_api.is_object_alive(target_obj) then
            return true
        end

        if init_flag then

            unimobs.mobkit_api.do_entity_animation(self, "fast")
            unimobs.mobkit_api.do_entity_sound(self, "attack")
            init_flag = false

        end

        local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
        if not stand_pos then
            return true
        end

        local yaw = self.object:get_yaw()
        local scan_pos = unimobs.gets_pos_of_node_centre(
            unimobs.mobkit_api.shift_pos_by_horizontal_distance(stand_pos, yaw, speed)
        )

        if not vector.equals(prev_scan_pos, scan_pos) then

            prev_scan_pos = scan_pos
            local new_yaw, height = unilib.pkg.shared_mobkit_aqua.check_swimming_direction(
                stand_pos, yaw, speed * 0.5
            )

            if height and height > stand_pos.y then

                local vel = self.object:get_velocity()
                vel.y = vel.y + 1
                self.object:set_velocity(vel)

            end

            if yaw ~= new_yaw then

                target_yaw = new_yaw
                unilib.pkg.hqb_aqua_turn.add_to_queue(self, priority + 1, target_yaw, speed)
                return

            end

        end

        -- N.B. Original mobkit code re-declares three local variables; here, they are named as
        --      "latter_X"
        local latter_target_pos = target_obj:get_pos()
        local latter_target_yaw = core.dir_to_yaw(vector.direction(stand_pos, latter_target_pos))
        unimobs.mobkit_api.turn_to_yaw(self, latter_target_yaw, 3)

        local latter_own_yaw = self.object:get_yaw()
        if unimobs.mobkit_api.check_main_timer(self, 1) then

            if not unilib.pkg.shared_mobkit_aqua.is_deep_in_liquid(target_obj) then
                return true
            end

            local vel = self.object:get_velocity()
            if latter_target_pos.y > (stand_pos.y + 0.5) then
                self.object:set_velocity({x = vel.x, y = vel.y + 0.5, z = vel.z})
            elseif latter_target_pos.y < (stand_pos.y - 0.5) then
                self.object:set_velocity({x = vel.x, y = vel.y - 0.5, z = vel.z})
            end

        end

        -- Bite (punch) the target
        if unimobs.mobkit_api.is_pos_in_box(
            unimobs.mobkit_api.shift_pos_by_horizontal_distance(
                stand_pos, latter_own_yaw, self.attack_table.range
            ),
            latter_target_pos,
            target_cbox
        ) then

            target_obj:punch(self.object, 1, self.attack_table)
            unilib.pkg.hqb_aqua_turn.add_to_queue(self, priority, latter_own_yaw - math.pi, speed)
            return true

        end

        unimobs.mobkit_api.set_forward_velocity(self, speed)

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_aqua_attack", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_aqua_attack.init()

    return {
        description = "Standard high-level mob behaviour: attack behaviour for aquatic mobs",
        depends = {"hqb_aqua_turn", "shared_mobkit_aqua"},
    }

end
