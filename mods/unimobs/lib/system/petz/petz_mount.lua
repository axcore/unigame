---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_mount.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local floor = math.floor

-- Was petz.mount_attached
local mounted_player_table = {}

-- Table of saddles, in the form
--      saddle_table[saddle_name] = list_of_compatible_mob_types
local saddle_table = {}
-- Table of saddle-bags, in the form
--      saddlebag_table[saddlebag_name] = list_of_compatible_mob_types
local saddlebag_table = {}
-- Table of wagon craftitems, in the form
--      wagon_craftitem_table[entity_name] = craftitem_name
local wagon_craftitem_table = {}
-- Table of wagon animation functions, in the form
--      wagon_animation_table[entity_name] = animation_func
local wagon_animation_table = {}

---------------------------------------------------------------------------------------------------
-- Shared API functions (original to unimobs)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.do_wagon_animation(self, animation_name)

    -- Original to unimobs
    -- Gets the wagon animation function for the specified mob, if any, and then calls it

    if self.wagon then

        local wagon_luaent = self.wagon:get_luaentity()
        local animation_func = wagon_animation_table[wagon_luaent.name]
        if animation_func then
            animation_func(self, animation_name)
        end

    end

end

function unimobs.petz_api.get_saddle_overlay(saddle_name, mob_type)

    -- Original to unimobs
    -- Returns the overlay texture for the specified saddle (e.g. "unilib:item_saddle_normal") and
    --      "mob_type" (e.g. "pony_normal")
    -- (Example texture: "unilib_mob_pony_normal_saddle_normal_overlay.png"

    return "unilib_" .. unilib.utils.get_item_name(saddle_name) .. "_on_" .. mob_type ..
            "_overlay.png"

end

function unimobs.petz_api.get_saddlebag_overlay(saddlebag_name, mob_type)

    -- Original to unimobs
    -- Returns the overlay texture for the specified saddle-bag (e.g.
    --      "unilib:item_saddlebag_normal") and "mob_type" (e.g. "camel_normal")
    -- (Example texture: "unilib_mob_camel_normal_saddlebag_normal_overlay.png"

    return "unilib_" .. unilib.utils.get_item_name(saddlebag_name) .. "_on_" .. mob_type ..
            "_overlay.png"

end

function unimobs.petz_api.get_wagon_craftitem(self)

    -- Original to unimobs
    -- Retrieves the craftitem corresponding to the wagon entity stored in the specified mob, if any

    if self.wagon then

        local wagon_luaent = self.wagon:get_luaentity()
        return wagon_craftitem_table[wagon_luaent.name]

    end

end

function unimobs.petz_api.register_saddle(saddle_name, mob_type_list)

    -- Original to unimobs
    -- Called by any package which provides a saddle

    saddle_table[saddle_name] = mob_type_list

end

function unimobs.petz_api.register_saddlebag(saddlebag_name, mob_type_list)

    -- Original to unimobs
    -- Called by any package which provides a saddle-bag

    saddlebag_table[saddlebag_name] = mob_type_list

end

function unimobs.petz_api.register_wagon(entity_name, craftitem_name, animation_func)

    -- Original to unimobs
    -- Called by any package which provides a wagon compatible with mountable mobs
    -- Only the "entity_name" argument is compulsory; the others may be nil

    wagon_craftitem_table[entity_name] = craftitem_name
    wagon_animation_table[entity_name] = animation_func

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_mount.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.interact_with_mountable_mob(self, clicker, wielded_item, wielded_name)

    -- From petz.mount()
    -- Handles mounting/dismounting a mountable mob such as a pony or a camel
    -- Also handles saddles, saddle-bags and wagons, when compatible with the mob
    --
    -- Returns true to show that an action has been taken, or false to show that no action has been
    --      taken, and that the calling code should therefore open the main mob formspec
    --
    -- N.B. To open the mob's main formspec, rather than mounting the mob, right-click the mob while
    --      holding down the sneak key
    if clicker:is_player() then

        local player_control_table = clicker:get_player_control()
        if player_control_table["sneak"] then
            return false
        end

    end

    if self.is_tamed_flag and self.owner == clicker:get_player_name() then

        -- Dismount a player who is already mounted on the mob
        if self.driver and clicker == self.driver then

            unimobs.petz_api.dismount_player_from_mob(clicker, {x = 1, y = 0, z = 1})
            unimobs.petz_api.do_wagon_animation(self, "stand")
            unimobs.mobkit_api.clear_both_queues(self)
            unimobs.mobkit_api.do_entity_animation(self, "still")
            return true

        end

        -- Using shears, remove attached saddles/saddle-bags/wagons, if they are attached
        if (self.saddle_name or self.saddlebag_name or self.wagon) and
                unilib.utils.is_value_in_list(wielded_name, unimobs.petz_setting.shears_list) then

            -- Remove the wagon, dropping it to the ground if possible
            if self.wagon then

                local drop_name = unimobs.petz_api.get_wagon_craftitem(self)
                if drop_name then
                    unimobs.kitz_api.make_mob_drop_single_item(self, ItemStack(drop_name .. " 1"))
                end

                self.wagon:remove()
                self.wagon = nil

            end

            -- Remove the saddle/saddle-bag
            unimobs.petz_api.remove_equipment_from_mountable_mob(self)

            -- Update the mob's textures
            unimobs.petz_api.set_mob_properties(
                self, {textures = {self.textures[self.mob_texture_num]}}
            )

            return true

        end

        -- Attach a saddle or saddle-bag
        if not self.driver and not self.is_baby_flag and (
            (
                saddle_table[wielded_name] ~= nil and
                not self.saddle_name and
                unilib.utils.is_value_in_list(self.mob_type, saddle_table[wielded_name])
            ) or (
                saddlebag_table[wielded_name] ~= nil and
                not self.saddlebag_name and
                unilib.utils.is_value_in_list(self.mob_type, saddlebag_table[wielded_name])
            )
        ) then

            unimobs.petz_api.put_equipment_on_mountable_mob(
                self, clicker, wielded_item, wielded_name
            )

            return true

        end

        -- Mount the mob, if it has a saddle or a wagon
        if not self.driver and (self.saddle_name or self.wagon) then

            unimobs.petz_api.set_mob_properties(self, {stepheight = 1.1})
            unimobs.petz_api.mount_player_on_mob(self, clicker)
            return true

        end

    end

    -- No action taken, so tell the calling code to open the formspec instead
    return false

end

function unimobs.petz_api.put_equipment_on_mountable_mob(self, clicker, wielded_item, wielded_name)

    -- From petz.put_saddle()
    -- Puts a saddle or saddle-bag on the specified mob
    -- Updates the specified mob's properties, including its texture

    -- Update dynamic mob properties and prepare the texture overlays
    local this_overlay
    local other_overlay = ""
    if saddle_table[wielded_name] ~= nil then

        self.saddle_name = unimobs.mobkit_api.add_mob_memory(self, "saddle_name", wielded_name)

        this_overlay = "^" .. unimobs.petz_api.get_saddle_overlay(wielded_name, self.mob_type)
        if self.saddlebag_name then

            other_overlay = "^" .. unimobs.petz_api.get_saddlebag_overlay(
                self.saddlebag_name, self.mob_type
            )

        end

    elseif saddlebag_table[wielded_name] ~= nil then

        self.saddlebag_name =
                unimobs.mobkit_api.add_mob_memory(self, "saddlebag_name", wielded_name)

        this_overlay = "^" .. unimobs.petz_api.get_saddlebag_overlay(wielded_name, self.mob_type)
        if self.saddle_name then

            other_overlay = "^" .. unimobs.petz_api.get_saddle_overlay(
                self.saddle_name, self.mob_type
            )

        end

    end

    -- Compose a texture containing the mob's usual skin, with saddle and/or saddle-bag overlays
    --      on top
    local texture = self.textures[self.mob_texture_num] .. this_overlay .. other_overlay
    unimobs.petz_api.set_mob_properties(self, {textures = {texture}})

    -- Remove the saddle/saddle-bag from the player's inventory
    wielded_item:take_item()
    clicker:set_wielded_item(wielded_item)

    -- Play a suitable sound
    unimobs.kitz_api.make_sound(
        "object", self.object, "unilib_put_petz", unimobs.petz_setting.max_hear_distance
    )

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_saddles.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.remove_equipment_from_mountable_mob(self)

    -- From petz.free_saddles(), .free_saddle(), .free_saddlebag()
    -- Removes saddles and/or saddle-bags from the specified mob, and updates properties

    if self.saddle_name then

        -- Drop the saddle

        -- Check that the saddle still exists, in case the package has not been loaded
        if core.registered_items[self.saddle_name] ~= nil then
            unimobs.kitz_api.make_mob_drop_single_item(self, ItemStack(self.saddle_name))
        end

        -- Update properties
        self.saddle_name = unimobs.mobkit_api.add_mob_memory(self, "saddle_name", nil)

        -- Play a suitable sound
        unimobs.kitz_api.make_sound(
            "object", self.object, "unilib_pop_petz", unimobs.petz_setting.max_hear_distance
        )

    end

    if self.saddlebag_name then

        -- Drop the saddle-bag and its inventory

        -- Check that the saddle-bag still exists, in case the package has not been loaded
        if core.registered_items[self.saddlebag_name] ~= nil then
            unimobs.kitz_api.make_mob_drop_single_item(self, ItemStack(self.saddlebag_name))
        end

        -- Drop any items in the saddle-bag's own inventory
        for _, full_name in pairs(self.saddlebag_inventory) do
            unimobs.kitz_api.make_mob_drop_single_item(self, ItemStack(full_name))
        end

        -- Update properties
        self.saddlebag_name = unimobs.mobkit_api.add_mob_memory(self, "saddlebag_name", nil)
        self.saddlebag_inventory =
                unimobs.mobkit_api.add_mob_memory(self, "saddlebag_inventory", {})

        -- Play a suitable sound
        unimobs.kitz_api.make_sound(
            "object", self.object, "unilib_pop_petz", unimobs.petz_setting.max_hear_distance
        )

    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/misc/mount.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.mount_player_on_mob(entity, player)

    -- Was petz.attach()
    -- Mounts the specified player on the specified entity (which should be a mountable mob, like a
    --      pony)

    entity.player_rotation = entity.player_rotation or {x = 0, y = 0, z = 0}
    entity.driver_attach_at = entity.driver_attach_at or {x = 0, y = 0, z = 0}
    entity.driver_eye_offset = entity.driver_eye_offset or {x = 0, y = 0, z = 0}
    entity.driver_scale = entity.driver_scale or {x = 1, y = 1}

    local rot_view = 0
    if entity.player_rotation.y == 90 then
        rot_view = math.pi / 2
    end

    local attach_at
    if not entity.wagon then
        attach_at = entity.driver_attach_at
    else
        attach_at = entity.driver_wagon_attach_at
    end

    local eye_offset
    if not entity.wagon then
        eye_offset = entity.driver_eye_offset
    else
        eye_offset = entity.driver_wagon_eye_offset
    end

    player:set_attach(entity.object, "", attach_at, entity.player_rotation)
    -- N.B. As explained in the comments in petz_init_prop.lua, the .driver property is not set
    --      using unimobs.mobkit_api.add_mob_memory()
    entity.driver = player

    local pname = player:get_player_name()
    mounted_player_table[pname] = entity
    unilib.player_api.set_player_attached(pname, true)
    player:set_eye_offset(eye_offset, {x = 0, y = 0, z = 0})
    player:set_properties({
        pointable = unimobs.petz_setting.mounted_driver_is_pointable_flag,
        visual_size = {
            x = unimobs.petz_api.truncate_numeric_value(entity.driver_scale.x, 2),
            y = unimobs.petz_api.truncate_numeric_value(entity.driver_scale.y, 2),
        },
    })

    core.after(0.3, function()
        unilib.player_api.set_animation(player, "sit" , 30)
    end)

    player:set_look_horizontal(entity.object:get_yaw() - rot_view)

    -- Update awards, if available
    if unilib.global.pkg_executed_table["award_ranger"] ~= nil then

        if not entity.wagon then
            unilib.pkg.award_ranger.on_mob_mount(player, entity)
        else
            unilib.pkg.award_ranger.on_wagon_ride(player, entity)
        end

    end

end

function unimobs.petz_api.force_dismount_player_from_mob(player)

    -- Was petz.force_detach()
    -- A force-dismount function, called (for example) when a player leaves the server
    -- Also called by unimobs.petz_api.dismount_player_from_mob() itself, since the code is the
    --      same for soft/forced dismounts

    local entity = mounted_player_table[player:get_player_name()]
    if not entity then
        return
    end

    -- N.B. As explained in the comments in petz_init_prop.lua, the .driver property is not set
    --      using unimobs.mobkit_api.add_mob_memory()
    if entity.driver and entity.driver == player then
        entity.driver = nil
    end

    if entity.wagon then

        unimobs.mobkit_api.clear_both_queues(entity)
        unimobs.mobkit_api.do_entity_animation(entity, "still")

    end

    player:set_detach()
    unilib.player_api.player_attached[player:get_player_name()] = false
    player:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})

    -- When dismounted, a player whose size has changed (due to the action of some other mod or
    --      package) is restored to their full size
    core.after(0.25, function()

        if player then

            player:set_properties({
                pointable = true,
                visual_size = {x = 1.0, y = 1.0},
            })

        end

        unilib.player_api.set_animation(player, "stand" , 30)

    end, player)

