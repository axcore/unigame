---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_capture.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Table of mob types, and the extension callbacks to call when a mob is captured
-- These callbacks are called after the new entity has been placed in the world, but before the
--      spawn egg is destroyed
-- Note that, unlike code in petz_on_rightclick.lua, these callbacks do not need to return any
--      special value; all callbacks matching the specified "mob_type" are called
-- Table in the form
--      extension_table[mob_type] = list_of_callbacks
local extension_table = {}

---------------------------------------------------------------------------------------------------
-- Shared API functions (original to unimobs)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.register_capture_extension(mob_type, callback)

    -- Original to unimobs
    -- Called by any package which wants to extend the standard behaviour, when a mob is captured

    if extension_table[mob_type] == nil then
        extension_table[mob_type] = { callback }
    else
        table.insert(extension_table[mob_type], callback)
    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_capture.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.can_capture_mob(self, clicker, wielded_name, check_room_in_inv_flag)

    -- Adapted from petz.check_capture_items()
    -- Called by unimobs.petz_api.on_rightclick_callback(), after the call to
    --      unimobs.petz_api.can_capture_mob_with_item(), but in advance of a call to
    --      unimobs.petz_api.capture_mob()
    --
    -- This function checks whether the player is allowed to capture the specified mob with the
    --      specified wielded item, checking (for example) that there's enough room in their
    --      inventory
    -- If allowed, returns true; otherwise returns false
    -- If false is returned, it's a fatal error; the calling code should not continue checking other
    --      uses of the wielded item

    local pname = clicker:get_player_name()

    if self.driver then

        -- Includes ponies pulling wagons, and so on
        core.chat_send_player(
            pname,
            S("You can't capture mounted creatures, or creatures attached to wagons!")
        )

        return false

    end

    if check_room_in_inv_flag then

        -- Check there's enough room in the player's inventory
        local inv = clicker:get_inventory()
        if not inv:room_for_item("main", ItemStack("air")) then

            core.chat_send_player(
                pname,
                S("There isn't enough room in your inventory to capture the creature")
            )

            return false

        end

    end

    -- The remaining checks were originally in unimobs.petz_api.on_rightclick_callback()
    local privs = core.get_player_privs(pname)
    if self.is_pet_flag and
            not privs.server and
            not unimobs.petz_setting.enable_mob_theft_flag and
            (not self.is_tamed_flag or (self.owner and self.owner ~= pname)) then

        core.chat_send_player(
            pname,
            unilib.utils.capitalise_translation(
                S(
                    "You are not the owner of @1",
                    unimobs.petz_api.get_insertion(self.mob_type, "object_the")
                )
            )
        )

        return false

    end

    if self.saddlebag_name then

        -- Saddle-bags contain an inventory, so mobs with saddle-bags must not be moved to the
        --      player's own inventory
        core.chat_send_player(pname, S("You cannot capture creatures with a saddle-bag!"))
        return false

    end

    return true

end

function unimobs.petz_api.can_capture_mob_with_item(self, wielded_name)

    -- Adapted from petz.check_capture_items()
    -- Called by unimobs.petz_api.on_rightclick_callback(), in advance of calls to
    --      unimobs.petz_api.can_capture_mob() and unimobs.petz_api.capture_mob()
    --
    -- unimobs permits multiple wieldable items to be used as a lasso or a net; any registered
    --      lasso, animal net or bug net can be used to capture a compatible mob
    -- This function checks whether the specified item can be used to capture the specified mob,
    --      returning true if so, and false if not
    -- If false is returned, it's a non-fatal error; the calling code can continue checking other
    --      uses of the wielded item

    local capture_type
    if unilib.utils.is_value_in_list(wielded_name, unimobs.petz_setting.lasso_list) then
        capture_type = "lasso"
    elseif unilib.utils.is_value_in_list(wielded_name, unimobs.petz_setting.animal_net_list) then
        capture_type = "animal_net"
    elseif unilib.utils.is_value_in_list(wielded_name, unimobs.petz_setting.bug_net_list) then
        capture_type = "bug_net"
    else
        return false
    end

    if capture_type ~= self.capture_type then
        return false
    else
        return true
    end

end

