---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_death.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Table of mob types, and the extension callbacks to call when a mob dies
-- These callbacks are called after any logs have been written, but before any other influences are
--      applied (unmounting ponies, dropping dreamcatchers etc)
-- Note that, unlike code in petz_on_rightclick.lua, these callbacks do not need to return any
--      special value; all callbacks matching the specified "mob_type" are called
-- Table in the form
--      extension_table[mob_type] = list_of_callbacks
local extension_table = {}

---------------------------------------------------------------------------------------------------
-- Shared API functions (original to unimobs)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.register_death_extension(mob_type, callback)

    -- Original to unimobs
    -- Called by any package which wants to extend the standard behaviour, when a mob dies

    if extension_table[mob_type] == nil then
        extension_table[mob_type] = { callback }
    else
        table.insert(extension_table[mob_type], callback)
    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_on_die.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.handle_mob_death(self)

    -- From petz.on_die()
    -- Called by various brain packages when a mob's .hp reaches zero (or in other situations, as
    --      appropriate)
    -- Handles the death gracefully, setting .is_dead_flag to true and initiating the death
    --      behaviour "hqb_die"

    if self.is_dead_flag then

        -- This function has already been called; re-initiate the standard death behaviour, in case
        --      that behaviour expired before the entity was removed from the world
        if unilib.global.pkg_executed_table["hqb_die"] ~= nil then
            unilib.pkg.hqb_die.add_to_queue(self)
        else
            unimobs.mobkit_api.on_die_failsafe(self)
        end

        return

    else

        -- Mark the mob as dead
        self.is_dead_flag = unimobs.mobkit_api.add_mob_memory(self, "is_dead_flag", true)

    end

    -- Write logs
    local owner = self.owner
    local spos = (
        self.object and unimobs.petz_api.pos_to_string(vector.round(self.object:get_pos()))
    ) or "unknown"

    if owner then

        unilib.utils.log(
            "action",
            string.format("[unimobs] %s @ %s owned by %s has died", self.name, spos, owner)
        )

    else

        unilib.utils.log("action", string.format("[unimobs] %s @ %s has died", self.name, spos))

    end

    local pos = self.object:get_pos()

    -- Process extension callbacks
    local callback_list = extension_table[self.mob_type]
    if callback_list ~= nil then

        for _, callback in ipairs(callback_list) do
            callback(self)
        end

    end

    -- Make the creature un-pointable
    self.object:set_properties({
        pointable = false,
    })

    -- Drop the dreamcatcher, if there is one
    if unilib.global.pkg_executed_table["item_dreamcatcher_pet"] ~= nil then
        unilib.pkg.item_dreamcatcher_pet.drop_from_mob(self)
    end

    -- Flying mobs fall to the ground
    if self.can_fly_flag then
        self.can_fly_flag = false
    end

    -- Tweak the collisionbox
    -- (N.B. The original code does not explain why it needs to be tweaked)
    local prop_table = self.object:get_properties()
    prop_table.collisionbox[2] = prop_table.collisionbox[1] - 0.0625
    self.object:set_properties({collisionbox = prop_table.collisionbox})

    -- Drop items
    unimobs.kitz_api.make_mob_drop_multiple_items(self, self.was_killed_by_player_flag or nil)
    unimobs.mobkit_api.clear_high_level_queue(self)

    -- Close the mob's formspec, if it's open
    if unimobs.petz_global.formspec_player_table[self.owner] then

        unimobs.petz_global.formspec_player_table[self.owner] = nil
        core.close_formspec(self.owner, "unilib:form_unimobs_standard_mob")

    end

    -- Moan in agony
    -- N.B. Fixed error in original code; call to kitz.make_sound() should have been a call to
    --      kitz.play_sound()
    unimobs.mobkit_api.do_entity_sound(self, "die")

    -- Display death particles, if permitted
    unimobs.petz_api.show_death_particles(self)

    -- Execute the standard death behaviour
    if unilib.global.pkg_executed_table["hqb_die"] ~= nil then
        unilib.pkg.hqb_die.add_to_queue(self)
    else
        unimobs.mobkit_api.on_die_failsafe(self)
    end

end
