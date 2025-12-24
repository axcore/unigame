---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.brain_ant = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.brain_ant.brain(self)

    -- Adapted from petz.ant_brain()
    -- Logic code for mobs defined in the "mob_ant_misc" package (only)

    local pos = self.object:get_pos()

    -- Standard vitals check
    unimobs.mobkit_api.check_vitals(self)

    -- Standard death check
    if self.hp <= 0 then

        unimobs.petz_api.handle_mob_death(self)
        return

    end

    -- Main brain code
    local timer_timing = 1
    local lay_egg_interval =
            unimobs.petz_api.get_custom_msetting("ant_queen", "custom_lay_egg_interval")
    if unimobs.mobkit_api.check_main_timer(self, timer_timing) then

        local priority = unimobs.mobkit_api.get_queue_priority(self)

        -- Emergency suffocation recovery check
        unilib.pkg.mtb_rescue_suffocating_mob.do_action(self)

        -- (Hardcoded lifespan for worker and warrior ants)
        if self.colony_type ~= "queen" then

            -- (Check the timer each second)
            unimobs.petz_api.lifespan_timer(self, lay_egg_interval, timer_timing)

        end

        -- If in water, find land as soon as possible
        if priority < 40 and self.isinliquid then

            unilib.pkg.hqb_find_land.add_to_queue(self, 40)
            return

        end

        -- Check environmental damage (from fire, lava, other igniters and any nodes that have been
        --      designated as harmful to the mob)
        if priority < 30 then
            unimobs.petz_api.apply_env_damage(self, pos, 30)
        end

        -- Hunt prey (another queen, in the case of a queen)
        if priority < 20 and self.colony_type == "queen" then
             unilib.pkg.mtb_hunt_prey.do_action(self, 20, true)
        end

        -- If a queen, try to establish an anthill every 10 seconds
        if priority < 13 and
                self.colony_type == "queen" and
                not self.colony_created_flag and
                unimobs.mobkit_api.check_main_timer(self, 10) and
                unilib.pkg.mtb_create_anthill.do_action(self) then
            return
        end

        -- Attack nearby players
        local player = unimobs.mobkit_api.get_random_nearby_player(self)
        if priority < 10 and
                player and
                unilib.pkg.mtb_attack_player.do_action(self, 10, player) then
            return
        end

        -- If a queen, try to create a colony (this time, without waiting for the timer)
        if priority < 8 and
                self.colony_type == "queen" and
                not self.colony_created_flag and
                unilib.pkg.mtb_create_anthill.do_action(self) then
            return
        end

        -- Lay eggs
        if priority < 6 and self.egg_name then

            -- (Eggs are laid quickly at the beginning)
            local max_population =
                    unimobs.petz_api.get_custom_msetting("ant_queen", "max_population")
            if self.egg_count <= max_population then
                lay_egg_interval = lay_egg_interval / max_population
            end

            if unimobs.mobkit_api.check_main_timer(self, lay_egg_interval) then
                unilib.pkg.mtb_lay_ant_egg.do_action(self)
            end

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

function unilib.pkg.brain_ant.init()

    return {
        description = "Logic code for mobs defined in the \"mob_ant_misc\" package (only)",
        depends = {
            "hqb_find_land",
            "hqb_roam",
            "mtb_attack_player",
            "mtb_create_anthill",
            "mtb_hunt_prey",
            "mtb_lay_ant_egg",
            "mtb_rescue_suffocating_mob",
        },
    }

end
