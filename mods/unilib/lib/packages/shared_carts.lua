---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    carts
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_carts = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.carts.add_mode

-- Table set by calls to unilib.pkg.shared_carts.register_rail(), and retrieved in calls to
--      .get_railparams()
-- Table in the form
--      rail_param_table[full_name] = parameter_table
-- ...where "full_name" is the name of the rail node
local rail_param_table = {}
-- Maximal speed of the cart in m/s (min = -1)
local speed_max = 7
-- Set to -1 to disable punching the cart from inside (min = -1)
local punch_speed_max = 5
-- Maximal distance for the path correction (for dtime peaks)
local path_distance_max = 3
-- Shortcut to the Minetest vector metatable
local v3_len = vector.length

---------------------------------------------------------------------------------------------------
-- Local functions (from carts/functions.lua)
---------------------------------------------------------------------------------------------------

local function get_sign(z)

    -- Adapted from carts/functions.lua, was carts:get_sign()

    if z == 0 then
        return 0
    else
        return z / math.abs(z)
    end

end

local function manage_attachment(player, obj)

    -- Adapted from carts/functions.lua, was carts:manage_attachment()

    if not player then
        return
    end

    local status = obj ~= nil
    local player_name = player:get_player_name()
    if obj and player:get_attach() == obj then
        return
    end

    unilib.player_api.set_player_attached(player_name, status)

    if status then
        player:set_attach(obj, "", {x = 0, y = -4.5, z = 0}, {x = 0, y = 0, z = 0})
        player:set_eye_offset({x = 0, y = -4, z = 0},{x = 0, y = -4, z = 0})

        -- player_api does not update the animation
        -- When the player is attached, reset to default animation
        unilib.player_api.set_animation(player, "stand")

    else

        player:set_detach()
        player:set_eye_offset({x = 0, y = 0, z = 0},{x = 0, y = 0, z = 0})

    end

end

local function velocity_to_dir(v)

    -- Adapted from carts/functions.lua, was carts:velocity_to_dir()

    if math.abs(v.x) > math.abs(v.z) then
        return {x = get_sign(v.x), y = get_sign(v.y), z = 0}
    else
        return {x = 0, y = get_sign(v.y), z = get_sign(v.z)}
    end

end

local function is_rail(pos, railtype)

    -- Adapted from carts/functions.lua, was carts:is_rail()

    local node = core.get_node(pos).name
    if node == "ignore" then

        local vm = core.get_voxel_manip()
        local emin, emax = vm:read_from_map(pos, pos)
        local area = VoxelArea:new{
            MinEdge = emin,
            MaxEdge = emax,
        }

        local data = vm:get_data()
        local vi = area:indexp(pos)
        node = core.get_name_from_content_id(data[vi])

    end

    if core.get_item_group(node, "rail") == 0 then
        return false
    end

    if not railtype then
        return true
    end

    return core.get_item_group(node, "connect_to_raillike") == railtype

end

local function check_front_up_down(pos, dir_, check_up, railtype)

    -- Adapted from carts/functions.lua, was carts:check_front_up_down()

    local dir = vector.new(dir_)
    local cur

    -- Front
    dir.y = 0
    cur = vector.add(pos, dir)
    if is_rail(cur, railtype) then
        return dir
    end

    -- Up
    if check_up then
        dir.y = 1
        cur = vector.add(pos, dir)
        if is_rail(cur, railtype) then
            return dir
        end
    end

    -- Down
    dir.y = -1
    cur = vector.add(pos, dir)
    if is_rail(cur, railtype) then
        return dir
    end
    return nil

end

