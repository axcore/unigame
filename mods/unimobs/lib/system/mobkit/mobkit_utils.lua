---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- mobkit_utils.lua
--      Utility functions
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local abs = math.abs
local atan2 = math.atan2
local ceil = math.ceil
local floor = math.floor
local max = math.max
local min = math.min
local random = math.random
local tan = math.tan

-- A list representing the positions of a node's horizontal neighbours
-- neighbour_num = 1 is offset {x = 1, z = 0}; subsequent neighbours go clockwise
-- Used by some built-in behaviours; custom behaviours may not need it at all
local neighbour_list = {
    {x = 1, z = 0},
    {x = 1, z = 1},
    {x = 0, z = 1},
    {x = -1, z = 1},
    {x = -1, z = 0},
    {x = -1, z = -1},
    {x = 0, z = -1},
    {x = 1, z = -1},
}

-- Maximum number of nodes checked in calls to unimobs.mobkit_api.get_table_of_nodes_in_area()
local max_node_search = 5*5*5

---------------------------------------------------------------------------------------------------
-- Local functions (from mobkit/init.lua)
---------------------------------------------------------------------------------------------------

local function get_signed_integer(x)

    -- From mobkit/init.lua, was sign()
    -- Returns -1 for a value that's less than 0, 1 otherwise

    return (x < 0) and -1 or 1

end

---------------------------------------------------------------------------------------------------
-- Local functions (from mobkit/example_behaviors.lua)
---------------------------------------------------------------------------------------------------

