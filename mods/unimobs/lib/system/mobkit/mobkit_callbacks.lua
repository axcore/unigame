---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- mobkit_callbacks.lua
--      Callback functions from the mobkit mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local abs = math.abs
local floor = math.floor
local min = math.min
local random = math.random

---------------------------------------------------------------------------------------------------
-- Shared functions (from mobkit/init.lua)
---------------------------------------------------------------------------------------------------

function unimobs.mobkit_api.default_brain_callback(self)

    -- From mobkit/init.lua, was mobkit.default_brain(), duplicated by kitz.default_brain()
    -- Default brain function for any mob that doesn't define its own brain function (see the API
    --      for details of how brains are implemented)
    -- Launches the "hqb_roam" behaviour (which continues indefinitely)

    if unilib.global.pkg_executed_table["hqb_roam"] ~= nil and
            unimobs.mobkit_api.is_high_level_queue_empty(self) then
        unilib.pkg.hqb_roam.add_to_queue(self, 0)
    end

end

function unimobs.mobkit_api.default_physics_callback(self, col_info_table)

    -- From mobkit/init.lua, was mobkit.physics(), duplicated by kitz.physics()
    -- Default physics callback
    --
    -- N.B. This function's behaviour differs when unimobs.setting.tweak_mobkit_engine_flag is set

    local current_velocity = self.object:get_velocity()
    local new_velocity = vector.new(current_velocity)

    -- N.B. Fix for undeclared global variable in original mobkit code, taking into account the
    --      fix in kitz, which passed "col_info_table" as an argument
    col_info_table = col_info_table or self.col_info_table

    -- Dumb friction
    if self.isonground and not self.isinliquid then

        -- N.B. kitz removes abs() here, but we retain the original mobkit code
        new_velocity = vector.new(
            ((abs(current_velocity.x) > 0.2) and
                (current_velocity.x * unimobs.constant.friction)) or
                0,
            current_velocity.y,
            ((abs(current_velocity.z) > 0.2) and
                (current_velocity.z * unimobs.constant.friction)) or
                0
        )

    end

    -- Bounciness
    if self.bounciness and self.bounciness > 0 then

        -- MT 5.3+
        if col_info_table and col_info_table.collides then

            for _, c in ipairs(col_info_table.collisions) do

                if c.old_velocity[c.axis] > 0.1 then
                    new_velocity[c.axis] = new_velocity[c.axis] * self.bounciness * -1
                end

            end

        -- MT 5.2 and earlier
        elseif not col_info_table then

            for _, k in ipairs({"y", "z", "x"}) do

                if velocity[k] == 0 and abs(self.last_velocity_table[k]) > 0.1 then
                    new_velocity[k] = -self.last_velocity_table[k] * self.bounciness
                end

            end

        end

    end

    self.object:set_velocity(new_velocity)

    -- Buoyancy
    local surface = nil
    local surface_node_name = nil
    local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
    if not stand_pos then
        return
    end

    stand_pos.y = stand_pos.y + 0.01

    -- Get surface height
    local snode_pos = unimobs.mobkit_api.get_pos_of_node_centre(stand_pos)
    local surface_node = unimobs.mobkit_api.get_node_defn_at_pos(stand_pos)
    while surface_node and surface_node.drawtype == "liquid" do

        surface_node_name = surface_node.name
        surface = snode_pos.y + 0.5
        if surface > stand_pos.y + self.height then
            break
        end

        snode_pos.y = snode_pos.y + 1
        surface_node = unimobs.mobkit_api.get_node_defn_at_pos(snode_pos)

    end

    self.isinliquid = surface_node_name
    -- Standing in liquid
    if surface then

        local submergence = min(surface - stand_pos.y, self.height) / self.height
        local buoyacc = unimobs.constant.gravity * (self.buoyancy - submergence)
        unimobs.mobkit_api.set_acceleration(
            self.object,
            {
                x = -current_velocity.x * self.water_drag,
                y = buoyacc - (current_velocity.y * abs(current_velocity.y) * 0.4),
                z = -current_velocity.z * self.water_drag,
            }
        )

    else

        self.object:set_acceleration({x = 0, y = unimobs.constant.gravity, z = 0})

    end

end

function unimobs.mobkit_api.get_staticdata_callback(self)

    -- From mobkit/init.lua, was mobkit.statfunc(), duplicated by kitz.statfunc()
    -- Callback for the mob entity's .get_staticdata field
    -- Returns a string that will be passed to an object's .on_activate(), the next time the object
    --      is instantiated

    local temp_table = {}

    temp_table.memory_table = self.memory_table
    temp_table.hp = self.hp
    temp_table.mob_texture_num = self.mob_texture_num

    return core.serialize(temp_table)

end