end

function unimobs.petz_api.dismount_player_from_mob(player, offset)

    -- Was petz.detach()
    -- A normal dismount function called, for example, when a player right-clicks a mob on which
    --      they're already mounted

    unimobs.petz_api.force_dismount_player_from_mob(player)

    local pos = player:get_pos()
    core.after(0.1, function()
        player:set_pos({x = pos.x + offset.x, y = pos.y + offset.y + 0.2, z = pos.z + offset.z})
    end)

end

function unimobs.petz_api.check_gallop_mode(self, dtime)

    -- Was petz.gallop()
    -- Called by unimobs.petz_api.on_step_callback() for a mob in gallop mode
    -- Check whether the time limit has expired, in which case disable gallop mode, and mark the
    --      mob as exhausted

    -- N.B. As explained in the comments in petz_init_prop.lua, these properties are not set using
    --      unimobs.mobkit_api.add_mob_memory()
    self.gallop_mode_time = self.gallop_mode_time + dtime
    if self.gallop_mode_time >= unimobs.petz_setting.max_gallop_time then

        self.gallop_mode_flag = false
        self.gallop_mode_time = 0
        self.gallop_mode_exhaustion_flag = true

        core.after(unimobs.petz_setting.gallop_recovery_time, function()

            if unimobs.mobkit_api.is_object_alive(self) then
                self.gallop_mode_exhaustion_flag = false
            end

        end, self)

    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_horseshoes.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.apply_horseshoe_speed_bonus(self, speed_bonus)

    -- From petz.speedup_change()
    -- Applies the specified speed bonus (which may be positive or negative) to the specified mob

    -- N.B. Not in original code: fractional values are fine, but we really don't need more than
    --      one decimal place
    speed_bonus = floor(speed_bonus * 10) / 10

    -- Apply the speed bonus
    self.mounted_forward_speed =
            unimobs.petz_api.adjust_mounted_value(self, "mounted_forward_speed") + speed_bonus
    self.mounted_reverse_speed =
            unimobs.petz_api.adjust_mounted_value(self, "mounted_reverse_speed") + speed_bonus
    self.mounted_speed_boost =
            unimobs.petz_api.adjust_mounted_value(self, "mounted_speed_boost") + speed_bonus

