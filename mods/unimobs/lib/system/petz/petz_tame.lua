---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_tame.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_feed_tame.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.tame_mob_with_lash(self, puncher)

    -- From petz.tame_whip()
    -- Called by unimobs.petz_api.on_punch_callback() for a mob with the .is_wild_flag property
    -- Such mobs can be tamed using a lash (such as an obedience whip). In Tamagotchi Mode, a lash
    --      maintains the mob's affinity
    -- Returns true if the mob is tamed during this call, false otherwise (if the mob was already
    --      tamed, has not been tamed yet, or if "puncher" is not wielding a suitable lash)

    local now_tamed_flag = false

    -- If wielding a suitable lash...
    if unilib.utils.is_value_in_list(
        puncher:get_wielded_item():get_name(), unimobs.petz_setting.lash_list
    ) then

        local pname = puncher:get_player_name()
        if not self.is_tamed_flag then

            -- The mob can be tamed by being lashed
            self.lash_countdown = unimobs.mobkit_api.add_mob_memory(
                self, "lash_countdown", self.lash_countdown - 1
            )
            -- N.B. In creative mode, the mob would die before the countdown reaches 0, so require
            --      just one lashing
            if self.lash_countdown <= 0 or unilib.utils.is_creative(pname) then

                -- Enough lashes have been received; reset the countdown, in case the creature is
                --      abandoned in the future
                unimobs.petz_api.update_lash_countdown_from_genetics(self)

                -- Tame the mob
                now_tamed_flag = true
                unimobs.kitz_api.set_mob_owner(self, pname)
                unimobs.petz_api.update_tamagotchi_mob_after_tame(self)
                core.chat_send_player(
                    self.owner,
                    unilib.utils.capitalise_translation(
                        S(
                            "@1 has been tamed",
                            unimobs.petz_api.get_insertion(self.mob_type, "subject_the")
                        )
                    )
                )

                -- The mob does not attack in response to the lashing
                unimobs.mobkit_api.clear_high_level_queue(self)

                -- Update awards, if available
                if unilib.global.pkg_executed_table["award_zoologist"] ~= nil then
                    unilib.pkg.award_zoologist.on_mob_tame(puncher, self)
                end

            end

            unimobs.kitz_api.make_sound(
                "object",
                puncher,
                "unilib_item_whip_obedience",
                unimobs.petz_setting.max_hear_distance
            )

        end

    end

    return now_tamed_flag

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_tamagochi.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.abandon_tamed_mob(self, msg)

    -- From petz.abandon_pet()
    -- Resets the properties of a tamed mob to make it an untamed mob, and displays the specified
    --      message

    if msg then
        core.chat_send_player(self.owner, msg)
    end

    unimobs.petz_api.remove_mob_nametag(self)
    unimobs.kitz_api.remove_mob_owner(self)
    if unilib.global.pkg_executed_table["item_dreamcatcher_pet"] ~= nil then
        unilib.pkg.item_dreamcatcher_pet.drop_from_mob(self)
    end

    self.init_tamagotchi_timer_flag =
            unimobs.mobkit_api.add_mob_memory(self, "init_tamagotchi_timer_flag", false)

    if self.for_sale_flag then
        self.for_sale_flag = unimobs.mobkit_api.add_mob_memory(self, "for_sale_flag", false)
    end

end
