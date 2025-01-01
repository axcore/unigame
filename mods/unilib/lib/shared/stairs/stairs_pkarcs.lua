---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stairs_pkarcs.lua
--      Stairs from pkarcs
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local node_box_table = {
    arch_simple = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, -0.4375, 0.5, 0.5},
            {-0.4375, -0.25, -0.5, -0.375, 0.5, 0.5},
            {-0.375, -0.0625, -0.5, -0.3125, 0.5, 0.5},
            {-0.3125, 0, -0.5, -0.25, 0.5, 0.5},
            {-0.25, 0.125, -0.5, -0.1875, 0.5, 0.5},
            {-0.1875, 0.1875, -0.5, -0.125, 0.5, 0.5},
            {-0.125, 0.25, -0.5, 0, 0.5, 0.5},
            {0, 0.3125, -0.5, 0.0625, 0.5, 0.5},
            {0.0625, 0.375, -0.5, 0.25, 0.5, 0.5},
            {0.25, 0.4375, -0.5, 0.5, 0.5, 0.5},
        },
    },
    arch_outer = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.5, -0.4375, 0.5, 0.4375},
            {-0.5, -0.25, 0.5, -0.375, 0.5, 0.375},
            {-0.5, -0.0625, 0.5, -0.3125, 0.5, 0.3125},
            {-0.5, 0, 0.5, -0.25, 0.5, 0.25},
            {-0.5, 0.125, 0.5, -0.1875, 0.5, 0.1875},
            {-0.5, 0.1875, 0.5, -0.125, 0.5, 0.125},
            {-0.5, 0.25, 0.5, 0, 0.5, 0},
            {-0.5, 0.3125, 0.5, 0.0625, 0.5, -0.0625},
            {-0.5, 0.375, 0.5, 0.25, 0.5, -0.25},
            {-0.5, 0.4375, 0.5, 0.5, 0.5, -0.5},
        },
    },
    arch_inner = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.5, -0.4375, 0.5, -0.5},
            {-0.5, -0.5, 0.5, 0.5, 0.5, 0.4375},
            {-0.5, -0.25, 0.5, -0.375, 0.5, -0.5},
            {-0.5, -0.25, 0.5, 0.5, 0.5, 0.375},
            {-0.5, -0.0625, 0.5, -0.3125, 0.5, -0.5},
            {-0.5, -0.0625, 0.5, 0.5, 0.5, 0.3125},
            {-0.5, 0, 0.5, -0.25, 0.5, -0.5},
            {-0.5, 0, 0.5, 0.5, 0.5, 0.25},
            {-0.5, 0.125, 0.5, -0.1875, 0.5, -0.5},
            {-0.5, 0.125, 0.5, 0.5, 0.5, 0.1875},
            {-0.5, 0.1875, 0.5, -0.125, 0.5, -0.5},
            {-0.5, 0.1875, 0.5, 0.5, 0.5, 0.125},
            {-0.5, 0.25, 0.5, 0, 0.5, -0.5},
            {-0.5, 0.25, 0.5, 0.5, 0.5, 0},
            {-0.5, 0.3125, 0.5, 0.0625, 0.5, -0.5},
            {-0.5, 0.3125, 0.5, 0.5, 0.5, -0.0625},
            {-0.5, 0.375, 0.5, 0.25, 0.5, -0.5},
            {-0.5, 0.375, 0.5, 0.5, 0.5, -0.25},
            {-0.5, 0.4375, 0.5, 0.5, 0.5, -0.5},
        },
    },
}

---------------------------------------------------------------------------------------------------
-- Stairs from pkarcs
---------------------------------------------------------------------------------------------------

function unilib.stairs._register_arch_simple(full_name, def_table, data_table)

    -- Adapted from pkarcs/pkarcs/init.lua, pkarcs:XXX_arc
    -- Creates a simple arch node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_arch_simple"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Simple arch"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_pkarcs_flag,
        {
            node_box = node_box_table.arch_simple,
        },
        {arch_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 5/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name .. " 5",
        recipe = {
            {full_name, full_name, full_name},
            {full_name, "", ""},
            {full_name, "", ""},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_arch_outer(full_name, def_table, data_table)

    -- Adapted from pkarcs/pkarcs/init.lua, pkarcs:XXX_outer_arc
    -- Creates an outer arch node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_arch_outer"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Outer arch"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_pkarcs_flag,
        {
            node_box = node_box_table.arch_outer,
        },
        {arch_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 7/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    -- N.B. Tweaked original recipe so it doesn't require a torch
    --[[
    unilib.register_craft({
        output = adj_full_name .. " 5",
        recipe = {
            {"group:torch", full_name, full_name},
            {full_name, "", ""},
            {full_name, "", ""},
        },
    })
    ]]--
    unilib.register_craft({
        output = adj_full_name .. " 4",
        recipe = {
            {"", full_name, full_name},
            {full_name, "", ""},
            {full_name, "", ""},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_arch_inner(full_name, def_table, data_table)

    -- Adapted from pkarcs/pkarcs/init.lua, pkarcs:XXX_inner_arc
    -- Creates an inner arch node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_arch_inner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Inner arch"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_pkarcs_flag,
        {
            node_box = node_box_table.arch_inner,
        },
        {arch_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 3/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    -- N.B. Tweaked original recipe so it doesn't require a torch
    --[[
    unilib.register_craft({
        output = adj_full_name .. " 5",
        recipe = {
            {"", full_name, full_name},
            {full_name, "group:torch", ""},
            {full_name, "", ""},
        },
    })
    ]]--
    unilib.register_craft({
        output = adj_full_name .. " 5",
        recipe = {
            {"", full_name, full_name},
            {full_name, full_name, ""},
            {full_name, "", ""},
        },
    })

    return adj_full_name

end
