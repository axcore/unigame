---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stairs_stairsplus.lua
--      Stairs from stairsplus
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local node_box_table = {
    simple_inverted = {
        type = "fixed",
        fixed = {
            {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, 0, 0.5, 0, 0.5},
        },
    },
    simple_half_inverted = {
        type = "fixed",
        fixed = {
            {-0.5, 0, -0.5, 0, 0.5, 0.5},
            {-0.5, -0.5, 0, 0, 0, 0.5},
        },
    },
    simple_half_right_inverted = {
        type = "fixed",
        fixed = {
            {0, 0, -0.5, 0.5, 0.5, 0.5},
            {0, -0.5, 0, 0.5, 0, 0.5},
        },
    },
    corner = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0, 0.5, 0},
        },
    },
    corner_half = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0, 0.5, 0, 0.5},
            {-0.5, -0.5, -0.5, 0, 0, 0},
        },
    },
    corner_half_inverted = {
        type = "fixed",
        fixed = {
            {-0.5, 0, 0, 0.5, 0.5, 0.5},
            {-0.5, 0, -0.5, 0, 0.5, 0},
        },
    },
    inner_inverted = {
        type = "fixed",
        fixed = {
            {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, 0, 0.5, 0, 0.5},
            {-0.5, -0.5, -0.5, 0, 0, 0},
        },
    },
    outer_inverted = {
        type = "fixed",
        fixed = {
            {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, 0, 0, 0, 0.5},
        },
    },
--  slab_inverted
--  slab_quarter
--  slab_quarter_inverted
--  slab_three_quarter
--  slab_three_quarter_inverted
    tile = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
    },
    tile_quarter = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0.25, 0.5, 0.5, 0.5},
    },
    tile_three_quarter = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.25, 0.5, 0.5, 0.5},
    },
    panel_top = {
        type = "fixed",
        fixed = {-0.5, 0, 0, 0.5, 0.5, 0.5},
    },
    panel_vertical = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0, 0.5, 0.5},
    },
    micro_top = {
        type = "fixed",
        fixed = {-0.5, 0, 0, 0, 0.5, 0.5},
    },
}

---------------------------------------------------------------------------------------------------
-- Stairs from stairsplus
---------------------------------------------------------------------------------------------------

function unilib.stairs._register_simple_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/stairs.lua, stairsplus:stair_XXX_inverted
    -- Creates an inverted simple stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_simple_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Inverted simple stair"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.simple_inverted,
        },
        {slab_img_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 12/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_simple"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {
                full_name .. "_stair_simple_half_inverted",
                full_name .. "_stair_simple_half_inverted",
            },
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {
                full_name .. "_stair_simple_half_right_inverted",
                full_name .. "_stair_simple_half_right_inverted",
            },
        },
    })

    return adj_full_name

end

