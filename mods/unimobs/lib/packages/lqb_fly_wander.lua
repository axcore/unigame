---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_fly_wander = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_fly_wander.add_to_queue(self, speed_factor)

    -- Adapted from petz.lq_dumbfly()
    -- Called for flying mobs to handle their flight
    -- The behaviour switches between four modes, depending on conditions. The modes are labelled
    --      "ascend", "descend", "stand" and "alight". The code considers switching from one mode to
    --      another every 3 seconds
    -- Depending on the current conditions, this behaviour may terminate to allow another one to
    --      start
    -- "speed_factor" is optional; its default value is 1. Higher or lower values increase or
    --      decrease the creature's flying speed

    -- (Persistent data used to preserve state between calls to the closure below)
    local fly_status = "ascend"
    local timer = unimobs.petz_setting.check_fly_behaviour_interval

    speed_factor = speed_factor or 1

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        -- There are 4 values for "fly_status": "ascend", "descend", "stand" and "alight"
        --
        -- Every 3 seconds:
        --      1) Check if the "max_roam_height" defined for each creature has been reached; if so,
        --          "descend" or "stand"
        --      2) Check if over water; if so, "ascend"
        --      3) Check if there's a node in front; if so, rotate in a random direction (but
        --          backwards), so the creature does not get stuck
        --      4) Do a random rotation, so the creature doesn't go too far in one direction
        --      5) For each value of "fly_status", there's a random chance of a change of status.
        --          There is a preference for "ascend" over "descend", because this keeps the
        --          creature in the air and allows it to fly over mountains and trees

        timer = timer - self.dtime
        -- Every 3 seconds...
        if timer < 0 then

            unimobs.mobkit_api.do_entity_animation(self, "fly")

            local yaw = self.object:get_yaw()
            local rotation = self.object:get_rotation()

            local front_node = unimobs.petz_api.get_node_at_named_location(self, "front")
            if (random(1, 5) <= 1 or not front_node or front_node.name ~= "air") and yaw then

                local rotation_integer = random(0, 4)
                local rotation_decimals = random()
                local new_yaw = yaw + rotation_integer + rotation_decimals
                unilib.pkg.lqb_fly_turn_to_yaw.add_to_queue(self, new_yaw)

                -- Terminate this behaviour to allow the turn to start
                return true

            end

            local y_impulse = 1
            local top_node = unimobs.petz_api.get_node_at_named_location(self, "top")
            if not unimobs.petz_api.is_obstacle_in_front_of_mob(self) and
                    top_node and
                    top_node.name == "air" then

                fly_status = "ascend"
                y_impulse = 3

            end

            -- (Returns nil if the mob flies higher than the .max_roam_height, otherwise returns
            ---     the height above the surface, building or tree)
            local height_from_ground = unimobs.petz_api.get_mob_height(self)

            -- "alight" at random intervals
            if self.can_alight_flag then

                if random(1, self.fly_chance) <= 1 then
                    fly_status = "alight"
                end

            end

            -- If the creature is at its max height, or if there's a node directly above it, then
            --      "descend" or "stand"
            if (fly_status ~= "alight" and not height_from_ground) or
                    not top_node or
                    top_node.name ~= "air" then

                if random(1, 100) < 70 then
                    fly_status = "descend"
                else
                    fly_status = "stand"
                end

            -- Check if water is below, or if near the ground; if so, then "ascend"
            elseif fly_status ~= "alight" then

                local below_node = unimobs.petz_api.get_node_at_named_location(self, "below")
                if below_node and core.get_item_group(below_node.name, "water") >= 1  then
                    fly_status = "ascend"
                end

                if height_from_ground and height_from_ground < 1 then
                    fly_status = "ascend"
                end

            end

            -- "stand"
            local vel
            if fly_status == "stand" then

                vel = {
                    x = self.max_speed * speed_factor,
                    y = 0,
                    z = self.max_speed * speed_factor,
                }

                self.object:set_rotation({x = 0, y = rotation.y, z = rotation.z})

                local random_num = random(1, 100)
                if random_num < 20 and not height_from_ground then
                    fly_status = "descend"
                elseif random_num < 40 then
                    fly_status = "ascend"
                end

            -- "descend"
            elseif fly_status == "descend" then

                vel = {
                    x = self.max_speed * speed_factor,
                    y = -speed_factor,
                    z = self.max_speed * speed_factor,
                }

                self.object:set_rotation({x = 0.16, y = rotation.y, z = rotation.z})

                local random_num = random(1, 100)
                if random_num < 20 then
                    fly_status = "stand"
                elseif random_num < 40 then
                    fly_status = "ascend"
                end

            -- "alight"
            elseif fly_status == "alight" then

                unilib.pkg.mtb_fly_alight.do_action(self, 0, "alight")
                return

            -- "ascend"
            else

                fly_status = "ascend"
                vel = {
                    x = self.max_speed * speed_factor,
                    y = speed_factor * (y_impulse or 1),
                    z = self.max_speed * speed_factor,
                }

                self.object:set_rotation({x = -0.16, y = rotation.y, z = rotation.z})

            end

            timer = unimobs.petz_setting.check_fly_behaviour_interval
            unilib.pkg.mtb_set_forward_velocity.do_action(self, vel)
            -- (Save the velocity at each step, not just every few seconds)
            self.fly_velocity = vel
            return true

        else

            if self.fly_velocity then

                unilib.pkg.mtb_set_forward_velocity.do_action(self, self.fly_velocity)

            else

                unilib.pkg.mtb_set_forward_velocity.do_action(
                    self, {x = 0, y = 0, z = 0}
                )

            end

        end

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_fly_wander", func)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_fly_wander.init()

    return {
        description = "Standard low-level mob behaviour: default roaming behaviour for flying mobs",
        notes = "This behaviour is called by the \"hqb_fly_wander\" behaviour, and itself calls" ..
                " the \"lqb_fly_turn_to_yaw\" behaviour",
        depends = {"lqb_fly_turn_to_yaw", "mtb_fly_alight", "mtb_set_forward_velocity"},
    }

end
