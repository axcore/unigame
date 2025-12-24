---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_on_punch.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local random = math.random

-- Table of mob types, and the extension callbacks to call when a mob is punched
-- Note that, unlike code in petz_on_rightclick.lua, these callbacks are called AFTER everything
--      else has been processed
-- Note also that the callbacks do not need to return any special value; all callbacks matching the
--      specified "mob_type" are called
-- Table in the form
--      mob_extension_table[mob_type] = list_of_callbacks
local mob_extension_table = {}
-- Table of wielded items, and the extension callbacks to call when a mob is punched while wielding
--      the items
-- Note that these callbacks are called after everything else has been processed (including the
--      callbacks in "mob_extension_table"), and that the callbacks don't need to return any special
--      value
-- Note also that these extension callbacks are NOT called if an untamed mob becomes tamed, as a
--      result of the punch (but the extension callbacks in "mob_extension_table" are called as
--      normal)
-- Table in the form
--      wielded_extension_table[full_name] = list_of_callbacks
local wielded_extension_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions (from petz/petz/api/api_on_punch.lua)
---------------------------------------------------------------------------------------------------

local function apply_kickback(self, dir)

    -- From petz.kick_back()
    -- Apply kickback to the mob as a consequence of the punch

    local hvel = vector.multiply(vector.normalize({x = dir.x, y = 0, z = dir.z}), 4)
    self.object:set_velocity({x = hvel.x, y = 2, z = hvel.z})

end

local function calculate_damage(self, time_from_last_punch, tool_capabilities)

    -- From petz.calculate_damage()
    -- Returns the amount of damage inflicted by the punch

    local tool_damage = tool_capabilities.damage_groups.fleshy or 1

    local time_bonus = (1 / time_from_last_punch)
    -- If a second successive punch occured less than a second after the previous one, apply a bonus
    --      (using a cubic root)
    if time_bonus > 1 then
        time_bonus = unimobs.kitz_api.round_number(time_bonus ^ 0.33)
    else
        time_bonus = 0
    end

    local health_bonus = unimobs.kitz_api.round_number((self.max_hp / self.hp) ^ 0.33)
    local luck_bonus = random(-1, 1)

    return tool_damage + time_bonus + health_bonus + luck_bonus

end

local function was_killed_by_player(self, puncher)

    -- From petz.was_killed_by_player()
    -- Returns true if the specified "puncher" is a player, and if the mob's .hp has reached zero;
    --      returns false otherwise

    if self.hp <= 0 then

        if puncher:is_player() then
            return true
        else
            return false
        end

    else

        return false

    end

end

local function is_puncher_a_player(puncher)

    -- From petz.puncher_is_player()
    -- Returns true if the specified "puncher" is a player, false otherwise

    if type(puncher) == "userdata" and puncher:is_player() then
        return true
    else
        return false
    end

end

local function update_affinity(self, puncher)

    -- From petz.punch_tamagochi()
    -- In Tamagotchi Mode, update a mob's affinity when punched by its owner

    if unimobs.petz_setting.enable_tamagotchi_mode_flag and
            self.affinity ~= nil and
            self.owner == puncher:get_player_name() then
        unimobs.petz_api.set_mob_affinity(self, -unimobs.petz_setting.tamagotchi_punch_rate)
    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (original to unimobs)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.register_punch_mob_extension(mob_type, callback)

    -- Original to unimobs
    -- Called by any package which wants to extend the standard behaviour, when a mob is punched

    if mob_extension_table[mob_type] == nil then
        mob_extension_table[mob_type] = { callback }
    else
        table.insert(mob_extension_table[mob_type], callback)
    end

end

