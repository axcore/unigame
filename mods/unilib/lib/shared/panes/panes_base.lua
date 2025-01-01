---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- panes_base.lua
--      Base API functions for panes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register panes
---------------------------------------------------------------------------------------------------

function unilib.panes._register_pane(data_table)

    -- Adapted from xpanes/init.lua
    -- Registers a pane (often, but not always, made of glass)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "glass_ordinary"
    --      orig_name (str or list): e.g. {"xpanes:pane", "xpanes:pane_flat"},
    --      def_table (table): The partial definition table, which should include a .textures field
    --          with a list of three items in the form {front_texture, ignored, edge_texture}
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
    if not unilib.global.use_unipanes_flag then
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
    if not unilib.global.use_unipanes_flag then
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
