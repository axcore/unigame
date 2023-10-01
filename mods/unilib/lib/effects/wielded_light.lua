---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- wielded_light.lua
--      Set up wielded light effects. Code adapted from the "wielded_light" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Meta-nodes created by this code are in the form "unilib:meta_light_XXX"
local meta_name = unilib.name .. ":meta_light_"

-- Node replacements that emit light. Table in the form
--      lighting_node_table[replacement_name] = mini_table
-- ...where "mini_table" is in the form { node = original_node, level = light_level }
local lighting_node_table = {}
-- Original nodes that can be replaced. Table in the form
--      lightable_node_table[original_name] = mini_list
-- ...where "mini_list" is a list of variants for each "original_name" node, one for each lighting
--      level (e.g. "unilib:meta_light_water_ordinary_1" to "unilib:meta_light_water_ordinary_14")
local lightable_node_table = {}
-- Node name components for checking duplicates (in the original code, described as "prefixes" (but
--      here found in the middle of a node name)
-- Table in the form
--      component_check_table[component] = original_name
-- e.g. "water_ordinary_" = "unilib:liquid_water_ordinary_source"
local component_check_table = {}
-- Original nodes that are liquids and which can flood some light sources. Table in the form
--      floodable_node_table[original_name] = true
local floodable_node_table = {}
-- Registered wielded lights. Table in the form
--      shining_node_table[item_name] = light_level
local shining_node_table = {}
-- Sets of known light sources and their levels by position. Table in the form
--      active_light_table[position] = mini_table
-- ...where "mini_table" is in the form {id = light_level}
local active_light_table = {}
-- Entities being tracked. Table in the form
--      tracked_entity_table[entity_id] = mini_table
-- ...where "mini_table" is in the form
--      {
--          obj = entity,
--          items = {
--              category_id..entity_id = {
--                  level = light_level,
--                  item? = item_name
--              },
--          },
--          update = true | false,
--          pos? = position_vector,
--          offset? = offset_vector,
--      }
local tracked_entity_table = {}
-- Positions that need to be recalculated on this update step. Table in the form
--      light_recalc_table[position] = true
local light_recalc_table = {}

-- Lists of custom callbacks for each update step
local update_callback_list = {}
local update_player_callback_list = {}

-- How often will the positions of lights be recalculated
local update_interval = 0.2
-- How long until a previously lit node should be updated (reduces flicker)
local removal_delay = update_interval * 0.5
-- How often a node will attempt to check itself for deletion
local cleanup_interval = update_interval * 3
-- How far in the future the position will be projected based on the velocity
local velocity_projection = update_interval * 1
-- How many light levels should an item held in the hand be reduced by, compared to the placed node
--      (does not apply to manually registered light levels)
local level_delta = 2

-- (Used in get_light_category_id() below)
-- Using 2-digit hex codes for categories
-- Starts at 00, ends at FF
-- This makes it easier extract "uid" from "cat_id..uid" by slicing off 2 characters
-- The category ID must be of a fixed length (2 characters)
local cat_id = 0
local cat_code_table = {}

-- (Used in global_timer_callback() below)
local timer = 0

-- (Used in track_user_entity() below)
-- A player's light should appear near their head, not their feet
local player_height_offset = {x = 0, y = 1, z = 0}

---------------------------------------------------------------------------------------------------
-- Local functions (local in original code)
---------------------------------------------------------------------------------------------------

local function get_light_category_id(cat)

    -- If the category id does not already exist, generate a new one

    if not cat_code_table[cat] then

        if cat_id >= 256 then

            unilib.show_error(
                "../lib/effects/wielded_light.lua, get_light_category_id(): Wielded light" ..
                        " category limit exceeded (maximum 256)"
            )

        end

        local code = string.format("%02x", cat_id)
        cat_id = cat_id + 1
        cat_code_table[cat] = code

    end

    -- If the category id does exist, return it
    return cat_code_table[cat]

end

local function is_lightable_liquid(pos)

    -- Is a node lightable and a liquid capable of flooding some light sources

    local node = minetest.get_node_or_nil(pos)
    if not node then
        return
    else
        return floodable_node_table[node.name]
    end

end

local function is_entity_valid(entity)

    -- Check if an entity instance still exists in the world

    return entity and (
        entity.obj:is_player() or
                (entity.obj:get_luaentity() and entity.obj:get_luaentity().name) or
                false
    )

end

local function is_wieldlight_node(pos_vec)

    -- Check whether a node was registered by the wield_light mod

    local name = string.sub(minetest.get_node(pos_vec).name, 1, #meta_name)
    return name == meta_name

end

local function entity_pos(obj, offset)

    -- Get the projected position of an entity based on its velocity, rounded to the nearest block

    local velocity
    if (minetest.features.direct_velocity_on_players or not obj:is_player()) and
            obj.get_velocity then
        velocity = obj:get_velocity()
    else
        velocity = obj:get_player_velocity()
    end

    return get_light_position(
        vector.round(
            vector.add(
                vector.add(
                    offset or {x = 0, y = 0, z = 0},
                    obj:get_pos()
                ),
                vector.multiply(
                    velocity or {x = 0, y = 0, z = 0},
                    velocity_projection
                )
            )
        )
    )

end

local function add_light(pos, id, light_level)

    -- Add light to active light list and mark position for update

    if not active_light_table[pos] then
        active_light_table[pos] = {}
    end

    if active_light_table[pos][id] ~= light_level then

        active_light_table[pos][id] = light_level
        light_recalc_table[pos] = true

    end

end

local function remove_light(pos, id)

    -- Remove light from active light list and mark position for update

    if not active_light_table[pos] then
        return
    end

    active_light_table[pos][id] = nil
    minetest.after(removal_delay, function ()
        light_recalc_table[pos] = true
    end)

end

local function update_entity(entity)

    -- Track an entity's position and update its light, will be called on every update step

    local pos = entity_pos(entity.obj, entity.offset)
    local pos_str = pos and minetest.pos_to_string(pos)

    -- If the position has changed, remove the old light and mark the entity for update
    if entity.pos and pos_str ~= entity.pos then

        entity.update = true
        for id,_ in pairs(entity.items) do
            remove_light(entity.pos, id)
        end

    end

    -- Update the recorded position
    entity.pos = pos_str

    -- If the position is still loaded, pump the timer up so it doesn't get removed
    if pos then

        -- If the entity is marked for an update, add the light in the position if it emits light
        if entity.update then

            for id, item in pairs(entity.items) do

                if item.level > 0 and not (item.floodable and is_lightable_liquid(pos)) then
                    add_light(pos_str, id, item.level)
                else
                    remove_light(pos_str, id)
                end

            end

        end

    end

    if active_light_table[pos_str] then

        if is_wieldlight_node(pos) then
            minetest.get_node_timer(pos):start(cleanup_interval)
        end

    end

    entity.update = false

end

local function save_timer(pos_vec)

    -- Save the original nodes timer if it has one

    local timer = minetest.get_node_timer(pos_vec)
    if timer:is_started() then

        local meta = minetest.get_meta(pos_vec)
        meta:set_float("saved_timer_timeout", timer:get_timeout())
        meta:set_float("saved_timer_elapsed", timer:get_elapsed())

    end

end

local function restore_timer(pos_vec)

    -- Restore the original nodes timer if it had one

    local meta = minetest.get_meta(pos_vec)
    local timeout = meta:get_float("saved_timer_timeout")
    if timeout > 0 then

        local elapsed = meta:get_float("saved_timer_elapsed")
        local timer = minetest.get_node_timer(pos_vec)
        timer:set(timeout, elapsed)
        meta:set_string("saved_timer_timeout", "")
        meta:set_string("saved_timer_elapsed", "")

    end

end

local function reset_lighting_node(pos)

    -- Replace a lighting node with its original counterpart
    local existing_node = minetest.get_node(pos)
    local lighting_node = get_lighting_node(existing_node.name)
    if not lighting_node then
        return
    end

    minetest.swap_node(pos, {name = lighting_node.node,param2 = existing_node.param2})
    restore_timer(pos)

end

local function cleanup_timer_callback(pos, elapsed)

    -- Will be run once the node timer expires

    local pos_str = minetest.pos_to_string(pos)
    local lights = active_light_table[pos_str]

    -- If no active lights for this position, remove itself
    if not lights then

        reset_lighting_node(pos)

    else

        -- Clean up any tracked entities for this position that no longer exist
        for id,_ in pairs(lights) do

            local uid = string.sub(id,3)
            local entity = tracked_entity_table[uid]
            if not is_entity_valid(entity) then
                remove_light(pos_str, id)
            end

        end

        minetest.get_node_timer(pos):start(cleanup_interval)

    end

end

local function recalc_light(pos)

    -- Recalculate the total light level for a given position and update the light level there

    -- If not in active lights list we can't do anything
    if not active_light_table[pos] then
        return
    end

    -- Calculate the light level of the node
    local any_light = false
    local max_light = 0
    for id, light_level in pairs(active_light_table[pos]) do

        any_light = true
        if light_level > max_light then
            max_light = light_level
        end

    end

    -- Convert the position back to a vector
    local pos_vec = minetest.string_to_pos(pos)

    -- If no items in this position, delete it from the list and remove any light node
    if not any_light then

        active_light_table[pos] = nil
        reset_lighting_node(pos_vec)
        return

    end

    -- If no light in this position remove any light node
    if max_light == 0 then

        reset_lighting_node(pos_vec)
        return

    end

    -- Limit the light level
    max_light = math.min(max_light, unilib.light_max)

    -- Get the current light level in this position
    local existing_node = minetest.get_node(pos_vec)
    local name = existing_node.name
    local old_value = level_of_lighting_node(name) or 0

    -- If the light level has changed, set the coresponding light node and initiate the cleanup
    --      timer
    if old_value ~= max_light then

        local node_name
        if lightable_node_table[name] then
            node_name = name
        elseif lighting_node_table[name] then
            node_name = lighting_node_table[name].node
        end

        if node_name then

            if not is_wieldlight_node(pos_vec) then
                save_timer(pos_vec)
            end

            minetest.swap_node(pos_vec, {
                name = lightable_node_table[node_name][max_light],
                param2 = existing_node.param2
            })
            minetest.get_node_timer(pos_vec):start(cleanup_interval)

        else

            active_light_table[pos] = nil

        end

    end

end

local function global_timer_callback(dtime)

    -- Will be run on every global step

    -- Only run once per update interval, global step will be called much more often than that
    timer = timer + dtime
    if timer < update_interval then
        return
    end

    timer = 0

    -- Run all custom player callbacks for each player
    local connected_players = minetest.get_connected_players()
    for _,callback in pairs(update_player_callback_list) do

        for _, player in pairs(connected_players) do
            callback(player)
        end

    end

    -- Run all custom callbacks
    for _,callback in pairs(update_callback_list) do
        callback()
    end

    -- Look at each tracked entity and update its position
    for uid, entity in pairs(tracked_entity_table) do

        if is_entity_valid(entity) then

            update_entity(entity)

        else

            -- If the entity no longer exists, stop tracking it
            tracked_entity_table[uid] = nil

        end

    end

    -- Recalculate light levels
    for pos,_ in pairs(light_recalc_table) do
        recalc_light(pos)
    end

    light_recalc_table = {}

end

---------------------------------------------------------------------------------------------------
-- Local functions (global in original code)
---------------------------------------------------------------------------------------------------

function register_lightstep(callback)

    -- Registers a callback to be called every time the update interval is passed

    table.insert(update_callback_list, callback)

end

function register_player_lightstep(callback)

    -- Registers a callback to be called for each player every time the update interval is passed
    table.insert(update_player_callback_list, callback)

end

function lighting_node_of_level(light_level, component)

    -- Returns the node name for a given light level

    -- Original code creates air variants called "unilib:1" to "unilib:14", and water variants
    --      called "unilib:water_ordinary_1", etc
    -- I don't like that, so do something different

    if component == "" then

        -- e.g. unilib:meta_light_air_1
        return meta_name .. "air_" .. light_level

    else

        -- e.g. unilib:meta_light_water_ordinary_1
        return meta_name .. component .. light_level

    end

end

function level_of_lighting_node(node_name)

    -- Gets the light level for a given node name, inverse of lighting_node_of_level()

    local lighting_node = get_lighting_node(node_name)
    if lighting_node then
        return lighting_node.level
    end

end

function get_lighting_node(node_name)

    -- Check if a node name is one of the wielded light nodes

    return lighting_node_table[node_name]

end

function is_lightable_node(node_pos)

    -- Check if node can have a wielded light node placed in it

    local name = minetest.get_node(node_pos).name
    if lightable_node_table[name] then
        return true
    elseif get_lighting_node(name) then
        return true
    end

    return false

end

function get_light_position(pos)

    -- Gets the closest position to pos that's a lightable node

    local around_vector = {
        {x = 0, y = 0, z = 0},
        {x = 0, y = 1, z = 0}, {x = 0, y = -1, z = 0},
        {x = 1, y = 0, z = 0}, {x = -1, y = 0, z = 0},
        {x = 0, y = 0, z = 1}, {x = 0, y = 0, z = -1},
    }

    for _, around in ipairs(around_vector) do

        local light_pos = vector.add(pos, around)
        if is_lightable_node(light_pos) then
            return light_pos
        end

    end

end

function get_light_def(item_name)

    -- Gets the emitted light level of a given item name

    -- Invalid item? No light
    if not item_name or item_name == "" then
        return 0, false
    end

    -- If the item is cached return the cached level
    local cached_definition = shining_node_table[item_name]
    if cached_definition then
        return cached_definition.level, cached_definition.floodable
    end

    -- Get the item definition
    local stack = ItemStack(item_name)
    local itemdef = stack:get_definition()

    -- If invalid, no light
    if not itemdef then
        return 0, false
    end

    -- Get the light level of an item from its definition
    -- Reduce the light level by level_delta - original functionality
    -- Limit between 0 and the max light level
    return math.min(
        math.max((itemdef.light_source or 0) - level_delta, 0),
        unilib.light_max
    ), itemdef.floodable

end

function register_item_floodable(item_name, floodable)

    -- Mark an item as floodable or not
    if floodable == nil then
        floodable = true
    end

    if shining_node_table[item_name] then

        shining_node_table[item_name].floodable = floodable

    else

        local calced_level = get_light_def(item_name)
        shining_node_table[item_name] = {
            level = calced_level,
            floodable = floodable
        }

    end

end

function track_item_entity(obj, cat, item)

    -- Keep track of an item entity. Should be called once for an item

    if not is_entity_valid({obj = obj}) then
        return
    end

    local light_level, light_is_floodable = get_light_def(item)
    -- If the item does not emit light, do not track it
    if light_level <= 0 then
        return
    end

    -- Generate the uid for the item and the id for the light category
    local uid = tostring(obj)
    local id = get_light_category_id(cat) .. uid

    -- Create the main tracking object for this item instance if it does not already exist
    if not tracked_entity_table[uid] then
        tracked_entity_table[uid] = {obj = obj, items = {}, update = true}
    end

    -- Create the item tracking object for this item + category
    tracked_entity_table[uid].items[id] = {level = light_level, floodable = light_is_floodable}

    -- Add the light in on creation so it's immediate
    local pos = entity_pos(obj)
    local pos_str = pos and minetest.pos_to_string(pos)
    if pos_str then

        if not (light_is_floodable and is_lightable_liquid(pos)) then
            add_light(pos_str, id, light_level)
        end

    end

    tracked_entity_table[uid].pos = pos_str

end

function track_user_entity(obj, cat, item)

    -- Keep track of a user / player entity. Should be called as often as the user updates

    -- Generate the uid for the player and the id for the light category
    local uid = tostring(obj)
    local id = get_light_category_id(cat) .. uid

    -- Create the main tracking object for this player instance if it does not already exist
    if not tracked_entity_table[uid] then

        tracked_entity_table[uid] = {
            obj = obj,
            items = {},
            offset = player_height_offset,
            update = true,
        }

    end

    local tracked_entity = tracked_entity_table[uid]
    local tracked_item = tracked_entity.items[id]

    -- If the item being tracked for the player changes, update the item tracking object for this
    --      item + category
    if not tracked_item or tracked_item.item ~= item then

        local light_level, light_is_floodable = get_light_def(item)
        tracked_entity.items[id] = {
            level = light_level,
            item = item,
            floodable = light_is_floodable
        }

        tracked_entity.update = true

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (API in original code)
---------------------------------------------------------------------------------------------------

function unilib.register_lightable_node(full_name, override_table, custom_component)

    -- Register any node as lightable, register all light level variations for it
    -- Can be called for air, different types of water, and so on
    -- By default, the setup code below calls this function for air and for all registered waters;
    --      but packages could call this function directly, if required

    -- Node name must be string
    if type(full_name) ~= "string" then

        unilib.show_error(
            string.format(
                "unilib.register_lightable_node(): You must provide a node name to be" ..
                        " registered as lightable, type \"%s\" given",
                type(full_name)
            )
        )

        return

    end

    -- Node must already be registered
    local orig_def_table = minetest.registered_nodes[full_name]
    if not orig_def_table then

        unilib.show_error(
            string.format(
                "unilib.register_lightable_node(): The node \"%s\" cannot be registered as" ..
                        " lightable because it does not exist",
                full_name
            )
        )

        return

    end

    -- Decide the component for the lighting node
    local component = custom_component or full_name:gsub(":", "_", 1, true) .. "_"
    if component_check_table[component] then

        unilib.show_error(
            string.format(
                "unilib.register_lightable_node(): The lighting component \"%s\" cannot be" ..
                        " used for \"%s\" as it is already used for \"%s\"",
                component,
                full_name,
                component_check_table[component]
            )
        )

        return

    end

    component_check_table[component] = full_name

    -- Default for property overrides
    if not override_table then
        override_table = {}
    end

    -- Copy the node definition and provide required settings for a lighting node
    local new_def_table = table.copy(orig_def_table)
    new_def_table.on_timer = cleanup_timer_callback
    new_def_table.paramtype = "light"
    new_def_table.mod_origin = unilib.name
    new_def_table.groups = new_def_table.groups or {}
    new_def_table.groups.not_in_creative_inventory = 1

    -- Make sure original node is dropped if a lit node is dug
    if not new_def_table.drop then
        new_def_table.drop = full_name
    end

    -- Allow any properties to be overridden on registration
    for prop, val in pairs(override_table) do
        new_def_table[prop] = val
    end

    -- If it's a liquid, we need to stop it flowing
    if new_def_table.groups.liquid then

        new_def_table.liquid_range = 0
        floodable_node_table[full_name] = true

    end

    -- Register the lighting nodes
    lightable_node_table[full_name] = {}
    for i = 1, unilib.light_max do

        local lighting_node_name = lighting_node_of_level(i, component)

        -- Index for quick finding later
        lightable_node_table[full_name][i] = lighting_node_name
        lighting_node_table[lighting_node_name] = {
            node = full_name,
            level = i
        }

        -- Copy the base definition and apply the light level
        local level_definition = table.copy(new_def_table)
        level_definition.light_source = i

        -- If it's a liquid, we need to stop it replacing itself with the original
        if level_definition.groups.liquid then

            level_definition.liquid_alternative_source = lighting_node_name
            level_definition.liquid_alternative_flowing = lighting_node_name

        end

        -- (No need to call unilib.register_node() in this case)
        minetest.register_node(lighting_node_name, level_definition)

    end

end

function unilib.register_item_light(item_name, light_level, floodable)

    -- Register an item as shining

    if shining_node_table[item_name] then

        if light_level then
            shining_node_table[item_name].level = light_level
        end
        if floodable ~= nil then
            shining_node_table[item_name].floodable = floodable
        end

    else

        if floodable == nil then

            local stack = ItemStack(item_name)
            local itemdef = stack:get_definition()
            floodable = itemdef.floodable

        end

        shining_node_table[item_name] = {
            level = light_level,
            floodable = floodable or false
        }

    end

end

---------------------------------------------------------------------------------------------------
-- Set up wielded light
---------------------------------------------------------------------------------------------------

if unilib.effects_wield_light_flag then

    -- Wielded item shining globalstep
    minetest.register_globalstep(global_timer_callback)

    -- Dropped item on_step override
    -- https://github.com/minetest/minetest/issues/6909
    local builtin_item = minetest.registered_entities["__builtin:item"]
    local item = {
        on_step = function(self, dtime, ...)

            builtin_item.on_step(self, dtime, ...)
            -- Register an item once for tracking. If it's already being tracked, exit
            if self.wielded_light then
                return
            end

            self.wielded_light = true
            local stack = ItemStack(self.itemstring)
            local item_name = stack:get_name()
            track_item_entity(self.object, "item", item_name)

        end
    }
    setmetatable(item, {__index = builtin_item})
    minetest.register_entity(":__builtin:item", item)

    -- Track a player's wielded item
    register_player_lightstep(function (player)
        track_user_entity(player, "wield", player:get_wielded_item():get_name())
    end)

    -- Register helper nodes (air, plus all water nodes)
    unilib.register_lightable_node("air", nil, "")
    for part_name, data_table in pairs (unilib.generic_liquid_table) do

        if data_table.water_flag then
            unilib.register_lightable_node(data_table.source_name, nil, part_name .. "_")
        end

    end

end
