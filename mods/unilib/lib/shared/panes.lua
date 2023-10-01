---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- panes.lua
--      Set up shared functions for panes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function is_pane(pos)

    -- Adapated from xpanes/init.lua

    if not unilib.use_unipanes_flag then
        return minetest.get_item_group(minetest.get_node(pos).name, "pane") > 0
    else
        return minetest.get_item_group(minetest.get_node(pos).name, "unipane") > 0
    end

end

local function connects_dir(pos, base_name, dir)

    -- Adapated from xpanes/init.lua

    local aside = vector.add(pos, minetest.facedir_to_dir(dir))
    if is_pane(aside) then
        return true
    end

    local connects_to = minetest.registered_nodes[base_name .. "_crossed"].connects_to
    if not connects_to then
        return false
    end

    local list = minetest.find_nodes_in_area(aside, aside, connects_to)
    if #list > 0 then
        return true
    end

    return false

end

local function swap(pos, node, name, param2)

    -- Adapated from xpanes/init.lua

    if node.name == name and node.param2 == param2 then
        return
    end

    minetest.swap_node(pos, {name = name, param2 = param2})

end

---------------------------------------------------------------------------------------------------
-- Register placing/digging panes
---------------------------------------------------------------------------------------------------

minetest.register_on_placenode(function(pos, node)

    if minetest.get_item_group(node, "pane") or minetest.get_item_group(node, "unipane") then
        unilib.update_pane(pos)
    end

    for i = 0, 3 do

        local dir = minetest.facedir_to_dir(i)
        unilib.update_pane(vector.add(pos, dir))

    end

end)

minetest.register_on_dignode(function(pos)

    for i = 0, 3 do

        local dir = minetest.facedir_to_dir(i)
        unilib.update_pane(vector.add(pos, dir))

    end

end)

---------------------------------------------------------------------------------------------------
-- Register panes
---------------------------------------------------------------------------------------------------

function unilib.register_pane(data_table)

    -- Adapated from xpanes/init.lua
    -- Registers a pane (usually, but not always, made of glass)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "glass_ordinary"
    --      orig_name (str or list): e.g. {"xpanes:pane", "xpanes:pane_flat"},
    --      def_table (table): The partial definition table
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local def_table = data_table.def_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode

    local full_name = "unilib:pane_" .. part_name

    -- The "flat" pane is a simple rectangle
    local flat_group_table = table.copy(def_table.groups)
    -- When running on top of minetest_game, we use the group "unipane" instead of "pane". This
    --      prevents a clash between unilib's LBM and the equivalent LBM in minetest_game
    if not unilib.use_unipanes_flag then
        flat_group_table.pane = 1
    else
        flat_group_table.unipane = 1
    end

    unilib.register_node(full_name .. "_flat", orig_name, replace_mode, {
        description = def_table.description,
        tiles = {
            def_table.textures[3],
            def_table.textures[3],
            def_table.textures[3],
            def_table.textures[3],
            def_table.textures[1],
            def_table.textures[1]
        },
        groups = flat_group_table,
        sounds = def_table.sounds,

        connect_sides = {"left", "right"},
        drawtype = "nodebox",
        drop = full_name .. "_flat",
        inventory_image = def_table.inventory_image,
        is_ground_content = false,
        light_source = def_table.light_source,
        node_box = {
            type = "fixed",
            fixed = {{-1/2, -1/2, -1/32, 1/2, 1/2, 1/32}},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {{-1/2, -1/2, -1/32, 1/2, 1/2, 1/32}},
        },
        sunlight_propagates = true,
        use_texture_alpha = def_table.use_texture_alpha and "blend" or "clip",
        wield_image = def_table.wield_image,
    })
    unilib.register_craft({
        output = full_name .. "_flat 16",
        recipe = def_table.recipe,
    })

    -- The "crossed" pane has corners, in order to connect to neighbouring panes
    local crossed_group_table = table.copy(def_table.groups)
    if not unilib.use_unipanes_flag then
        crossed_group_table.pane = 1
    else
        crossed_group_table.unipane = 1
    end
    crossed_group_table.not_in_creative_inventory = 1

    unilib.register_node(full_name .. "_crossed", nil, replace_mode, {
        description = def_table.description,
        tiles = {
            def_table.textures[3],
            def_table.textures[3],
            def_table.textures[1],
        },
        groups = crossed_group_table,
        sounds = def_table.sounds,

        connects_to = {
            "group:glass",
            "group:pane", "group:unipane",
            "group:stone",
            "group:tree",
            "group:wood",
        },
        drawtype = "nodebox",
        drop = full_name .. "_flat",
        is_ground_content = false,
        light_source = def_table.light_source,
        node_box = {
            type = "connected",
            fixed = {{-1/32, -1/2, -1/32, 1/32, 1/2, 1/32}},
            connect_front = {{-1/32, -1/2, -1/2, 1/32, 1/2, -1/32}},
            connect_left = {{-1/2, -1/2, -1/32, -1/32, 1/2, 1/32}},
            connect_back = {{-1/32, -1/2, 1/32, 1/32, 1/2, 1/2}},
            connect_right = {{1/32, -1/2, -1/32, 1/2, 1/2, 1/32}},
        },
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = def_table.use_texture_alpha and "blend" or "clip",
    })

end

---------------------------------------------------------------------------------------------------
-- Update panes (from the LBM)
---------------------------------------------------------------------------------------------------

function unilib.update_pane(pos)

    -- Adapated from xpanes/init.lua
    -- Called by the LBM in lbms.lua to switch between flat and crossed panes, depending on the
    --      pane's neighbour(s)
    --
    -- Args:
    --      pos (table): e.g. {x = 1, y = 1, z = 1}

    if not is_pane(pos) then
        return
    end

    local node = minetest.get_node(pos)
    local full_name = node.name
    local base_name

    if full_name:sub(-5) == "_flat" then
        base_name = full_name:sub(1, -6)
    elseif full_name:sub(-8) == "_crossed" then
        base_name = full_name:sub(1, -9)
    end

    local any = node.param2
    local c = {}
    local count = 0
    for dir = 0, 3 do

        c[dir] = connects_dir(pos, base_name, dir)
        if c[dir] then

            any = dir
            count = count + 1

        end

    end

    if count == 0 then

        swap(pos, node, base_name .. "_flat", any)

    elseif count == 1 then

        swap(pos, node, base_name .. "_flat", (any + 1) % 4)

    elseif count == 2 then

        if (c[0] and c[2]) or (c[1] and c[3]) then
            swap(pos, node, base_name .. "_flat", (any + 1) % 4)
        else
            swap(pos, node, base_name .. "_crossed", 0)
        end

    else

        swap(pos, node, base_name .. "_crossed", 0)

    end

end
