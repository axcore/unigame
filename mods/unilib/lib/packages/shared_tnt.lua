---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tnt
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_tnt = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

-- Loss probabilities array (one in X will be lost)
-- Retain the original nodes from default, in case its replace mode is "defer"
local loss_prob = {}
loss_prob["default:cobble"] = 3
loss_prob["unilib:stone_ordinary_cobble"] = 3
loss_prob["default:dirt"] = 4
loss_prob["unilib:dirt_ordinary"] = 4

local cid_data = {}
local generic_tnt_radius = tonumber(minetest.settings:get("tnt_radius") or 3)
-- Cached value, set by unilib.pkg.shared_tnt.register_tnt() and used by destroy()
local basic_flame_on_construct

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function rand_pos(center, pos, radius)

    -- Adapted from tnt/init.lua

    local def
    local reg_nodes = minetest.registered_nodes
    local i = 0
    repeat

        -- Give up and use the center if this takes too long
        if i > 4 then

            pos.x, pos.z = center.x, center.z
            break

        end

        pos.x = center.x + math.random(-radius, radius)
        pos.z = center.z + math.random(-radius, radius)
        def = reg_nodes[minetest.get_node(pos).name]
        i = i + 1

    until def and not def.walkable

end

local function eject_drops(drops, pos, radius)

    -- Adapted from tnt/init.lua

    local drop_pos = vector.new(pos)
    for _, item in pairs(drops) do

        local count = math.min(item:get_count(), item:get_stack_max())
        while count > 0 do

            local take = math.max(
                1,
                math.min(radius * radius, count, item:get_stack_max())
            )

            rand_pos(pos, drop_pos, radius)
            local dropitem = ItemStack(item)
            dropitem:set_count(take)
            local obj = minetest.add_item(drop_pos, dropitem)
            if obj then

                obj:get_luaentity().collect = true
                obj:set_acceleration({x = 0, y = -10, z = 0})
                obj:set_velocity({
                    x = math.random(-3, 3),
                    y = math.random(0, 10),
                    z = math.random(-3, 3)
                })

            end

            count = count - take

        end

    end

end

local function add_drop(drops, item)

    -- Adapted from tnt/init.lua

    item = ItemStack(item)
    local name = item:get_name()
    if loss_prob[name] ~= nil and math.random(1, loss_prob[name]) == 1 then
        return
    end

    local drop = drops[name]
    if drop == nil then
        drops[name] = item
    else
        drop:set_count(drop:get_count() + item:get_count())
    end

end

local function destroy(
    drops, npos, cid, c_air, c_fire, on_blast_queue, on_construct_queue, ignore_protection,
    ignore_on_blast, owner
)
    -- Adapted from tnt/init.lua

    if not ignore_protection and minetest.is_protected(npos, owner) then
        return cid
    end

    local def = cid_data[cid]

    if not def then

        return c_air

    elseif not ignore_on_blast and def.on_blast then

        on_blast_queue[#on_blast_queue + 1] = {
            pos = vector.new(npos),
            on_blast = def.on_blast
        }

        return cid

    elseif def.flammable then

        on_construct_queue[#on_construct_queue + 1] = {
            fn = basic_flame_on_construct,
            pos = vector.new(npos)
        }

        return c_fire

    else

        local node_drops = minetest.get_node_drops(def.name, "")
        for _, item in pairs(node_drops) do
            add_drop(drops, item)
        end

        return c_air

    end

end

local function calc_velocity(pos1, pos2, old_vel, power)

    -- Adapted from tnt/init.lua

    -- Avoid errors caused by a vector of zero length
    if vector.equals(pos1, pos2) then
        return old_vel
    end

    local vel = vector.direction(pos1, pos2)
    vel = vector.normalize(vel)
    vel = vector.multiply(vel, power)

    -- Divide by distance
    local dist = vector.distance(pos1, pos2)
    dist = math.max(dist, 1)
    vel = vector.divide(vel, dist)

    -- Add old velocity
    vel = vector.add(vel, old_vel)

    -- Randomise it a bit
    vel = vector.add(vel, {
        x = math.random() - 0.5,
        y = math.random() - 0.5,
        z = math.random() - 0.5,
    })

    -- Limit to terminal velocity
    dist = vector.length(vel)
    if dist > 250 then
        vel = vector.divide(vel, dist / 250)
    end

    return vel

