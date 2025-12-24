---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_clutching.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Table of clutchable items, in the form
--      clutchable_table[full_node_name] = equivalent_entity_name
local clutchable_table = {}
-- Reverse lookup table, in the form
--      clutchable_table[entity_name] = full_node_name
local rev_clutchable_table = {}

---------------------------------------------------------------------------------------------------
-- Notes
---------------------------------------------------------------------------------------------------

-- A "clutchable" item is one which a mob can carry (usually in its mouth, e.g. a dog carrying a
--      square ball during a game of fetch)
-- In the original code, only dogs and square balls could be used. In unimobs, you can create
--      additional clutchable items (see the "item_ball_square" and "shared_petz_balls" packages for
--      some code to adapt)
-- In addition, any mob can be made compatible with clutchable items by setting its
--      .can_clutch_flag to true

---------------------------------------------------------------------------------------------------
-- Shared API functions (original to unimobs)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.register_clutchable_item(full_name, entity_name)

    -- Original to unimobs
    -- Called by any package which provides a clutchable item

    clutchable_table[full_name] = entity_name
    rev_clutchable_table[entity_name] = full_name

end

function unimobs.petz_api.is_node_clutchable(full_name)

    -- Original to unimobs
    -- Returns true if the specified item is clutchable, false otherwise

    if not clutchable_table[full_name] then
        return false
    else
        return true
    end

end

function unimobs.petz_api.is_entity_clutchable(entity_name)

    -- Original to unimobs
    -- Returns true if the specified entity is the equivalent of a clutchable item, false otherwise

    if not rev_clutchable_table[entity_name] then
        return false
    else
        return true
    end

end

function unimobs.petz_api.convert_clutchable_node_to_entity(full_name)

    -- Original to unimobs
    -- Converts the name of the specified clutchable node into its entity equivalent

    return clutchable_table[full_name]

end

function unimobs.petz_api.convert_clutchable_entity_to_node(entity_name)

    -- Original to unimobs
    -- Converts the specified clutchable entity into the equivalent node name

    return rev_clutchable_table[entity_name]

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_squareball.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.attach_clutchable_item(clutch_ent, mob_ent, thing_obj, thrower_name)

    -- From petz/petz/api/api_squareball.lua, was petz.attach_squareball()
    -- Can be called by brain pacakges (e.g. by the "brain_herbivore" package); also called by
    --      unimobs.petz_api.update_clutchable_item()
    --
    -- Attaches the clutchable item entity to a mob entity, as if the mob were carrying a ball in
    --      its mouth
    --
    -- Args:
    --      clutch_ent (luaentity): The luaentity for the clutchable item (e.g. the square ball),
    --          created by the calling code using a call to core.add_entity()
    --      mob_ent (luaentity): The luaentity for the mob to which the item will be attached
    --      mob_obj (entity): The actual mob entity
    --
    -- Optional args:
    --      thrower_name (str): The name of the player that threw the clutchable item, if known
    --          (used in games of fetch)

    clutch_ent.object:set_properties({
        collisionbox = {-0.15, -0.15, -0.15, 0.15, 0.15, 0.15},
        groups = {immortal = 1},
        physical = true,
        -- N.B. The texture list has been moved to code the "shared_petz_balls" package
        visual = "cube",
        visual_size = {x = 0.045, y = 0.045},
    })
    clutch_ent.object:set_attach(
        thing_obj, "head", {x = 0, y = 0.5, z = -0.45}, {x = 0, y = 0, z = 0}
    )

    -- N.B. Removed this memory because, when the game is restarted, the attached item is
    --      automatically dropped (therefore .clutched_item_flag must revert back to false)
--  unimobs.mobkit_api.add_mob_memory(
--      mob_ent, "clutched_item_flag", mob_ent.clutched_item_flag
--  )
    mob_ent.clutched_item_flag = true
    mob_ent.clutched_item_luaent = clutch_ent

    -- N.B. Fixed error in original code; call to kitz.make_sound() should have been a call to
    --      kitz.play_sound()
    unimobs.mobkit_api.do_entity_sound(mob_ent, "moaning")

    if thrower_name then

        local player = core.get_player_by_name(thrower_name)
        if player then

            unimobs.mobkit_api.clear_low_level_queue(mob_ent)
            -- N.B. Original code initiated the "hqb_follow" behaviour only
            if unilib.global.pkg_executed_table["hqb_follow_and_drop"] ~= nil then
                unilib.pkg.hqb_follow_and_drop.add_to_queue(mob_ent, 15, player)
            elseif unilib.global.pkg_executed_table["hqb_follow"] ~= nil then
                unilib.pkg.hqb_follow.add_to_queue(mob_ent, 15, player)
            end

            -- (Disable the .on_step event)
            clutch_ent.thrower_name = ""

        end

    end

end

