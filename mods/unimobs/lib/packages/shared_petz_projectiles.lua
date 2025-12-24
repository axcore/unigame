---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_petz_projectiles = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Table of projectile by-products, fully populated below
local byproduct_func_table = {
    cobweb = function() end,
    fire = function() end,
}

---------------------------------------------------------------------------------------------------
-- Local function
---------------------------------------------------------------------------------------------------

local function get_offset(axis, old_velocity, new_velocity)

    -- Was get_offset()

    if axis == "x" then

        if old_velocity.x >= new_velocity.x then
            return vector.new(-1, 0, 0)
        else
            return vector.new(1, 0, 0)
        end

    elseif axis == "y" then

        if old_velocity.y >= new_velocity.y then
            return vector.new(0, -1, 0)
        else
            return vector.new(0, 1, 0)
        end

    elseif axis == "z" then

        if old_velocity.z >= new_velocity.z then
            return vector.new(0, 0, -1)
        else
            return vector.new(0, 0, 1)
        end

    end

    return vector.new(0, 0, 0)

end

local function get_object_name(obj)

    -- Was get_object_name()

    if core.is_player(obj) then

        return obj:get_player_name()

    else

        local luaent = obj:get_luaentity()
        if luaent then
            return luaent.name
        else
            return ""
        end

    end

end

local function on_throw(
    self, dtime, damage, byproduct_type, particle_type, sound_name, move_result_table
)
    -- From petz.throw()
    -- Called from the .on_step callback below
    -- "Throws" the projectile entity

    if self.thrower_name == "" then

        if self.object:get_attach() == nil then
            self.object:remove()
        end

        return

    end

    local collision = move_result_table.collisions[1]
    if not collision then
        return
    end

    local pos, pos_above
    if collision.type == "node" then

        pos = collision.node_pos
        local offset = get_offset(collision.axis, collision.old_velocity, collision.new_velocity)
        pos_above = vector.add(pos, offset)

    elseif collision.type == "object" then

        local obj = collision.object
        -- Don't hit ourselves
        if get_object_name(obj) == self.thrower_name then
            return
        end

        pos = vector.round(obj:get_pos())
        pos_above = pos
        if damage and damage > 0 then

            local damage_group = ((byproduct_type == "fire") and "fire") or "fleshy"
            local thrower = self.thrower
            if core.is_player(thrower) or thrower:get_luaentity() then
                thrower = self.thrower
            else
                thrower = obj
            end

            obj:punch(
                thrower, 1.0, {full_punch_interval = 1.0, damage_groups = {[damage_group] = damage}}
            )

        end

    else

        -- Failsafe (should never happen)
        return

    end

    if byproduct_type then

        local byproduct_func = byproduct_func_table[byproduct_type]
        if byproduct_func then
            byproduct_func(self, pos, pos_above)
        end

    end

    if particle_type then
        unimobs.petz_api.show_standard_particles(pos_above, particle_type)
    end

    if sound_name then
        unimobs.kitz_api.make_sound("pos", pos, sound_name, unimobs.petz_setting.max_hear_distance)
    end

    self.object:remove()

end

---------------------------------------------------------------------------------------------------
-- Shared function
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_petz_projectiles.register_entity(
    name, textures, damage, byproduct_type, particle_type, sound_name
)
    -- From petz.register_throw_entity()
    -- Called by the "misc_projectile_cobweb" and "misc_projectile_lantern" packages to register the
    --      entity corresponding to a node, when it is thrown

    unilib.register_entity(name, {
        initial_properties = {
            -- (It's possible to catch the projectile)
            collide_with_objects = true,
            collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
            hp_max = 4,
            physical = true,
            static_save = false,
            textures = {textures},
            visual = "wielditem",
            visual_size = {x = 1.0, y = 1.0},
        },

        on_activate = function(self)

            self.object:set_acceleration({x = 0, y = unimobs.constant.gravity, z = 0})
            self.thrower_name = ""

        end,

        on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
            return false
        end,

        on_step = function(self, dtime, moveresult)
            on_throw(self, dtime, damage, byproduct_type, particle_type, sound_name, moveresult)
        end,
    })

end

function unilib.pkg.shared_petz_projectiles.spawn_projectile(thrower, throw_strength, entity)

    -- From petz.spawn_throw_object()
    -- Spawns the entity specified in the earlier call to
    --      unilib.pkg.shared_petz_projectiles.register_entity()

    local pos = thrower:get_pos()
    local luaent = thrower:get_luaentity()
    local dir, yaw

    if thrower:is_player() then

        -- (Camera offset)
        pos.y = pos.y + (thrower:get_properties().eye_height or 1.5)
        yaw = thrower:get_look_horizontal()
        dir = thrower:get_look_dir()

    elseif luaent then

        yaw = thrower:get_yaw()
        dir = core.yaw_to_dir(yaw)

    else

        return

    end

    local throw_obj = core.add_entity(pos, entity)
    if not throw_obj then
        return
    end

    local throw_luaent = throw_obj:get_luaentity()
    if not throw_luaent then
        return
    end

    throw_luaent.thrower = thrower
    throw_luaent.thrower_name = get_object_name(thrower)
    throw_obj:set_yaw(yaw - (0.5 * math.pi))
    throw_obj:set_velocity(vector.multiply(dir, throw_strength))

    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_petz_projectiles.init()

    return {
        description = "Shared functions for projectiles (from petz)",
        optional = "fire_ordinary",
    }

end

function unilib.pkg.shared_petz_projectiles.exec()

    -- Set up projectile by_products, depending on which packages/nodes are available
    core.after(0.1, function()

        if unilib.global.pkg_executed_table["misc_projectile_cobweb"] ~= nil then

            byproduct_func_table.cobweb = function(self, pos, pos_above)

                local node_above = core.get_node(pos_above)
                if node_above.name == "air" and
                        not core.is_protected(pos_above, self.thrower_name) then
                    core.set_node(pos_above, {name = "unilib:misc_projectile_cobweb"})
                end

            end

        end

        local c_fire
        if unilib.global.pkg_executed_table["fire_ordinary"] ~= nil then
            c_fire = "unilib:fire_ordinary"
        elseif core.registered_nodes["fire:basic_flame"] ~= nil then
            c_fire = "fire:basic_flame"
        end

        if c_fire ~= nil then

            byproduct_func_table.fire = function(self, pos, pos_above)

                unimobs.kitz_api.make_sound(
                    "pos",
                    pos,
                    "unilib_misc_projectile_lantern_firecracker",
                    unimobs.petz_setting.max_hear_distance
                )

                local node = core.get_node(pos)
                if core.get_item_group(node.name, "flammable") > 1 and
                        not core.is_protected(pos, self.thrower_name) then
                    core.set_node(pos, {name = c_fire})
                end

                local node_above = core.get_node(pos_above)
                if node_above.name == "air" then
                    unimobs.petz_api.show_standard_particles(pos_above, "fire")
                end

            end

        end

    end)

end