end

local function entity_physics(pos, radius, drops)

    -- Adapted from tnt/init.lua

    local objs = minetest.get_objects_inside_radius(pos, radius)

    for _, obj in pairs(objs) do

        local obj_pos = obj:get_pos()
        local dist = math.max(1, vector.distance(pos, obj_pos))

        local damage = (4 / dist) * radius
        if obj:is_player() then

            local dir = vector.normalize(vector.subtract(obj_pos, pos))
            local moveoff = vector.multiply(dir, 2 / dist * radius)
            obj:add_velocity(moveoff)

            obj:set_hp(obj:get_hp() - damage)

        else

            local luaobj = obj:get_luaentity()

            -- Object might have disappeared somehow
            if luaobj then

                local do_damage = true
                local do_knockback = true
                local entity_drops = {}
                local objdef = minetest.registered_entities[luaobj.name]

                if objdef and objdef.on_blast then
                    do_damage, do_knockback, entity_drops = objdef.on_blast(luaobj, damage)
                end

                if do_knockback then

                    local obj_vel = obj:get_velocity()
                    obj:set_velocity(calc_velocity(pos, obj_pos, obj_vel, radius * 10))

                end

                if do_damage then

                    if not obj:get_armor_groups().immortal then

                        obj:punch(
                            obj,
                            1.0,
                            {
                                full_punch_interval = 1.0,
                                damage_groups = {fleshy = damage},
                            },
                            nil
                        )

                    end

                end

                for _, item in pairs(entity_drops) do
                    add_drop(drops, item)
                end

            end

        end

    end

end

local function add_effects(pos, radius, drops)

    -- Adapted from tnt/init.lua

    minetest.add_particle({
        acceleration = vector.new(),
        collisiondetection = false,
        expirationtime = 0.4,
        glow = 15,
        pos = pos,
        size = radius * 10,
        texture = "unilib_tnt_ordinary_boom.png",
        velocity = vector.new(),
        vertical = false,
    })

    minetest.add_particlespawner({
        amount = 64,
        time = 0.5,

        maxacc = vector.new(),
        minacc = vector.new(),
        maxexptime = 2.5,
        minexptime = 1,
        maxpos = vector.add(pos, radius / 2),
        minpos = vector.subtract(pos, radius / 2),
        maxsize = radius * 5,
        minsize = radius * 3,
        maxvel = {x = 10, y = 10, z = 10},
        minvel = {x = -10, y = -10, z = -10},
        texture = "unilib_tnt_ordinary_smoke.png",
    })

    -- We just dropped some items. Look at the items entities and pick one of them to use as texture
    local texture = "unilib_tnt_ordinary_blast.png"     -- Fallback texture
    local node
    local most = 0

    for name, stack in pairs(drops) do

        local count = stack:get_count()
        if count > most then

            most = count
            local def = minetest.registered_nodes[name]
            if def then
                node = { name = name }
            end

            if def and def.tiles and def.tiles[1] then
                texture = def.tiles[1]
            end

        end

    end

    minetest.add_particlespawner({
        amount = 64,
        time = 0.1,

        collisiondetection = true,
        maxacc = {x = 0, y = -10, z = 0},
        minacc = {x = 0, y = -10, z = 0},
        maxexptime = 2.0,
        minexptime = 0.8,
        maxpos = vector.add(pos, radius / 2),
        minpos = vector.subtract(pos, radius / 2),
        maxsize = radius,
        minsize = radius * 0.33,
        maxvel = {x = 3, y = 5,  z = 3},
        minvel = {x = -3, y = 0, z = -3},
        -- (Only as fallback for clients without support for `node` parameter)
        node = node,
        texture = texture,
    })

end

