---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- doors.lua
--      Set up shared functions for doors, trapdoors and fence gates
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (Use to retrieve the door/trapdoor mesh)
local registered_doors = {}
local registered_trapdoors = {}

-- (Table used to assist with door opening/closing)
local transform = {
    {
        {v = "_a", param2 = 3},
        {v = "_a", param2 = 0},
        {v = "_a", param2 = 1},
        {v = "_a", param2 = 2},
    },
    {
        {v = "_c", param2 = 1},
        {v = "_c", param2 = 2},
        {v = "_c", param2 = 3},
        {v = "_c", param2 = 0},
    },
    {
        {v = "_b", param2 = 1},
        {v = "_b", param2 = 2},
        {v = "_b", param2 = 3},
        {v = "_b", param2 = 0},
    },
    {
        {v = "_d", param2 = 3},
        {v = "_d", param2 = 0},
        {v = "_d", param2 = 1},
        {v = "_d", param2 = 2},
    },
}

-- (Used with fence gates)
local fence_collision_extra = minetest.settings:get_bool("enable_fence_tall") and 3/8 or 0

---------------------------------------------------------------------------------------------------
-- Register the "hidden" door
---------------------------------------------------------------------------------------------------

-- Adapated from doors/init.lua

-- This hidden node is placed on top of the door bottom, and prevents nodes from being placed in the
--      top half of the door
unilib.register_node(
    -- From doors:hidden
    "unilib:door_hidden",
    "doors:hidden",
    "add",          -- Add this node regardless of any original mods
    {
        description = S("Hidden Door Segment"),
        -- (no tiles)
        groups = {not_in_creative_inventory = 1},
        -- (no sounds)

        buildable_to = false,
        -- 1px block inside door hinge near node top
        collision_box = {
            type = "fixed",
            fixed = {-15/32, 13/32, -15/32, -13/32, 1/2, -13/32},
        },
        diggable = false,
        drawtype = "airlike",
        drop = "",
        floodable = false,
        inventory_image = "unilib_door_hidden_segment.png^unilib_invisible_node_overlay.png",
        paramtype = "light",
        paramtype2 = "facedir",
        pointable = false,
        sunlight_propagates = true,
        -- Has to be walkable for falling nodes to stop falling
        walkable = true,
        wield_image = "unilib_door_hidden_segment.png^unilib_invisible_node_overlay.png",

        on_blast = function() end,
    }
)

-- As the replace_mode just above is a literal "add", remove the equivalent mod from the original
--      node, if loaded
if minetest.registered_nodes["doors:hidden"] ~= nil then
    minetest.unregister_item("doors:hidden")
end

---------------------------------------------------------------------------------------------------
-- Register doors (Local functions)
---------------------------------------------------------------------------------------------------

local function replace_old_owner_information(pos)

    -- Adapated from doors/init.lua

    local meta = minetest.get_meta(pos)
    local owner = meta:get_string("doors_owner")

    if owner and owner ~= "" then

        meta:set_string("owner", owner)
        meta:set_string("doors_owner", "")

    end

end