end

function unimobs.petz_api.cancel_horseshoe_speed_bonus(self)

    -- Original to unimobs
    -- Restores the original values of a mounted mob's speed properties, removing any bonus applied
    --      during calls to unimobs.petz_api.apply_horseshoe_speed_bonus()

    self.mounted_forward_speed =
            unimobs.petz_api.adjust_mounted_value(self, "mounted_forward_speed")
    self.mounted_reverse_speed =
            unimobs.petz_api.adjust_mounted_value(self, "mounted_reverse_speed")
    self.mounted_speed_boost = unimobs.petz_api.adjust_mounted_value(self, "mounted_speed_boost")

end

function unimobs.petz_api.remove_horseshoes_from_mob(self)

    -- From petz.horseshoes_reset()
    -- Removes any horseshoes from the specified mob and resets its properties, removing any speed
    --      bonus that was applied

    if self.horseshoe_count == 0 then
        return
    end

    unimobs.petz_api.cancel_horseshoe_speed_bonus(self)

    -- (If the package that provides the specified horseshoe has not been loaded, then don't drop
    --      any unknown items)
    if core.registered_items[self.horseshoe_name] ~= nil then

        local pos = self.object:get_pos()
        for i = 1, self.horseshoe_count do

            local obj = core.add_item(pos, self.horseshoe_name)
            if obj then
                unimobs.kitz_api.set_drop_velocity(obj)
            end

        end

    end

    self.horseshoe_count = unimobs.mobkit_api.add_mob_memory(self, "horseshoe_count", 0)
    self.horseshoe_name = unimobs.mobkit_api.add_mob_memory(self, "horseshoe_name", nil)

    unimobs.kitz_api.make_sound(
        "object", self.object, "unilib_pop_petz", unimobs.petz_setting.max_hear_distance
    )

end

---------------------------------------------------------------------------------------------------
-- Setup code (from petz/petz/misc/mount.lua)
---------------------------------------------------------------------------------------------------

core.register_on_leaveplayer(function(player)
    unimobs.petz_api.force_dismount_player_from_mob(player)
end)

core.register_on_shutdown(function()

    local player_list = core.get_connected_players()
    for i = 1, #player_list do
        unimobs.petz_api.force_dismount_player_from_mob(player_list[i])
    end

end)

core.register_on_player_hpchange(function(player, hp_change)

    local attached_to = player:get_attach()
    if attached_to then

        local luaent = attached_to:get_luaentity()
        if luaent and luaent.is_mountable_flag then

            local hp = player:get_hp()
            if hp_change < 0 then

                local new_hp = hp + hp_change
                if new_hp <= 0 then
                    unimobs.petz_api.force_dismount_player_from_mob(player)
                end

            end

        end

    end

end)
