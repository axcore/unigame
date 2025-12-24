---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.brain_monster = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.brain_monster.brain(self)

    -- Adapted from petz.monster_brain()
    -- Logic code for various monsters

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

        -- Hunt prey, if not busy with anything important
        if priority < 12 and not self.is_tamed_flag then

            local prey_list = unimobs.petz_api.get_msetting(self.mob_type, "prey_list")
            if prey_list ~= nil then

                for _, mob_name in ipairs(prey_list) do

                    -- Is this mob nearby?
                    local obj = unimobs.mobkit_api.get_closest_entity(self, mob_name)
                    if obj then

                        self.max_speed = 2.5
                        unilib.pkg.hqb_hunt.add_to_queue(self, 12, obj)
                        return

                    end

                end

            end

        end

        -- Werewolves "hunt" players
        local player = unimobs.mobkit_api.get_random_nearby_player(self)
        if priority < 10 and player then

            local werewolf_flag = false
            if unilib.global.pkg_executed_table["shared_petz_lycanthropy"] ~= nil and
                    unilib.pkg.shared_petz_lycanthropy.is_werewolf(player) then
                werewolf_flag = true
            end

            if (
                not self.is_tamed_flag and not werewolf_flag
            ) or (
                self.is_tamed_flag and
                self.status == "guard" and
                player:get_player_name() ~= self.owner
            ) then

                local player_pos = player:get_pos()
                -- (If the player is close enough)
                if vector.distance(pos, player_pos) <= self.view_range then

                    self.max_speed = 2.5
                    unilib.pkg.hqb_hunt.add_to_queue(self, 10, player)
                    return

                end

            end

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

        -- Handle default roaming
        if unimobs.mobkit_api.is_high_level_queue_empty(self) then

            self.max_speed = 1.5
            unilib.pkg.hqb_roam.add_to_queue(self, 0)

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brain_monster.init()

    return {
        description = "Logic code for various monsters",
        depends = {
            "hqb_find_land",
            "hqb_hunt",
            "hqb_roam",
            "mtb_replace_node_or_lay_egg",
            "mtb_rescue_suffocating_mob",
        },
        optional = "shared_petz_lycanthropy",
    }

end