local function get_rail_direction(pos_, dir, ctrl, old_switch, railtype)

    -- Adapted from carts/functions.lua, was carts:get_rail_direction()

    local pos = vector.round(pos_)
    local cur
    local left_check, right_check = true, true

    -- Check left and right
    local left = {x = 0, y = 0, z = 0}
    local right = {x = 0, y = 0, z = 0}

    if dir.z ~= 0 and dir.x == 0 then

        left.x = -dir.z
        right.x = dir.z

    elseif dir.x ~= 0 and dir.z == 0 then

        left.z = dir.x
        right.z = -dir.x

    end

    local straight_priority = ctrl and dir.y ~= 0

    -- Normal, to disallow rail switching up- & downhill
    if straight_priority then
        cur = check_front_up_down(pos, dir, true, railtype)
        if cur then
            return cur
        end
    end

    if ctrl then

        if old_switch == 1 then
            left_check = false
        elseif old_switch == 2 then
            right_check = false
        end

        if ctrl.left and left_check then

            cur = check_front_up_down(pos, left, false, railtype)
            if cur then
                return cur, 1
            end
            left_check = false

        end

        if ctrl.right and right_check then

            cur = check_front_up_down(pos, right, false, railtype)
            if cur then
                return cur, 2
            end
            right_check = true

        end

    end

    -- Normal
    if not straight_priority then

        cur = check_front_up_down(pos, dir, true, railtype)
        if cur then
            return cur
        end

    end

    -- Left, if not already checked
    if left_check then

        cur = check_front_up_down(pos, left, false, railtype)
        if cur then
            return cur
        end

    end

    -- Right, if not already checked
    if right_check then

        cur = check_front_up_down(pos, right, false, railtype)
        if cur then
            return cur
        end

    end

    -- Backwards
    if not old_switch then

        cur = check_front_up_down(pos, {x = -dir.x, y = dir.y, z = -dir.z}, true, railtype)
        if cur then
            return cur
        end

    end

    return {x = 0, y = 0, z = 0}

end

local function pathfinder(pos_, old_pos, old_dir, distance, ctrl, pf_switch, railtype)

    -- Adapted from carts/functions.lua, was carts:pathfinder()

    local pos = vector.round(pos_)
    if vector.equals(old_pos, pos) then
        return
    end

    local pf_pos = vector.round(old_pos)
    local pf_dir = vector.new(old_dir)
    distance = math.min(path_distance_max, math.floor(distance + 1))

    for i = 1, distance do

        pf_dir, pf_switch = get_rail_direction(
            pf_pos,
            pf_dir,
            ctrl,
            pf_switch or 0, railtype
        )

        if vector.equals(pf_dir, {x = 0, y = 0, z = 0}) then

            -- No way forwards
            return pf_pos, pf_dir

        end

        pf_pos = vector.add(pf_pos, pf_dir)

        if vector.equals(pf_pos, pos) then

            -- Success! Cart moved on correctly
            return

        end

    end

    -- Not found. Put cart to predicted position
    return pf_pos, pf_dir

end

local function get_rail_groups(additional_groups)

    -- Adapted from carts/functions.lua, was carts:get_rail_groups()

    -- Get the default rail groups and add more when a table is given
    local groups = {
        dig_immediate = 2,
        attached_node = 1,
        rail = 1,
        connect_to_raillike = core.raillike_group("rail")
    }

    if type(additional_groups) == "table" then
        for k, v in pairs(additional_groups) do
            groups[k] = v
        end
    end

    return groups

end

---------------------------------------------------------------------------------------------------
-- Local functions (from carts/cart_entity.lua)
---------------------------------------------------------------------------------------------------

local function rail_on_step_event(handler, obj, dtime)

    -- Adapted from carts/cart_entity.lua, was rail_on_step_event()

    if handler then
        handler(obj, dtime)
    end

end

