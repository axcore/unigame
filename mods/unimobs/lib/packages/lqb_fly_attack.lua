---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_fly_attack = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_fly_attack.add_to_queue(self, target_obj)

    -- Adapted from petz.lq_flyattack()
    -- Called only for flying mobs
    -- Flies towards the "target_obj", punching it when close enough

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or
                not unimobs.mobkit_api.is_object_alive(target_obj) then
            return true
        end

        local target_pos = target_obj:get_pos()
        local pos = self.object:get_pos()

        -- Calculate attack spot
        local dist = vector.distance(pos, target_pos)
        if dist <= 1.5 then

            target_obj:punch(self.object, 1, self.attack_table)

            -- Bounce off
            local y_velocity = self.object:get_velocity().y
            local yaw = self.object:get_yaw()
            local dir = core.yaw_to_dir(yaw)
            self.object:set_velocity({x = dir.x * -3, y = y_velocity, z = dir.z * -3})

            -- Play attack sound, if defined
            -- N.B. Fixed error in original code; call to kitz.make_sound() should have been a call
            --      to kitz.play_sound()
            unimobs.mobkit_api.do_entity_sound(self, "attack")

            if self.kamikaze_attack_mode_flag then
                unimobs.mobkit_api.apply_damage(self, self.hp, "kamikaze attack")
            end

        else

            unilib.pkg.mtb_fly_to.do_action(self, target_obj)

        end

        unilib.pkg.lqb_idle.add_to_queue(self, 0.3)
        return true

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_fly_attack", func)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_fly_attack.init()

    return {
        description = "Standard low-level mob behaviour: attack the specified target",
        notes = "See also the related behaviour in the \"hqb_fly_attack\" package",
        depends = {"lqb_idle", "mtb_fly_to"},
    }

end