function unilib.stairs._register_simple_half_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/stairs.lua, stairsplus:stair_XXX_half_inverted
    -- Creates an inverted half simple stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_simple_half_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Inverted half simple stair"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.simple_half_inverted,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 6/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 4",
        recipe = {
            {full_name .. "_stair_simple_inverted", full_name .. "_stair_simple_inverted"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_simple_half"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_simple_half_right"},
        },
    })

    unilib.register_craft({
        output = adj_full_name .. " 2",
        recipe = {
            {full_name .. "_stair_simple_half_right_inverted"},
            {full_name .. "_stair_simple_half_right_inverted"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_simple_half_right_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/stairs.lua, stairsplus:stair_XXX_right_half_inverted
    -- Creates an inverted right-half simple stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_simple_half_right_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc =
            unilib.utils.brackets(def_table.description, S("Inverted right-half simple stair"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.simple_half_right_inverted,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 6/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 2",
        recipe = {
            {full_name .. "_stair_simple_half_inverted"},
            {full_name .. "_stair_simple_half_inverted"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_corner(full_name, def_table, data_table)

    -- Adapted from stairsplus/corner.lua, stairsplus:corner_XXX
    -- Creates a corner stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_corner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Corner stair"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.corner,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 12/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 8",
        recipe = {
            {full_name, full_name, full_name},
            {full_name, full_name, ""},
            {full_name, "", ""},
        },
    })
    unilib.register_craft({
        output = adj_full_name .. " 8",
        recipe = {
            {full_name, full_name, full_name},
            {"", full_name, full_name},
            {"", "", full_name},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_corner_half"},
            {full_name .. "_stair_corner_half"},
        },
    })

    unilib.register_craft({
        output = full_name .. "_stair_corner",
        recipe = {
            {full_name .. "_stair_corner_half_inverted"},
            {full_name .. "_stair_corner_half_inverted"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_corner_half(full_name, def_table, data_table)

    -- Adapted from stairsplus/corner.lua, stairsplus:corner_XXX_half
    -- Creates a half corner stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_corner_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Half corner stair"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.corner_half,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 6/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_micro_bottom"},
            {full_name .. "_stair_panel_bottom"},
        },
    })

    unilib.register_craft({
        output = adj_full_name .. " 2",
        recipe = {
            {full_name .. "_stair_corner"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_corner_half_inverted"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_corner_half_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/corner.lua, stairsplus:corner_XXX_half_inverted
    -- Creates an inverted half corner stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_corner_half_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Inverted half corner stair"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.corner_half_inverted,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 6/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_corner_half"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_inner_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/corner.lua, stairsplus:corner_XXX_inner_inverted
    -- Creates an inverted inner stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_inner_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Inverted inner stair"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.inner_inverted,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 14/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab"},
            {full_name .. "_stair_corner_half"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_inner"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_outer_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/corner.lua, stairsplus:corner_XXX_outer_inverted
    -- Creates an inverted outer stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_outer_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Inverted outer stair"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.outer_inverted,
        },
        {slab_img_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 14/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_outer"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_slab_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/slab.lua, stairsplus:slab_XXX_inverted
    -- Creates an inverted slab node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Inverted slab"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
        {slab_flag = true, slab_img_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 8/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab_quarter_inverted"},
            {full_name .. "_stair_slab_quarter_inverted"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_slab_quarter(full_name, def_table, data_table)

    -- Adapted from stairsplus/slab.lua, stairsplus:slab_XXX_quarter
    -- N.B. This function and unilib.register_stairs_slab_cut_quarter() produce a node that looks
    --      the same, but which have different names. For consistency, both are available
    --
    -- Creates a quarter slab node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Quarter slab"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
        {slab_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 4/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab_quarter_inverted"},
        },
    })

    unilib.register_craft({
        output = full_name,
        recipe = {
            {full_name .. "_stair_slab_quarter"},
            {full_name .. "_stair_slab_quarter"},
            {full_name .. "_stair_slab_quarter"},
            {full_name .. "_stair_slab_quarter"},
        },
    })

    unilib.register_craft({
        output = adj_full_name .. " 6",
        recipe = {
            {full_name .. "_stair_slab_three_quarter"},
            {full_name .. "_stair_slab_three_quarter"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_slab_quarter_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/slab.lua, stairsplus:slab_XXX_quarter_inverted
    -- Creates an inverted quarter slab node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_quarter_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Inverted quarter slab"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},
        {slab_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 4/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 6",
        recipe = {
            {
                full_name .. "_stair_slab_inverted",
                full_name .. "_stair_slab_inverted",
                full_name .. "_stair_slab_inverted",
            },
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab_quarter"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_slab_three_quarter(full_name, def_table, data_table)

    -- Adapted from stairsplus/slab.lua, stairsplus:slab_XXX_three_quarter
    -- Creates a three-quarter slab node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_three_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Three-quarter slab"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
        {slab_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 12/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab_three_quarter_inverted"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab_quarter"},
            {full_name .. "_stair_slab_quarter"},
            {full_name .. "_stair_slab_quarter"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_slab_three_quarter_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/slab.lua, stairsplus:slab_XXX_three_quater_inverted
    -- Creates an inverted three-quarter slab node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_three_quarter_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Inverted three-quarter slab"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {-0.5, -0.25, -0.5, 0.5, 0.5, 0.5},
        {slab_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 12/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab_three_quarter"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab_quarter_inverted"},
            {full_name .. "_stair_slab_quarter_inverted"},
            {full_name .. "_stair_slab_quarter_inverted"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_tile(full_name, def_table, data_table)

    -- Adapted from stairsplus/wall.lua, stairsplus:wall_XXX
    -- Creates a tile stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_tile"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Tile"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.tile,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 8/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 6",
        recipe = {
            {full_name},
            {full_name},
            {full_name},
        },
    })

    unilib.register_craft({
        output = full_name,
        recipe = {
            {full_name .. "_stair_tile", full_name .. "_stair_tile"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_tile_quarter(full_name, def_table, data_table)

    -- Adapted from stairsplus/wall.lua, stairsplus:wall_XXX_quarter
    -- Creates a quarter tile stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_tile_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Quarter tile"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.tile_quarter,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 4/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 6",
        recipe = {
            {full_name .. "_stair_slab", full_name .. "_stair_slab", full_name .. "_stair_slab"},
        },
    })

    unilib.register_craft({
        output = adj_full_name .. " 6",
        recipe = {
            {full_name .. "_stair_tile"},
            {full_name .. "_stair_tile"},
            {full_name .. "_stair_tile"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_tile_three_quarter(full_name, def_table, data_table)

    -- Adapted from stairsplus/wall.lua, stairsplus:wall_XXX_three_quarter
    -- Creates a three-quarter tile stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_tile_three_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Three-quarter tile"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.tile_three_quarter,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 12/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {
                full_name .. "_stair_tile_quarter",
                full_name .. "_stair_tile_quarter",
                full_name .. "_stair_tile_quarter",
            },
        },
    })

    return adj_full_name

end

function unilib.stairs._register_panel_top(full_name, def_table, data_table)

    -- Adapted from stairsplus/panel.lua, stairsplus:panel_XXX_top
    -- Creates a top panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_top"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Top panel"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.panel_top,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 4/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = full_name,
        recipe = {
            {adj_full_name, adj_full_name},
            {adj_full_name, adj_full_name},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_micro_bottom"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_panel_vertical(full_name, def_table, data_table)

    -- Adapted from stairsplus/panel.lua, stairsplus:panel_XXX_vertical
    -- Creates a vertical panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_vertical"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Vertical panel"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.panel_vertical,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 4/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 8",
        recipe = {
            {full_name},
            {full_name},
        },
    })

    unilib.register_craft({
        output = full_name,
        recipe = {
            {adj_full_name, adj_full_name},
            {adj_full_name, adj_full_name},
        },
    })

    unilib.register_craft({
        output = adj_full_name .. " 2",
        recipe = {
            {full_name .. "_stair_panel_bottom"},
            {full_name .. "_stair_panel_bottom"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_micro_top(full_name, def_table, data_table)

    -- Adapted from stairsplus/micro.lua, stairsplus:micro_XXX_top
    -- Creates a top micro stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_micro_top"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Top microblock"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.micro_top,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 2/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_micro_bottom"},
        },
    })

    unilib.register_craft({
        output = full_name,
        recipe = {
            {adj_full_name, adj_full_name, adj_full_name},
            {adj_full_name, "", adj_full_name},
            {adj_full_name, adj_full_name, adj_full_name},
        },
    })

    return adj_full_name

end