local function rail_sound(self, dtime)

    -- Adapted from carts/cart_entity.lua, was rail_sound()
    -- Sound refresh interval = 1.0sec

    if not self.sound_ttl then

        self.sound_ttl = 1.0
        return

    elseif self.sound_ttl > 0 then

        self.sound_ttl = self.sound_ttl - dtime
        return

    end

    self.sound_ttl = 1.0
    if self.sound_handle then

        local handle = self.sound_handle
        self.sound_handle = nil
        core.after(0.2, core.sound_stop, handle)

    end

    local vel = self.object:get_velocity()
    local speed = vector.length(vel)
    if speed > 0 then

        self.sound_handle = core.sound_play(
            "unilib_cart_moving",
            {
                object = self.object,
                gain = (speed / speed_max) / 2,
                loop = true,
            }
        )

    end

end

local function get_railparams(pos)

    -- Adapted from carts/cart_entity.lua, was get_railparams()

    local node = core.get_node(pos)
    return rail_param_table[node.name] or {}

end

local function rail_on_step(self, dtime)

    -- Adapted from carts/cart_entity.lua, was rail_on_step()

    local vel = self.object:get_velocity()
    if self.punched then

        vel = vector.add(vel, self.velocity)
        self.object:set_velocity(vel)
        self.old_dir.y = 0

    elseif vector.equals(vel, {x = 0, y = 0, z = 0}) then

        return

    end

    local pos = self.object:get_pos()
    local dir = velocity_to_dir(vel)
    local dir_changed = not vector.equals(dir, self.old_dir)
    local update = {}

    if self.old_pos and not self.punched and not dir_changed then

        local flo_pos = vector.round(pos)
        local flo_old = vector.round(self.old_pos)
        if vector.equals(flo_pos, flo_old) then

            -- Do not check one node multiple times
            return

        end

    end

    local ctrl, player

    -- Get player controls
    if self.driver then

        player = core.get_player_by_name(self.driver)
        if player then
            ctrl = player:get_player_control()
        end

    end

    local stop_wiggle = false
    if self.old_pos and not dir_changed then

        -- Detection for "skipping" nodes (perhaps use average dtime?)
        -- It's sophisticated enough to take the acceleration into account
        local acc = self.object:get_acceleration()
        local distance = dtime * (v3_len(vel) + 0.5 * dtime * v3_len(acc))

        local new_pos, new_dir = pathfinder(
            pos, self.old_pos, self.old_dir, distance, ctrl,
            self.old_switch, self.railtype
        )

        if new_pos then

            -- No rail found: set to the expected position
            pos = new_pos
            update.pos = true
            dir = new_dir

        end

    elseif self.old_pos and self.old_dir.y ~= 1 and not self.punched then

        -- Stop wiggle
        stop_wiggle = true

    end

    local railparams

    -- dir:         New moving direction of the cart
    -- switch_keys: Currently pressed L(1) or R(2) key, used to ignore the key on the next rail node
    local switch_keys
    dir, switch_keys = get_rail_direction(
        pos, dir, ctrl, self.old_switch, self.railtype
    )
    local dir_changed = not vector.equals(dir, self.old_dir)

    local acc = 0
    if stop_wiggle or vector.equals(dir, {x = 0, y = 0, z = 0}) then

        dir = vector.new(self.old_dir)
        vel = {x = 0, y = 0, z = 0}
        local pos_r = vector.round(pos)
        if not is_rail(pos_r, self.railtype) and self.old_pos then

            pos = self.old_pos

        elseif not stop_wiggle then

            -- End of rail; smooth out
            pos = pos_r
            dir_changed = false
            dir.y = 0

        else

            pos.y = math.floor(pos.y + 0.5)

        end

        update.pos = true
        update.vel = true

    else

        -- Direction change detected
        if dir_changed then

            vel = vector.multiply(dir, math.abs(vel.x + vel.z))
            update.vel = true
            if dir.y ~= self.old_dir.y then

                pos = vector.round(pos)
                update.pos = true

            end

        end

        -- Center on the rail
        if dir.z ~= 0 and math.floor(pos.x + 0.5) ~= pos.x then

            pos.x = math.floor(pos.x + 0.5)
            update.pos = true

        end

        if dir.x ~= 0 and math.floor(pos.z + 0.5) ~= pos.z then

            pos.z = math.floor(pos.z + 0.5)
            update.pos = true

        end

        -- Slow down or speed up...
        acc = dir.y * -4.0

        -- Get rail for corrected position
        railparams = get_railparams(pos)

        -- No need to check for railparams == nil since we always make it exist
        local speed_mod = railparams.acceleration
        if speed_mod and speed_mod ~= 0 then

            -- Try to make it similar to the original carts mod
            acc = acc + speed_mod

        else

            -- Handbrake or coast
            if ctrl and ctrl.down then
                acc = acc - 3
            else
                acc = acc - 0.4
            end

        end

    end

    -- Limit cart speed
    local vel_len = vector.length(vel)
    if vel_len > speed_max then

        vel = vector.multiply(vel, speed_max / vel_len)
        update.vel = true

    end

    if vel_len >= speed_max and acc > 0 then
        acc = 0
    end

    self.object:set_acceleration(vector.multiply(dir, acc))

    self.old_pos = vector.round(pos)
    self.old_dir = vector.new(dir)
    self.old_switch = switch_keys

    if self.punched then

        -- Collect dropped items
        for _, obj_ in pairs(core.get_objects_inside_radius(pos, 1)) do

            local ent = obj_:get_luaentity()
            -- Careful here: physical_state and disable_physics are item-internal APIs
            if ent and ent.name == "__builtin:item" and ent.physical_state then

                ent:disable_physics()
                obj_:set_attach(self.object, "", {x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
                self.attached_items[#self.attached_items + 1] = obj_

            end

        end

        self.punched = false
        update.vel = true

    end

    railparams = railparams or get_railparams(pos)

    if not (update.vel or update.pos) then

        rail_on_step_event(railparams.on_step, self, dtime)
        return

    end

    local yaw = 0
    if dir.x < 0 then
        yaw = 0.5
    elseif dir.x > 0 then
        yaw = 1.5
    elseif dir.z < 0 then
        yaw = 1
    end

    self.object:set_yaw(yaw * math.pi)

    local anim = {x = 0, y = 0}
    if dir.y == -1 then
        anim = {x = 1, y = 1}
    elseif dir.y == 1 then
        anim = {x = 2, y = 2}
    end

    self.object:set_animation(anim, 1, 0)

    if update.vel then
        self.object:set_velocity(vel)
    end

    if update.pos then

        if dir_changed then
            self.object:set_pos(pos)
        else
            self.object:move_to(pos)
        end

    end

    -- Call event handler
    rail_on_step_event(railparams.on_step, self, dtime)

end

---------------------------------------------------------------------------------------------------
-- Local functions (prepare the cart entity)
---------------------------------------------------------------------------------------------------

local function prepare_cart_entity(full_name, part_name)

    -- Adapted from carts/cart_entity.lua
    -- Returns an entity definition, ready for the call to unilib.register_entity()

    local def_table = {
        initial_properties = {
            collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            mesh = "unilib_cart.b3d",
            physical = false,               -- Otherwise going uphill breaks
            textures = {"unilib_cart_" .. part_name .. ".png"},
            visual = "mesh",
            visual_size = {x = 1, y = 1},
        },

        attached_items = {},
        driver = nil,
        old_dir = {x = 1, y = 0, z = 0},    -- Random value to start the cart on punch
        old_pos = nil,
        old_switch = 0,
        railtype = nil,
        punched = false,                    -- Used to re-send velocity and position
        velocity = {x = 0, y = 0, z = 0},   -- Only used on punch
    }

    function def_table:on_rightclick(clicker)

        -- Was cart_entity:on_rightclick()

        if not clicker or not clicker:is_player() then
            return
        end

        local player_name = clicker:get_player_name()
        if self.driver and player_name == self.driver then

            manage_attachment(clicker, nil)

        elseif not self.driver then

            manage_attachment(clicker, self.object)
            self.driver = player_name

        end

    end

    function def_table:on_activate(staticdata, dtime_s)

        -- Was cart_entity:on_activate()

        self.object:set_armor_groups({immortal = 1})
        if string.sub(staticdata, 1, string.len("return")) ~= "return" then
            return
        end

        local data = core.deserialize(staticdata)
        if type(data) ~= "table" then
            return
        end

        self.railtype = data.railtype
        self.old_dir = data.old_dir or self.old_dir

    end

    function def_table:get_staticdata()

        -- Was cart_entity:get_staticdata()

        return core.serialize({
            railtype = self.railtype,
            old_dir = self.old_dir
        })

    end

    function def_table:on_detach_child(child)

        -- Was cart_entity:on_detach_child()
        -- 0.5.x and later: When the driver leaves

        if child and child:get_player_name() == self.driver then

            -- Clean up eye height
            manage_attachment(child, nil)
            self.driver = nil

        end

    end

    function def_table:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)

        -- Was cart_entity:on_punch()

        local pos = self.object:get_pos()
        local vel = self.object:get_velocity()
        if not self.railtype or vector.equals(vel, {x = 0, y = 0, z = 0}) then

            local node = core.get_node(pos).name
            self.railtype = core.get_item_group(node, "connect_to_raillike")

        end

        -- Punched by non-player
        if not puncher or not puncher:is_player() then

            local cart_dir = get_rail_direction(pos, self.old_dir, nil, nil, self.railtype)
            if vector.equals(cart_dir, {x = 0, y = 0, z = 0}) then
                return
            end

            self.velocity = vector.multiply(cart_dir, 2)
            self.punched = true
            return

        end

        -- Player digs cart by sneak-punch
        if puncher:get_player_control().sneak then

            if self.sound_handle then
                core.sound_stop(self.sound_handle)
            end

            -- Detach driver and items
            if self.driver then

                if self.old_pos then
                    self.object:set_pos(self.old_pos)
                end

                local player = core.get_player_by_name(self.driver)
                manage_attachment(player, nil)

            end

            for _, obj_ in ipairs(self.attached_items) do

                if obj_ then
                    obj_:set_detach()
                end

            end

            -- Pick up cart
            local inv = puncher:get_inventory()
            if not unilib.utils.is_creative(puncher:get_player_name()) or
                    not inv:contains_item("main", full_name) then

                local leftover = inv:add_item("main", full_name)
                -- If no room in inventory add a replacement cart to the world
                if not leftover:is_empty() then
                    core.add_item(self.object:get_pos(), leftover)
                end

            end
            self.object:remove()
            return

        end

        -- Player punches cart to alter velocity
        if puncher:get_player_name() == self.driver then

            if math.abs(vel.x + vel.z) > punch_speed_max then
                return
            end

        end

        local punch_dir = velocity_to_dir(puncher:get_look_dir())
        punch_dir.y = 0
        local cart_dir = get_rail_direction(pos, punch_dir, nil, nil, self.railtype)
        if vector.equals(cart_dir, {x = 0, y = 0, z = 0}) then
            return
        end

        local punch_interval = 1
        -- Faulty tool registrations may cause the interval to be set to 0 !
        if tool_capabilities and (tool_capabilities.full_punch_interval or 0) > 0 then
            punch_interval = tool_capabilities.full_punch_interval
        end

        time_from_last_punch = math.min(time_from_last_punch or punch_interval, punch_interval)
        local f = 2 * (time_from_last_punch / punch_interval)

        self.velocity = vector.multiply(cart_dir, f)
        self.old_dir = cart_dir
        self.punched = true

    end

    function def_table:on_step(dtime)

        -- Was cart_entity:on_step()

        rail_on_step(self, dtime)
        rail_sound(self, dtime)

    end

    return def_table

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_carts.register_cart(data_table)

    -- Adapted from carts/cart_entity.lua
    -- Create a cart craftitem
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "ordinary"
    --      orig_name (str): e.g. "carts:cart"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Ordinary Cart"
    --      ingredient (str): unilib:metal_steel_ingot
    --
    -- Return values:
    --      The full_name of the new craftitem

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Cart")
    local ingredient = data_table.ingredient or ""

    local full_name = "unilib:cart_" .. part_name
    local entity_name = "unilib:entity_cart_" .. part_name

    -- Prepare the entity definition
    local def_table = prepare_cart_entity(full_name, part_name)
    -- Register the entity
    unilib.register_entity(entity_name, def_table)

    -- Register the craftitem
    unilib.register_craftitem(full_name, orig_name, replace_mode, {
        -- From carts:cart
        description = unilib.utils.hint(description, S("sneak + Click to pick up")),
        inventory_image = core.inventorycube(
            "unilib_cart_" .. part_name .. "_top.png",
            "unilib_cart_" .. part_name .. "_front.png",
            "unilib_cart_" .. part_name .. "_side.png"
        ),

        wield_image = "unilib_cart_" .. part_name .. "_front.png",

        on_place = function(itemstack, placer, pointed_thing)

            local under = pointed_thing.under
            local node = core.get_node(under)
            local udef = core.registered_nodes[node.name]
            if udef and udef.on_rightclick and not (
                placer and placer:is_player() and
                placer:get_player_control().sneak
            ) then

                return udef.on_rightclick(under, node, placer, itemstack, pointed_thing) or
                        itemstack

            end

            if pointed_thing.type ~= "node" then
                return
            end

            if is_rail(pointed_thing.under) then
                core.add_entity(pointed_thing.under, entity_name)
            elseif is_rail(pointed_thing.above) then
                core.add_entity(pointed_thing.above, entity_name)
            else
                return
            end

            core.sound_play(
                {name = "unilib_place_node_metal", gain = 0.5},
                {pos = pointed_thing.above},
                true
            )

            local player_name = placer and placer:get_player_name() or ""
            if not unilib.utils.is_creative(player_name) then
                itemstack:take_item()
            end

            return itemstack

        end,
    })
    unilib.register_craft({
        -- From carts:cart
        output = full_name,
        recipe = {
            {"", "", ""},
            {ingredient, "", ingredient},
            {ingredient, ingredient, ingredient},
        },
    })

    return full_name

end

function unilib.pkg.shared_carts.register_rail(data_table)

    -- Adapted from carts/cart_entity.lua, was carts:register_rail()
    -- Create a rail node for carts
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "ordinary"
    --      orig_name (str): e.g. "carts:rail"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      def_table (table): The partial definition table
    --      multiple (int): Number of rail nodes produced by the craft recipe, e.g. 18
    --      param_table (table): Extra parameters for this rail, e.g. {acceleration = -3}
    --      recipe_table (table): Craft recipe for this rail
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local def_table = data_table.def_table or {}
    local multiple = data_table.multiple or 18
    local param_table = data_table.param_table or {}
    local recipe_table = data_table.recipe_table or {}

    local full_name = "unilib:rail_" .. part_name

    local adj_def_table = {
        groups = get_rail_groups(),

        drawtype = "raillike",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
        },
        sounds = unilib.global.sound_table.metal,
        sunlight_propagates = true,
        walkable = false,
    }

    for k, v in pairs(def_table) do
        adj_def_table[k] = v
    end

    if not adj_def_table.inventory_image then

        adj_def_table.wield_image = adj_def_table.tiles[1]
        adj_def_table.inventory_image = adj_def_table.tiles[1]

    end

    if param_table then
        rail_param_table[full_name] = table.copy(param_table)
    end

    unilib.register_node(full_name, orig_name, replace_mode, adj_def_table)
    unilib.register_craft({
        output = full_name .. " " .. multiple,
        recipe = recipe_table,
    })

    return full_name

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_carts.init()

    return {
        description = "Shared functions for carts (from minetest_game/carts)",
    }

end
