---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- carpentry.lua
--      Set up shared functions for items made from multiple types of wood
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Wooden furniture
---------------------------------------------------------------------------------------------------

function unilib.register_wooden_bench(data_table)

    -- Adapted from simple_furniture/sf_benches.lua
    -- Creates a wooden bench (made from a particular tree)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen" (a key in unilib.tree_table)
    --      orig_name (str): e.g. "simple_furniture:aspen_wood_bench"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Aspen Wood Bench"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Wooden Bench")

    local full_name = "unilib:furniture_bench_" .. part_name
    local slab_name = "unilib:tree_" .. part_name .. "_wood_stair_slab"
    local img = "unilib_tree_" .. part_name .. "_wood.png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {img},
        -- N.B. sf_aspen_wood_bench = 1 (etc) in original code
        groups = {bench = 1, choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.375, -0.5, -0.3125, -0.25, -0.0625, -0.25},
                {-0.375, -0.5, 0.3125, -0.25, -0.0625, 0.25},
                {0.375, -0.5, -0.3125, 0.25, -0.0625, -0.25},
                {0.375, -0.5, 0.3125, 0.25, -0.0625, 0.25},
                {-0.5, -0.0625, -0.375, 0.5, 0, 0.375},
                {-0.5, -0.125, -0.3125, 0.5, -0.0625, -0.4375},
                {-0.5, -0.125, 0.3125, 0.5, -0.0625, 0.4375},
                {0.0625, 0, 0.375, -0.0625, 0.375, 0.3125},
                {-0.5, 0.1875, 0.3125, 0.5, 0.4375, 0.25},
                {-0.5, 0.375, 0.375, 0.5, 0.5, 0.3125},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {"", "", slab_name},
            {slab_name, slab_name, slab_name},
            {slab_name, "", slab_name},
        },
    })

    return full_name

end

function unilib.register_wooden_cabinet(data_table)

    -- Adapted from simple_furniture/sf_cabinets.lua
    -- Creates a wooden cabinets (made from a particular tree)
    -- This item is purely decorative, it can't be used as a container
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen" (a key in unilib.tree_table)
    --      orig_name (str): e.g. "simple_furniture:aspen_wood_cabinet"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Aspen Wood Cabinet"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Wooden Cabinet")

    local full_name = "unilib:furniture_cabinet_" .. part_name
    local slab_name = "unilib:tree_" .. part_name .. "_wood_stair_slab"
    local img = "unilib_tree_" .. part_name .. "_wood.png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {
            img,
            img,
            "unilib_container_chest_ordinary_top.png",
            "unilib_container_chest_ordinary_top.png",
            "unilib_container_chest_ordinary_side.png",
            img,
        },
        -- N.B. sf_aspen_wood_cabinet = 1 (etc) in original code
        groups = {cabinet = 1, choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {0.5, -0.5, 0.5, -0.5, -0.4375, -0.375},
                {0.5, -0.4375, 0.5, 0.4375, 0.4375, -0.375},
                {-0.5, -0.4375, 0.5, -0.4375, 0.4375, -0.375},
                {0.4375, -0.4375, 0.5, -0.4375, 0.4375, 0.4375},
                {0.4375, -0.4375, -0.3125, -0.4375, 0.4375, -0.375},
                {0.4375, -0.4375, -0.375, 0.0625, 0.375, -0.4375},
                {-0.4375, -0.4375, -0.375, -0.0625, 0.375, -0.4375},
                {-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {slab_name, slab_name, slab_name},
            {"unilib:trapdoor_wood_ordinary", slab_name, "unilib:trapdoor_wood_ordinary"},
            {slab_name, slab_name, slab_name},
        },
    })

    return full_name

end

function unilib.register_wooden_chair(data_table)

    -- Adapted from simple_furniture/sf_chairs.lua
    -- Creates a wooden chair (made from a particular tree)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen" (a key in unilib.tree_table)
    --      orig_name (str): e.g. "simple_furniture:aspen_wood_chair"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Aspen Wood Chair"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Wooden Chair")

    local full_name = "unilib:furniture_chair_" .. part_name
    local slab_name = "unilib:tree_" .. part_name .. "_wood_stair_slab"
    local stick_name = "unilib:item_stick_ordinary"
    local img = "unilib_tree_" .. part_name .. "_wood.png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {img},
        -- N.B. sf_aspen_wood_chair = 1 (etc) in original code
        groups = {chair = 1, choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.25},
                {-0.375, -0.5, 0.375, -0.3125, -0.0625, 0.25},
                {0.375, -0.5, -0.375, 0.3125, -0.0625, -0.25},
                {0.375, -0.5, 0.375, 0.3125, -0.0625, 0.25},
                {-0.375, -0.0625, -0.375, 0.375, 0, 0.375},
                {-0.375, 0, 0.375, -0.3125, 0.5, 0.25},
                {0.375, 0, 0.375, 0.3125, 0.5, 0.25},
                {-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.25},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {"", "", stick_name},
            {slab_name, slab_name, slab_name},
            {stick_name, "", stick_name},
        },
    })

    return full_name

end

function unilib.register_wooden_table_dining(data_table)

    -- Adapted from simple_furniture/sf_dining_tables.lua
    -- Creates a wooden dining table (made from a particular tree)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen" (a key in unilib.tree_table)
    --      orig_name (str): e.g. "simple_furniture:aspen_wood_dining_table"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Aspen Wood Dining Table"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Wooden Dining Table")

    local full_name = "unilib:furniture_table_dining_" .. part_name
    local slab_name = "unilib:tree_" .. part_name .. "_wood_stair_slab"
    local stick_name = "unilib:item_stick_ordinary"
    local img = "unilib_tree_" .. part_name .. "_wood.png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {img},
        -- N.B. sf_aspen_wood_dining_table = 1 (etc) in original code
        groups = {choppy = 3, dining_table = 1, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.0625, -0.375, -0.0625, 0.0625, 0.375, 0.0625},
                {-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
                {-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
                {-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
                {-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {slab_name, slab_name, slab_name},
            {"", stick_name, ""},
            {"", slab_name, ""},
        },
    })

    return full_name

end

function unilib.register_wooden_table_end(data_table)

    -- Adapted from simple_furniture/sf_end_tables.lua
    -- Creates a wooden end table (made from a particular tree)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen" (a key in unilib.tree_table)
    --      orig_name (str): e.g. "simple_furniture:aspen_wood_end_table"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Aspen Wood End Table"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Wooden End Table")

    local full_name = "unilib:furniture_table_end_" .. part_name
    local slab_name = "unilib:tree_" .. part_name .. "_wood_stair_slab"
    local stick_name = "unilib:item_stick_ordinary"
    local img = "unilib_tree_" .. part_name .. "_wood.png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {img},
        -- N.B. sf_aspen_wood_end_table = 1 (etc) in original code
        groups = {choppy = 3, end_table = 1, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.375, -0.5, -0.375, -0.25, 0.375, -0.3125},
                {-0.375, -0.5, 0.375, -0.25, 0.375, 0.3125},
                {0.375, -0.5, -0.375, 0.25, 0.375, -0.3125},
                {0.375, -0.5, 0.375, 0.25, 0.375, 0.3125},
                {-0.3125, -0.25, 0.3125, -0.25, -0.1875, -0.3125},
                {0.3125, -0.25, 0.3125, 0.25, -0.1875, -0.3125},
                {-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
                {-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {slab_name, slab_name, slab_name},
            {stick_name, "", stick_name},
            {stick_name, "", stick_name},
        },
    })

    return full_name

end