function unimobs.petz_api.capture_mob(self, clicker, wielded_name, put_in_inventory_flag)

    -- From petz.capture()
    -- Commonly called by unimobs.petz_api.on_rightclick_callback() (or by any other code; for
    --      example in code in the "shared_petz_bottles" package). Should usually be preceded by
    --      calls to unimobs.petz_api.can_capture_mob_with_item() and
    --      unimobs.petz_api.can_capture_mob()
    --
    -- "Captures" the mob by converting an entity into a spawn egg, preserving much of its metadata
    -- Optionally places the spawn egg into the player's inventory
    -- Returns the metadata for the new stack, so that the calling code can perform further
    --      operations if necessary (for example, to convert a moth spawn egg into a moth in a
    --      bottle)

    -- N.B. Fixed bug in original code, in which self.is_captured_flag is set AFTER
    --      static_data_table is compiled (a clear error)
    self.is_captured_flag = unimobs.mobkit_api.add_mob_memory(self, "is_captured_flag", true)

    -- Prepare a table of the mob's metadata
    local luaent = self.object:get_luaentity()
    local staticdata = luaent:get_staticdata(self)
    local static_data_table = core.deserialize(staticdata)

    -- We can't capture a dead mob
    if static_data_table and
            static_data_table["memory_table"] and
            static_data_table["memory_table"]["is_dead_flag"] then

        local pname = clicker:get_player_name()
        if pname then
            core.chat_send_player(pname, S("You cannot capture a dead creature!"))
        end

        return nil

    end

    -- Create a special spawn egg that preserves the mob's metadata, so that it can be restored when
    --      the spawn egg is used to create a new mob
    local new_stack = ItemStack(unimobs.global.spawnegg_lookup_table[self.name])
    local new_stack_meta = new_stack:get_meta()
    new_stack_meta:set_string("staticdata", staticdata)

    -- Prepare infotext for the new ItemStack
    local infotext = ""
    if not unimobs.petz_api.is_string_empty(self.nametag) then
        infotext = infotext .. "\n" .. S("Name") .. ": " .. self.nametag
    end

    if self.can_breed_flag then

        local gender
        if self.is_male_flag then
            gender = S("Male")
        else
            gender = S("Female")
        end

        infotext = infotext .. "\n" .. S("Gender") .. ": " .. gender

    end

    local skin_description = unimobs.petz_api.get_skin_description(self)
    if skin_description and skin_description ~= "" then
        infotext = infotext .. "\n" .. S("Colour") .. ": " .. skin_description
    end

    if self.is_pregnant_flag then
        infotext = infotext .. "\n" .. S("She is pregnant")
    end

    local description
    if not self.is_tamed_flag then
        description = unilib.utils.brackets(self.description, S("tamed"))
    else
        description = self.description
    end

    new_stack_meta:set_string(
        "description", description .. infotext
    )

    -- Place the captured item in the player's inventory, if required
    if put_in_inventory_flag then

        local inv = clicker:get_inventory()
        if inv:room_for_item("main", new_stack) then
            inv:add_item("main", new_stack)
        else
            core.add_item(clicker:get_pos(), new_stack)
        end

    end

    -- Process extension callbacks
    local callback_list = extension_table[self.mob_type]
    if callback_list ~= nil then

        for _, callback in ipairs(callback_list) do
            callback(self, clicker)
        end

    end

    -- Having converted the entity into a spawn egg, remove the entity from the world
    unimobs.kitz_api.remove_mob(self)

    -- Register the discovery of the correct capturing item
    unimobs.kitz_api.register_discovered_item(clicker, self.mob_type, "capture", wielded_name)

    return new_stack_meta

end

function unimobs.petz_api.release_mob(placer, itemstack, mob_name, pos)

    -- From petz.create_pet()
    -- "Releases" a mob by converting a spawn egg into an entity, preserving much of its metadata
    --      (thus this function is the opposite of unimobs.petz_api.capture_mob() )
    -- Commonly called by the spawn egg's .on_place() callback, but is also called by other code
    --      (for example, by the cat basket and bird stand packages)
    -- Returns the luaentity on success

    local meta = itemstack:get_meta()
    local staticdata = meta:get_string("staticdata")
    local static_data_table = core.deserialize(staticdata)

    -- We can't release a dead mob
    if static_data_table and
            static_data_table["memory_table"] and
            static_data_table["memory_table"]["is_dead_flag"] then

        local pname = placer:get_player_name()
        if pname then
            chat.chat_send_player(pname, S("You cannot release a dead creature!"))
        end

        -- Destroy the spawn egg, since it can never be placed
        itemstack:take_item()

        return nil

    end

    local mob = core.add_entity(pos, mob_name, staticdata)
    if mob then

        local luaent = mob:get_luaentity()
        if not luaent.is_wild_flag and not luaent.owner then

            unimobs.kitz_api.set_mob_owner(luaent, placer:get_player_name())
            unimobs.petz_api.update_tamagotchi_mob_after_tame(luaent)

        end

        -- Since each mob entity is unique, we remove the spawn egg after use
        itemstack:take_item()
        return luaent

    else

        return nil

    end

end
