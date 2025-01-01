---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stairs_moreblocks.lua
--      Stairs from moreblocks
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local node_box_table = {
    micro_bottom_cut_eighth = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0, -0.4375, 0.5},
    },
    micro_bottom_cut_quarter = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0, -0.375, 0.5},
    },
    micro_bottom_cut_half = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0, -0.25, 0.5},
    },
    panel_vertical_sliced_eighth = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0, 0.4375, 0.5},
    },
    panel_vertical_sliced_quarter = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0, 0.375, 0.5},
    },
    panel_vertical_sliced_half = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0, 0.25, 0.5},
    },
    panel_bottom_cut_eighth = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0.5, -0.4375, 0.5},
    },
    panel_bottom_cut_quarter = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0.5, -0.375, 0.5},
    },
    panel_bottom_cut_half = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0.5, -0.25, 0.5},
    },
    tile_sliced_eighth = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0.5, 0.4375, 0.5},
    },
    tile_sliced_quarter = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0.5, 0.375, 0.5},
    },
    tile_sliced_half = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0.5, 0.25, 0.5},
    },
    slab_cut_eighth = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, ((1/16) - 0.5), 0.5},
    },
    slab_cut_quarter = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, ((2/16) - 0.5), 0.5},
    },
    slab_cut_half = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, ((4/16) - 0.5), 0.5},
    },
    slab_sliced_eighth = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, ((15/16) - 0.5), 0.5},
    },
    slab_sliced_quarter = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, ((14/16) - 0.5), 0.5},
    },
    slab_sliced_half = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, ((12/16) - 0.5), 0.5},
    },
    box_sided_two = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -7/16, 7/16},
            {-0.5, -0.5, 7/16, 0.5, 0.5, 0.5},
        },
    },
    box_sided_three = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, -7/16},
            {-0.5, -0.5, -7/16, 0.5, -7/16, 7/16},
            {-0.5, -0.5, 7/16, 0.5, 0.5, 0.5},
        },
    },
    box_sided_three_corner = {
        type = "fixed",
        fixed = {
            {-7/16, -0.5, -0.5, 0.5, -7/16, 7/16},
            {-7/16, -0.5, 7/16, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, -7/16, 0.5, 0.5},
        },
    },
--  _slope_half
--  _slope_half_raised
--  _slope_inner_half
--  _slope_inner_half_raised
--  _slope_inner_cut
--  _slope_inner_cut_half
--  _slope_inner_cut_half_raised
--  _slope_outer_half
--  _slope_outer_half_raised
--  _slope_outer_cut
--  _slope_outer_cut_half
--  _slope_outer_cut_half_raised
--  _slope_cut
    steps = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0, 0},
            {-0.5, 0, 0, 0.5, 0.5, 0.5},
        },
    },
    steps_sliced_eighth = {
        type = "fixed",
        fixed = {
            {-0.5, -0.0625, -0.5, 0.5, 0, 0},
            {-0.5, 0.4375, 0, 0.5, 0.5, 0.5},
        },
    },
    steps_sliced_quarter = {
        type = "fixed",
        fixed = {
            {-0.5, -0.125, -0.5, 0.5, 0, 0},
            {-0.5, 0.375, 0, 0.5, 0.5, 0.5},
        },
    },
    steps_sliced_half = {
        type = "fixed",
        fixed = {
            {-0.5, -0.25, -0.5, 0.5, 0, 0},
            {-0.5, 0.25, 0, 0.5, 0.5, 0.5},
        },
    },
}

