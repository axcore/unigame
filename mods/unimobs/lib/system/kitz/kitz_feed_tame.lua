---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- kitz_feed_tame.lua
--      Shared API functions from the petz/kitz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local abs = math.abs

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/kitz/api/api_feed_tame.lua)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.feed_mob(self, clicker, feed_rate, msg_full_health, sound_type)

    -- Was kitz.feed()
    -- Feeds the specified mob using the player's wielded item (as long as it appears in the list of
    --      feedable items in the remix CSV)
    --
    -- "feed_rate" is a value in the range 0-1, representing the fraction of the mob's .max_hp to be
    --      restored
    -- "msg_full_health" is optional
    -- "sound_type" is the type of sound stored in the mob's .sound field
    --
    -- Returns true if the creature has been fed, or false otherwise

    local wielded_item = clicker:get_wielded_item()
    local wielded_name = wielded_item:get_name()

    -- Check that the wielded item can be used for feeding, in this case
    if not unimobs.petz_api.check_lookup_table_in_msetting_by_group(
        self.mob_type, "feed_item_table", wielded_name
    ) then
        return false
    end

    -- If not in creative, then take the item
    --[[
    local creative_mode = core.settings:get_bool("creative_mode")
    if creative_mode == false then

        wielded_item:take_item()
        clicker:set_wielded_item(wielded_item)

    end
    ]]--
    local pname = clicker:get_player_name()
    if not unilib.utils.is_creative(pname) then

        wielded_item:take_item()
        clicker:set_wielded_item(wielded_item)

    end

    -- Do the feed
    unimobs.kitz_api.set_mob_health(self, feed_rate or unimobs.kitz_const.default_feed_rate)

    if self.hp >= self.max_hp and msg_full_health then
        core.chat_send_player(pname, msg_full_health)
    end

    -- Decrease the feeding countdown (code in unimobs.kitz_api.tame_mob() will check for a zero
    --      value)
    -- N.B. In creative mode, the mob would die before the countdown reaches 0, so require just one
    --      feeding
    if unilib.utils.is_creative(pname) then

        self.feed_countdown = unimobs.mobkit_api.add_mob_memory(
            self, "feed_countdown", 0
        )

    else

        self.feed_countdown = unimobs.mobkit_api.add_mob_memory(
            self, "feed_countdown", self.feed_countdown - 1
        )

    end

    if sound_type then
        unimobs.mobkit_api.do_entity_sound(self, sound_type)
    end

    -- Register the discovery of the correct feeding item
    unimobs.kitz_api.register_discovered_item(clicker, self.mob_type, "feed", wielded_name)

    return true

end

function unimobs.kitz_api.get_active_mobs_by_owner(owner, nametag)

    -- Was kitz.get_active_mobs_by_owner()
    -- Returns of list of active mobs which belong to the specified "owner"
    -- If the optional "nametag" is specified, only mobs with that name are returned
    --
    -- This function only returns mobs from unimobs.global.active_mob_table, which itself may only
    --      include petz-compatible mobs

    local active_mobs_by_owner_list = {}
    for id, obj in pairs(unimobs.global.active_mob_table) do

        if unimobs.mobkit_api.is_object_alive(obj.object) then

            if obj.owner == owner then

                if not nametag or
                        (nametag and not unimobs.petz_api.is_string_empty(obj.nametag)) then
                    active_mobs_by_owner_list[#active_mobs_by_owner_list + 1] = obj
                end

            end

        end

    end

    return active_mobs_by_owner_list

end

function unimobs.kitz_api.remove_mob_owner(self)

    -- Was kitz.remove_owner()
    -- Marks the mob as unowned, by resetting its .is_tamed_flag and .owner fields

    self.is_tamed_flag = unimobs.mobkit_api.add_mob_memory(self, "is_tamed_flag", false)
    self.owner = unimobs.mobkit_api.add_mob_memory(self, "owner", nil)

end

function unimobs.kitz_api.set_mob_health(self, factor)

    -- Was kitz.set_health()
    -- Adjusts the mob's health
    -- "factor" is a value in the range 0-1, representing the fraction of .max_hp to be added (if
    --      positive) or removed (if negative)

    if factor > 1.0 then
        factor = 1.0
    end

    local hp_amount = abs(self.max_hp * factor)
    if factor >= 0 then
        unimobs.mobkit_api.heal_damage(self, hp_amount)
    else
        unimobs.mobkit_api.apply_damage(self, hp_amount, "set health")
    end

end

function unimobs.kitz_api.set_mob_owner(self, owner_name)

    -- Was kitz.set_owner()
    -- Marks the mob as owned, by setting its .is_tamed_flag and .owner fields

    self.is_tamed_flag = unimobs.mobkit_api.add_mob_memory(self, "is_tamed_flag", true)
    self.owner = unimobs.mobkit_api.add_mob_memory(self, "owner", owner_name)

end

function unimobs.kitz_api.tame_mob(self, tame_count, owner_name, msg_tamed, limit_table)

    -- Was kitz.tame()
    -- Tames the specified mob
    --
    -- "tame_count" is the amount of food required to tame the mob (before reductions due to the
    --      "digestion" gene are applied); if not specified, then the default value is used
    -- "limit_table" is an optional table in the form:
    --      .max: The maximum number of tamed mobs per player
    --      .count: The number of mobs currently tamed by the player that is trying to tame this
    --          mob
    --      .msg: Message to display when the maximum is reached (in which case, the taming process
    --          is aborted)

    local tamed_flag = false

    -- N.B. In creative mode, code in unimobs.kitz_api.feed_mob() has already set this value to 0
    --      for the first feeding
    if self.feed_countdown <= 0 then

        -- Enough feeding has occured; reset the countdown, in case the tamed creature is abandoned
        --      in the future
        unimobs.petz_api.update_feed_countdown_from_genetics(self)

        if self.is_tamed_flag == false then

            local limit_reached_flag = false
            if limit_table and limit_table.max >= 0 then

                if (limit_table.count + 1) > limit_table.max then

                    core.chat_send_player(owner_name, limit_table.msg)
                    limit_reached_flag = true

                end

            end

            if not limit_reached_flag then

                tamed_flag = true
                unimobs.kitz_api.set_mob_owner(self, owner_name)
                if msg_tamed then
                    core.chat_send_player(owner_name, msg_tamed)
                end

                -- Clear previous behaviours (e.g. running away from the player)
                unimobs.mobkit_api.clear_high_level_queue(self)

                -- Update awards, if available
                if unilib.global.pkg_executed_table["award_zoologist"] ~= nil then

                    unilib.pkg.award_zoologist.on_mob_tame(
                        core.get_player_by_name(owner_name), self
                    )

                end

            end

        end

    end

    return tamed_flag

end