local function tnt_explode(pos, radius, ignore_protection, ignore_on_blast, owner, explode_center)

    -- Adapted from tnt/init.lua

    pos = vector.round(pos)
    -- Scan for adjacent TNT nodes first, and enlarge the explosion
    local vm1 = VoxelManip()
    local p1 = vector.subtract(pos, 2)
    local p2 = vector.add(pos, 2)
    local minp, maxp = vm1:read_from_map(p1, p2)
    local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
    local data = vm1:get_data()
    local count = 0
    local c_tnt
    local c_tnt_burning = minetest.get_content_id("unilib:tnt_ordinary_burning")
    local c_tnt_boom = minetest.get_content_id("unilib:tnt_ordinary_placeholder")
    local c_air = minetest.get_content_id("air")

    if unilib.enable_tnt_flag then
        c_tnt = minetest.get_content_id("unilib:tnt_ordinary")
    else
        c_tnt = c_tnt_burning   -- TNT is not registered if disabled
    end

    -- Make sure we still have explosion even when centre node isn't TNT related
    if explode_center then
        count = 1
    end

    for z = pos.z - 2, pos.z + 2 do

        for y = pos.y - 2, pos.y + 2 do

            local vi = a:index(pos.x - 2, y, z)
            for x = pos.x - 2, pos.x + 2 do

                local cid = data[vi]
                if cid == c_tnt or cid == c_tnt_boom or cid == c_tnt_burning then

                    count = count + 1
                    data[vi] = c_air

                end

                vi = vi + 1

            end

        end

    end

    vm1:set_data(data)
    vm1:write_to_map()

    -- Recalculate new radius
    radius = math.floor(radius * math.pow(count, 1/3))

    -- Perform the explosion
    local vm = VoxelManip()
    local pr = PseudoRandom(os.time())
    p1 = vector.subtract(pos, radius)
    p2 = vector.add(pos, radius)
    minp, maxp = vm:read_from_map(p1, p2)
    a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
    data = vm:get_data()

    local drops = {}
    local on_blast_queue = {}
    local on_construct_queue = {}
    -- N.B. The ultimate caller is unilib.pkg.shared_tnt.register_tnt(), called from a package like
    --      "tnt_ordinary", for which we assume "fire_ordinary" is a dependent package
    basic_flame_on_construct = minetest.registered_nodes["unilib:fire_ordinary"].on_construct

    local c_fire = minetest.get_content_id("unilib:fire_ordinary")
    for z = -radius, radius do

        for y = -radius, radius do

            local vi = a:index(pos.x + (-radius), pos.y + y, pos.z + z)
            for x = -radius, radius do

                local r = vector.length(vector.new(x, y, z))
                if (radius * radius) / (r * r) >= (pr:next(80, 125) / 100) then

                    local cid = data[vi]
                    local p = {x = pos.x + x, y = pos.y + y, z = pos.z + z}
                    if cid ~= c_air then

                        data[vi] = destroy(
                            drops, p, cid, c_air, c_fire, on_blast_queue, on_construct_queue,
                            ignore_protection, ignore_on_blast, owner
                        )

                    end

                end

                vi = vi + 1

            end

        end

    end

    vm:set_data(data)
    vm:write_to_map()
    vm:update_map()
    vm:update_liquids()

    -- call check_single_for_falling for everything within 1.5x blast radius
    for y = -radius * 1.5, radius * 1.5 do

        for z = -radius * 1.5, radius * 1.5 do

            for x = -radius * 1.5, radius * 1.5 do

                local rad = {x = x, y = y, z = z}
                local s = vector.add(pos, rad)
                local r = vector.length(rad)
                if r / radius < 1.4 then
                    minetest.check_single_for_falling(s)
                end

            end

        end

    end

    for _, queued_data in pairs(on_blast_queue) do

        local dist = math.max(1, vector.distance(queued_data.pos, pos))
        local intensity = (radius * radius) / (dist * dist)
        local node_drops = queued_data.on_blast(queued_data.pos, intensity)
        if node_drops then

            for _, item in pairs(node_drops) do
                add_drop(drops, item)
            end

        end

    end

    for _, queued_data in pairs(on_construct_queue) do
        queued_data.fn(queued_data.pos)
    end

    unilib.log(
        "action",
        "TNT owned by " .. owner .. " detonated at " .. minetest.pos_to_string(pos) ..
                " with radius " .. radius
    )

    return drops, radius