local selection_box_table = {
    slope_half = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
            {-0.5, -0.375, -0.25, 0.5, -0.25, 0.5},
            {-0.5, -0.25, 0, 0.5, -0.125, 0.5},
            {-0.5, -0.125, 0.25, 0.5, 0, 0.5},
        },
    },
    slope_half_raised = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5},
            {-0.5, 0.125, -0.25, 0.5, 0.25, 0.5},
            {-0.5, 0.25, 0, 0.5, 0.375, 0.5},
            {-0.5, 0.375, 0.25, 0.5, 0.5, 0.5},
        },
    },
    slope_inner_half = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
            {-0.5, -0.375, -0.25, 0.5, -0.25, 0.5},
            {-0.5, -0.375, -0.5, 0.25, -0.25, 0.5},
            {-0.5, -0.25, -0.5, 0, -0.125, 0.5},
            {-0.5, -0.25, 0, 0.5, -0.125, 0.5},
            {-0.5, -0.125, 0.25, 0.5, 0, 0.5},
            {-0.5, -0.125, -0.5, -0.25, 0, 0.5},
        },
    },
    slope_inner_half_raised = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5},
            {-0.5, 0.125, -0.25, 0.5, 0.25, 0.5},
            {-0.5, 0.125, -0.5, 0.25, 0.25, 0.5},
            {-0.5, 0.25, -0.5, 0, 0.375, 0.5},
            {-0.5, 0.25, 0, 0.5, 0.375, 0.5},
            {-0.5, 0.375, 0.25, 0.5, 0.5, 0.5},
            {-0.5, 0.375, -0.5, -0.25, 0.5, 0.5},
        },
    },
    slope_outer_half = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
            {-0.5, -0.375, -0.25, 0.25, -0.25, 0.5},
            {-0.5, -0.25, 0, 0, -0.125, 0.5},
            {-0.5, -0.125, 0.25, -0.25, 0, 0.5},
        },
    },
    slope_outer_half_raised = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5},
            {-0.5, 0.125, -0.25, 0.25, 0.25, 0.5},
            {-0.5, 0.25, 0, 0, 0.375, 0.5},
            {-0.5, 0.375, 0.25, -0.25, 0.5, 0.5},
        },
    },
}

---------------------------------------------------------------------------------------------------
-- Stairs from moreblocks
---------------------------------------------------------------------------------------------------

function unilib.stairs._register_micro_bottom_cut_eighth(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:micro_XXX_1
    -- Creates a cut microblock stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_micro_bottom_cut_eighth"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Bottom microblock 1/8 cut"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.micro_bottom_cut_eighth,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, (2/16) * (1/8))
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_micro_bottom_cut_quarter(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:micro_XXX_2
    -- Creates a cut microblock stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_micro_bottom_cut_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Bottom microblock 1/4 cut"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.micro_bottom_cut_quarter,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, (2/16) * (1/4))
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_micro_bottom_cut_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:micro_XXX_4
    -- Creates a cut microblock stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_micro_bottom_cut_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Bottom microblock 1/2 cut"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.micro_bottom_cut_half,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, (2/16) * (1/2))
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_panel_vertical_sliced_eighth(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:micro_XXX_15
    -- Creates a sliced vertical panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_vertical_sliced_eighth"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Vertical panel 1/8 sliced"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.panel_vertical_sliced_eighth,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, (4/16) * (7/8))
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_panel_vertical_sliced_quarter(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:micro_XXX_14
    -- Creates a sliced vertical panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_vertical_sliced_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Vertical panel 1/4 sliced"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.panel_vertical_sliced_quarter,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, (4/16) * (3/4))
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_panel_vertical_sliced_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:micro_XXX_12
    -- Creates a sliced vertical panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_vertical_sliced_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Vertical panel 1/2 sliced"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.panel_vertical_sliced_half,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, (4/16) * (1/2))
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_panel_bottom_cut_eighth(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:panel_XXX_1
    -- Creates a cut bottom panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_bottom_cut_eighth"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Bottom panel 1/8 cut"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.panel_bottom_cut_eighth,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, (4/16) * (1/8))
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_panel_bottom_cut_quarter(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:panel_XXX_2
    -- Creates a cut bottom panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_bottom_cut_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Bottom panel 1/4 cut"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.panel_bottom_cut_quarter,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, (4/16) * (1/4))
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_panel_bottom_cut_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:panel_XXX_4
    -- Creates a cut bottom panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_bottom_cut_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Bottom panel 1/2 cut"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.panel_bottom_cut_half,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, (4/16) * (1/2))
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_tile_sliced_eighth(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:panel_XXX_15
    -- Creates a sliced tile stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_tile_sliced_eighth"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Tile 1/8 sliced"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.tile_sliced_eighth,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, (4/16) * (7/8))
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_tile_sliced_quarter(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:panel_XXX_14
    -- Creates a sliced tile stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_tile_sliced_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Tile 1/4 sliced"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.tile_sliced_quarter,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, (4/16) * (3/4))
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_tile_sliced_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:panel_XXX_12
    -- Creates a sliced tile stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_tile_sliced_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Tile 1/2 sliced"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.tile_sliced_half,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, (4/16) * (1/2))
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_slab_cut_eighth(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_1
    -- Creates a cut slab stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_cut_eighth"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Slab 1/8 cut"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.slab_cut_eighth,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 1/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_slab_cut_quarter(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_2
    -- N.B. This function and unilib.register_stairs_slab_quarter() produce a node that looks the
    --      same, but which have different names. For consistency, both are available
    --
    -- Creates a cut slab stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_cut_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Slab 1/4 cut"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.slab_cut_quarter,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 2/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {
            adj_full_name, adj_full_name, adj_full_name, adj_full_name,
            adj_full_name, adj_full_name, adj_full_name, adj_full_name,
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {full_name .. "_stair_slab_sliced_quarter", adj_full_name},
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab_cut_eighth", full_name .. "_stair_slab_cut_eighth"},
    })

    return adj_full_name

end

function unilib.stairs._register_slab_cut_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_quarter
    -- Creates a cut slab stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_cut_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Slab 1/2 cut"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.slab_cut_half,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 4/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, adj_full_name, adj_full_name, adj_full_name},
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab_cut_quarter", full_name .. "_stair_slab_cut_quarter"},
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {
            full_name .. "_stair_slab_cut_eighth",
            full_name .. "_stair_slab_cut_eighth",
            full_name .. "_stair_slab_cut_eighth",
            full_name .. "_stair_slab_cut_eighth",
        },
    })

    return adj_full_name

end

function unilib.stairs._register_slab_sliced_eighth(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_15
    -- Creates a sliced slab stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_sliced_eighth"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Slab 1/8 sliced"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.slab_sliced_eighth,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 15/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {full_name .. "_stair_slab_sliced_eighth", full_name .. "_stair_slab_cut_eighth"},
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab_sliced_quarter", full_name .. "_stair_slab_cut_eighth"},
    })

    return adj_full_name

end

function unilib.stairs._register_slab_sliced_quarter(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_14
    -- Creates a sliced slab stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_sliced_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Slab 1/4 sliced"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.slab_sliced_quarter,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 14/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab_sliced_half", full_name .. "_stair_slab_cut_quarter"},
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
        },
    })

    return adj_full_name