local function update_waypoint_history(self, pos)

    -- Adapted from mobkit.get_next_waypoint(), duplicated by kitz.get_next_waypoint()

    table.insert(self.waypoint_history_list, 1, pos)
    if #self.waypoint_history_list > 2 then
        table.remove(self.waypoint_history_list, #self.waypoint_history_list)
    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (from kitz/engine.lua)
---------------------------------------------------------------------------------------------------

local function do_area_sort(area)

    -- From kitz/engine.lua, was sort()
    -- Called only by spawn_inside_area()

    local a
    if not (area[1].x < area[2].x) then

        a = area[1].x
        area[1].x = area[2].x
        area[2].x = a

    end

    if not (area[1].y < area[2].y) then

        a = area[1].y
        area[1].y = area[2].y
        area[2].y = a

    end

    if not (area[1].z < area[2].z) then

        a = area[1].z
        area[1].z = area[2].z
        area[2].z = a

    end

    return area

end

local function spawn_inside_area(spawn_pos, area)

    -- From kitz/engine.lua, was spawn_inside_area()
    -- Called only by unimobs.mobkit_api.get_spawn_pos_kitz()

    do_area_sort(area)

    if not (spawn_pos.x >= area[1].x and spawn_pos.x <= area[2].x) then
        return false
    end

    if not (spawn_pos.y >= area[1].y and spawn_pos.y <= area[2].y) then
        return false
    end

    if not (spawn_pos.z >= area[1].x and spawn_pos.z <= area[2].z) then
        return false
    end

    return true

end

---------------------------------------------------------------------------------------------------
-- Shared functions (from mobkit/init.lua)
---------------------------------------------------------------------------------------------------

function unimobs.mobkit_api.apply_damage(luaent, val, reason)

    -- From mobkit/init.lua, was mobkit.hurt(), duplicated by kitz.hurt()
    -- Decrease the specified luaentity's .hp by "val"
    -- Returns true if the luaentity exists and damage can be applied to it; false otherwise (this
    --      is a change to the original mobkit code, which returned nil or false)
    -- The "reason" argument is optional (it was used in the original kitz code, but not in the
    --      corresponding original mobkit code)
    --
    -- N.B. This function's behaviour differs when unimobs.setting.tweak_mobkit_engine_flag is set

    if luaent ~= nil and type(luaent) == "table" then

        if not unimobs.setting.tweak_mobkit_engine_flag then

            luaent.hp = max((luaent.hp or 0) - val, 0)

        else

            local old_hp = luaent.hp or 0
            local new_hp = max(old_hp - val, 0)
            luaent.hp = new_hp

            local name = luaent.name
            local spos = (
                luaent.object and
                unimobs.petz_api.pos_to_string(vector.round(luaent.object:get_pos()))
            ) or "unknown"
            local owner = luaent.owner
            reason = reason or "unknown"

            if owner and owner ~= "" then

                unilib.utils.log(
                    "action",
                    string.format(
                        "[unimobs] %s at %s owned by %s took %s damage because %s",
                        name, spos, owner, old_hp - new_hp, reason
                    )
                )

            else

                unilib.utils.log(
                    "action",
                    string.format(
                        "[unimobs] %s at %s took %s damage because %s",
                        name, spos, old_hp - new_hp, reason
                    )
                )

            end

        end

        return true

    else

        return false

    end

end

function unimobs.mobkit_api.check_main_timer(self, interval)

    -- From mobkit/init.lua, was mobkit.timer(), duplicated by kitz.timer()
    -- Returns true approximately once every "interval" seconds, otherwise false
    -- Used to prevent execution of any code that doesn't necessarily need to run on every engine
    --      step

    local t1 = floor(self.time_total)
    local t2 = floor(self.time_total + self.dtime)
    if (t2 > t1) and ((t2 % interval) == 0) then
        return true
    else
        return false
    end

end

function unimobs.mobkit_api.check_vitals(self)

    -- From mobkit/init.lua, was mobkit.vitals(), duplicated by kitz.vitals()
    -- Checks for drowning and fall damage
    -- This function should be called before checking .hp
    --
    -- N.B. This function's behaviour differs when unimobs.setting.tweak_mobkit_engine_flag is set

    -- Vitals: fall damage
    local vel = self.object:get_velocity()
    local velocity_delta = abs(self.last_velocity_table.y - vel.y)
    if velocity_delta > unimobs.constant.safe_velocity then

        if not unimobs.setting.tweak_mobkit_engine_flag then

            self.hp = self.hp - floor(
                self.max_hp * min(1, (velocity_delta / unimobs.constant.terminal_velocity))
            )

        else

            local damage_ratio = min(
                1,
                (velocity_delta - unimobs.constant.safe_velocity) /
                        (unimobs.constant.terminal_velocity - unimobs.constant.safe_velocity)
            )

            unimobs.mobkit_api.apply_damage(
                self, floor(self.max_hp * damage_ratio), "terminal velocity"
            )

        end

    end

    -- Vitals: drowning
    if self.lung_capacity then

        local cbox = self.object:get_properties().collisionbox
        -- Node at hitbox top
        local head_node = unimobs.mobkit_api.get_node_defn_at_pos(
            unimobs.mobkit_api.shift_pos_by_vector(self.object:get_pos(), {y = cbox[5]})
        )

        if head_node and head_node.drawtype == "liquid" then
            self.oxygen = self.oxygen - self.dtime
        else
            self.oxygen = self.lung_capacity
        end

        if self.oxygen <= 0 then

            -- Drown
            if not unimobs.setting.tweak_mobkit_engine_flag then
                self.hp = 0
            else
                unimobs.mobkit_api.apply_damage(self, self.hp, "drown")
            end

        end

    end

    -- N.B. Not in original code: update harm bars, if permitted
    if unimobs.setting.enable_harm_bar_mobs_flag and (
            not unimobs.setting.enable_harm_bar_victim_flag or
            not self.petz_compat_flag or
            self.was_attacked_by_player_flag
    ) then
        unimobs.misc_api.update_harm_bar(self.object, self.hp, self.max_hp)
    end

end

function unimobs.mobkit_api.convert_dir_to_rot(dir, rot)

    -- From mobkit/init.lua, was mobkit.dir_to_rot(), duplicated by kitz.dir_to_rot()
    -- Converts a 3d vector "dir" to a Minetest rotation vector in the form returned by
    --      core.set_rotation(), i.e. (pitch, yaw, roll)
    -- "rot" is optional; if specified, it is the current object rotation

    rot = rot or {x = 0, y = 0 , z = 0}

    return {
        x = ((dir.x == 0 and dir.y == 0 and dir.z == 0) and rot.x) or
                atan2(dir.y, vector.length({x = dir.x, y = 0, z = dir.z})),
        y = ((dir.x == 0 and dir.z == 0) and rot.y) or core.dir_to_yaw(dir),
        z = rot.z
    }

end

function unimobs.mobkit_api.convert_rot_to_dir(rot)

    -- From mobkit/init.lua, was mobkit.rot_to_dir(), duplicated by kitz.rot_to_dir()
    -- Converts a Minetest rotation vector - in the form returned by core.set_rotation(), i.e.
    --      (pitch, yaw, roll) - into a direction unit vector
    -- "rot" must be in the range ( -pi/2, pi/2 )

    local dir = core.yaw_to_dir(rot.y)
    dir.y = dir.y + (tan(rot.x) * vector.length(dir))
    return vector.normalize(dir)

end

function unimobs.mobkit_api.do_entity_animation(self, anim)

    -- From mobkit/init.lua, was mobkit.animate(), duplicated by kitz.animate()
    -- Makes the entity "self" play the animation "anim" (a string like "stand")
    -- Does nothing if the animation is not defined, or if the same animation is already running

    if self.animation_table and self.animation_table[anim] then

        if self._anim == anim then
            return
        end

        self._anim = anim

        local param_table = {}
        if #self.animation_table[anim] > 0 then
            param_table = self.animation_table[anim][random(#self.animation_table[anim])]
        else
            param_table = self.animation_table[anim]
        end

        param_table.frame_blend = param_table.frame_blend or 0

        self.object:set_animation(
            param_table.range, param_table.speed, param_table.frame_blend, param_table.loop
        )

    else

        self._anim = nil

    end

end

function unimobs.mobkit_api.do_entity_sound(self, sound)

    -- From mobkit/init.lua, was mobkit.make_sound(), duplicated by kitz.play_sound()
    -- Makes the entity "self" play the sound "sound" (a string like "warn"), or does nothing if the
    --      specified "sound" is not defined
    -- Returns the sound handle

    local spec = self.sounds and self.sounds[sound]
    local param_table = {object = self.object}

    -- N.B. Original code does not correctly handle arguments to this function, in the form not
    --      described by mobkit's mobkit_api.txt, but nonetheless used by many petz-compatible mobs
    --          [name] = { list_of_string_filenames }
    -- The fix is to add a second "if type(spec) == table"
    if type(spec) == "table" then

        -- If random sounds matching "sound" are specified, choose one at random
        if #spec > 0 then
            spec = spec[random(#spec)]
        end

    end

    if type(spec) == "table" then

        -- Returns value or a random value within the range [value[1], value[2])
        local function in_range(value)

            return (type(value) == "table" and (value[1] + random() * (value[2] - value[1]))) or
                    value

        end

        -- Pick random values within a range if they're a table
        param_table.gain = in_range(spec.gain)
        param_table.fade = in_range(spec.fade)
        param_table.pitch = in_range(spec.pitch)
        return core.sound_play(spec.name, param_table)

    else

        return core.sound_play(spec, param_table)

    end

end

function unimobs.mobkit_api.does_object_exist(obj)

    -- From mobkit/init.lua, was mobkit.exists(), duplicated by kitz.exists()
    -- Checks whether the specified object exists in the world
    -- "obj" can be a luaentity or ObjectRef; this function is used for stored luaentities and
    --      ObjectRefs

    if not obj then
        return false
    end

    if type(obj) == "table" then
        obj = obj.object
    end

    if type(obj) == "userdata" then

        if obj:is_player() then

            if obj:get_look_horizontal() then
                return true
            end

        else

            if obj:get_yaw() then
                return true
            end

        end

    end

    -- N.B. In original mobkit code, false was not returned here
    return false

end

function unimobs.mobkit_api.get_closest_entity(self, name)

    -- From mobkit/init.lua, was mobkit.get_closest_entity(), duplicated by
    --      kitz.get_closest_entity()
    -- Returns the closest entity named "name", or nil if no such entity is found nearby
    --
    -- N.B. This function's behaviour differs when unimobs.setting.tweak_mobkit_engine_flag is set

    local closest_obj = nil
    local dist = unimobs.setting.abr * 64
    local pos = self.object:get_pos()

    if not unimobs.setting.tweak_mobkit_engine_flag then

        for _, obj in ipairs(self.nearby_obj_list) do

            local luaent = obj:get_luaentity()
            if unimobs.mobkit_api.is_object_alive(obj) and
                    not obj:is_player() and
                    luaent and
                    luaent.name == name then

                local this_pos = obj:get_pos()
                local this_dist = abs(this_pos.x - pos.x) + abs(this_pos.z - pos.z)
                if this_dist < dist then

                    dist = this_dist
                    closest_obj = obj

                end

            end

        end

    else

        for id, obj in pairs(unimobs.global.active_mob_table) do

            local luaent = obj.object:get_luaentity()
            if self._id ~= id and
                    unimobs.mobkit_api.is_object_alive(obj.object) and
                    luaent and
                    luaent.name == name then

                local this_pos = obj.object:get_pos()
                local this_dist = abs(this_pos.x - pos.x) + abs(this_pos.z - pos.z)
                if this_dist < dist then

                    dist = this_dist
                    closest_obj = obj.object

                end

            end

        end

    end

    return closest_obj

end

function unimobs.mobkit_api.get_closest_entity_to_pos(pos, name)

    -- Original to unimobs
    -- An alternative to unimobs.mobkit_api.get_closest_entity(), in which we find the closest
    --      entity to the specified pos, returning nil if no entity is found
    -- The "name" argument is optional; if not specified, any entity which satisfies the
    --      unimobs.mobkit_api.is_object_alive() test is returned

    local closest_obj = nil
    local dist = unimobs.setting.abr * 64

    for id, obj in pairs(unimobs.global.active_mob_table) do

        local luaent = obj.object:get_luaentity()
        if unimobs.mobkit_api.is_object_alive(obj.object) and
                luaent and
                (name == nil or name == luaent.name) then

            local this_pos = obj.object:get_pos()
            local this_dist = abs(this_pos.x - pos.x) + abs(this_pos.z - pos.z)
            if this_dist < dist then

                dist = this_dist
                closest_obj = obj.object

            end

        end

    end

    return closest_obj

end

function unimobs.mobkit_api.get_collision_box_bottom(self)

    -- From mobkit/init.lua, was mobkit.get_hitbox_bottom(), duplicated by kitz.get_hitbox_bottom()
    -- Gets the position of the bottom of the object's collisionbox

    local cbox = self.object:get_properties().collisionbox
    local y = cbox[2]
    local pos = self.object:get_pos()

    return {
        {x = pos.x + cbox[1], y = pos.y + y, z = pos.z + cbox[3]},
        {x = pos.x + cbox[1], y = pos.y + y, z = pos.z + cbox[6]},
        {x = pos.x + cbox[4], y = pos.y + y, z = pos.z + cbox[3]},
        {x = pos.x + cbox[4], y = pos.y + y, z = pos.z + cbox[6]},
    }

end

function unimobs.mobkit_api.get_collision_box_height(obj)

    -- From mobkit/init.lua, was mobkit.get_box_height(), duplicated by kitz.get_box_height()
    -- Returns the height of the specified object's collision box

    if type(obj) == "table" then
        obj = obj.object
    end

    local cbox = obj:get_properties().collisionbox
    local height
    if cbox then
        height = cbox[5] - cbox[2]
    else
        height = 0.1
    end

    return (height > 0 and height) or 0.1

end

function unimobs.mobkit_api.get_columns_displaced_by_node_box(pos, node_box, vec, dist)

    -- From mobkit/init.lua, was mobkit.get_box_displace_cols(), duplicated by
    --      kitz.get_box_displace_cols()
    -- Returns a list of items representing columns, in the form {x=n, z=n}
    -- Each column is displaced by the "node_box" (e.g. a collision box), when it is at the position
    --      "pos" and moves in the horizontal vector "vec"
    -- If "dist" is specified, then the vector "vec" is normalised (i.e. reduced to a length of 1),
    --      before being multipled by the "dist" itself

    local return_list = {{}}

    -- Front-facing corner pos and neighbours
    local fpos = {pos.y}
    -- N.B. These variables, declared in the original mobkit code, are unused
--  local xpos = {pos.y}
--  local zpos = {pos.y}
    local xoff = nil
    local zoff = nil

    if vec.x < 0 then

        fpos.x = pos.x + node_box[1]        -- Front-facing corner x
        xoff = node_box[4] - node_box[1]    -- Edge offset along x

    else

        fpos.x = pos.x + node_box[4]
        xoff = node_box[1] - node_box[4]

    end

    if vec.z < 0 then

        fpos.z = pos.z + node_box[3]        -- Front-facing corner z
        zoff = node_box[6] - node_box[3]    -- Edge offset along z

    else

        fpos.z = pos.z + node_box[6]
        zoff = node_box[3] - node_box[6]

    end

    -- If "dist" is specified, then the vector "vec" is normalised (i.e. reduced to a length of 1),
    --      before being multipled by the "dist" itself
    if dist then
        vec = vector.multiply(vector.normalize(vec), dist)
    end

    -- Traverse x
    local xsgn = get_signed_integer(vec.x)
    local zsgn = get_signed_integer(zoff)
    local index = 0

    for x = floor(fpos.x + 0.5) + (xsgn * 0.5), fpos.x + vec.x, xsgn do

        index = index + 1
        if index > 50 then
            return return_list
        end

        return_list[index] = return_list[index] or {}
        -- z component at the intersection of x and the node edge
        local zcomp = (vec.x == 0 and 0) or (fpos.z + ((x - fpos.x) * vec.z / vec.x))
        for z = floor(zcomp + 0.5), floor(zcomp + zoff + 0.5), zsgn do
            table.insert(return_list[index], {x = x + (xsgn * 0.5), z = z})
        end

    end

    -- Traverse z
    zsgn = get_signed_integer(vec.z)
    xsgn = get_signed_integer(xoff)
    index = 0

    for z = floor(fpos.z + 0.5) + (zsgn * 0.5), fpos.z + vec.z, zsgn do

        index = index + 1
        if index > 50 then
            return return_list
        end

        return_list[index] = return_list[index] or {}
        local xcomp = (vec.z == 0 and 0) or (fpos.x + ((z - fpos.z) * vec.x / vec.z))
        for x = floor(xcomp + 0.5), floor(xcomp + xoff + 0.5), xsgn do
            table.insert(return_list[index], {x = x, z = z + (zsgn * 0.5)})
        end
    end

    return return_list

end

function unimobs.mobkit_api.get_columns_intersected_by_node_box(pos, node_box)

    -- From mobkit/init.lua, was mobkit.get_box_intersect_cols(), duplicated by
    --      kitz.get_box_intersect_cols()
    -- Returns a list of items representing columns, in the form {x=n, z=n}
    -- Each column is intersected by the "node_box" (e.g. a collision box), when it is at the
    --      position "pos"

    local min_pos = {x = floor(pos.x + node_box[1] + 0.5), z = floor(pos.z + node_box[3] + 0.5)}
    local max_pos = {x = floor(pos.x + node_box[4] + 0.5), z = floor(pos.z + node_box[6] + 0.5)}

    local return_list = {}
    for x = min_pos.x, max_pos.x do

        for z = min_pos.z, max_pos.z do
            table.insert(return_list, {x = x, z = z})
        end

    end

    return return_list

end

function unimobs.mobkit_api.get_dot_product(v1, v2)

    -- From mobkit/init.lua, was mobkit.dot(), duplicated by kitz.dot()
    -- Returns the dot product of two vectors

    return (v1.x * v2.x) + (v1.y * v2.y) + (v1.z * v2.z)

end

function unimobs.mobkit_api.get_feet_pos(obj)

    -- From mobkit/init.lua, commented out in original code
    -- Returns the object's pos projected onto the bottom face of its collisionbox (only); compare
    --      unimobs.mobkit_api.get_standing_pos()
    -- "obj" can be a luaentity or ObjectRef

    if type(obj) == "table" then

        return unimobs.mobkit_api.shift_pos_by_vector(
            obj.object:get_pos(), {y = obj.collisionbox[2] + 0.01}
        )

    elseif type(obj) == "userdata" then

        local cbox = obj:get_properties().collisionbox
        return unimobs.mobkit_api.shift_pos_by_vector(obj:get_pos(), {y = cbox[2] + 0.01})

    end

end

function unimobs.mobkit_api.get_min_value_within_range(v, m)

    -- From mobkit/init.lua, was mobkit.minmax(), duplicated by kitz.minmax()
    -- Returns v trimmed to the range <-m, m>

    return min(abs(v), m) * get_signed_integer(v)

end

function unimobs.mobkit_api.get_name_of_node_at_vector(pos, vec)

    -- From mobkit/init.lua, was mobkit.get_nodename_off(), duplicated by kitz.get_nodename_off()
    -- Gets the name of the node at the specified vector from "pos"

    return core.get_node(unimobs.mobkit_api.shift_pos_by_vector(pos, vec)).name

end

function unimobs.mobkit_api.get_node_defn_at_pos(pos)

    -- From mobkit/init.lua, was mobkit.nodeatpos(), duplicated by kitz.nodeatpos()
    -- Returns the definition of the node at the specified "pos", or nil if it's an ignore node

    local node = core.get_node_or_nil(pos)
    if node then
        return core.registered_nodes[node.name]
    end

end

function unimobs.mobkit_api.get_node_height(pos)

    -- From mobkit/init.lua, was mobkit.get_node_height(), duplicated by kitz.get_node_height()
    -- Returns three values which are not descibed by original mobkit documentation
    --
    -- N.B. This function's behaviour differs when unimobs.setting.tweak_mobkit_engine_flag is set

    local centre_pos = unimobs.mobkit_api.get_pos_of_node_centre(pos)
    local def_table = unimobs.mobkit_api.get_node_defn_at_pos(centre_pos)
    if def_table == nil then
        return nil
    end

    -- N.B. Updated original code to allow mobs to pass through open gates
    if def_table.walkable and (
        not unimobs.setting.tweak_mobkit_engine_flag or (
            unimobs.petz_setting.enable_pass_through_opening_flag and
            not unimobs.kitz_api.node_has_group(pos, "door") and
            not unimobs.kitz_api.node_has_group(pos, "fence")
        )
    ) then

        if def_table.drawtype == "nodebox" then

            -- Non-cubic node
            local box
            if not unimobs.setting.tweak_mobkit_engine_flag then
                box = def_table.collision_box or def_table.node_box
            elseif unimobs.setting.tweak_mobkit_engine_flag  then
                box = def_table.node_box
            end

            if box and box.type == "fixed" then

                -- Notes from original code:
                -- TODO: Handle table of boxes
                if type(box.fixed[1]) == "number" then
                    return centre_pos.y + box.fixed[5], 0, false
                elseif type(box.fixed[1]) == "table" then
                    return centre_pos.y + box.fixed[1][5], 0, false
                else
                    return centre_pos.y + 0.5, 1, false
                end

            elseif box and box.type == "leveled" then

                return (core.get_node_level(pos) / 64) - 0.5 + centre_pos.y, 0, false

            else

                -- Failsafe
                return centre_pos.y + 0.5, 1, false

            end

        else

            -- Cubic node
            return centre_pos.y + 0.5, 1, false

        end

    else

        local liquid_flag = false
        if def_table.drawtype == "liquid" then
            liquid_flag = true
        end

        return centre_pos.y - 0.5, -1, liquid_flag

    end

end

function unimobs.mobkit_api.get_pos_of_node_centre(pos)

    -- From mobkit/init.lua, was mobkit.get_node_pos(), duplicated by kitz.get_node_pos()
    -- Returns "pos" tweaked so that it's the centre of the node, e.g.
    --      {x = 10.5, y = 51.5, z = 0.5}

    return {x = floor(pos.x + 0.5), y = floor(pos.y + 0.5), z = floor(pos.z + 0.5)}

end

function unimobs.mobkit_api.get_random_nearby_entity(self, name)

    -- From mobkit/init.lua, was mobkit.get_nearby_entity(), duplicated by kitz.get_nearby_entity()
    -- Returns a random entity from those that are nearby, or nil if no entities are nearby

    if not unimobs.setting.tweak_mobkit_engine_flag then

        for _, obj in ipairs(self.nearby_obj_list) do

            if unimobs.mobkit_api.is_object_alive(obj) and
                    not obj:is_player() and
                    obj:get_luaentity().name == name then
                return obj
            end

        end

    else

        -- N.B. In the original code, this "random" function returns, at best, a pseudo-random
        --      value; this is a fix for that
        local id_list = {}
        for id, _ in pairs(unimobs.global.active_mob_table) do
            table.insert(id_list, id)
        end

        for _, id in ipairs(unimobs.kitz_api.shuffle_table_indices(id_list)) do

            local obj = unimobs.global.active_mob_table[id]

            if self._id ~= id and
                    unimobs.mobkit_api.is_object_alive(obj.object) and
                    -- N.B. Fixed bug in original kitz code, causing a crash
--                  obj:get_luaentity().name == name then
                    obj.object:get_luaentity().name == name then
                return obj.object
            end

        end

    end

    return

end

function unimobs.mobkit_api.get_random_nearby_player(self)

    -- From mobkit/init.lua, was mobkit.get_nearby_player(), duplicated by kitz.get_nearby_player()
    -- Returns a random player from those that are nearby, or nil if no players are nearby
    --
    -- N.B. This function's behaviour differs when unimobs.setting.tweak_mobkit_engine_flag is set

    if not unimobs.setting.tweak_mobkit_engine_flag then

        for _, obj in ipairs(self.nearby_obj_list) do

            if obj:is_player() and unimobs.mobkit_api.is_object_alive(obj) then
                return obj
            end

        end

    else

        local pos = self.object:get_pos()
        -- N.B. In the original code, 50% of self.view_range, but that's not enough for mobs to
        --      comfortably follow a player
        local range = self.view_range * 0.66
        -- N.B. In the original code, this "random" function returns the same player every time;
        --      instead, make sure it's actually a random choice each time
--      for _, obj in ipairs(core.get_connected_players()) do
        for _, obj in ipairs(
            unimobs.kitz_api.shuffle_table_indices(core.get_connected_players())
        ) do
            if unimobs.mobkit_api.is_object_alive(obj) then

                local obj_pos = obj:get_pos()
                local obj_dist = abs(obj_pos.x - pos.x) + abs(obj_pos.z - pos.z)
                if obj_dist <= range then
                    return obj
                end

            end

        end

    end

    return

end

function unimobs.mobkit_api.get_spawn_pos(dtime, interval, radius, chance, reduction)

    -- From mobkit/init.lua, was mobkit.get_spawn_pos_abr(), duplicated by kitz.get_spawn_pos_abr()
    -- Returns a potential spawn position at random intervals
    --
    -- Args:
    --      dtime (float): Time interval
    --      interval (float): Average spawn attempt interval for every player
    --      radius (int): Spawn distance in nodes, the engine's active block range (i.e.
    --          unimobs.setting.abr) multiplied by 16 is recommended
    --      chance (float): Value in the range 0-1. The chance of spawning a mob if there are no
    --          other objects in the area
    --      reduction (float): Value in the range 0-1. The spawn chance is reduced by this factor
    --          for every object in the area
    --
    -- Return values:
    --      nil for nothing to spawn, or items in the form (suggested_pos, liquid_flag)
    --
    -- Usage:
    --      core.register_globalstep(function(dtime)
    --          local spawn_pos = unimobs.mobkit_api.get_spawn_pos(...)
    --          if spawn_pos then
    --             [LOGIC GOES HERE]
    --          end
    --      end)

    dtime = min(dtime, 0.1)
    local player_list = core.get_connected_players()
    interval = 1 / interval

    if random() < (dtime * interval * #player_list) then

        -- Choose a random player
        local player = player_list[random(#player_list)]
        local vel = (core.features.object_step_has_moveresult and player:get_velocity()) or
                player:get_velocity()
        local speed = vector.length(vel)
        chance = ((1 - chance) * 1) / ((speed * 0.75) + 1)

        local yaw
        if speed > 1 then

            -- Spawn in the front-facing arc
            yaw = core.dir_to_yaw(vel) + (random() * 0.35) - 0.75

        else

            -- Random yaw
            yaw = random() * math.pi * 2 - math.pi

        end

        local pos = player:get_pos()
        local dir = vector.multiply(core.yaw_to_dir(yaw), radius)
        local pos2 = vector.add(pos, dir)
        pos2.y = pos2.y - 5

        local height, liquid_flag = unimobs.mobkit_api.get_walkable_terrain_height(pos2, 32)
        if height then

            local obj_list = core.get_objects_inside_radius(pos, radius * 1.1)
            -- Count mobs in active block range
            for _, obj in ipairs(obj_list) do

                if not obj:is_player() then

                    local luaent = obj:get_luaentity()
                    if luaent and luaent.name ~= "__builtin:item" then

                        -- Chance reduced for every mob in range
                        chance = chance + ((1 - chance) * reduction)

                    end

                end

            end

            if chance < random() then

                pos2.y = height
                local obj_list2 = core.get_objects_inside_radius(pos2, (radius * 0.95))
                -- Do not spawn if another player is nearby
                for _, obj in ipairs(obj_list2) do

                    if obj:is_player() then
                        return
                    end

                end

                return pos2, liquid_flag

            end

        end

    end

end

function unimobs.mobkit_api.get_spawn_pos_kitz(abr)

    -- From kitz.get_spawn_pos_abr()
    -- Alternative to unimobs.mobkit_api.get_spawn_pos(), called only by code imported from kitz
    -- Returns a potential spawn position at random intervals

    local player_list = core.get_connected_players()
    if #player_list == 0 then
        return
    end

    -- Choose a random player
    local player = player_list[random(#player_list)]
    local player_pos = player:get_pos()

    -- Recommended spawn range
    local radius =  abr * 16
    local spawn_point = vector.new(random(-radius, radius), 0, random(-radius, radius))
    local spawn_pos = vector.add(player_pos, spawn_point)

    local height, liquid_flag = unimobs.mobkit_api.get_walkable_terrain_height(spawn_pos, 32)
    if height then

        if unimobs.petz_setting.exclusive_spawn_area_list and
                not unimobs.kitz_api.is_table_empty(
                    unimobs.petz_setting.exclusive_spawn_area_list
                ) then

            local spawn_in_area_flag = false
            -- "this_area", in the form "(x,y,z);(x,y,z)", defines an area in which mobs
            --      exclusively spawn
            for _, this_area in ipairs(unimobs.petz_setting.exclusive_spawn_area_list) do

                local point_list = string.split(this_area, ';')
                local area_list = {}
                for i = 1, 2 do

                    local axis_list = string.split(point_list[i])
                    if #axis_list == 3 then

                        area_list[i] = vector.new(
                            tonumber(axis_list[1]), tonumber(axis_list[2]), tonumber(axis_list[3])
                        )

                    end

                end

                if #area_list == 2 and spawn_inside_area(spawn_pos, area_list) then

                    -- The spawn position is inside an area
                    spawn_in_area_flag = true
                    break

                end

            end

            if not spawn_in_area_flag then

                -- No spawn inside any area
                return false, false

            end

        end

        spawn_pos.y = height
        return spawn_pos, liquid_flag

    end

end

function unimobs.mobkit_api.get_standing_pos(obj)

    -- From mobkit/init.lua, was mobkit.get_stand_pos(), duplicated by kitz.get_stand_pos()
    -- Returns the object's pos projected onto the bottom face of its collisionbox, and its actual
    --      pos; compare unimobs.mobkit_api.get_feet_pos()
    -- "obj" can be a luaentity or ObjectRef
    --
    -- N.B. Original code returned false on failure
    -- N.B. All calling code must check for a nil return value (original mobkit and petz code did
    --      not)

    local pos = {}
    local cbox = {}

    if type(obj) == "table" then

        -- N.B. When called for a dead mob, :get_pos() and :get_properties() sometimes return nil;
        --      tweaked the original code to catch it, before a crash happens
        pos = obj.object:get_pos()
        if pos == nil then
            return
        end

        cbox = obj.object:get_properties().collisionbox

    elseif type(obj) == "userdata" then

        pos = obj:get_pos()
        if pos == nil then
            return
        end

        cbox = obj:get_properties().collisionbox

    else

        return

    end

    return unimobs.mobkit_api.shift_pos_by_vector(pos, {y = cbox[2] + 0.01}), pos

end

function unimobs.mobkit_api.get_table_of_nodes_in_area(pos1, pos2, advanced_flag)

    -- From mobkit/init.lua, was mobkit.get_nodes_in_area(), duplicated by kitz.get_nodes_in_area()
    -- In basic mode (advanced_flag = false or nil), returns a table of unique nodes within the area
    --      specified by the opposite corners "pos1" and "pos2"; the table is indexed by node
    --      definition, i.e.
    --          table[node_definition] = true
    -- In advanced mode (advanced_flag = true) returns a table of nodes definitions indexed by
    --      position, i.e.
    --          table[pos] = node_definition
    -- The maximum number of nodes searched is specified by "max_node_search" (declared above,
    --      default value is 125)

    local return_table = {}
    local centre_pos1 = unimobs.mobkit_api.get_pos_of_node_centre(pos1)
    local centre_pos2 = unimobs.mobkit_api.get_pos_of_node_centre(pos2)
    local safety_count = 0

    local step_x = ((pos2.x < pos1.x) and -1) or 1
    local step_z = ((pos2.z < pos1.z) and -1) or 1
    local step_y = ((pos2.y < pos1.y) and -1) or 1

    local x = centre_pos1.x - step_x
    -- N.B. Initial values for z, y (used in the original mobkit code) are redundant
--  local z = centre_pos1.z - step_z
--  local y = centre_pos1.y - step_y
    local z, y

    repeat

        x = x + step_x
        z = centre_pos1.z - step_z

        repeat

            z = z + step_z
            y = centre_pos1.y - step_y

            repeat

                y = y + step_y

                local pos = {x = x, y = y, z = z}
                local defn_table = unimobs.mobkit_api.get_node_defn_at_pos(pos)
                if defn_table then

                    if advanced_flag == true then
                        return_table[pos] = defn_table
                    else
                        return_table[defn_table] = true
                    end

                end

                safety_count = safety_count + 1
                if safety_count > max_node_search then

                    unilib.utils.show_error(
                        "unimobs.mobkit_api.get_table_of_nodes_in_area(): search area too big"
                    )
                    return return_table

                end

            until y == centre_pos2.y

        until z == centre_pos2.z

    until x == centre_pos2.x

    return return_table

end

function unimobs.mobkit_api.get_walkable_terrain_height(pos, steps, dir, liquid_flag)

    -- From mobkit/init.lua, was mobkit.get_terrain_height(), duplicated by
    --      kitz.get_terrain_height()
    -- Recursively searches for a walkable surface on, above or below the specified "pos"
    --
    -- Args:
    --      pos (table): The target position
    --      steps (int or nil): Number of recursion steps, or how far above/below "pos" to check;
    --          default value is 3
    --      dir (int or nil): Direction of search: 1 to search above, -1 to search below, 0 to
    --          search in both directions (default is 0)
    --      liquid_flag (bool): Do not specify this parameter in initial calls to the function;
    --          during recursion, it is set to true if a surface is covered in water
    --
    -- Return values:
    --      y_coordinate_of_found_surface, liquid_flag_for_that_surface

    steps = steps or 3
    dir = dir or 0

    -- N.B. The meaning of these values are not described by the original mobkit documentation
    local h, f, l = unimobs.mobkit_api.get_node_height(pos)
    if h == nil then
        return nil
    end

    if l then
        liquid_flag = true
    end

    if f == 0 then
        return h, liquid_flag
    end

    if dir == 0 or dir == f then

        steps = steps - 1
        if steps <= 0 then
            return nil
        end

        return unimobs.mobkit_api.get_walkable_terrain_height(
            unimobs.mobkit_api.shift_pos_by_vector(pos, {y = f}),
            steps,
            f,
            liquid_flag
        )

    else

        return h, liquid_flag

    end

end

function unimobs.mobkit_api.has_reached_destination(current_pos, dir, dest_pos)

    -- From mobkit/init.lua, was mobkit.is_there_yet2d(), kitz.is_there_yet2d()
    -- Returns true if the position "dest_pos" is behind "current_pos", according to the vector of
    --      direction "dir", indicating that something has reached its destination
    -- y components are ignored, so the check is performed as if the positions were on a plane; thus
    --      true is returned if "dest_pos" is in the rear half-plane, as defined by "current_pos"
    --      and "dir"

    -- Constant
    local c = (-dir.x * current_pos.x) - (dir.z * current_pos.z)
    -- Line equation
    if dir.z > 0 then
        return dest_pos.z <= ((-dir.x * dest_pos.x) - c) / dir.z
    elseif dir.z < 0 then
        return dest_pos.z >= ((-dir.x * dest_pos.x) - c) / dir.z
    elseif dir.x > 0 then
        return dest_pos.x <= ((-dir.z * dest_pos.z) - c) / dir.x
    elseif dir.x < 0 then
        return dest_pos.x >= ((-dir.z * dest_pos.z) - c) / dir.x
    else
        return false
    end

end

function unimobs.mobkit_api.heal_damage(luaent, val)

    -- From mobkit/init.lua, was mobkit.heal(), duplicated by kitz.heal()
    -- Increases the specified luaentity's .hp by "val"
    -- Returns true if the luaentity exists and healing can be applied to it; false otherwise (this
    --      is a change to the original mobkit code, which returned nil or false)

    if not luaent then
        return false
    end

    if luaent ~= nil and type(luaent) == "table" then

        luaent.hp = min(luaent.max_hp, (luaent.hp or 0) + val)
        return true

    else

        return false

    end

end

function unimobs.mobkit_api.is_object_alive(obj)

    -- From mobkit/init.lua, was mobkit.is_alive(), duplicated by kitz.is_alive()
    -- Checks whether the specified object exists in the world and is alive
    -- "obj" can be a luaentity or ObjectRef; this function is used for stored luaentities and
    --      ObjectRefs
    -- Assumes that luaentities are considered dead when their .hp is 0 or below
    -- In the original mobkit code, this function is marked as non-essential (for reasons not
    --      explained)
    --
    -- N.B. The petz/kitz version of this function contains some minor changes from the original
    --      mobkit version, which were NOT copied into this unimobs function

    if not unimobs.mobkit_api.does_object_exist(obj) then
        return false
    end

    -- Support for mobs_redo
    if type(obj) == "table" then
        return obj.hp > 0 or (obj.health and obj.health > 0)
    end

    if obj:is_player() then

        return obj:get_hp() > 0

    else

        local luaent = obj:get_luaentity()
        -- (Support for mobs_redo)
        local hp = luaent and (luaent.hp or luaent.health) or nil
        return hp and hp > 0

    end

end

function unimobs.mobkit_api.is_pos_in_box(pos, box_pos, box)

    -- From mobkit/init.lua, was mobkit.is_pos_in_box(), duplicated by kitz.is_pos_in_box()
    -- Returns true if "pos" within the collision box "box", which is at the position "box_pos"

    return pos.x > (box_pos.x + box[1]) and
            pos.x < (box_pos.x + box[4]) and
            pos.y > (box_pos.y + box[2]) and
            pos.y < (box_pos.y + box[5]) and
            pos.z > (box_pos.z + box[3]) and
            pos.z < (box_pos.z + box[6])

end

function unimobs.mobkit_api.is_pos_in_cube(pos1, pos2, radius)

    -- From mobkit/init.lua, was mobkit.isnear3d(), duplicated by kitz.isnear3d()
    -- Returns true if "pos2" is within a cube whose centre is "pos1", and whose radius is "radius";
    --      otherwise returns false

    if abs(pos2.x - pos1.x) < radius and
            abs(pos2.z - pos1.z) < radius and
            abs(pos2.y - pos1.y) < radius then
        return true
    else
        return false
    end

end

function unimobs.mobkit_api.is_pos_in_square(pos1, pos2, radius)

    -- From mobkit/init.lua, was mobkit.isnear2d(), duplicated by kitz.isnear2d()
    -- Returns true if "pos2" is within a square whose centre is "pos1", and whose radius is
    --      "radius"; otherwise returns false
    -- y components are ignored, so pos1.y need not be equal to pos2.y, in order to return true

    if abs(pos2.x - pos1.x) < radius and abs(pos2.z - pos1.z) < radius then
        return true
    else
        return false
    end

end

function unimobs.mobkit_api.move_towards_pos(self, target_pos, speed, turn_rate, dist)

    -- From mobkit/init.lua, was mobkit.drive_to_pos(), duplicated by kitz.drive_to_pos()
    -- Moves in the facing direction while gradually turning towards "target_pos"
    --
    -- Args:
    --      target_pos (table): The target position
    --      speed (float): Speed in metres per second
    --      turn_rate (float): Turning rate in radians per second
    --      distance (float): Desired distance from the target, in metres
    --
    -- Return values:
    --      true if within the distance "dist" from "target_pos", otherwise false

    local current_pos = self.object:get_pos()
    dist = dist or 0.2
    if unimobs.mobkit_api.is_pos_in_square(current_pos, target_pos, dist) then
        return true
    end

    local target_yaw = core.dir_to_yaw(vector.direction(current_pos, target_pos))
    unimobs.mobkit_api.turn_to_yaw(self, target_yaw, turn_rate)
    unimobs.mobkit_api.set_forward_velocity(self, speed)
    return false

end

function unimobs.mobkit_api.set_acceleration(obj, vec, limit)

    -- From mobkit/init.lua, was mobkit.set_acceleration(), duplicated by kitz.set_acceleration()
    -- Called when an object is in a liquid, in order to set its acceleration; in the air,
    --      obj:set_acceleration() can be called directly

    limit = limit or 100
    if type(obj) == "table" then
        obj = obj.object
    end

    vec.x = unimobs.mobkit_api.get_min_value_within_range(vec.x, limit)
    vec.y = unimobs.mobkit_api.get_min_value_within_range(vec.y, limit)
    vec.z = unimobs.mobkit_api.get_min_value_within_range(vec.z, limit)

    obj:set_acceleration(vec)

end

function unimobs.mobkit_api.set_forward_velocity(self, speed)

    -- From mobkit/init.lua, was mobkit.go_forward_horizontal(), duplicated by
    --      kitz.go_forward_horizontal()
    -- Sets an entity's horizontal velocity in the yaw direction; its vertical velocity is
    --      unaffected

    local y = self.object:get_velocity().y
    local yaw = self.object:get_yaw()
    local vel = vector.multiply(core.yaw_to_dir(yaw), speed)

    vel.y = y
    self.object:set_velocity(vel)

end

function unimobs.mobkit_api.shift_pos_by_horizontal_distance(pos, yaw, dist)

    -- From mobkit/init.lua, was mobkit.pos_translate2d(), duplicated by kitz.pos_translate2d()
    -- Returns "pos" shifted in the direction of "yaw" by the distance "dist"

    return vector.add(pos, vector.multiply(core.yaw_to_dir(yaw), dist))

end

function unimobs.mobkit_api.shift_pos_by_vector(pos, vec)

    -- From mobkit/init.lua, was mobkit.pos_shift(), duplicated by kitz.pos_shift()
    -- Returns "pos" shifted by the specified vector, "vec"
    -- "pos" must be a full Minetest position table, containing .x, .y and .z fields
    -- The fields in "vec" are optional; any missing fields are handled as 0, e.g. {y = 1}

    vec.x = vec.x or 0
    vec.y = vec.y or 0
    vec.z = vec.z or 0

    return {x = pos.x + vec.x, y = pos.y + vec.y, z = pos.z + vec.z}

end

function unimobs.mobkit_api.turn_to_yaw(self, target_yaw, rate)

    -- From mobkit/init.lua, was mobkit.turn2yaw(), duplicated by kitz.turn2yaw()
    -- Gradually turns towards the specified yaw
    --
    -- Args:
    --      self (luaentity): A mob
    --      target_yaw (float): Target yaw in radians
    --      rate (float): Turn rate in radians per second
    --
    -- Return values:
    --      Returns two values, in the form
    --          true_if_facing_target_yaw_otherwise_false, current_yaw

    target_yaw = target_yaw or 0
    rate = rate or 6

    local yaw = self.object:get_yaw()
    yaw = yaw + math.pi
    target_yaw = (target_yaw + math.pi ) % (math.pi * 2)

    local step = min(self.dtime * rate, abs(target_yaw - yaw) % (math.pi * 2))

    local dir = (abs(target_yaw - yaw) > math.pi and -1) or 1
--  dir = ((target_yaw > yaw) and (dir * 1)) or (dir * -1)
    dir = ((target_yaw > yaw) and dir) or (dir * -1)

    local new_yaw = (yaw + (step * dir)) % (math.pi * 2)
    self.object:set_yaw(new_yaw - math.pi)

    if new_yaw == target_yaw then
        return true, new_yaw - math.pi
    else
        return false, new_yaw - math.pi
    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (from mobkit/example_behaviors.lua)
---------------------------------------------------------------------------------------------------

function unimobs.mobkit_api.convert_vector_to_neighbour_num(dir)

    -- From mobkit/example_behaviors.lua, was mobkit.dir2neighbor(), duplicated by
    --      kitz.dir2neighbor()
    -- Converts a 3d vector to a neighbour number (an index in "neighbour_list", in the range 1-8).
    --       The y-component of "dir" is ignored

    dir.y = 0
    dir = vector.round(vector.normalize(dir))
    for k, v in ipairs(neighbour_list) do

        if v.x == dir.x and v.z == dir.z then
            return k
        end

    end

    return 1

end

function unimobs.mobkit_api.get_next_neighbour(neighbour_num, shift)

    -- From mobkit/example_behaviors.lua, was mobkit.neighbor_shift(), duplicated by
    --      kitz.neighbor_shift()
    -- Converts "neighbour_num" (an index in "neighbour_list", representing a neighbouring node)
    --      into one of the other indices (representing a different neighbouring node)
    -- If "shift" is positive, move clockwise; if negative, move anti-clockwise
    -- e.g. (1, 1) -> 2, (1, -2) -> 7

    return ((8 + neighbour_num + shift - 1) % 8) + 1

end

function unimobs.mobkit_api.get_next_waypoint(self, target_pos)

    -- From mobkit/example_behaviors.lua, was mobkit.get_next_waypoint()
    -- Called by unimobs.mobkit_api.goto_next_waypoint()

    local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
    if not stand_pos then
        return
    end

    local dir = vector.direction(stand_pos, target_pos)
    local neighbour_num = unimobs.mobkit_api.convert_vector_to_neighbour_num(dir)
    local no_go_pos = self.waypoint_history_list[2]

    local height, this_pos, liquid_flag =
            unimobs.mobkit_api.is_neighbour_node_reachable(self, neighbour_num)
    if height and
            not liquid_flag and
            not (no_go_pos and unimobs.mobkit_api.is_pos_in_square(this_pos, no_go_pos, 0.1)) then

        local heightl = unimobs.mobkit_api.is_neighbour_node_reachable(
            self, unimobs.mobkit_api.get_next_neighbour(neighbour_num, -1)
        )

        if heightl and abs(heightl - height) < 0.001 then

            local heightr = unimobs.mobkit_api.is_neighbour_node_reachable(
                self, unimobs.mobkit_api.get_next_neighbour(neighbour_num, 1)
            )

            if heightr and abs(heightr - height) < 0.001 then

                dir.y = 0
                local dirn = vector.normalize(dir)
                local npos = unimobs.mobkit_api.get_pos_of_node_centre(
                    unimobs.mobkit_api.shift_pos_by_vector(stand_pos, neighbour_list[neighbour_num])
                )
                local factor = ((abs(dirn.x) > abs(dirn.z)) and abs(npos.x - stand_pos.x)) or
                        abs(npos.z - stand_pos.z)
                this_pos = unimobs.mobkit_api.shift_pos_by_vector(
                    stand_pos, {x = dirn.x * factor, z = dirn.z * factor}
                )

            end

        end

        update_waypoint_history(self, this_pos)
        return height, this_pos

    else

        for i = 1, 3 do

            -- Scan left
            local height, this_pos, liquid_flag2 = unimobs.mobkit_api.is_neighbour_node_reachable(
                self, unimobs.mobkit_api.get_next_neighbour(neighbour_num, (-i * self.path_dir))
            )

            if height and
                    not liquid_flag2 and
                    not (
                        no_go_pos and unimobs.mobkit_api.is_pos_in_square(this_pos, no_go_pos, 0.1)
                    ) then

                update_waypoint_history(self, this_pos)
                return height, this_pos

            end

            -- Scan right
            height, this_pos, liquid_flag2 = unimobs.mobkit_api.is_neighbour_node_reachable(
                self, unimobs.mobkit_api.get_next_neighbour(neighbour_num, (i * self.path_dir))
            )

            if height and
                    not liquid_flag2 and
                    not (
                        no_go_pos and unimobs.mobkit_api.is_pos_in_square(this_pos, no_go_pos, 0.1)
                    ) then

                update_waypoint_history(self, this_pos)
                return height, this_pos

            end

        end

        -- Scan rear
        height, this_pos, liquid_flag = unimobs.mobkit_api.is_neighbour_node_reachable(
            self, unimobs.mobkit_api.get_next_neighbour(neighbour_num, 4)
        )

        if height and
                not liquid_flag and
                not (
                    no_go_pos and
                    unimobs.mobkit_api.is_pos_in_square(this_pos, no_go_pos, 0.1)
                ) then

            update_waypoint_history(self, this_pos)
            return height, this_pos

        end

    end

    -- This code executed, when stuck...
    table.remove(self.waypoint_history_list, 2)
    -- ...so try something else
    self.path_dir = self.path_dir * -1

end

function unimobs.mobkit_api.get_next_waypoint_fast(self, target_pos, no_go_pos)

    -- From mobkit/example_behaviors.lua, was mobkit.get_next_waypoint_fast(), duplicated by
    --      kitz.get_next_waypoint_fast()
    -- Alternative to unimobs.mobkit_api.get_next_waypoint(); not currently called by code imported
    --      from the original mobkit mod
    -- The "no_go_pos" argument, if specified, is ignored

    local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
    if not stand_pos then
        return
    end

    local dir = vector.direction(stand_pos, target_pos)
    local neighbour_num = unimobs.mobkit_api.convert_vector_to_neighbour_num(dir)
    local height, this_pos, liquid_flag =
            unimobs.mobkit_api.is_neighbour_node_reachable(self, neighbour_num)

    if height and not liquid_flag then

        local fast_flag = false
        heightl = unimobs.mobkit_api.is_neighbour_node_reachable(
            self, unimobs.mobkit_api.get_next_neighbour(neighbour_num, -1)
        )

        if heightl and abs(heightl - height) < 0.001 then

            heightr = unimobs.mobkit_api.is_neighbour_node_reachable(
                self, unimobs.mobkit_api.get_next_neighbour(neighbour_num, 1)
            )

            if heightr and abs(heightr - height) < 0.001 then

                fast_flag = true
                dir.y = 0
                local ndir = vector.normalize(dir)
                local npos = unimobs.mobkit_api.get_pos_of_node_centre(
                    unimobs.mobkit_api.shift_pos_by_vector(stand_pos, neighbour_list[neighbour_num])
                )
                local factor = ((abs(ndir.x) > abs(ndir.z)) and abs(npos.x - stand_pos.x)) or
                        abs(npos.z - stand_pos.z)
                this_pos = unimobs.mobkit_api.shift_pos_by_vector(
                    stand_pos, {x = ndir.x * factor, z = ndir.z * factor}
                )

            end

        end

        return height, this_pos, fast

    else

        for i = 1, 4 do

            -- Scan left
            local liquid_flag2
            height, this_pos, liquid_flag2 = unimobs.mobkit_api.is_neighbour_node_reachable(
                self, unimobs.mobkit_api.get_next_neighbour(neighbour_num, -i)
            )

            if height and not liquid_flag2 then
                return height, this_pos
            end

            -- Scan right
            height, this_pos, liquid_flag2 = unimobs.mobkit_api.is_neighbour_node_reachable(
                self, unimobs.mobkit_api.get_next_neighbour(neighbour_num, i)
            )

            if height and not liquid_flag2 then
                return height, this_pos
            end

        end

    end

end

function unimobs.mobkit_api.goto_next_waypoint(self, target_pos)

    -- From mobkit/example_behaviors.lua, was mobkit.goto_next_waypoint(), duplicated by
    --      kitz.goto_next_waypoint()
    -- This function groups common operations, causing mobs to move in a specific direction
    -- It's not a behaviour in itself, but is used by some built-in high-level behaviours which use
    --      a node-by-node movement algorithm

    local height, waypoint_pos = unimobs.mobkit_api.get_next_waypoint(self, target_pos)
    if not height then
        return false
    end

    if height <= 0.01 then

        if unilib.global.pkg_executed_table["lqb_turn_to_pos"] ~= nil and
                unilib.global.pkg_executed_table["lqb_dumb_walk"] ~= nil then

            local yaw = self.object:get_yaw()
            local waypoint_yaw = core.dir_to_yaw(
                vector.direction(self.object:get_pos(), waypoint_pos)
            )

            if abs(waypoint_yaw - yaw) > 1 then
                unilib.pkg.lqb_turn_to_pos.add_to_queue(self, waypoint_pos)
            end

            unilib.pkg.lqb_dumb_walk.add_to_queue(self, waypoint_pos)

            return true

        end

    else

        if unilib.global.pkg_executed_table["lqb_turn_to_pos"] ~= nil and
                unilib.global.pkg_executed_table["lqb_dumb_jump"] ~= nil then

            unilib.pkg.lqb_turn_to_pos.add_to_queue(self, waypoint_pos)
            unilib.pkg.lqb_dumb_jump.add_to_queue(self, height)

            return true

        end

    end

    return false

end

function unimobs.mobkit_api.is_neighbour_node_reachable(self, neighbour_num)

    -- From mobkit/example_behaviors.lua, was mobkit.is_neighbor_node_reachable(), duplicated by
    --      kitz.is_neighbor_node_reachable()
    -- If the neighbouring node, whose index in "neighbour_list" is specified by "neighbour_num",
    --      is reachable, then return the values
    --          height, target_pos, liquid_flag
    -- ...otherwise return nil
    --
    -- Notes from original code:
    -- TODO: Take either number or pos
    --
    -- N.B. This function's behaviour differs when unimobs.setting.tweak_mobkit_engine_flag is set

    local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
    if not stand_pos then
        return
    end

    local offset = neighbour_list[neighbour_num]
    local target_pos = unimobs.mobkit_api.get_pos_of_node_centre(
        unimobs.mobkit_api.shift_pos_by_vector(stand_pos, offset)
    )

    -- N.B. Updated original code to allow mobs to pass through open gates. Note that both fences
    --      and gates have the "fence" group; ideally, I would like to check for a group that's
    --      unique to gates, but there isn't one
    local target_node = core.get_node(target_pos)
    if unimobs.setting.tweak_mobkit_engine_flag and
            not unimobs.petz_setting.enable_jump_over_fences_flag and
            unimobs.kitz_api.node_has_group(target_pos, "fence") and
            not string.find(target_node.name, "gate") then

        -- Don't jump fences
        return

    end

    local recursion_steps = ceil(self.jump_height) + 1
    local height, liquid_flag =
            unimobs.mobkit_api.get_walkable_terrain_height(target_pos, recursion_steps)

    if height and abs(height - stand_pos.y) <= self.jump_height then

        target_pos.y = height
        height = height - stand_pos.y

        -- Don't cut corners
        -- (Diagonal neighbours are even)
        if neighbour_num % 2 == 0 then

            -- Left neighbour never < 0
            local n2 = neighbour_num - 1
            offset = neighbour_list[n2]
            local t2 = unimobs.mobkit_api.get_pos_of_node_centre(
                    unimobs.mobkit_api.shift_pos_by_vector(stand_pos, offset)
            )
            local h2 = unimobs.mobkit_api.get_walkable_terrain_height(t2, recursion_steps)

            if h2 and h2 - stand_pos.y > 0.02 then
                return
            end

            -- Right neighbour
            n2 = (neighbour_num + 1) % 8
            offset = neighbour_list[n2]
            t2 = unimobs.mobkit_api.get_pos_of_node_centre(
                unimobs.mobkit_api.shift_pos_by_vector(stand_pos, offset)
            )
            h2 = unimobs.mobkit_api.get_walkable_terrain_height(t2, recursion_steps)

            if h2 and h2 - stand_pos.y > 0.02 then
                return
            end

        end

        -- Check headroom
        if not unimobs.setting.tweak_mobkit_engine_flag then

            local foot = unimobs.mobkit_api.get_pos_of_node_centre(stand_pos)
            local head = unimobs.mobkit_api.get_pos_of_node_centre(
                    vector.new(stand_pos.x, stand_pos.y + self.height, stand_pos.z)
            )
            local target_head = unimobs.mobkit_api.get_pos_of_node_centre(
                vector.new(target_pos.x, target_pos.y + self.height, target_pos.z)
            )
            local target_high = vector.new(
                target_head.x, max(target_head.y, head.y), target_head.z
            )

            -- Check that the mob's head is inside the node above, otherwise there's no point in
            --      checking for headroom
            if target_high.y > foot.y then

                local target_foot = unimobs.mobkit_api.get_pos_of_node_centre(target_pos)
                local low = vector.new(foot.x, target_foot.y + 1, foot.z)

                local node_table =
                        unimobs.mobkit_api.get_table_of_nodes_in_area(low, target_high, true)
                for _, node in pairs(node_table) do

                    if node.name == "ignore" or node.walkable then
                        return
                    end

                end

            end

        else

            -- Check that the mob's head is inside the node above, otherwise there's no point in
            --      checking for headroom
            if target_pos.y + self.height - stand_pos.y > 1 then

                local snpos = unimobs.mobkit_api.get_pos_of_node_centre(stand_pos)
                -- Current pos plus node up
                local pos1 = {x = stand_pos.x, y = snpos.y + 1, z = stand_pos.z}
                -- Target head pos
                local pos2 = {x = target_pos.x, y = target_pos.y + self.height, z = target_pos.z}

                local node_table = unimobs.mobkit_api.get_table_of_nodes_in_area(pos1, pos2 ,true)
                for this_pos, node in pairs(node_table) do

                    if snpos.x == this_pos.x and snpos.z == this_pos.z then

                        -- N.B. Updated original code to allow mobs to pass through open gates
                        if node.name == "ignore" or (
                            node.walkable and
                            unimobs.petz_setting.enable_pass_through_opening_flag and
                            not unimobs.kitz_api.node_has_group(this_pos, "door") and
                            not unimobs.kitz_api.node_has_group(this_pos, "fence")
                        ) then
                            return
                        end

                    else

                        -- N.B. Updated original code to allow mobs to pass through open gates
                        if node.name == "ignore" or (
                            node.walkable and
                            unimobs.petz_setting.enable_pass_through_opening_flag and
                            not unimobs.kitz_api.node_has_group(this_pos, "door") and
                            not unimobs.kitz_api.node_has_group(this_pos, "fence") and
                            unimobs.mobkit_api.get_node_height(this_pos) > (target_pos.y + 0.001)
                        ) then
                            return
                        end

                    end

                end

            end

        end

        return height, target_pos, liquid_flag

    else

        return

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (original to unimobs)
---------------------------------------------------------------------------------------------------

function unimobs.mobkit_api.apply_brain_death(self)

    -- Original to unimobs
    -- A mob becomes "brain dead" when its .brain_func property is set to an empty function
    -- That functionality is wrapped inside this new function for the sake of clarity

    self.brain_func = function(self) end

end

function unimobs.mobkit_api.is_behaviour_safe(self)

    -- Original to unimobs
    -- Because of changes to the engine, functions like self.object:get_yaw() and
    --      self.object:get_pos() can now return nil unexpectedly, if the specified mob has been
    --      removed from the world; this causes a number of crashes
    -- We already have unimobs.mobkit_api.does_object_exist() and
    --      unimobs.mobkit_api.is_object_alive(), both of which could be used to intercept such
    --      problems
    --
    -- This function is a stripped-down version of both of them, that should be called by every
    --      high-level and low-level behaviour package, before doing anything else. It can also be
    --      called by any meta-behaviour package which uses ObjectRef functions like :get_yaw(),
    --      :set_pos() and so on
    -- This function assumes that "self" is the mob's luaentity, and
    --      does not refer to an ObjectRef or to a player
    -- If calls to this function return false, the behaviour should terminate itself

    if not self.object or not self.object:get_yaw() then
        return false
    else
        return true
    end

end

function unimobs.mobkit_api.settings_get_float(arg)

    -- Duplicate of unimobs.mobkit_api.settings_get_float() (which may not be available, while
    --      unimobs is being loaded)
    -- Reads a floating-point value from settingtypes.txt, because apparently Minetest 5.7.0 is
    --      incapable of doing that, instead returning a string
    -- This functions returns a floating-point value if the setting exists, or nil if not

    local value = core.settings:get(arg)
    if value == nil then
        return value
    else
        return tonumber(value)
    end

end

function unimobs.mobkit_api.settings_get_int(arg)

    -- Duplicate of unimobs.mobkit_api.settings_get_int() (which may not be available, while unimobs
    --      is being loaded)
    -- Reads an integer from settingtypes.txt, because apparently Minetest 5.7.0 is incapable of
    --      doing that, instead returning a string
    -- This functions returns an integer if the setting exists, or nil if not

    local value = core.settings:get(arg)
    if value == nil then
        return value
    else
        return math.floor(tonumber(value))
    end

end

function unimobs.mobkit_api.sort_keys_by_values(t)

    -- Original to unimobs
    -- Returns a list of keys, sorted by value

    local return_list = {}

    for key in pairs(t) do
        table.insert(return_list, key)
    end

    table.sort(return_list, function(a, b)
        return t[a] < t[b]
    end)

    return return_list

end