end

---------------------------------------------------------------------------------------------------
-- Shared functions (explosions)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_tnt.tnt_burn(pos, nodename)

    -- Adapted from tnt/init.lua
    -- Called on a timer to handle burning of an item like "unilib:tnt_gunpowder_burning"
    --
    -- Args:
    --      pos (table): Position of the burning item, e.g. {x = 1, y = 1, z = 1}
    --
    -- Optional args
    --      nodename (str or nil): The burning node, if "pos" does not correspond to it

    local name = nodename or minetest.get_node(pos).name
    local def = minetest.registered_nodes[name]

    if not def then

        return

    elseif def.on_ignite then

        def.on_ignite(pos)

    elseif minetest.get_item_group(name, "tnt") > 0 then

        minetest.swap_node(pos, {name = name .. "_burning"})
        minetest.sound_play("unilib_tnt_ignite", {pos = pos}, true)
        minetest.get_node_timer(pos):start(1)

    end

end

function unilib.pkg.shared_tnt.tnt_boom(pos, def_table)

    -- Adapted from tnt/init.lua
    -- Callback to handle a detonating item, e.g. "unilib:tnt_ordinary"
    --
    -- Args:
    --      pos (table): Position of the detonating item, e.g. {x = 1, y = 1, z = 1}
    --      def_table (table): The partial definition table for the detonator, supplied in the
    --          earlier call to unilib.pkg.shared_tnt.register_tnt()

    def_table = def_table or {}
    def_table.radius = def_table.radius or 1
    def_table.damage_radius = def_table.damage_radius or def_table.radius * 2
    local meta = minetest.get_meta(pos)
    local owner = meta:get_string("owner")
    if not def_table.explode_center and def_table.ignore_protection ~= true then
        minetest.set_node(pos, {name = "unilib:tnt_ordinary_placeholder"})
    end

    local sound = def_table.sound or "unilib_tnt_explode"
    minetest.sound_play(
        sound,
        {pos = pos, gain = 2.5, max_hear_distance = math.min(def_table.radius * 20, 128)},
        true
    )

    local drops, radius = tnt_explode(
        pos,
        def_table.radius,
        def_table.ignore_protection,
        def_table.ignore_on_blast,
        owner,
        def_table.explode_center
    )

    -- Append entity drops
    local damage_radius = (radius / math.max(1, def_table.radius)) * def_table.damage_radius
    entity_physics(pos, damage_radius, drops)
    if not def_table.disable_drops then
        eject_drops(drops, pos, radius)
    end

    add_effects(pos, radius, drops)
    unilib.log(
        "action",
        "A TNT explosion occurred at " .. minetest.pos_to_string(pos) .. " with radius " .. radius
    )

end