end

function unilib.stairs._register_slab_sliced_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_three_quarter
    -- Creates a sliced slab stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_sliced_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Slab 1/2 sliced"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.slab_sliced_half,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 12/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab", full_name .. "_stair_slab_cut_half"},
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {
            full_name .. "_stair_slab_cut_half",
            full_name .. "_stair_slab_cut_half",
            full_name .. "_stair_slab_cut_half",
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, adj_full_name},
    })

    return adj_full_name

end

function unilib.stairs._register_box_sided_two(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_two_sides
    -- Creates a three-sided box stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_box_sided_two"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Two-sided box"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.box_sided_two,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 2/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_box_sided_three(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_three_sides_u
    -- Creates a three-sided box stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_box_sided_three"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Three-sided box"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.box_sided_three,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 3/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_box_sided_three_corner(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_three_sides
    -- Creates a three-sided box stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_box_sided_three_corner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Three-sided corner box"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.box_sided_three_corner,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 3/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_slope_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_half
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

    local adj_part_name = "_stair_slope_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Half slope"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_half.obj",
            collision_box = selection_box_table.slope_half,
            selection_box = selection_box_table.slope_half,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 4/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, full_name .. "_stair_slope_half_raised"},
    })

    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, adj_full_name, adj_full_name, adj_full_name},
    })

    return adj_full_name

end

function unilib.stairs._register_slope_half_raised(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_half_raised
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

    local adj_part_name = "_stair_slope_half_raised"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Raised half slope"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_half_raised.obj",
            collision_box = selection_box_table.slope_half_raised,
            selection_box = selection_box_table.slope_half_raised,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 12/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {
            full_name .. "_stair_slope_half",
            full_name .. "_stair_slope_half",
            full_name .. "_stair_slope_half",
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab", full_name .. "_stair_slope_half"},
    })

    return adj_full_name

end

function unilib.stairs._register_slope_inner_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_inner_half
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

    local adj_part_name = "_stair_slope_inner_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Inner half slope"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_inner_half.obj",
            collision_box = selection_box_table.slope_inner_half,
            selection_box = selection_box_table.slope_inner_half,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 6/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {full_name .. "_stair_slope_outer_half_raised", adj_full_name},
    })

    return adj_full_name

end

