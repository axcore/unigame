---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_replenish.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Table of mob types, and the extension callback to call whenever unimobs.petz_api.replenish_mob()
--      is called
-- If unimobs.petz_api.replenish_mob() is called and there is no extension callback for the mob,
--      then the mob's milk is replenished (when appropriate), otherwise nothing happens
-- Note also that the callbacks do not need to return any special value; all callbacks matching the
--      specified "mob_type" are called
-- Table in the form
--      extension_table[mob_type] = list_of_callbacks
local extension_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions (from petz/petz/api/api_wool_milk.lua)
---------------------------------------------------------------------------------------------------

function replenish_milk(self, clicker)

    -- From petz.milk_refill()
    -- "Refill" the mob's milk by resetting its properties (but only when the mob has "eaten"
    --      enough)
    -- "clicker" is an optional argument, specified only when a player is the cause of the event
    --      (e.g. by feeding a sheep)

    -- N.B. self.replace_countdown is only updated when required (e.g. when a mob has been milked,
    --      and must be replenished before it can be milked again)
    if self.has_been_milked_flag then

        self.replace_countdown = unimobs.mobkit_api.add_mob_memory(
            self, "replace_countdown", self.replace_countdown - 1
        )

    end

    -- N.B. Comments in the original code did not match the code itself; they describe a mob which
    --      "eats" by replacing turf, but the code itself checks the number of times the mob has
    --      been fed by the player
    -- N.B. In creative mode, the mob would die before the countdown reaches 0, so require just one
    --      action from a player
    if self.replace_countdown <= 0 or
            (clicker and unilib.utils.is_creative(clicker:get_player_name())) then

        -- Enough nodes have been replaced; reset the countdown, ready for the next milking
        unimobs.petz_api.update_replace_countdown_from_genetics(self)

        -- Update mob properties (the mob is now ready to be milked again)
        self.has_been_milked_flag =
                unimobs.mobkit_api.add_mob_memory(self, "has_been_milked_flag", false)

        -- Show particles because why not
        unimobs.petz_api.show_standard_particles(
            self.object:get_pos(),
            "hungry",
            "unilib_bucket_steel_empty.png^unilib_bucket_milk_cow_overlay.png"
        )

    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (original to unimobs)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.register_replenish_extension(mob_type, callback)

    -- Original to unimobs
    -- Called by any package which wants to extend the standard behaviour, when a mob is to be
    --      replenished

    if extension_table[mob_type] == nil then
        extension_table[mob_type] = { callback }
    else
        table.insert(extension_table[mob_type], callback)
    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_wool_milk.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.replenish_mob(self, clicker)

    -- From petz.refill()
    -- Replenish the mob, for example by restoring sheared wool, refilling its milk, and so on
    -- If there is nothing to replenish, then do nothing
    -- "clicker" is an optional argument, specified only when a player is the cause of the event
    --      (e.g. by feeding a sheep)

    -- Process extension callbacks
    local callback_list = extension_table[self.mob_type]
    if callback_list ~= nil then

        for _, callback in ipairs(callback_list) do
            callback(self, clicker)
        end

    elseif self.is_milkable_flag then

        replenish_milk(self, clicker)

    end

end

function unimobs.petz_api.extract_milk_from_mob(self, clicker, full_bucket_name)

    -- From petz.milk_milk()
    -- Milk the mob, updating its properties, and generating a full bucket of milk in the player's
    --      inventory

    if self.has_been_milked_flag then

        core.chat_send_player(clicker:get_player_name(), S("This creature has already been milked"))
        return

    elseif self.is_male_flag then

        core.chat_send_player(clicker:get_player_name(), S("Only female creatures can be milked!"))
        return

    elseif self.is_baby_flag then

        core.chat_send_player(
            clicker:get_player_name(), S("Only fully-grown creatures can be milked!")
        )

        return

    end

    local inv = clicker:get_inventory()
    local wielded_item = clicker:get_wielded_item()
    wielded_item:take_item()
    clicker:set_wielded_item(wielded_item)

    if inv:room_for_item("main", full_bucket_name) then

        inv:add_item("main", full_bucket_name)
        unimobs.kitz_api.make_sound(
            "object",
            self.object,
            "unilib_mob_" .. self.generic_type .. "_moaning",
            unimobs.petz_setting.max_hear_distance
        )

    else

        core.add_item(self.object:get_pos(), full_bucket_name)

    end

    self.has_been_milked_flag =
            unimobs.mobkit_api.add_mob_memory(self, "has_been_milked_flag", true)

end
