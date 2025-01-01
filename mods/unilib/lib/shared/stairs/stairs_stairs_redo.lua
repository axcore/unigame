---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stairs_stairs_redo.lua
--      Stairs from stairs_redo
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local selection_box_table = {
    slope = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            {-0.5, -0.25, -0.25, 0.5, 0, 0.5},
            {-0.5, 0, 0, 0.5, 0.25, 0.5},
            {-0.5, 0.25, 0.25, 0.5, 0.5, 0.5},
        },
    },
    slope_inner = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            {-0.5, -0.5, -0.25, 0.5, 0, 0.5},
            {-0.5, -0.5, -0.5, 0.25, 0, 0.5},
            {-0.5, 0, -0.5, 0, 0.25, 0.5},
            {-0.5, 0, 0, 0.5, 0.25, 0.5},
            {-0.5, 0.25, 0.25, 0.5, 0.5, 0.5},
            {-0.5, 0.25, -0.5, -0.25, 0.5, 0.5},
        },
    },
    slope_outer = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            {-0.5, -0.25, -0.25, 0.25, 0, 0.5},
            {-0.5, 0, 0, 0, 0.25, 0.5},
            {-0.5, 0.25, 0.25, -0.25, 0.5, 0.5},
        },
    },
}

---------------------------------------------------------------------------------------------------
-- Stairs from stairs_redo
---------------------------------------------------------------------------------------------------

function unilib.stairs._register_slope(full_name, def_table, data_table)

    -- Adapted from stairs_redo/init.lua, stairs:slope_XXX
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Slope"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairs_redo_flag or unilib.setting.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope.obj",
            collision_box = selection_box_table.slope,
            selection_box = selection_box_table.slope,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 8/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, adj_full_name},
    })

    return adj_full_name

end

function unilib.stairs._register_slope_inner(full_name, def_table, data_table)

    -- Adapted from stairs_redo/init.lua, stairs:slope_XXX_inner
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_inner
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope_inner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Inner slope"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairs_redo_flag or unilib.setting.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_inner.obj",
            collision_box = selection_box_table.slope_inner,
            selection_box = selection_box_table.slope_inner,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 14/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_slope_outer(full_name, def_table, data_table)

    -- Adapted from stairs_redo/init.lua, stairs:slope_XXX_outer
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_outer
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope_outer"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Outer slope"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairs_redo_flag or unilib.setting.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_outer.obj",
            collision_box = selection_box_table.slope_outer,
            selection_box = selection_box_table.slope_outer,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 6/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, full_name .. "_stair_slope_inner"},
    })

    return adj_full_name

end
