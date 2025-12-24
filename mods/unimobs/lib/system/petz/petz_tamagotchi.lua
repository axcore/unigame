---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_tamagotchi.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Affinity is a value in the range 0-100
-- At 100, the mob is totally satisfied with its owner; at 0, the mob will abandon its owner
local max_affinity = 100

-- Table of mob types, and the extension callback to call whenever tamagotchi_mode_timer() is called
-- Note that the callbacks do not need to return any special value; all callbacks matching the
--      specified "mob_type" are called
-- Table in the form
--      extension_table[mob_type] = list_of_callbacks
local extension_table = {}

---------------------------------------------------------------------------------------------------
-- Shared API functions (original to unimobs)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.register_tamagotchi_extension(mob_type, callback)

    -- Original to unimobs
    -- Called by any package which wants to extend the standard behaviour, when a Tamagotchi Mode
    --      check occurs

    if extension_table[mob_type] == nil then
        extension_table[mob_type] = { callback }
    else
        table.insert(extension_table[mob_type], callback)
    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (from petz/petz/api/api_tamagochi.lua)
---------------------------------------------------------------------------------------------------

local function tamagotchi_mode_timer(self)

    -- From petz.timer()
    -- Main Tamagotchi Mode timer for the specified mob

    core.after(unimobs.petz_setting.tamagotchi_update_interval, function()

        -- Is the mob still alive?
        if not unimobs.mobkit_api.is_object_alive(self) then
            return
        end

        -- Is the mob's owner online?
        if not core.is_singleplayer() and
                unimobs.petz_setting.tamagotchi_require_online_owner_flag and
                self.owner and
                not core.player_exists(self.owner) then
            return
        end

        -- If the mob has died before core.after() could run, stop the timer
        local pos = self.object:get_pos()
        if pos == nil then

            -- The mob died before core.after() could run, so stop the timer
            self.init_tamagotchi_timer_flag = unimobs.mobkit_api.add_mob_memory(
                self, "init_tamagotchi_timer_flag", false
            )

            return

        end

        -- Check whether the mob is standing on a safe node (for example, the floor of a dog kennel)
        -- If so, take no further action (but re-initialise the timer ready for the next check)
        local pos_below = {x = pos.x, y = pos.y - 1.5, z = pos.z}
        local node_below = core.get_node_or_nil(pos_below)

        for i = 1, #unimobs.petz_setting.tamagotchi_safe_node_list do

            if node_below and
                    node_below.name == unimobs.petz_setting.tamagotchi_safe_node_list[i] then

                self.init_tamagotchi_timer_flag = unimobs.mobkit_api.add_mob_memory(
                    self, "init_tamagotchi_timer_flag", true
                )

                return

            end

        end

        -- If the mob has not been fed, decrease health and affinity
        if not self.has_been_fed_flag then

            unimobs.kitz_api.set_mob_health(
                self, -unimobs.petz_setting.tamagotchi_feed_hunger_rate
            )

            unimobs.petz_api.update_mob_nametag(self)

            if self.hp > 0 and self.has_tamagotchi_mode_flag then

                unimobs.petz_api.set_mob_affinity(
                    self, -unimobs.petz_setting.tamagotchi_feed_hunger_rate
                )

            end

        else

            -- Mob has been fed; reset properties ready for the next check
            self.has_been_fed_flag =
                    unimobs.mobkit_api.add_mob_memory(self, "has_been_fed_flag", false)

        end

        -- If the mob has not been groomed and/or lashed, decrease affinity (by whichever setting
        --      is greater)
        local affinity_change = 0
        if self.can_groom_flag then

            if not self.brush_applied_flag and not self.lotion_applied_flag then

                if self.has_tamagotchi_mode_flag then
                    affinity_change = unimobs.petz_setting.tamagotchi_groom_rate
                end

            else

                -- Mob has been groomed; reset properties ready for the next check
                -- (We don't know whether brushing or grooming applies to any given mob, so just
                --      reset both)
                self.brush_applied_flag =
                        unimobs.mobkit_api.add_mob_memory(self, "brush_applied_flag", false)
                self.lotion_applied_flag =
                        unimobs.mobkit_api.add_mob_memory(self, "lotion_applied_flag", false)

            end

        end

        if self.is_wild_flag then

            if not self.lash_applied_flag then

                if self.has_tamagotchi_mode_flag and (
                    affinity_change == 0 or
                    affinity_change < unimobs.petz_setting.tamagotchi_lash_rate
                ) then
                    affinity_change = unimobs.petz_setting.tamagotchi_lash_rate
                end

            else

                -- Mob has been lashed; reset properties ready for the next check
                self.lash_applied_flag =
                        unimobs.mobkit_api.add_mob_memory(self, "lash_applied_flag", false)

            end

        end

        if affinity_change ~= 0 then
            unimobs.petz_api.set_mob_affinity(self, -affinity_change)
        end

        -- Process extension callbacks
        local callback_list = extension_table[self.mob_type]
        if callback_list ~= nil then

            for _, callback in ipairs(callback_list) do
                callback(self)
            end

        end

        -- Decide whether the timer should be re-initialised, ready for the next check
        local insertion = unimobs.petz_api.get_insertion(self.mob_type, "subject")

        if self.hp <= 0 then

            core.chat_send_player(
                self.owner,
                unilib.utils.capitalise_translation(
                    S("Your @1 has starved to death!", insertion)
                )
            )

            self.init_tamagotchi_timer_flag = unimobs.mobkit_api.add_mob_memory(
                self, "init_tamagotchi_timer_flag", false
            )

        elseif self.has_tamagotchi_mode_flag and self.affinity <= 0 then

            -- (The call to this function sets self.init_tamagotchi_timer_flag to false)
            unimobs.petz_api.abandon_tamed_mob(
                self,
                unilib.utils.capitalise_translation(
                    S("Your @1 has abandoned you!", insertion)
                )
            )

        else

            self.init_tamagotchi_timer_flag = unimobs.mobkit_api.add_mob_memory(
                self, "init_tamagotchi_timer_flag", true
            )

        end

    end, self)

    -- If the timer is to be re-initialised after the check, this flag is set to true during the
    --      core.after() function above
    self.init_tamagotchi_timer_flag = unimobs.mobkit_api.add_mob_memory(
            self, "init_tamagotchi_timer_flag", false
    )

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_tamagochi.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.calculate_affinity_change(rate)

    -- From petz.calculate_affinity_change()
    -- In Tamagotchi Mode, calculates the increase/decrease in the mob's affinity, given the
    --      specified "rate" of change
    -- Affinity increases if "rate" is positive, but decreases if "rate" is negative

    if rate < 0 then
        rate = rate - (rate * unimobs.petz_setting.tamagotchi_affinity_reduction_factor)
    end

    return max_affinity * rate