---------------------------------------------------------------------------------------------------
-- Shared functions (register TNT)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_tnt.register_tnt(data_table)

    -- Adapted from tnt/init.lua
    -- Creates two items - a TNT node, and its burning equivalent
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "ordinary"
    --      orig_name (list): e.g. {"tnt:tnt", "tnt:tnt_burning"}
    --      def_table (table): The partial definition table, the basis of two node registrations
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --
    -- Return values:
    --      The full_name of the new node

    -- (Keys in data_table)
    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local def_table = data_table.def_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode

    local full_name = "unilib:tnt_" .. part_name

    -- (Not keys in data_table)
    if not def_table.tiles then def_table.tiles = {} end

    local tnt_top = def_table.tiles.top or "unilib_tnt_" .. part_name .. "_top.png"
    local tnt_bottom = def_table.tiles.bottom or "unilib_tnt_" .. part_name .. "_bottom.png"
    local tnt_side = def_table.tiles.side or "unilib_tnt_" .. part_name .. "_side.png"
    local tnt_burning = def_table.tiles.burning or "unilib_tnt_" .. part_name ..
            "_top_burning_animated.png"

    if def_table.radius == nil then def_table.radius = generic_tnt_radius end
    if not def_table.damage_radius then def_table.damage_radius = def_table.radius * 2 end

    if unilib.enable_tnt_flag then

        local mesecon_group = nil
        local mesecon_table = nil
        -- (N.B. This check was not in the original code)
        if minetest.get_modpath("mesecons") then

            mesecon_group = 2
            mesecon_table = {effector =
                {action_on =
                    function(pos)
                        unilib.pkg.shared_tnt.tnt_boom(pos, def_table)
                    end
                }
            }

        end

        -- ("orig_name" should be a list containing both variants, the ordinary tnt node first,
        --      followed by the "burning" variety)
        unilib.register_node(full_name, orig_name, replace_mode, {
            description = def_table.description,
            tiles = {tnt_top, tnt_bottom, tnt_side},
            groups = {dig_immediate = 2, flammable = 5, mesecon = mesecon_group, tnt = 1},
            sounds = unilib.sound_table.wood,

            is_ground_content = false,
            mesecons = mesecon_table,

            after_place_node = function(pos, placer)

                if placer:is_player() then

                    local meta = minetest.get_meta(pos)
                    meta:set_string("owner", placer:get_player_name())

                end

            end,

            on_punch = function(pos, node, puncher)

                -- N.B. The ultimate caller is a package like "tnt_ordinary", for which we assume
                --  "torch_ordinary" is a dependent package
                if puncher:get_wielded_item():get_name() == "unilib:torch_ordinary" then

                    minetest.swap_node(pos, {name = full_name .. "_burning"})
                    minetest.registered_nodes[full_name .. "_burning"].on_construct(pos)
                    unilib.log(
                        "action",
                        puncher:get_player_name() .. " ignites " .. node.name .. " at " ..
                                minetest.pos_to_string(pos)
                    )

                end

            end,

            on_blast = function(pos, intensity)

                minetest.after(0.1, function()
                    unilib.pkg.shared_tnt.tnt_boom(pos, def_table)
                end)

            end,

            on_burn = function(pos)

                minetest.swap_node(pos, {name = full_name .. "_burning"})
                minetest.registered_nodes[full_name .. "_burning"].on_construct(pos)

            end,

            on_ignite = function(pos, igniter)

                minetest.swap_node(pos, {name = full_name .. "_burning"})
                minetest.registered_nodes[full_name .. "_burning"].on_construct(pos)

            end,
        })

    end

    unilib.register_node(full_name .. "_burning", nil, replace_mode, {
        -- (no description)
        tiles = {
            {
                name = tnt_burning,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1,
                }
            },
            tnt_bottom, tnt_side
        },
        groups = {falling_node = 1, not_in_creative_inventory = 1},
        sounds = unilib.sound_table.wood,

        drop = "",
        light_source = 5,

        on_construct = function(pos)

            minetest.sound_play("unilib_tnt_ignite", {pos = pos}, true)
            minetest.get_node_timer(pos):start(4)
            minetest.check_for_falling(pos)

        end,

        on_timer = function(pos, elapsed)
            unilib.pkg.shared_tnt.tnt_boom(pos, def_table)
        end,

        -- Unaffected by explosions
        on_blast = function() end,
    })

    return full_name

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_tnt.init()

    return {
        description = "Shared functions for TNT (from minetest_game/tnt)",
    }

end

function unilib.pkg.shared_tnt.exec()

    -- Adapted from tnt/init.lua

    -- Fill a list with data for content IDs, after all nodes have been registered
    for name, def in pairs(minetest.registered_nodes) do

        cid_data[minetest.get_content_id(name)] = {
            name = name,
            drops = def.drops,
            flammable = def.groups.flammable,
            on_blast = def.on_blast,
        }

    end

end
