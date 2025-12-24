---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_aqua_roam = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_aqua_roam.add_to_queue(self, priority, speed, shallow_flag)

    -- Adapted from mobkit.hq_aqua_roam(), duplicated by kitz.hq_aqua_roam()
    -- The default behaviour for many aquatic mobs. The mob chooses a random direction (launching
    --      the "hqb_aqua_turn" behaviour if necessary), then moves towards it at the specified
    --      "speed"
    -- N.B. In shallow water (1 block deep), creatures get stuck in a constant turning loop. The
    --      fix is to specify a true value for "shallow_flag" when called from "hqb_aqua_roam" and
    --      "mtb_order_autonomy"; this fix has been adopted from Slightly's version of petz

    -- (Persistent data used to preserve state between calls to the closure below)
    local init_flag = true
    local centre_pos = self.object:get_pos()
    local prev_scan_pos = {x = 0, y = 0, z = 0}
    local target_yaw = 0

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        if init_flag then

            unimobs.mobkit_api.do_entity_animation(self, "def")
            init_flag = false

        end

        local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
        if not stand_pos then
            return true
        end

        local yaw = self.object:get_yaw()
        local scan_pos = unimobs.mobkit_api.get_pos_of_node_centre(
            unimobs.mobkit_api.shift_pos_by_horizontal_distance(stand_pos, yaw, speed)
        )

        if not vector.equals(prev_scan_pos, scan_pos) then

            prev_scan_pos = scan_pos
            local new_yaw, height = unilib.pkg.shared_mobkit_aqua.check_swimming_direction(
                stand_pos, yaw, speed, true, shallow_flag
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

        if unimobs.mobkit_api.check_main_timer(self, 1) then

            if vector.distance(stand_pos, centre_pos) > unimobs.setting.abr * 16 * 0.5 then

                target_yaw = core.dir_to_yaw(
                    vector.direction(
                        stand_pos,
                        {
                            x = centre_pos.x + (random() * 10) - 5,
                            y = centre_pos.y,
                            z = centre_pos.z + (random() * 10) - 5,
                        }
                    )
                )

            else

                if random(10) >= 9 then
                    target_yaw = target_yaw + (random() * math.pi) - (math.pi * 0.5)
                end

            end

        end

        unimobs.mobkit_api.turn_to_yaw(self, target_yaw, 3)
        unimobs.mobkit_api.set_forward_velocity(self, speed)

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_aqua_roam", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_aqua_roam.init()

    return {
        description = "Standard high-level mob behaviour: roaming behaviour for aquatic mobs",
        depends = {"hqb_aqua_turn", "shared_mobkit_aqua"},
    }

end