local function door_toggle(pos, node, clicker)

    -- Adapated from doors/init.lua

    local meta = minetest.get_meta(pos)
    node = node or minetest.get_node(pos)
    local def = minetest.registered_nodes[node.name]
    local name = def.door.name

    local state = meta:get_string("state")
    if state == "" then

        -- Fix up lvm-placed right-hinged doors, default closed
        if node.name:sub(-2) == "_b" then
            state = 2
        else
            state = 0
        end

    else

        state = tonumber(state)

    end

    replace_old_owner_information(pos)

    if clicker and not default.can_interact_with_node(clicker, pos) then
        return false
    end

    -- Until Lua-5.2 we have no bitwise operators :(
    if state % 2 == 1 then
        state = state - 1
    else
        state = state + 1
    end

    local dir = node.param2

    -- It's possible param2 is messed up, so, validate before using the input data. This indicates
    ---     something may have rotated the door, even though that is not supported
    if not transform[state + 1] or not transform[state + 1][dir + 1] then
        return false
    end

    if state % 2 == 0 then

        minetest.sound_play(
            def.door.sounds[1],
            {pos = pos, gain = def.door.gains[1], max_hear_distance = 10},
            true
        )

    else

        minetest.sound_play(
            def.door.sounds[2],
            {pos = pos, gain = def.door.gains[2], max_hear_distance = 10},
            true
        )

    end

    minetest.swap_node(pos, {
        name = name .. transform[state + 1][dir+1].v,
        param2 = transform[state + 1][dir+1].param2
    })
    meta:set_int("state", state)

    return true

end

local function on_place_node(place_to, newnode, placer, oldnode, itemstack, pointed_thing)

    -- Adapated from doors/init.lua

    -- Run script hook
    for _, callback in ipairs(minetest.registered_on_placenodes) do

        -- Deepcopy pos, node and pointed_thing because callback can modify them
        local place_to_copy = {x = place_to.x, y = place_to.y, z = place_to.z}
        local newnode_copy = {name = newnode.name, param1 = newnode.param1, param2 = newnode.param2}
        local oldnode_copy = {name = oldnode.name, param1 = oldnode.param1, param2 = oldnode.param2}
        local pointed_thing_copy = {
            type = pointed_thing.type,
            above = vector.new(pointed_thing.above),
            under = vector.new(pointed_thing.under),
            ref = pointed_thing.ref,
        }
        callback(place_to_copy, newnode_copy, placer, oldnode_copy, itemstack, pointed_thing_copy)

    end

end

local function can_dig_door(pos, digger)

    -- Adapated from doors/init.lua

    replace_old_owner_information(pos)
    return default.can_interact_with_node(digger, pos)

end

---------------------------------------------------------------------------------------------------
-- Register doors (shared functions)
---------------------------------------------------------------------------------------------------

function unilib.get_door(pos)

    -- Adapated from doors/init.lua
    -- Returns an object to a door object or nil

    local node_name = minetest.get_node(pos).name

    if registered_doors[node_name] then

        -- A normal upright door
        return {
            pos = pos,

            open = function(self, player)

                if self:state() then
                    return false
                end
                return doors.door_toggle(self.pos, nil, player)

            end,

            close = function(self, player)

                if not self:state() then
                    return false
                end
                return doors.door_toggle(self.pos, nil, player)

            end,

            toggle = function(self, player)
                return doors.door_toggle(self.pos, nil, player)
            end,

            state = function(self)

                local state = minetest.get_meta(self.pos):get_int("state")
                return state %2 == 1

            end
        }

    elseif registered_trapdoors[node_name] then

        -- A trapdoor
        return {
            pos = pos,

            open = function(self, player)

                if self:state() then
                    return false
                end
                return doors.trapdoor_toggle(self.pos, nil, player)

            end,

            close = function(self, player)

                if not self:state() then
                    return false
                end
                return doors.trapdoor_toggle(self.pos, nil, player)

            end,

            toggle = function(self, player)
                return doors.trapdoor_toggle(self.pos, nil, player)
            end,

            state = function(self)
                return minetest.get_node(self.pos).name:sub(-5) == "_open"
            end
        }

    else

        return nil

    end

end

function unilib.register_door(data_table)

    -- Adapated from doors/init.lua
    -- Creates a door node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "wood_ordinary"
    --      orig_name (str or list): e.g. {"doors:door_wood_a", ...}
    --      def_table (table): The partial definition table
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      orig_craftitem_name (str): "doors:door_wood"

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local def_table = data_table.def_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local orig_craftitem_name = data_table.orig_craftitem_name or nil

    local full_name = "unilib:door_" .. part_name

    -- Define the craftitem
    unilib.register_craftitem(full_name, orig_craftitem_name, replace_mode, {
        description = def_table.description,
        inventory_image = def_table.inventory_image,
        groups = table.copy(def_table.groups),

        on_place = function(itemstack, placer, pointed_thing)

            local pos

            if not pointed_thing.type == "node" then
                return itemstack
            end

            local node = minetest.get_node(pointed_thing.under)
            local pdef = minetest.registered_nodes[node.name]
            if pdef and pdef.on_rightclick and not (
                placer and
                placer:is_player() and
                placer:get_player_control().sneak
            ) then

                return pdef.on_rightclick(
                    pointed_thing.under, node, placer, itemstack, pointed_thing
                )

            end

            if pdef and pdef.buildable_to then

                pos = pointed_thing.under

            else

                pos = pointed_thing.above
                node = minetest.get_node(pos)
                pdef = minetest.registered_nodes[node.name]
                if not pdef or not pdef.buildable_to then
                    return itemstack
                end

            end

            local above = {x = pos.x, y = pos.y + 1, z = pos.z}
            local top_node = minetest.get_node_or_nil(above)
            local topdef = top_node and minetest.registered_nodes[top_node.name]

            if not topdef or not topdef.buildable_to then
                return itemstack
            end

            local pn = placer and placer:get_player_name() or ""
            if minetest.is_protected(pos, pn) or minetest.is_protected(above, pn) then
                return itemstack
            end

            local dir = placer and minetest.dir_to_facedir(placer:get_look_dir()) or 0

            local ref = {
                {x = -1, y = 0, z = 0},
                {x = 0, y = 0, z = 1},
                {x = 1, y = 0, z = 0},
                {x = 0, y = 0, z = -1},
            }

            local aside = {
                x = pos.x + ref[dir + 1].x,
                y = pos.y + ref[dir + 1].y,
                z = pos.z + ref[dir + 1].z,
            }

            local state = 0
            if minetest.get_item_group(minetest.get_node(aside).name, "door") == 1 then

                state = state + 2
                minetest.set_node(pos, {name = full_name .. "_b", param2 = dir})
                minetest.set_node(above, {name = "unilib:door_hidden", param2 = (dir + 3) % 4})

            else

                minetest.set_node(pos, {name = full_name .. "_a", param2 = dir})
                minetest.set_node(above, {name = "unilib:door_hidden", param2 = dir})

            end

            local meta = minetest.get_meta(pos)
            meta:set_int("state", state)

            if def_table.protected_flag then

                meta:set_string("owner", pn)
                meta:set_string("infotext", def_table.description .. "\n" .. S("Owned by @1", pn))

            end

            if not unilib.is_creative(pn) then
                itemstack:take_item()
            end

            minetest.sound_play(def_table.sounds.place, {pos = pos}, true)

            on_place_node(pos, minetest.get_node(pos), placer, node, itemstack, pointed_thing)

            return itemstack

        end
    })

    -- Set up the node definition
    def_table.inventory_image = nil

    if def_table.recipe then

        unilib.register_craft({
            output = full_name,
            recipe = def_table.recipe,
        })

    end

    def_table.recipe = nil

    if not def_table.sounds then
        def_table.sounds = unilib.sound_table.wood
    end

    if not def_table.sound_open then
        def_table.sound_open = "unilib_door_open"
    end

    if not def_table.sound_close then
        def_table.sound_close = "unilib_door_close"
    end

    if not def_table.gain_open then
        def_table.gain_open = 0.3
    end

    if not def_table.gain_close then
        def_table.gain_close = 0.3
    end

    def_table.groups.not_in_creative_inventory = 1
    def_table.groups.door = 1
    def_table.drop = full_name
    def_table.door = {
        name = full_name,
        sounds = {def_table.sound_close, def_table.sound_open},
        gains = {def_table.gain_close, def_table.gain_open},
    }

    if not def_table.on_rightclick then

        def_table.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            doors.door_toggle(pos, node, clicker)
            return itemstack

        end

    end

    def_table.after_dig_node = function(pos, node, meta, digger)

        minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
        minetest.check_for_falling({x = pos.x, y = pos.y + 1, z = pos.z})

    end

    def_table.on_rotate = function(pos, node, user, mode, new_param2)
        return false
    end

    if def_table.protected_flag then

        def_table.can_dig = can_dig_door
        def_table.on_blast = function() end

        def_table.on_key_use = function(pos, player)

            local door = unilib.get_door(pos)
            door:toggle(player)

        end

        def_table.on_skeleton_key_use = function(pos, player, newsecret)

            replace_old_owner_information(pos)
            local meta = minetest.get_meta(pos)
            local owner = meta:get_string("owner")
            local pname = player:get_player_name()

            -- Verify placer is owner of lockable door
            if owner ~= pname then

                minetest.record_protection_violation(pos, pname)
                minetest.chat_send_player(pname, S("You do not own this locked door"))
                return nil

            end

            local secret = meta:get_string("key_lock_secret")
            if secret == "" then

                secret = newsecret
                meta:set_string("key_lock_secret", secret)

            end

            return secret, S("a locked door"), owner

        end

        def_table.node_dig_prediction = ""

    else

        def_table.on_blast = function(pos, intensity)

            minetest.remove_node(pos)
            -- Hidden node doesn't get blasted away.
            minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
            return {full_name}

        end

    end

    def_table.on_destruct = function(pos)
        minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
    end

    def_table.buildable_to = false
    def_table.collision_box = {type = "fixed", fixed = {-1/2, -1/2, -1/2, 1/2, 3/2, -6/16}}
    def_table.drawtype = "mesh"
    def_table.is_ground_content = false
    def_table.paramtype = "light"
    def_table.paramtype2 = "facedir"
    def_table.selection_box = {type = "fixed", fixed = {-1/2, -1/2, -1/2, 1/2, 3/2, -6/16}}
    def_table.sunlight_propagates = true
    def_table.use_texture_alpha = "clip"
    def_table.walkable = true

    -- Make the door mesecon-compatible, if required
    -- Code block adpated from mesecons/mesecons_doors/init.lua
    if unilib.mesecons_door_flag and minetest.get_modpath("mesecons") then

        def_table.mesecons = {
            effector = {
                action_on = function(pos, node)

                    local door = unilib.get_door(pos)
                    if door then
                        door:open()
                    end

                end,

                action_off = function(pos, node)

                    local door = unilib.get_door(pos)
                    if door then
                        door:close()
                    end
                end,

                rules = mesecon.rules.pplate,
            }
        }

    end

    -- Register the nodes
    -- ("orig_name" should be a list containing all four variants, the "_a" variant first)
    def_table.mesh = "unilib_door_a.obj"
    unilib.register_node(full_name .. "_a", orig_name, replace_mode, def_table)

    def_table.mesh = "unilib_door_b.obj"
    unilib.register_node(full_name .. "_b", nil, replace_mode, def_table)

    def_table.mesh = "unilib_door_a2.obj"
    unilib.register_node(full_name .. "_c", nil, replace_mode, def_table)

    def_table.mesh = "unilib_door_b2.obj"
    unilib.register_node(full_name .. "_d", nil, replace_mode, def_table)

    registered_doors[full_name .. "_a"] = true
    registered_doors[full_name .. "_b"] = true
    registered_doors[full_name .. "_c"] = true
    registered_doors[full_name .. "_d"] = true

end

---------------------------------------------------------------------------------------------------
-- Register trapdoors (Local functions)
---------------------------------------------------------------------------------------------------

local function trapdoor_toggle(pos, node, clicker)

    -- Adapated from doors/init.lua

    node = node or minetest.get_node(pos)

    replace_old_owner_information(pos)

    if clicker and not unilib.can_interact_with_node(clicker, pos) then
        return false
    end

    local def = minetest.registered_nodes[node.name]

    if string.sub(node.name, -5) == "_open" then

        minetest.sound_play(
            def.sound_close,
            {pos = pos, gain = def.gain_close, max_hear_distance = 10},
            true
        )

        minetest.swap_node(pos, {
            name = string.sub(node.name, 1, string.len(node.name) - 5),
            param1 = node.param1,
            param2 = node.param2
        })

    else

        minetest.sound_play(
            def.sound_open,
            {pos = pos, gain = def.gain_open, max_hear_distance = 10},
            true
        )

        minetest.swap_node(pos, {
            name = node.name .. "_open",
            param1 = node.param1,
            param2 = node.param2
        })

    end

end

---------------------------------------------------------------------------------------------------
-- Register trapdoors (shared functions)
---------------------------------------------------------------------------------------------------

function unilib.register_trapdoor(data_table)

    -- Adapated from doors/init.lua
    -- Creates a trapdoor node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "wood_ordinary"
    --      orig_name (str or list): e.g. {"doors:trapdoor", "doors:trapdoor_open"}
    --      def_table (table): The partial definition table
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local def_table = data_table.def_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode

    local full_name = "unilib:trapdoor_" .. part_name
    local closed_name = full_name
    local open_name = full_name .. "_open"

    def_table.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

        trapdoor_toggle(pos, node, clicker)
        return itemstack

    end

    -- Common trapdoor configuration
    def_table.drawtype = "nodebox"
    def_table.is_ground_content = false
    def_table.paramtype = "light"
    def_table.paramtype2 = "facedir"
    def_table.use_texture_alpha = "clip"

    if def_table.protected_flag then

        def_table.can_dig = can_dig_door

        def_table.after_place_node = function(pos, placer, itemstack, pointed_thing)

            local pn = placer:get_player_name()
            local meta = minetest.get_meta(pos)
            meta:set_string("owner", pn)
            meta:set_string("infotext", def_table.description .. "\n" .. S("Owned by @1", pn))

            return unilib.is_creative(pn)

        end

        def_table.on_blast = function() end

        def_table.on_key_use = function(pos, player)

            local door = unilib.get_door(pos)
            door:toggle(player)

        end

        def_table.on_skeleton_key_use = function(pos, player, newsecret)

            replace_old_owner_information(pos)
            local meta = minetest.get_meta(pos)
            local owner = meta:get_string("owner")
            local pname = player:get_player_name()

            -- Verify placer is owner of lockable door
            if owner ~= pname then

                minetest.record_protection_violation(pos, pname)
                minetest.chat_send_player(pname, S("You do not own this locked trapdoor"))
                return nil

            end

            local secret = meta:get_string("key_lock_secret")
            if secret == "" then

                secret = newsecret
                meta:set_string("key_lock_secret", secret)

            end

            return secret, S("a locked trapdoor"), owner

        end

        def_table.node_dig_prediction = ""

    else

        def_table.on_blast = function(pos, intensity)

            minetest.remove_node(pos)
            return {full_name}

        end

    end

    if not def_table.sounds then
        def_table.sounds = unilib.sound_table.wood
    end

    if not def_table.sound_open then
        def_table.sound_open = "unilib_door_open"
    end

    if not def_table.sound_close then
        def_table.sound_close = "unilib_door_close"
    end

    if not def_table.gain_open then
        def_table.gain_open = 0.3
    end

    if not def_table.gain_close then
        def_table.gain_close = 0.3
    end

    -- Make the trapdoor mesecon-compatible, if required
    -- Code block adpated from mesecons/mesecons_doors/init.lua
    if unilib.mesecons_trapdoor_flag and minetest.get_modpath("mesecons") then

        def_table.mesecons = {
            effector = {
                action_on = function(pos, node)

                    local door = unilib.get_door(pos)
                    if door then
                        door:open()
                    end

                end,

                action_off = function(pos, node)

                    local door = unilib.get_door(pos)
                    if door then
                        door:close()
                    end
                end,
            }
        }

    end

    -- Open/closed trapdoor configuration
    local open_table = table.copy(def_table)
    local closed_table = table.copy(def_table)

    closed_table.node_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -6/16, 0.5}
    }
    closed_table.selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -6/16, 0.5}
    }
    closed_table.tiles = {
        def_table.tile_front,
        def_table.tile_front .. '^[transformFY',
        def_table.tile_side,
        def_table.tile_side,
        def_table.tile_side,
        def_table.tile_side
    }

    open_table.node_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, 6/16, 0.5, 0.5, 0.5}
    }
    open_table.selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, 6/16, 0.5, 0.5, 0.5}
    }
    open_table.tiles = {
        def_table.tile_side,
        def_table.tile_side .. '^[transform2',
        def_table.tile_side .. '^[transform3',
        def_table.tile_side .. '^[transform1',
        def_table.tile_front .. '^[transform46',
        def_table.tile_front .. '^[transform6'
    }

    open_table.drop = closed_name
    open_table.groups.not_in_creative_inventory = 1

    -- ("orig_name" should be a list containing both variants, the "closed" variant first)
    unilib.register_node(open_name, orig_name, replace_mode, open_table)
    unilib.register_node(closed_name, nil, replace_mode, closed_table)

    registered_trapdoors[open_name] = true
    registered_trapdoors[closed_name] = true

