---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stairs_mixed.lua
--      Stairs from moreblocks and stairs_redo
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local node_box_table = {
    simple_half = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0, 0, 0.5},
            {-0.5, 0, 0, 0, 0.5, 0.5},
        },
    },
    simple_half_right = {
        type = "fixed",
        fixed = {
            {0, -0.5, -0.5, 0.5, 0, 0.5},
            {0, 0, 0, 0.5, 0.5, 0.5},
        },
    },
    panel_bottom = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0.5, 0, 0.5},
    },
    micro_bottom = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0, 0, 0.5},
    },
}

---------------------------------------------------------------------------------------------------
-- Stairs from moreblocks and stairs_redo
---------------------------------------------------------------------------------------------------

function unilib.stairs._register_simple_half(full_name, def_table, data_table)

    -- Adapted from stairsplus/stairs.lua, stairsplus:stair_XXX_half
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:stair_XXX_half
    -- Creates an half simple stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_simple_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Half simple stair"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag or unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.simple_half,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 6/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 4",
        recipe = {
            {full_name .. "_stair_simple", full_name .. "_stair_simple"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_simple_half_inverted"},
        },
    })

    unilib.register_craft({
        output = adj_full_name .. " 2",
        recipe = {
            {full_name .. "_stair_simple_half_right"},
            {full_name .. "_stair_simple_half_right"},
        },
    })

    if unilib.setting.add_stairs_moreblocks_flag then

        -- Adapted from moreblocks/recipes.lua

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
            },
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {full_name .. "_stair_panel_bottom", full_name .. "_stair_micro_bottom"},
        })

    end

    return adj_full_name

end

function unilib.stairs._register_simple_half_right(full_name, def_table, data_table)

    -- Adapted from stairsplus/stairs.lua, stairsplus:stair_XXX_right_half
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:stair_XXX_right_half
    -- Creates a right-half simple stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_simple_half_right"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Right-half simple stair"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag or unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.simple_half_right,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 6/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 2",
        recipe = {
            {full_name .. "_stair_simple_half"},
            {full_name .. "_stair_simple_half"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_simple_half_right_inverted"},
        },
    })

    if unilib.setting.add_stairs_moreblocks_flag then

        -- Adapted from moreblocks/recipes.lua

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {full_name .. "_stair_simple_half"},
        })

    end

    return adj_full_name

end

function unilib.stairs._register_panel_bottom(full_name, def_table, data_table)

    -- Adapted from stairsplus/panel.lua, stairsplus:panel_XXX_bottom
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:panel_XXX
    -- Creates a bottom panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_bottom"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Bottom panel"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag or unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.panel_bottom,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 4/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 8",
        recipe = {
            {full_name, full_name},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_panel_top"},
        },
    })

    unilib.register_craft({
        output = adj_full_name .. " 2",
        recipe = {
            {full_name .. "_stair_panel_vertical", full_name .. "_stair_panel_vertical"},
        },
    })

    if unilib.setting.add_stairs_moreblocks_flag then

        -- Adapted from moreblocks/recipes.lua

        unilib.register_craft({
            output = adj_full_name .. " 12",
            recipe = {
                {full_name, ""},
                {full_name, full_name},
            },
        })

        unilib.register_craft({
            output = adj_full_name .. " 12",
            recipe = {
                {"", full_name},
                {full_name, full_name},
            },
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {full_name .. "_stair_micro_bottom", full_name .. "_stair_micro_bottom"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = full_name,
            recipe = {adj_full_name, adj_full_name, adj_full_name, adj_full_name},
        })

    end

    return adj_full_name

end

function unilib.stairs._register_micro_bottom(full_name, def_table, data_table)

    -- Adapted from stairsplus/micro.lua, stairplus:micro_XXX_bottom
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:micro_XXX
    -- Creates a bottom microblock stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_micro_bottom"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Bottom microblock"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_stairsplus_flag or unilib.setting.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.micro_bottom,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 2/16)
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
        output = adj_full_name .. " 8",
        recipe = {
            {"group:stick"},
            {full_name},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_micro_top"},
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

    if unilib.setting.add_stairs_moreblocks_flag then

        -- Adapted from moreblocks/recipes.lua

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name .. " 7",
            recipe = {full_name .. "_stair_inner"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name .. " 6",
            recipe = {full_name .. "_stair_simple"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name .. " 5",
            recipe = {full_name .. "_stair_outer"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name .. " 4",
            recipe = {full_name .. "_stair_slab"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name .. " 4",
            recipe = {full_name .. "_stair_steps"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name .. " 3",
            recipe = {full_name .. "_stair_simple_half_right"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name .. " 2",
            recipe = {full_name .. "_stair_panel_bottom"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = full_name,
            recipe = {
                adj_full_name, adj_full_name, adj_full_name, adj_full_name,
                adj_full_name, adj_full_name, adj_full_name, adj_full_name,
            },
        })

    end

    return adj_full_name

end
