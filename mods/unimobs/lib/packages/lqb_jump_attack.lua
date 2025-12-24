---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
--
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_jump_attack = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

-- Localise math functions (for speed)
local sqrt = math.sqrt

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_mobkit_attack(self, height, target_obj)

    -- Adapted from mobkit.lq_jumpattack(), duplicated by kitz.lq_jumpattack() and
    --      petz.lq_jumpattack()

    -- (Persistent data used to preserve state between calls to the closure below)
    local init_flag = true
    local target_cbox = target_obj:get_properties().collisionbox
    -- N.B. This variable, declared in the original mobkit code, is unused
--  local timer = 0.5

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or
                not unimobs.mobkit_api.is_object_alive(target_obj) then
            return true
        end

        if self.isonground then

            -- Collision bug workaround
            if init_flag then

                -- N.B. This variable, declared in the original mobkit code, is unused
--              local vel = self.object:get_velocity()
                local dir = core.yaw_to_dir(self.object:get_yaw())
                dir = vector.multiply(dir, 6)
                dir.y = unimobs.constant.abs_gravity *
                        sqrt(height * 2 / unimobs.constant.abs_gravity)
                self.object:set_velocity(dir)
                unimobs.mobkit_api.do_entity_sound(self, "charge")
                init_flag = false

            else

                unilib.pkg.lqb_idle.add_to_queue(self, 0.3)
                return true

            end

        else

            local target_pos = target_obj:get_pos()
            local current_pos = self.object:get_pos()

            -- Calculate attack spot
            local yaw = self.object:get_yaw()
            local dir = core.yaw_to_dir(yaw)
            local attack_pos = unimobs.mobkit_api.shift_pos_by_horizontal_distance(
                current_pos, yaw, self.attack_table.range
            )

            -- If in range, punch the target
            if unimobs.mobkit_api.is_pos_in_box(attack_pos, target_pos, target_cbox) then

                target_obj:punch(self.object, 1, self.attack_table)

                -- Bounce off
                local y_velocity = self.object:get_velocity().y
                self.object:set_velocity({x = dir.x * -3, y = y_velocity, z = dir.z * -3})

                -- Play attack sound, if defined
                unimobs.mobkit_api.do_entity_sound(self, "attack")
                return true

            end

        end

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_jump_attack", func)

end

local function do_petz_attack(self, height, target_obj)

    -- Adapted from petz.lq_jumpattack()
    -- By rewriting the original mobkit version of this behaviour, it's not clear which problem the
    --      author of petz is trying to solve. It MIGHT be trying to prevent the mob from delivering
    --      multiple punches during one jump
    -- In any case, the player can use settings to choose the original mobkit attacks, if they
    --      prefer

    -- (Persistent data used to preserve state between calls to the closure below)
    local phase = 1

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or
                not unimobs.mobkit_api.is_object_alive(target_obj) then
            return true
        end

        if self.isonground then

            if phase == 1 then

                -- Collision bug workaround
                local vel = self.object:get_velocity()
                vel.y = unimobs.constant.abs_gravity *
                        sqrt(height * 2 / unimobs.constant.abs_gravity)
                self.object:set_velocity(vel)
                -- N.B. Fixed error in original code; call to kitz.make_sound() should have been a
                --      call to kitz.play_sound()
                unimobs.mobkit_api.do_entity_sound(self, "charge")

                phase = 2

            else

                unilib.pkg.lqb_idle.add_to_queue(self, 0.3)
                return true

            end

        elseif phase == 2 then

            local dir = core.yaw_to_dir(self.object:get_yaw())
            local y_velocity = self.object:get_velocity().y
            dir = vector.multiply(dir, 6)
            dir.y = y_velocity
            self.object:set_velocity(dir)

            phase = 3

        elseif phase == 3 then

            -- In air
            local target_pos = target_obj:get_pos()
            local pos = self.object:get_pos()

            -- (Calculate attack spot)
            local yaw = self.object:get_yaw()
            local dir = core.yaw_to_dir(yaw)
            local distance = vector.distance(pos, target_pos)

            if distance < 2.0 then

                target_obj:punch(self.object, 1, self.attack_table)

                -- Bounce off
                local y_velocity = self.object:get_velocity().y
                self.object:set_velocity({x = dir.x * -3, y = y_velocity, z = dir.z * -3})

                -- Play attack sound, if defined
                -- N.B. Fixed error in original code; call to kitz.make_sound() should have been a
                --      call to kitz.play_sound()
                unimobs.mobkit_api.do_entity_sound(self, "attack")

                -- Having set the phase to 4, the "lqb_idle" behaviour can be enabled (in the code
                --      just above) during the next call to this function
                phase = 4

            end

        end

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_jump_attack", func)

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_jump_attack.add_to_queue(self, height, target_obj)

    -- Jump towards the specified "target_obj" at the specified "height", give or take. Then punch
    --       the target
    -- The behaviour terminates after a punch, or when back on the ground

    if not unimobs.petz_setting.use_petz_attack_flag then
        do_mobkit_attack(self, height, target_obj)
    else
        do_petz_attack(self, height, target_obj)
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_jump_attack.init()

    return {
        description = "Standard low-level mob behaviour: jump towards the target and attack it",
        notes = "The closure function returns true after the punch, or after landing on the ground",
        depends = "lqb_idle",
    }

end