end

---------------------------------------------------------------------------------------------------
-- Register (fence) gates
---------------------------------------------------------------------------------------------------

function unilib.register_gate(data_table)

    -- Adapated from doors/init.lua
    -- Creates a fence gate for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- This function expects a partial definition table as an argument, set up as if it were to be
    --      used in a call to unilib.register_node()
    -- However, only a few of its fields are used in the actual definition table passed to
    --      unilib.register_node(); any other fields are ignored:
    --          .description
    --          .texture (a pseudo-field whose value is used as the .tiles field, after some
    --              adjustments in this function)
    --          .groups
    --          .sounds
    --          .ingredient (a pseudo-field whose value is used to set the craft recipe)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
    --      orig_name (list):
    --          e.g. {"doors:gate_aspen_wood_closed", "doors:gate_aspen_wood_open"}
    --      def_table (table): The definition table described above
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local def_table = data_table.def_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode

    local full_name = "unilib:gate_" .. part_name

    local adj_def_table = {
        description = def_table.description,
        tiles = {},
        groups = def_table.groups,
        sounds = def_table.sounds,

        connect_sides = {"left", "right"},
        drawtype = "mesh",
        drop = full_name .. "_closed",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-1/2, -1/2, -1/4, 1/2, 1/2, 1/4}
        },
        sunlight_propagates = true,

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            local node_def = minetest.registered_nodes[node.name]
            minetest.swap_node(pos, {name = node_def._gate, param2 = node.param2})
            minetest.sound_play(
                node_def._gate_sound,
                {pos = pos, gain = 0.15, max_hear_distance = 8},
                true
            )

            return itemstack

        end,
    }

    if type(def_table.texture) == "string" then

        adj_def_table.tiles[1] = {name = def_table.texture, backface_culling = true}

    elseif def_table.texture.backface_culling == nil then

        adj_def_table.tiles[1] = table.copy(def_table.texture)
        adj_def_table.tiles[1].backface_culling = true

    else

        fence_def_table.tiles[1] = def_table.texture

    end

    if not adj_def_table.sounds then
        adj_def_table.sounds = unilib.sound_table.wood
    end

    adj_def_table.groups.fence = 1

    local fence_closed_table = table.copy(adj_def_table)
    fence_closed_table.mesh = "unilib_gate_closed.obj"
    fence_closed_table._gate = full_name .. "_open"
    fence_closed_table._gate_sound = "unilib_gate_open"
    fence_closed_table.collision_box = {
        type = "fixed",
        fixed = {-1/2, -1/2, -1/8, 1/2, 1/2 + fence_collision_extra, 1/8}
    }

    local fence_open_table = table.copy(adj_def_table)
    fence_open_table.mesh = "unilib_gate_open.obj"
    fence_open_table._gate = full_name .. "_closed"
    fence_open_table._gate_sound = "unilib_gate_close"
    fence_open_table.groups.not_in_creative_inventory = 1
    fence_open_table.collision_box = {
        type = "fixed",
        fixed = {
            {-1/2, -1/2, -1/8, -3/8, 1/2 + fence_collision_extra, 1/8},
            {-1/2, -3/8, -1/2, -3/8, 3/8, 0}
        }
    }

    -- ("orig_name" should be a list containing both variants, the "closed" variant first)
    unilib.register_node(full_name .. "_closed", orig_name, replace_mode, fence_closed_table)
    unilib.register_node(full_name .. "_open", nil, replace_mode, fence_open_table)

    unilib.register_craft({
        output = full_name .. "_closed",
        recipe = {
            {"group:stick", def_table.ingredient, "group:stick"},
            {"group:stick", def_table.ingredient, "group:stick"}
        }
    })

end