function unimobs.petz_api.detach_clutchable_item(self, clicker, full_name)

    -- From petz/petz/api/api_squareball.lua (originally the .on_rightclick() callback for the
    --      "petz:ent_square_ball" entity)
    -- Called when the player right-clicks a clutched item
    -- Detaches the clutched item from the mob to which it's attached, and places the equivalent
    --      node ("full_name") in the player's inventory

    if self.object:get_attach() then

        local attach = self.object:get_attach()
        local inv = clicker:get_inventory()
        local new_stack = ItemStack(full_name)

        if inv:room_for_item("main", new_stack) then

            inv:add_item("main", new_stack)

        else

            local parent_pos = attach:get_pos()
            core.add_item(parent_pos, new_stack)

        end

        self.object:set_detach()

        local parent_luaent = attach:get_luaentity()
        -- N.B. As described in the comments above, .clutched_item_flag and .clutched_item_luaent
        --      are not set with unimobs.mobkit_api.add_mob_memory()
        parent_luaent.clutched_item_flag = false
        parent_luaent.clutched_item_luaent = nil

        unimobs.mobkit_api.clear_low_level_queue(parent_luaent)
        if unilib.global.pkg_executed_table["hqb_follow_and_drop"] ~= nil then
            unilib.pkg.hqb_follow_and_drop.add_to_queue(parent_luaent)
        end

        -- (Remove the clutchable item entity)
        self.object:remove()

    end

end

function unimobs.petz_api.throw_clutchable_item(user, entity_name, strength)

    -- From petz/petz/api/api_squareball.lua, was petz.spawn_square_ball()
    -- Called by a node's .on_use() function
    -- Generates an entity corresponding to the clutchable node, and "throws" it in the correct
    --      direction and at the correct angle

    local pos = user:get_pos()
    -- (Camera offset)
    pos.y = pos.y + 1.5

    local dir = user:get_look_dir()
    local yaw = user:get_look_horizontal()

    local obj = core.add_entity(pos, entity_name)
    if not obj then
        return
    end

    obj:get_luaentity().thrower_name = user:get_player_name()
    obj:set_yaw(yaw - 0.5 * math.pi)
    obj:set_velocity(vector.multiply(dir, strength))

    return true

end

function unimobs.petz_api.update_clutchable_item(self, full_name)

    -- From petz/petz/api/api_squareball.lua (originally the .on_step() callback for the
    --      "petz:ent_square_ball" entity)
    -- Called while the clutchable item, having been thrown, is still moving
    -- Checks for collisions with other mobs and/or nodes, handling the first collision found

    -- N.B. We have avoided duplicate clutchable items by moving this check before the
    --      self.thrower_name check just below
    if self.waiting_for_removal_flag then

        self.object:remove()
        return

    end

    -- Force-drop the clutched item, when required
    if self.thrower_name == "" then

        if self.object:get_attach() == nil then

            -- Triggered when the game restarts, for a mob that was carrying a clutchable item
            -- N.B. In original code, when the game restarts, the clutchable item vanishes; here,
            --      the mob "drops" the clutchable item instead
            core.item_drop(
                ItemStack(full_name),
                nil,
                unimobs.mobkit_api.shift_pos_by_vector(
                    self.object:get_pos(), vector.random_direction()
                )
            )
            self.object:remove()

        end

        return

    end

    -- Check for collisions with other mobs and/or nodes
    local pos = self.object:get_pos()
    self.old_pos = self.old_pos or pos

    local cast = core.raycast(self.old_pos, pos, true, false)
    local thing = cast:next()

    while thing do

        if thing.type == "object" and thing.ref ~= self.object then

            if not thing.ref:is_player() and thing.ref:get_player_name() ~= self.thrower_name then

                local thing_luaent = thing.ref:get_luaentity()
                if thing_luaent then

                    -- N.B. Fixed crash from original code, while wielding a clutchable item (as a
                    --      node) and left-clicking the corresponding entity
                    if thing_luaent.petz_compat_flag and
                            thing_luaent.can_clutch_flag and
                            -- N.B. Fix bug in original code; sleeping mobs should not interact with
                            --      clutchable items
                            thing_luaent.status ~= "sleep" and
                            not thing.ref.clutched_item_flag then

                        unimobs.petz_api.attach_clutchable_item(
                            self, thing_luaent, thing.ref, self.thrower_name
                        )

                        return

                    end

                end

            end

        elseif thing.type == "node" then

            local under_name = core.get_node(thing.under).name
            if core.registered_items[under_name].walkable then

                local clutchable_stack = ItemStack(full_name)

                -- N.B. In original code, the thrown entity has a .thrower_name property, with the
                --      intention that any dog which finds the ball, can return it to the thrower
                -- This works fine when the ball lands "on" the dog
                -- However, when the ball "lands" on a node, it's replaced with a "__builtin:item"
                --      which doesn't preserve the .thrower_name property, so the dog doesn't know
                --      who the thrower is
                -- Get around this by manually spawning our own "__builtin:item", so we can pass it
                --      a .thrower_name
                local builtin_obj = core.add_entity(pos, "__builtin:item")
                if not builtin_obj then

                    -- Use original behaviour
                    core.item_drop(clutchable_stack, nil, vector.round(self.old_pos))

                else

                    local builtin_luaent = builtin_obj:get_luaentity()
                    builtin_luaent:set_item(clutchable_stack:to_string())
                    builtin_luaent.thrower_name = self.thrower_name

                end

                self.waiting_for_removal_flag = true
                self.object:remove()
                return

            end

        end

        thing = cast:next()

    end

    self.old_pos = pos

end
