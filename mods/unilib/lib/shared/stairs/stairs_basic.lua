---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stairs_basic.lua
--      Basic stairs
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local node_box_table = {
    simple = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            {-0.5, 0, 0, 0.5, 0.5, 0.5},
        },
    },
    inner = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            {-0.5, 0, 0, 0.5, 0.5, 0.5},
            {-0.5, 0, -0.5, 0, 0.5, 0},
        },
    },
    outer = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            {-0.5, 0, 0, 0, 0.5, 0.5},
        },
    },
--  slab
}

---------------------------------------------------------------------------------------------------
-- Basic stairs
---------------------------------------------------------------------------------------------------

function unilib.stairs._register_simple(full_name, def_table, data_table)

    -- Adapted from stairs/init.lua, stairs:stair_XXX
    -- Adapted from stairs_redo/init.lua, stairs:stair_XXX
    -- Adapted from stairsplus/stair.lua, stairsplus:stair_XXX
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:stair_XXX
    -- Creates a simple stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_simple"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Simple stair"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.global.show_stairs_any_flag or (
            data_table.super_flag and unilib.setting.show_stairs_super_flag
        ),
        {
            node_box = node_box_table.simple,
        },
        {slab_img_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 12/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From minetest_game/stairs)
    unilib.register_craft({
        output = adj_full_name .. " 8",
        recipe = {
            {"", "", full_name},
            {"", full_name, full_name},
            {full_name, full_name, full_name},
        },
    })
    unilib.register_craft({
        output = adj_full_name .. " 8",
        recipe = {
            {full_name, "", ""},
            {full_name, full_name, ""},
            {full_name, full_name, full_name},
        },
    })

    unilib.register_craft({
        output = full_name .. " 3",
        recipe = {
            {adj_full_name, adj_full_name},
            {adj_full_name, adj_full_name},
        },
    })

    if unilib.setting.add_stairs_stairsplus_flag and not data_table.basic_flag then

        -- Adapted from stairsplus/stairs.lua

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_simple_inverted"},
            },
        })

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_simple_half", full_name .. "_stair_simple_half"},
            },
        })

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_simple_half_right", full_name .. "_stair_simple_half_right"},
            },
        })

    end

    if unilib.setting.add_stairs_moreblocks_flag and not data_table.basic_flag then

        -- Adapted from moreblocks/recipes.lua

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {full_name .. "_stair_panel_bottom", full_name .. "_stair_slab"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_panel_bottom",
                full_name .. "_stair_panel_bottom",
                full_name .. "_stair_panel_bottom",
            },
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
            },
        })

    end

    return adj_full_name

end

function unilib.stairs._register_inner(full_name, def_table, data_table)

    -- Adapted from stairs/init.lua, stairs:stair_inner_XXX
    -- Adapted from stairs_redo/init.lua, stairs:stair_inner_XXX
    -- Adapted from stairsplus/corner.lua, stairsplus:corner_XXX_inner
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:stair_XXX_inner
    -- Creates an inner stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_inner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Inner stair"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.global.show_stairs_any_flag or (
            data_table.super_flag and unilib.setting.show_stairs_super_flag
        ),
        {
            node_box = node_box_table.inner,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 14/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From minetest_game/stairs)
    unilib.register_craft({
        output = adj_full_name .. " 7",
        recipe = {
            {"", full_name, ""},
            {full_name, "", full_name},
            {full_name, full_name, full_name},
        },
    })

    if unilib.setting.add_stairs_stairsplus_flag and not data_table.basic_flag then

        -- Adapted from stairsplus/stairs.lua

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_micro_bottom", full_name .. "_stair_simple"},
            },
        })

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_corner_half"},
                {full_name .. "_stair_slab"},
            },
        })

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_inner_inverted"},
            },
        })

    end

    if unilib.setting.add_stairs_moreblocks_flag and not data_table.basic_flag then

        -- Adapted from moreblocks/recipes.lua

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
            },
        })

    end

    return adj_full_name

end