function unimobs.petz_api.register_punch_with_extension(full_name, callback)

    -- Original to unimobs
    -- Called by any package which wants to extend the standard behaviour, when a mob is punched
    --      with a wielded item

    if wielded_extension_table[full_name] == nil then
        wielded_extension_table[full_name] = { callback }
    else
        table.insert(wielded_extension_table[full_name], callback)
    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_on_punch.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.on_punch_callback(
    self, puncher, time_from_last_punch, tool_capabilities, dir
)
    -- From petz.on_punch()
    -- Standard .on_punch() callback for all petz-compatible mob entities

    local pos = self.object:get_pos()

    -- Check the creature is not dead
    if not unimobs.mobkit_api.is_object_alive(self) then
        return
    end

    -- Do not punch the creature on which you are mounted
    if self.is_mountable_flag and puncher == self.driver then
        return
    end

    -- Check the enable damage setting
    if unimobs.petz_setting.disable_damage_in_peaceful_worlds_flag and
            not core.setting_getbool("enable_damage") then
        return
    end

    -- Check area protection
    if unimobs.petz_setting.disable_damage_in_protected_areas_flag and
            core.is_protected(pos, puncher:get_player_name()) then
        return
    end

    -- Check dreamcatcher protection
    local puncher_is_player_flag = is_puncher_a_player(puncher)
    if puncher_is_player_flag then

        -- The dreamcatcher protects the mob
        if self.has_dreamcatcher_flag and self.owner ~= puncher:get_player_name() then
            return
        end

    else

        if self.has_dreamcatcher_flag then
            return
        end

    end

    -- Colourise the mob when punched
    if unimobs.petz_setting.colourise_on_punch_mob_flag then

        local mob_texture_num = self.mob_texture_num or 1
        local punch_texture = self.textures[mob_texture_num] ..
                "^[colorize:" .. unimobs.petz_setting.punched_mob_colour .. ":125"
        self.object:set_properties(self, {textures = {punch_texture}})

        core.after(0.1, function()

            if self then

                self.object:set_properties(
                    self, {textures = { unimobs.petz_api.compose_skin_texture(self) }}
                )

            end

        end)

    end

    -- Apply damage
    local damage = calculate_damage(self, time_from_last_punch, tool_capabilities)
    if puncher_is_player_flag then

        unimobs.mobkit_api.apply_damage(
            self, damage, string.format("punched by player %s", puncher:get_player_name())
        )

    else

        unimobs.mobkit_api.apply_damage(self, damage, string.format("punched by non-player"))

    end

    -- Check if killed by player and store the result
    -- N.B. As described in the comments in petz_init_prop.lua, .was_killed_by_player_flag is
    --      not set with unimobs.mobkit_api.add_mob_memory()
    self.was_killed_by_player_flag = was_killed_by_player(self, puncher)

    -- Update the nametag
    unimobs.petz_api.update_mob_nametag(self)

    -- Handle kickback
    apply_kickback(self, dir)

    -- Make a punching sound
    unimobs.kitz_api.make_sound(
        "object", self.object, "unilib_punch_petz", unimobs.petz_setting.max_hear_distance
    )

    -- Display blood particles, if permitted
    unimobs.petz_api.show_blood_particles(self)

    -- Unmount the creature?
    if self.is_mountable_flag and self.hp <= 0 and self.driver then
        unimobs.petz_api.force_dismount_player_from_mob(self.driver)
    end

    -- Handle the reaction to violent players (violence between mobs is handled by their normal
    --      logic)
    local wielded_name = puncher:get_wielded_item():get_name()
    if puncher_is_player_flag then

        -- N.B. As described in the comments in petz_init_prop.lua, .was_attacked_by_player_flag is
        --      not set with unimobs.mobkit_api.add_mob_memory()
        self.was_attacked_by_player_flag = true

        -- Tame wild animals, if wielding a lash
        if self.is_wild_flag then

            -- If the mob is tamed during the call to unimobs.petz_api.tame_mob_with_lash(), then
            --      we don't want the code below to process affinity changes or to call extension
            --      callbacks; we can prevent from happening by resetting "wielded_name"
            if unimobs.petz_api.tame_mob_with_lash(self, puncher) then
                wielded_name = ""
            end

        end

        -- In Tamagotchi Mode, update a mob's affinity when punched by its owner (unless there's
        --      a callback for the wielded item, in which case that callback can handle the
        --      affinity change)
        if unimobs.petz_setting.enable_tamagotchi_mode_flag and
                self.affinity ~= nil and
                self.owner == puncher:get_player_name() and (
                    wielded_name == "" or wielded_extension_table[wielded_name] == nil
                ) then
            unimobs.petz_api.set_mob_affinity(self, -unimobs.petz_setting.tamagotchi_punch_rate)
        end

        -- Tamed creatures won't react to an attack from players (except birds and aquatic
        --      creatures; in particular, birds on a bird stand must fly away, if punched)
        -- N.B. In original code, sleeping creatures like cats did not react to being punched
        --      (although their textures were updated to open their eyes); here, all sleeping
        --      creatures react as if they were untamed
        -- Otherwise, wild animals that are normally passive will attack the player, if punched; all
        --      other passive creatures will try to flee the attacking player
        if self.can_fly_flag or
                (self.can_swim_flag and self.isinliquid) or
                not self.is_tamed_flag or
                self.status == "sleeping" then

            if self.is_wild_flag and not self.hostile_to_players_flag then

                -- (Since self.was_attacked_by_player_flag is now true, the mob's normal logic
                --      will initiate attacking the player)
                unimobs.mobkit_api.clear_high_level_queue(self)

            elseif not self.hostile_to_players_flag then

                -- N.B. In original code, passive creatures did not flee an attacking player
                unimobs.mobkit_api.clear_both_queues(self)
                self.status = unimobs.mobkit_api.add_mob_memory(self, "status", nil)
                -- (Same priority as "mtb_flee_predator" behaviour
                unilib.pkg.mtb_flee_player.do_action(self, 18, puncher)

            end

        end

    end

    -- Process extension callbacks
    local mob_callback_list = mob_extension_table[self.mob_type]
    if mob_callback_list ~= nil then

        for _, callback in ipairs(mob_callback_list) do
            callback(self, puncher, time_from_last_punch, tool_capabilities, dir)
        end

    end

    if wielded_name ~= "" then

        local wielded_callback_list = wielded_extension_table[wielded_name]
        if wielded_callback_list ~= nil then

            for _, callback in ipairs(wielded_callback_list) do
                callback(self, puncher, time_from_last_punch, tool_capabilities, dir)
            end

        end

    end

end
