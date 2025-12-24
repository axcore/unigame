---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.brain_semiaquatic = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.brain_semiaquatic.brain(self)

    -- Adapted from petz.semiaquatic_brain()
    -- Logic code for various semi-aquatic mobs

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
        if not unimobs.petz_api.is_mob_in_liquid(self) then
            unilib.pkg.mtb_rescue_suffocating_mob.do_action(self)
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

        -- Hunt prey, if not busy with anything important
        if priority < 12 then
             unilib.pkg.mtb_hunt_prey.do_action(self, 12, false)
        end

        -- Attack nearby players
        if priority < 10 and
                player and
                (
                    not self.is_tamed_flag or
                    (self.status == "guard" and player:get_player_name() ~= self.owner)
                ) then

            local player_pos = player:get_pos()
            if vector.distance(pos, player_pos) <= self.view_range and
                    self.was_attacked_by_player_flag then

                -- Abandon whatever the mob has been doing
                unimobs.mobkit_api.clear_high_level_queue(self)
                if unimobs.petz_api.is_mob_in_liquid(self) then
                    unilib.pkg.hqb_aqua_attack.add_to_queue(self, 10, player, 6)
                else
                    unilib.pkg.hqb_hunt.add_to_queue(self, 10, player)
                end

            end

        end

        -- Handle jumping
        -- N.B. Fixed bug in original code, which crashed the game if .can_jump_flag was set, but
        --      .jump_chance was not; as a default value, use 10 (used by petz frogs and rabbits)
        if priority < 8 and
                self.can_jump_flag and
                not self.status and
                random(1, (self.jump_chance or 10)) == 1 then

            unimobs.mobkit_api.clear_high_level_queue(self)
            unilib.pkg.hqb_terrestrial_jump.add_to_queue(self, 8)

        end

        -- N.B. Not in original code; added so that penguins can produce guano
        -- Handle dung
        if priority < 7 then
            unimobs.petz_api.make_mob_produce_dung(self, pos)
        end

        -- Replace nodes or lay eggs
        if priority < 6 then
            unilib.pkg.mtb_replace_node_or_lay_egg.do_action(self)
        end

        -- Make a random noise
        unimobs.kitz_api.make_misc_sound(
            self,
            unimobs.petz_setting.random_sound_chance,
            unimobs.petz_setting.max_hear_distance
        )

        -- If a beaver, build a dam
        if self.mob_type == "beaver_normal" and
                unilib.global.pkg_executed_table["mob_beaver_normal"] ~= nil then
            unilib.pkg.mob_beaver_normal.create_dam(self, pos)
        end

        -- If near water, then sometimes jump in (or back out again)
        -- N.B. This code was commented out in the original petz, perhaps because the
        --      "hqb_find_liquid" behaviour was in an unfinished state. Also, having jumped into
        --      water, there was no mechanism for jumping out again
        -- N.B. Added a timer, so that semi-aquatic animals can spend more than a few seconds on
        --      land/in the water
        if priority < 5 and
                unimobs.mobkit_api.check_main_timer(self, 30) and
                math.random(1, 5) == 1 then

            if (not self.isinliquid and unilib.pkg.hqb_find_liquid.add_to_queue(self, 5)) or
                    (self.isinliquid and unilib.pkg.hqb_find_land.add_to_queue(self, 5)) then
                return
            end

        end

        -- Handle default roaming
        if unimobs.mobkit_api.is_high_level_queue_empty(self) and not self.status then

            if self.isinliquid then

                -- N.B. The true argument is not found in the original code; it fixes the swimming
                --      issue described in the comments in the "hqb_aqua_roam" package
                unilib.pkg.hqb_aqua_roam.add_to_queue(self, 0, (self.max_speed / 3), true)

            else

                unilib.pkg.hqb_roam.add_to_queue(self, 0)

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brain_semiaquatic.init()

    return {
        description = "Logic code for various semi-aquatic mobs",
        depends = {
            "hqb_aqua_attack",
            "hqb_aqua_roam",
            "hqb_hunt",
            "hqb_roam",
            "hqb_terrestrial_jump",
            "mtb_hunt_prey",
            "mtb_replace_node_or_lay_egg",
            "mtb_rescue_suffocating_mob",
            "mtb_start_following",
            "mtb_start_repelling",
            "mtb_stop_following",
            "mtb_stop_repelling",
        },
        optional = "mob_beaver_normal",
    }

end
