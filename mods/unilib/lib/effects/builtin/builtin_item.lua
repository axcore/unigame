---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- builtin_item.lua
--      Apply special effects to Minetest __builtin:item entities (adapted from various mods)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Some changes to "__builtin:item" depends on Minetest settings; others depend on other factors
--      (such as which packages are loaded)
-- In case none of those things apply, we don't modify __builtin:item at all

-- Modify __builtin:item for special effects
local special_flag = not unilib.setting.debug_disable_effects_flag and (
    unilib.setting.debug_enable_effects_flag or unilib.setting.builtin_entity_effects_flag
)

-- Modify __builtin:item for items thrown into a rubbish bin
local bin_flag = unilib.global.pkg_executed_table["misc_bin_wooden"] ~= nil and
        unilib.setting.trash_can_throw_flag

-- Modify __builtin:item for items providing light
local light_flag = not unilib.setting.debug_disable_effects_flag and (
    unilib.setting.debug_enable_effects_flag or unilib.setting.wield_light_flag
)

-- Modify __builtin:item for Minecraft-style item get
local magnet_flag = not unilib.setting.debug_disable_effects_flag and (
    unilib.setting.debug_enable_effects_flag or unilib.setting.magnet_auto_get_flag
) and unilib.setting.magnet_auto_fly_radius > unilib.setting.magnet_auto_get_radius

local magnet_object_ref
local magnet_blocked_method_list = {
    "set_acceleration", "set_velocity", "setacceleration", "setvelocity",
}

-- Apply the modifications, if any
if special_flag or bin_flag or light_flag then

    local old_builtin_item = core.registered_entities["__builtin:item"]
    local new_builtin_item = {}

    if special_flag then

        new_builtin_item.burn_up = function(self)

            -- Adapted from default
            -- The item disappears in a smoke puff
            local p = self.object:get_pos()
            self.object:remove()

            core.sound_play("unilib_misc_smoke", {
                pos = p,
                gain = 1.0,
                max_hear_distance = 8,
            }, true)

            core.add_particlespawner({
                amount = 3,
                time = 0.1,
                texture = "unilib_misc_smoke.png",

                maxacc = {x = 0.15, y = -0.01, z = 0.15},
                minacc = {x = -0.15, y = -0.02, z = -0.15},
                maxpos = {x = p.x + 0.1, y = p.y + 0.2, z = p.z + 0.1},
                minpos = {x = p.x - 0.1, y = p.y + 0.1, z = p.z - 0.1},
                maxsize = 5,
                minsize = 5,
                maxvel = {x = 0, y = 2.5, z = 0},
                minvel = {x = 0, y = 2.5, z = 0},
                maxexptime = 6,
                minexptime = 4,

                collisiondetection = true,
            })

        end

    end

    new_builtin_item.on_step = function(self, dtime, ...)

        local item_pos = self.object:get_pos()
        local container_name = core.get_node(item_pos).name

        -- If the wielded light effect is enabled, register the item for tracking (unless it's
        --      already being tracked)
        -- We do this first, because (for example) a thrown torch has self.flammable = true, so
        --      will also the trigger the "special_flag" code block below
        if light_flag and not self.wielded_light then

            self.wielded_light = true
            local itemstack = ItemStack(self.itemstring)
            unilib.wield_light.track_item_entity(self.object, "item", itemstack:get_name())

        end

        if special_flag and self.flammable then

            old_builtin_item.on_step(self, dtime, ...)

            -- Flammable, so check for igniters every 10 s
            self.ignite_timer = (self.ignite_timer or 0) + dtime
            if self.ignite_timer > 10 then

                self.ignite_timer = 0

                local pos = self.object:get_pos()
                if pos == nil then

                    -- Object already deleted
                    return

                end

                local node = core.get_node_or_nil(pos)
                if not node then
                    return
                end

                -- Immediately burn up flammable items in lava
                if core.get_item_group(node.name, "lava") > 0 then

                    self:burn_up()

                else

                    --  Otherwise the probability depends on its igniter value
                    local burn_chance = self.flammable * core.get_item_group(node.name, "igniter")
                    if burn_chance > 0 and math.random(0, burn_chance) ~= 0 then
                        self:burn_up()
                    end

                end

            end

        elseif bin_flag and container_name == "unilib:misc_bin_wooden" then

            -- (old_builtin_item.on_step is NOT called)

            -- Round the values (not essential, but makes logs look nicer)
            item_pos.y = item_pos.y - 0.325
            item_pos = vector.round(item_pos)

            local item_stack = ItemStack(self.itemstring)
            local inv = core.get_inventory({type = "node", pos = item_pos})
            local leftover = inv:add_item("trashlist", item_stack)

            if leftover:get_count() == 0 then

                self.object:remove()
                unilib.utils.log(
                    "action",
                    item_stack:to_string() .. " added to rubbish bin at " ..
                            core.pos_to_string(item_pos)
                )

            elseif item_stack:get_count() - leftover:get_count() ~= 0 then

                self.set_item(self, leftover:to_string())
                unilib.utils.log(
                    "action",
                    item_stack:to_string() .. " added to rubbish bin at " ..
                            core.pos_to_string(item_pos) .. " with " ..
                            leftover:to_string() .. " left over"
                )

            end

        elseif magnet_flag and self.is_magnet_item then

            old_builtin_item.on_step(self, dtime, ...)

            magnet_object_ref = magnet_object_ref or getmetatable(self.object)
            local old_func_table = {}
            for i = 1, #magnet_blocked_method_list do

                local method = magnet_blocked_method_list[i]
                old_func_table[method] = magnet_object_ref[method]
                magnet_object_ref[method] = do_nothing

            end

            old_on_step(self, ...)
            for i = 1, #magnet_blocked_method_list do

                local method = magnet_blocked_method_list[i]
                magnet_object_ref[method] = old_func_table[method]

            end

        else

            -- Execute behaviour of the default __builtin:item
            old_builtin_item.on_step(self, dtime, ...)

        end

    end

    if special_flag then

        new_builtin_item.set_item = function(self, itemstring)

            old_builtin_item.set_item(self, itemstring)

            local stack = ItemStack(itemstring)
            local item_def_table = core.registered_items[stack:get_name()]
            if item_def_table and item_def_table.groups.flammable ~= 0 then
                self.flammable = item_def_table.groups.flammable
            end

        end

    end

    -- Set the new __builtin:item, with the old one as a fallback
    setmetatable(new_builtin_item, {__index = old_builtin_item})
    core.register_entity(":__builtin:item", new_builtin_item)

end
