---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.brain_predator = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.brain_predator.brain(self)

    -- Adapted from petz.predator_brain()
    -- Logic code for various predator mobs

    local pos = self.object:get_pos()

    -- Standard vitals check
    unimobs.mobkit_api.check_vitals(self)

    -- Standard death check
    if self.hp <= 0 then

        unimobs.petz_api.handle_mob_death(self)
        return

    end

    -- Main brain code
    if unimobs.mobkit_api.check_main_timer(self, 1) then

        local priority = unimobs.mobkit_api.get_queue_priority(self)

        -- Emergency suffocation recovery check
        unilib.pkg.mtb_rescue_suffocating_mob.do_action(self)

        -- Check environmental damage (from fire, lava, other igniters and any nodes that have been
        --      designated as harmful to the mob)
        if priority < 45 then
            unimobs.petz_api.apply_env_damage(self, pos, 45)
        end

        -- If in water, find land as soon as possible
        if priority < 40 and self.isinliquid then

            unilib.pkg.hqb_find_land.add_to_queue(self, 40)
            return

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
        if priority < 12 and not unimobs.petz_setting.streamline_behaviour_flag then
             unilib.pkg.mtb_hunt_prey.do_action(self, 12, false)
        end

        -- Attack nearby players
        if priority < 10 and
                player and
                unilib.pkg.mtb_attack_player.do_action(self, 10, player) then
            return
        end

        -- Babies straggle (follow behind) their parents
        if priority < 10 and
                not unimobs.petz_setting.streamline_behaviour_flag and
                unimobs.petz_setting.enable_straggle_flag and
                self.straggle_type_list and
                self.is_baby_flag and
                -- (Search for parents every 5 seconds)
                unimobs.mobkit_api.check_main_timer(self, 5) then
            unilib.pkg.mtb_straggle_parents.do_action(self)
        end

        -- N.B. Not in original code; added so that bears can produce scat
        -- Handle dung
        if priority < 7 then
            unimobs.petz_api.make_mob_produce_dung(self, pos)
        end

        -- Replace nodes or lay eggs
        if priority < 6 then
            unilib.pkg.mtb_replace_node_or_lay_egg.do_action(self)
        end

        -- Handle breeding
        if priority < 5 then
            unilib.pkg.mtb_breed.do_action(self)
        end

        -- Make a random noise
        unimobs.kitz_api.make_misc_sound(
            self,
            unimobs.petz_setting.random_sound_chance,
            unimobs.petz_setting.max_hear_distance
        )

        -- Handle default roaming
        if unimobs.mobkit_api.is_high_level_queue_empty(self) and not self.status then
            unilib.pkg.hqb_roam.add_to_queue(self, 0)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brain_predator.init()

    return {
        description = "Logic code for various predator mobs",
        depends = {
            "hqb_find_land",
            "hqb_roam",
            "mtb_attack_player",
            "mtb_breed",
            "mtb_hunt_prey",
            "mtb_replace_node_or_lay_egg",
            "mtb_rescue_suffocating_mob",
            "mtb_start_following",
            "mtb_start_repelling",
            "mtb_stop_following",
            "mtb_stop_repelling",
            "mtb_straggle_parents",
        },
    }

end