function unimobs.mobkit_api.on_activate_callback(self, staticdata, dtime_s)

    -- From mobkit/init.lua, was mobkit.actfunc(), duplicated by kitz.actfunc()
    -- Standard .on_activate callback for all mob entities
    -- Called when an object is instantiated
    --
    -- N.B. This function's behaviour differs when unimobs.setting.tweak_mobkit_engine_flag is set

    if unimobs.setting.tweak_mobkit_engine_flag  then

        unimobs.kitz_api.register_active_mob(self)
        self.active_time = 0

    end

    self.physics_func = self.physics_func or unimobs.mobkit_api.default_physics_callback

    self.hqueue_list = {}
    self.lqueue_list = {}
    self.nearby_obj_list = {}       -- (only when unimobs.setting.tweak_mobkit_engine_flag == false)
    self.nearby_player_list = {}
    self.waypoint_history_list = {}
    self.path_dir = 1
    self.time_total = 0
    self.water_drag = self.water_drag or 1

    local sdata = core.deserialize(staticdata)
    if sdata then

        for k, v in pairs(sdata) do
            self[k] = v
        end

    end

    if self.textures == nil then

        local prop_tex = self.object:get_properties().textures
        if prop_tex then
            self.textures = prop_tex
        end

    end

    if not self.memory_table then

        -- This is the first activation; provide the mob with a memory
        self.memory_table = {}

        -- Texture variation
        if (not unimobs.setting.tweak_mobkit_engine_flag) and #self.textures > 1 then
            self.mob_texture_num = random(#self.textures)
        end

    end

    if self.timeout and (
        (self.timeout > 0 and dtime_s > self.timeout and next(self.memory_table) == nil) or
        (self.timeout < 0 and dtime_s > abs(self.timeout))
    ) then
        self.object:remove()
    end

    if (not unimobs.setting.tweak_mobkit_engine_flag) and
            self.textures and
            self.mob_texture_num then

        -- Apply texture only if required
        local prop_table = {}
        prop_table.textures = {self.textures[self.mob_texture_num]}
        self.object:set_properties(prop_table)

    end

    self.max_hp = self.max_hp or 10
    self.hp = self.hp or self.max_hp

    if type(self.armour_groups) ~= "table" then
        self.armour_groups = {}
    end

    self.armour_groups.immortal = 1
    self.object:set_armor_groups(self.armour_groups)

    self.buoyancy = self.buoyancy or 0
    self.oxygen = self.oxygen or self.lung_capacity
    self.last_velocity_table = {x = 0, y = 0, z = 0}

    if not unimobs.setting.tweak_mobkit_engine_flag then
        self.sensor_func = unimobs.mobkit_api.sensors_callback()
    end

end

function unimobs.mobkit_api.on_step_callback(self, dtime, col_info_table)

    -- From mobkit/init.lua, was mobkit.stepfunc(), duplicated by kitz.stepfunc()
    -- Callback for the entity's .on_step() field
    -- Called on every server tick, after movement and collision processing
    -- Notes from original code: not intended to be modified
    --
    -- N.B. This function's behaviour differs when unimobs.setting.tweak_mobkit_engine_flag is set

    self.dtime = min(dtime, 0.2)
    self.col_info_table = col_info_table
    self.height = unimobs.mobkit_api.get_collision_box_height(self)

    -- Handle physics first
    local vel = self.object:get_velocity()

    if col_info_table then

        self.isonground = col_info_table.touching_ground

    else

        if self.last_velocity_table.y == 0 and vel.y == 0 then
            self.isonground = true
        else
            self.isonground = false
        end

    end

    self:physics_func(col_info_table)

    if self.brain_func then

        if not unimobs.setting.tweak_mobkit_engine_flag and self.view_range then
            self:sensor_func()
        end

        self:brain_func()
        unimobs.mobkit_api.execute_queues(self)

    end

    self.last_velocity_table = self.object:get_velocity()
    self.time_total = self.time_total + self.dtime

end

function unimobs.mobkit_api.sensors_callback()

    -- From mobkit/init.lua, was sensors()
    -- Scans the mob's vicinity, updating its .nearby_obj_list property
    --
    -- N.B. This function is called only when unimobs.setting.tweak_mobkit_engine_flag is false

    local timer = 2
    local pulse = 1

    return function(self)

        timer = timer - self.dtime
        if timer < 0 then

            -- Do full range every third scan
            pulse = pulse + 1
            local range = self.view_range
            if pulse > 2 then
                pulse = 1
            else
                range = self.view_range * 0.5
            end

            local pos = self.object:get_pos()
            self.nearby_obj_list = core.get_objects_inside_radius(pos, range)
            for i, obj in ipairs(self.nearby_obj_list) do

                if obj == self.object then

                    table.remove(self.nearby_obj_list, i)
                    break

                end

            end

            timer = 2

        end

    end

end
