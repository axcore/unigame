---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.brain_bee = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local abs = math.abs

-- Table of doomed worker bees; keys are the mob's ._id, values are "true"
local doomed_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function handle_bee_death(self, meta, beehive_exists_flag)

    -- Adapted from petz.bee_brain()

    doomed_table[self._id] = nil

    if beehive_exists_flag then

        -- Decrease the total bee count
        unilib.pkg.misc_hive_normal.decrease_total_bee_count(self.beehive_pos)
        unilib.pkg.misc_hive_normal.set_infotext(meta, honey_count, bee_count)

    end

    unimobs.petz_api.handle_mob_death(self)

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.brain_bee.brain(self)

    -- Adapted from petz.bee_brain()
    -- Logic code for mobs defined in the "mob_bee_misc" package (only)

    local pos = self.object:get_pos()

    -- Standard vitals check
    unimobs.mobkit_api.check_vitals(self)

    -- Bees ignore gravity
    self.object:set_acceleration({x = 0, y = 0, z = 0})

    -- Handle adding/removal of bees from the hive
    local beehive_exists_flag = unilib.pkg.mob_bee_misc.does_beehive_exist(self)

    local meta, pollen_count, honey_count, bee_count
    if beehive_exists_flag then

        meta, pollen_count, honey_count, bee_count =
                unilib.pkg.misc_hive_normal.get_stats(self.beehive_pos)

    end

    if self.hp <= 0 then

        -- Standard death
        return handle_bee_death(self, meta, beehive_exists_flag)

    elseif self.colony_type ~= "queen" and
            not beehive_exists_flag and
            not doomed_table[self._id] then

        -- N.B. In original code, a worker bee without a hive died instantly (after the destruction
        --      of the hive, or after a spawn egg was placed in the world)
        local doomed_delay = unimobs.petz_setting.beehive_doomed_worker_delay
        if doomed_delay <= 0 then
            return handle_bee_death(self, meta, false)
        end

        -- In unimobs, we let them live for a short interval, by default; enough time for a player
        --      to catch the bees with a net, ready to be placed in another hive

        -- Only one core.after() call for each doomed bee; the key-value pair is removed in the
        --      call to handle_bee_death()
        doomed_table[self._id] = true

        -- Standard death, after the interval elapses
        core.after(unimobs.petz_api.get_random_interval(doomed_delay), function()

            if unimobs.mobkit_api.is_object_alive(self) then
                return handle_bee_death(self, meta, false)
            end

        end)

    elseif unimobs.petz_api.is_night() and self.colony_type ~= "queen" then

        -- All the bees sleep in their beehive
        if beehive_exists_flag then

            bee_count = bee_count + 1
            meta:set_int("bee_count", bee_count)

            if self.has_pollen_flag and honey_count < unimobs.petz_setting.beehive_max_honey then

                pollen_count = pollen_count + 1
                if pollen_count >= unimobs.petz_setting.beehive_max_pollen then

                    pollen_count = 0
                    honey_count = honey_count + 1

                end

                meta:set_int("pollen_count", pollen_count)
                meta:set_int("honey_count", honey_count)

            end

            unilib.pkg.misc_hive_normal.set_infotext(meta, honey_count, bee_count)
            unimobs.kitz_api.remove_mob(self)

            return

        end

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

        -- Search for flowers
        if priority < 20 and
                beehive_exists_flag and
                self.colony_type ~= "queen" and
                not self.has_pollen_flag and
                honey_count < unimobs.petz_setting.beehive_max_honey then

            local view_range = self.view_range
            local nearby_flower_list = core.find_nodes_in_area(
                {x = pos.x - view_range, y = pos.y - view_range, z = pos.z - view_range},
                {x = pos.x + view_range, y = pos.y + view_range, z = pos.z + view_range},
                {"group:flower"}
            )

            if #nearby_flower_list >= 1 then

                local target_pos = nearby_flower_list[1]
                unilib.pkg.hqb_find_flower.add_to_queue(self, 20, target_pos)
                return

            end

        end

        -- When bees have pollen, they search for the beehive
        if priority < 18 and
                beehive_exists_flag and
                self.colony_type ~= "queen" and
                self.has_pollen_flag and
                honey_count < unimobs.petz_setting.beehive_max_honey and
                vector.distance(pos, self.beehive_pos) <= self.view_range then

            unilib.pkg.hqb_find_beehive.add_to_queue(self, 18)
            return

        end

        -- Stay close to the beehive
        if priority < 15 and beehive_exists_flag and self.colony_type ~= "queen" then

            if abs(pos.x - self.beehive_pos.x) > self.view_range and
                    abs(pos.z - self.beehive_pos.z) > self.view_range then

                unilib.pkg.hqb_approach_beehive.add_to_queue(self, 15)
                return

            end

        end

        -- Queens can try to create a beehive
        if priority < 13 and
                self.colony_type == "queen" and
                unilib.pkg.mtb_create_beehive.do_action(self) then
            return
        end

        -- Attack nearby players
        local player = unimobs.mobkit_api.get_random_nearby_player(self)
        if priority < 10 and
                player and
                unilib.pkg.mtb_attack_player.do_action(self, 10, player) then
            return
        end

        -- Make a random noise
        unimobs.kitz_api.make_misc_sound(
            self,
            unimobs.petz_setting.random_sound_chance,
            unimobs.petz_setting.max_hear_distance
        )

        -- Handle default roaming
        if unimobs.mobkit_api.is_high_level_queue_empty(self) and not self.status then
            unilib.pkg.hqb_fly_wander.add_to_queue(self, 0)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brain_bee.init()

    return {
        description = "Logic code for mobs defined in the \"mob_bee_misc\" package (only)",
        notes = "This package can only be used with the hive from the \"misc_hive_normal\" package",
        depends = {
            "hqb_approach_beehive",
            "hqb_find_beehive",
            "hqb_find_flower",
            "hqb_find_land",
            "hqb_fly_wander",
            "misc_hive_normal",
            "mob_bee_misc",
            "mtb_attack_player",
            "mtb_create_beehive",
            "mtb_rescue_suffocating_mob",
        },
    }

end