end

function unimobs.petz_api.init_tamagotchi_timer(self)

    -- From petz.init_tamagochi_timer()
    -- Called by unimobs.petz_api.set_initial_properties() and unimobs.petz_api.on_step_callback()
    -- When a mob is compatible with Tamagotchi Mode, its .init_tamagotchi_timer_flag is initially
    --      set to true, which starts the timer (and sets the flag back to false)
    -- The flag can be set back to true at any time in order to re-initiate the timer

    -- (Calling code has already checked that self.init_tamagotchi_timer_flag is true)
    if unimobs.petz_setting.enable_tamagotchi_mode_flag and self.is_tamed_flag then

        tamagotchi_mode_timer(self)
        return true

    else

        return false

    end

end

function unimobs.petz_api.set_mob_affinity(self, rate)

    -- From petz.set_affinity()
    -- In Tamagotchi Mode, sets the mob's affinity according to the specified "rate" of change
    -- Affinity increases if "rate" is positive, but decreases if "rate" is negative

    local new_affinity = unimobs.kitz_api.round_number(
        self.affinity + unimobs.petz_api.calculate_affinity_change(rate)
    )

    if new_affinity > max_affinity then
        new_affinity = max_affinity
    elseif new_affinity < 0 then
        new_affinity = 0
    end

    self.affinity = unimobs.mobkit_api.add_mob_memory(self, "affinity", new_affinity)

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_feed_tame.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.update_tamagotchi_mob_after_feed(self)

    -- From petz.do_feed()
    -- In Tamagotchi Mode, this function is called after a creature is fed, in order to update its
    --      properties

    unimobs.petz_api.set_mob_affinity(self, unimobs.petz_setting.tamagotchi_feed_hunger_rate)
    self.has_been_fed_flag = unimobs.mobkit_api.add_mob_memory(self, "has_been_fed_flag", true)

end

function unimobs.petz_api.update_tamagotchi_mob_after_tame(self)

    -- From petz.after_tame()
    -- This function can be called for all mobs, so that in Tamagotchi Mode, its properties can be
    --      updated

    if unimobs.petz_setting.enable_tamagotchi_mode_flag then

        self.init_tamagotchi_timer_flag =
                unimobs.mobkit_api.add_mob_memory(self, "init_tamagotchi_timer_flag", true)

    end

end