function unilib.stairs._register_slope_inner_half_raised(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_inner_half_raised
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

    local adj_part_name = "_stair_slope_inner_half_raised"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Raised inner half slope"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_inner_half_raised.obj",
            collision_box = selection_box_table.slope_inner_half_raised,
            selection_box = selection_box_table.slope_inner_half_raised,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 14/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab", full_name .. "_stair_slope_inner_half"},
    })

    return adj_full_name

end

function unilib.stairs._register_slope_inner_cut(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_inner_cut
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

    local adj_part_name = "_stair_slope_inner_cut"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Cut inner slope"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_inner_cut.obj",
            collision_box = selection_box_table.slope_inner,
            selection_box = selection_box_table.slope_inner,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 14/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_slope_inner_cut_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_inner_cut_half
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

    local adj_part_name = "_stair_slope_inner_cut_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Cut inner half slope"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_inner_cut_half.obj",
            collision_box = selection_box_table.slope_inner_half,
            selection_box = selection_box_table.slope_inner_half,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 8/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_slope_inner_cut_half_raised(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_inner_cut_half_raised
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

    local adj_part_name = "_stair_slope_inner_cut_half_raised"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Raised cut inner half slope"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_inner_cut_half_raised.obj",
            collision_box = selection_box_table.slope_inner_half_raised,
            selection_box = selection_box_table.slope_inner_half_raised,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 16/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab", full_name .. "_stair_slope_inner_cut_half"},
    })

    return adj_full_name

end

function unilib.stairs._register_slope_outer_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_outer_half
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

    local adj_part_name = "_stair_slope_outer_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Outer half slope"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_outer_half.obj",
            collision_box = selection_box_table.slope_outer_half,
            selection_box = selection_box_table.slope_outer_half,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 4/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, full_name .. "_stair_slope_inner_half_raised"},
    })

    return adj_full_name

end

function unilib.stairs._register_slope_outer_half_raised(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_outer_half_raised
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

    local adj_part_name = "_stair_slope_outer_half_raised"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Raised outer half slope"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_outer_half_raised.obj",
            collision_box = selection_box_table.slope_outer_half_raised,
            selection_box = selection_box_table.slope_outer_half_raised,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 12/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab", full_name .. "_stair_slope_outer_half"},
    })

    return adj_full_name

end

function unilib.stairs._register_slope_outer_cut(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_outer_cut
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

    local adj_part_name = "_stair_slope_outer_cut"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Cut outer slope"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_outer_cut.obj",
            collision_box = selection_box_table.slope_outer,
            selection_box = selection_box_table.slope_outer,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 4/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, full_name .. "_stair_slope_inner_cut"},
    })

    return adj_full_name

end

function unilib.stairs._register_slope_outer_cut_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_outer_cut_half
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

    local adj_part_name = "_stair_slope_outer_cut_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Cut outer half slope"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_outer_cut_half.obj",
            collision_box = selection_box_table.slope_outer_half,
            selection_box = selection_box_table.slope_outer_half,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 2/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, full_name .. "_stair_slope_inner_cut_half_raised"},
    })

    return adj_full_name

end

function unilib.stairs._register_slope_outer_cut_half_raised(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_outer_cut_half_raised
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

    local adj_part_name = "_stair_slope_outer_cut_half_raised"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Raised cut outer half slope"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_outer_cut_half_raised.obj",
            collision_box = selection_box_table.slope_outer_half_raised,
            selection_box = selection_box_table.slope_outer_half_raised,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 6/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_slope_cut(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_cut
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

    local adj_part_name = "_stair_slope_cut"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Cut slope"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_cut.obj",
            collision_box = selection_box_table.slope_outer,
            selection_box = selection_box_table.slope_outer,
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

function unilib.stairs._register_steps(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_alt
    -- Creates a steps stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_steps"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Steps"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.steps,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 8/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_panel_bottom", ""},
            {"", full_name .. "_stair_panel_bottom"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_panel_bottom", ""},
            {"", full_name .. "_stair_panel_bottom"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_steps_sliced_eighth(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_alt_1
    -- Creates a sliced steps stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_steps_sliced_eighth"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Steps 1/8 sliced"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.steps_sliced_eighth,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 2/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_steps_sliced_quarter(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_alt_2
    -- Creates a sliced steps stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_steps_sliced_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Steps 1/4 sliced"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.steps_sliced_quarter,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 2/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.stairs._register_steps_sliced_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_alt_4
    -- Creates a sliced steps stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_steps_sliced_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Steps 1/2 sliced"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.steps_sliced_half,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 4/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

