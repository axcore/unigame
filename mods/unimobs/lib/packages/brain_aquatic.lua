---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.brain_aquatic = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.brain_aquatic.brain(self)

    -- Adapted from petz.aquatic_brain()
    -- Logic code for various aquatic mobs

    local pos = self.object:get_pos()

    -- Standard vitals check
    unimobs.mobkit_api.check_vitals(self)

    -- Standard death check
    if self.hp <= 0 then

        unimobs.petz_api.handle_mob_death(self)
        return

    elseif not unimobs.petz_api.is_night() and
            self.die_in_daylight_flag and
            core.get_node_light(pos, core.get_timeofday()) >= self.spawn_max_light then

        -- This mob dies in light that's stronger than its maximum spawn light
        unimobs.petz_api.handle_mob_death(self)
        return

    end

    -- Main brain code
    if unimobs.mobkit_api.check_main_timer(self, 1) then

        local priority = unimobs.mobkit_api.get_queue_priority(self)

        -- Emergency suffocation recovery check
        unilib.pkg.mtb_rescue_suffocating_mob.do_action(self)

        -- If not a mammal, aquatic mobs suffocate in the air
        if not self.is_mammal_flag and not unimobs.petz_api.is_mob_in_liquid(self) then

            unimobs.mobkit_api.apply_damage(
                self, unimobs.petz_setting.air_damage, "suffocation in air"
            )

        end

        -- Check environmental damage (from fire, lava, other igniters and any nodes that have been
        --      designated as harmful to the mob)
        if priority < 30 then
            unimobs.petz_api.apply_env_damage(self, pos, 30)
        end

        -- Repel/follow behaviours
        local player = unimobs.mobkit_api.get_random_nearby_player(self)
        if priority == 16 then

            if (
                self.status == "repel" and
                unilib.pkg.mtb_stop_repelling.do_action(self, player)
            ) or (
                self.status == "follow" and
                unilib.pkg.mtb_stop_following.do_action(self, player)
            ) then
                return
            end

        elseif priority < 16 then

            -- N.B. Repel/follow behaviours can't happen at the same time, so share the same
            --      priority
            if unilib.pkg.mtb_start_repelling.do_action(self, 16, player) or
                    unilib.pkg.mtb_start_following.do_action(self, 16, player) then
                return
            end

        end

        -- Attack nearby players, if hostile
        if priority < 10 and
                player and
                self.hostile_to_players_flag and
                unilib.pkg.mtb_attack_player.do_action(self, 10, player) then
            return
        end

        -- Handle jumping
        if priority < 8 and
                self.can_jump_flag and
                self.status ~= "jump" and
                unilib.pkg.shared_mobkit_aqua.is_deep_in_liquid(self) and
                random(1, 25) == 1 and
                unimobs.petz_api.can_jump_in_liquid(self, pos) then

            unimobs.mobkit_api.clear_high_level_queue(self)
            unilib.pkg.hqb_aqua_jump.add_to_queue(self, 8)

        end

        -- Make a random noise
        unimobs.kitz_api.make_misc_sound(
            self,
            unimobs.petz_setting.random_sound_chance,
            unimobs.petz_setting.max_hear_distance
        )

        -- Handle default roaming
        if unimobs.mobkit_api.is_high_level_queue_empty(self) and
                not self.status and
                self.isinliquid then
            unilib.pkg.hqb_aqua_roam.add_to_queue(self, 0, self.max_speed)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brain_aquatic.init()

    return {
        description = "Logic code for various aquatic mobs",
        depends = {
            "hqb_aqua_jump",
            "hqb_aqua_roam",
            "mtb_attack_player",
            "mtb_rescue_suffocating_mob",
            "mtb_start_following",
            "mtb_start_repelling",
            "mtb_stop_following",
            "mtb_stop_repelling",
            "shared_mobkit_aqua",
        },
    }

end
