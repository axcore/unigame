---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.brain_herbivore = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local random = math.random

-- Table of entity IDs, and the behaviour which cannot be repeated, until another behaviour has been
--      engaged. This prevents (for example) climbing mobs like squirrels from getting into an
--      endless loop of failed attemps to climb a tree
local excluded_table = {}

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.brain_herbivore.brain(self)

    -- Adapted from petz.herbivore_brain()
    -- Logic code for various herbivore mobs

    if self.is_dead_flag then
        return
    end

    local pos = self.object:get_pos()

    -- Standard vitals check
    unimobs.mobkit_api.check_vitals(self)

    -- Standard death check
    local die_flag = false
    if self.hp <= 0 then

        die_flag = true

    elseif not unimobs.petz_api.is_night() and self.die_in_daylight_flag and pos then

        -- This mob dies in light that's stronger than its maximum spawn light
        local node_light = core.get_node_light(pos, core.get_timeofday())
        if node_light and self.spawn_max_light and node_light >= self.spawn_max_light then
            die_flag = true
        end

    end

    if die_flag then

        unimobs.petz_api.handle_mob_death(self)
        return

    end

    -- Ignore gravity when climbing
    if self.status == "climb" then
        self.object:set_acceleration({x = 0, y = 0, z = 0})
    end

    -- Main brain code
    if unimobs.mobkit_api.check_main_timer(self, 1) then

        local priority = unimobs.mobkit_api.get_queue_priority(self)

        -- Emergency suffocation recovery check
        unilib.pkg.mtb_rescue_suffocating_mob.do_action(self)

        -- Check environmental damage (from fire, lava, other igniters and any nodes that have been
        --      designated as harmful to the mob)
        if priority < 30 then
            unimobs.petz_api.apply_env_damage(self, pos, 30)
        end

        -- When a mob is mounted by a player, the player controls its behaviour
        if priority < 25 and self.driver then

            unilib.pkg.hqb_obey_driver.add_to_queue(self, 25)
            return

        end

        -- If in water, find land (N.B. In all other petz brain packages, the priority is 40)
        if priority < 20 and self.isinliquid then

            unilib.pkg.hqb_find_land.add_to_queue(self, 20)
            return

        end

        -- Flee from predators
        if priority < 18 and
                not unimobs.petz_setting.streamline_behaviour_flag and
                unilib.pkg.mtb_flee_predator.do_action(self, 18) then
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

        -- Flee from players
        -- N.B. Changed the original code; it seems unnecessary to check what the player is wielding
        --      for a third time. Also replaced the check for self.is_pet_flag, with a check for
        --      self.is_wild_flag (seems more realistic)
        if priority < 14 and
                not unimobs.petz_setting.streamline_behaviour_flag and
                not self.is_tamed_flag and
                not self.is_wild_flag and
                player then

            local player_pos = player:get_pos()
            if vector.distance(pos, player_pos) <= self.view_range then

                unilib.pkg.hqb_evade.add_to_queue(self, 14, player)
                return

            end

        end

        -- Hunt prey, if this mob is aggressive
        if priority < 12 and self.is_aggressive_flag then
             unilib.pkg.mtb_hunt_prey.do_action(self, 12, true)
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

        -- Handle herding
        if priority < 4.5 and
                unimobs.petz_setting.enable_herding_flag and
                unimobs.mobkit_api.check_main_timer(
                    self, unimobs.petz_setting.herding_behaviour_chance
                ) and unilib.pkg.mtb_find_herd.do_action(self, player) then
            return
        end

        -- Search for a pet bowl or bale
        if priority < 4 and
                self.is_tamed_flag and
                not unimobs.petz_setting.streamline_behaviour_flag then

            local view_range = self.view_range
            local nearby_node_list = core.find_nodes_in_area(
                {x = pos.x - (view_range / 2), y = pos.y - 1, z = pos.z - (view_range / 2)},
                {x = pos.x + (view_range / 2), y = pos.y + 1, z = pos.z + (view_range / 2)},
                {"group:feeder"}
            )

            if #nearby_node_list >= 1 then

                local target_pos = nearby_node_list[1]
                local distance = vector.distance(pos, target_pos)

                if distance > 3.0 then

                    unilib.pkg.hqb_goto.add_to_queue(self, 4, target_pos)
                    -- N.B. No return in original code
                    return

                elseif distance <= 3.0 and
                        unimobs.petz_setting.enable_tamagotchi_mode_flag and
                        not self.has_been_fed_flag then

                    unimobs.petz_api.update_tamagotchi_mob_after_feed(self)

                    if self.eat_hay_flag then

                        local node = core.get_node_or_nil(target_pos)
                        if node and unilib.pkg.shared_petz_straw.is_straw_edible(node.name) then

                            core.remove_node(target_pos)
                            unimobs.kitz_api.make_sound(
                                "pos",
                                target_pos,
                                "unilib_eat_petz",
                                5 or unimobs.kitz_const.default_max_hear_distance
                            )

                            -- N.B. No return in original code
                            return

                        end

                    end

                end

            end

        end

        -- A mob can "take" a clutchable item (such as a ball) that has been thrown near it
        -- N.B. Code commented out in original mod, perhaps because it doesn't work properly in its
        --      original state
        if priority < 5 and
                self.can_clutch_flag and
                -- N.B. Fix bug in original code; sleeping mobs should not interact with clutchable
                --      items
                self.status ~= "sleep" and
                self.is_tamed_flag and
                not self.clutched_item_flag then

            local obj_list = core.get_objects_inside_radius(self.object:get_pos(), 10)
            for i = 1, #obj_list do

                local obj = obj_list[i]
                local luaent = obj:get_luaentity()
                if luaent and
                        luaent.name == "__builtin:item" and
                        unimobs.petz_api.is_node_clutchable(luaent.itemstring) and
                        -- N.B. Change to original code - only take a clutchable item that was
                        --      thrown by a player (otherwise the mob re-takes the clutchable item,
                        --      immediately after dropping it)
                        luaent.thrower_name then

                    local spos = self.object:get_pos()
                    local tpos = obj:get_pos()
                    if vector.distance(spos, tpos) > 2 then

                        if tpos then

                            unilib.pkg.hqb_goto.add_to_queue(self, 5, tpos)
                            -- N.B. No return in original code
                            return

                        end

                    else

                        -- Replace the "__builtin:item" with a new clutchable item entity (because
                        --      otherwise, it will spin in the mob's mouth)
                        local new_obj = core.add_entity(
                            pos,
                            unimobs.petz_api.convert_clutchable_node_to_entity(luaent.itemstring)
                        )

                        if new_obj then

                            -- Attach the new clutchable item to the mob's entity
                            unimobs.petz_api.attach_clutchable_item(
                                new_obj:get_luaentity(), self, self.object, luaent.thrower_name
                            )

                            -- Dispose of the "__builtin:item"
                            obj:remove()

                            -- N.B. No return in original code
                            return

                        end

                    end

                end

            end

        end

        -- Make a random noise
        unimobs.kitz_api.make_misc_sound(
            self,
            unimobs.petz_setting.random_sound_chance,
            unimobs.petz_setting.max_hear_distance
        )

        -- Climb trees (and other suitable nodes)
        if priority < 3 and
                self.can_climb_trees_flag and
                excluded_table[self._id] ~= "mtb_climb_tree" and
                unilib.pkg.mtb_climb_tree.do_action(self, 3) then

            -- In case the attempted climb fails, don't try again until a different behaviour has
            --      been engaged
            excluded_table[self._id] = "mtb_climb_tree"
            return

        end

        -- Go to sleep, if possible
        if priority < 2 then

            unilib.pkg.mtb_fall_asleep.do_action(self, 2)
            excluded_table[self._id] = nil

        end

        -- Look at nearby players
        if priority < 1 and
                player and
                unilib.pkg.mtb_look_at.do_action(self, 1, player:get_pos()) then

            excluded_table[self._id] = nil
            return

        end

        -- Handle default roaming
        if unimobs.mobkit_api.is_high_level_queue_empty(self) and
                not self.status and
                not self.wagon then

            unilib.pkg.hqb_roam.add_to_queue(self, 0)
            excluded_table[self._id] = nil

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brain_herbivore.init()

    return {
        description = "Logic code for various herbivore mobs",
        depends = {
            "hqb_evade",
            "hqb_find_land",
            "hqb_goto",
            "hqb_roam",
            "hqb_obey_driver",
            "hqb_terrestrial_jump",
            "mtb_breed",
            "mtb_climb_tree",
            "mtb_fall_asleep",
            "mtb_find_herd",
            "mtb_flee_predator",
            "mtb_hunt_prey",
            "mtb_look_at",
            "mtb_replace_node_or_lay_egg",
            "mtb_rescue_suffocating_mob",
            "mtb_start_following",
            "mtb_start_repelling",
            "mtb_stop_following",
            "mtb_stop_repelling",
            "mtb_straggle_parents",
            "shared_petz_straw",
        },
    }

end