function unilib.stairs._register_outer(full_name, def_table, data_table)

    -- Adapted from stairs/init.lua, stairs:stair_outer_XXX
    -- Adapted from stairs_redo/init.lua, stairs:stair_outer_XXX
    -- Adapted from stairsplus/corner.lua, stairsplus:corner_XXX_outer
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:stair_XXX_outer
    -- Creates an outer stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_outer"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Outer stair"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.global.show_stairs_any_flag or (
            data_table.super_flag and unilib.setting.show_stairs_super_flag
        ),
        {
            node_box = node_box_table.outer,
        },
        {slab_img_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 10/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From minetest_game/stairs)
    unilib.register_craft({
        output = adj_full_name .. " 6",
        recipe = {
            {"", full_name, ""},
            {full_name, full_name, full_name},
        },
    })

    if unilib.setting.add_stairs_stairsplus_flag and not data_table.basic_flag then

        -- Adapted from stairsplus/stairs.lua

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_micro_bottom"},
                {full_name .. "_stair_slab"},
            },
        })

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_outer_inverted"},
            },
        })

    end

    if unilib.setting.add_stairs_moreblocks_flag and not data_table.basic_flag then

        -- Adapted from moreblocks/recipes.lua

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {full_name .. "_stair_micro_bottom", full_name .. "_stair_slab"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
            },
        })

    end

    return adj_full_name

end

function unilib.stairs._register_slab(full_name, def_table, data_table)

    -- Adapted from stairs/init.lua, stairs:slab_XXX
    -- Adapted from stairs_redo/init.lua, stairs:slab_XXX
    -- Adapted from stairsplus/slab.lua, stairsplus:slab_XXX
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX
    -- Creates a slab stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Slab"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.global.show_stairs_any_flag or (
            data_table.super_flag and unilib.setting.show_stairs_super_flag
        ),
        {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        {slab_flag = true, slab_img_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 8/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From minetest_game/stairs)
    unilib.register_craft({
        output = adj_full_name .. " 6",
        recipe = {
            {full_name, full_name, full_name},
        },
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {adj_full_name},
            {adj_full_name},
        },
    })

    if unilib.setting.add_stairs_stairsplus_flag and not data_table.basic_flag then

        -- Adapted from stairsplus/stairs.lua

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_slab_inverted"},
            },
        })

        unilib.register_craft({
            output = full_name,
            recipe = {
                {full_name .. "_stair_slab_inverted"},
                {full_name .. "_stair_slab_inverted"},
            },
        })

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_slab_quarter"},
                {full_name .. "_stair_slab_quarter"},
            },
        })

    end

    if unilib.setting.add_stairs_moreblocks_flag and not data_table.basic_flag then

        -- Adapted from moreblocks/recipes.lua

        unilib.register_craft({
            output = adj_full_name .. " 6",
            recipe = {
                {full_name, full_name, full_name},
            },
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
            },
        })

        -- N.B. At the time of writing, the potential conflict described in
        --      https://github.com/minetest/minetest/issues/2881 does not appear to have been
        --      resolved, therefore we continue to use two recipes, rather than one shapeless recipe
        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_panel_bottom", full_name .. "_stair_panel_bottom"},
            },
        })

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_panel_bottom"},
                {full_name .. "_stair_panel_bottom"},
            },
        })

        unilib.register_craft({
            type = "shapeless",
            output = full_name,
            recipe = {adj_full_name, adj_full_name},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name .. " 3",
            recipe = {full_name .. "_stair_simple", full_name .. "_stair_simple"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {full_name .. "_stair_slab_cut_half", full_name .. "_stair_slab_cut_half"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_slab_cut_quarter",
                full_name .. "_stair_slab_cut_quarter",
                full_name .. "_stair_slab_cut_quarter",
                full_name .. "_stair_slab_cut_quarter",
            },
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_slab_cut_eighth",
                full_name .. "_stair_slab_cut_eighth",
                full_name .. "_stair_slab_cut_eighth",
                full_name .. "_stair_slab_cut_eighth",
                full_name .. "_stair_slab_cut_eighth",
                full_name .. "_stair_slab_cut_eighth",
                full_name .. "_stair_slab_cut_eighth",
                full_name .. "_stair_slab_cut_eighth",
            },
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {full_name .. "_stair_slope_half", full_name .. "_stair_slope_half"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_slope_outer_half",
                full_name .. "_stair_slope_outer_half",
            },
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_slope_outer_cut_half",
                full_name .. "_stair_slope_outer_cut_half",
            },
        })

    end

    return adj_full_name

end
