---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stairs_castle.lua
--      Stairs from castle modpack
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local node_box_table = {
    hole_murder = {
        type = "fixed",
        fixed = {
            {-8/16, -8/16, -8/16, -4/16, 8/16, 8/16},
            {4/16, -8/16, -8/16, 8/16, 8/16, 8/16},
            {-4/16, -8/16, -8/16, 4/16, 8/16, -4/16},
            {-4/16, -8/16, 8/16, 4/16, 8/16, 4/16},
        },
    },
    hole_machicolation = {
        type = "fixed",
        fixed = {
            {-0.5, 0, -0.5, 0.5, 0.5, 0},
            {-0.5, -0.5, 0, -0.25, 0.5, 0.5},
            {0.25, -0.5, 0, 0.5, 0.5, 0.5},
        },
    },
    pillar_bottom = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
            {-0.375, -0.375, -0.375, 0.375, -0.125, 0.375},
            {-0.25, -0.125, -0.25, 0.25, 0.5, 0.25},
        },
    },
    pillar_bottom_half = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0, 0.5, -0.375, 0.5},
            {-0.375, -0.375, 0.125, 0.375, -0.125, 0.5},
            {-0.25, -0.125, 0.25, 0.25, 0.5, 0.5},
        },
    },
    pillar_top = {
        type = "fixed",
        fixed = {
            {-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5},
            {-0.375, 0.0625, -0.375, 0.375, 0.3125, 0.375},
            {-0.25, -0.5, -0.25, 0.25, 0.0625, 0.25},
        },
    },
    pillar_top_half = {
        type = "fixed",
        fixed = {
            {-0.5, 0.3125, 0, 0.5, 0.5, 0.5},
            {-0.375, 0.0625, 0.125, 0.375, 0.3125, 0.5},
            {-0.25, -0.5, 0.25, 0.25, 0.0625, 0.5},
        },
    },
    pillar_middle = {
        type = "fixed",
        fixed = {
            {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
        },
    },
    pillar_middle_half = {
        type = "fixed",
        fixed = {
            {-0.25, -0.5, 0.25, 0.25, 0.5, 0.5},
        },
    },
    pillar_crossbrace = {
        type = "connected",
        fixed = {-0.25, 0.25, -0.25, 0.25, 0.5, 0.25},
        connect_front = {-0.25, 0.25, -0.75, 0.25, 0.5, -0.25},
        connect_left = {-0.25, 0.25, -0.25, -0.75, 0.5, 0.25},
        connect_back = {-0.25, 0.25, 0.25, 0.25, 0.5, 0.75},
        connect_right = {0.25, 0.25, -0.25, 0.75, 0.5, 0.25},
    },
    pillar_crossbrace_ext = {
        type = "fixed",
        fixed = {-1.25, 0.25, -0.25, 1.25, 0.5, 0.25},
    },
    slit = {
        type = "fixed",
        fixed = {
            {-0.5, -0.375, 0.5, -0.0625, 0.375, 0.3125},
            {0.0625, -0.375, 0.5, 0.5, 0.375, 0.3125},
            {-0.5, 0.375, 0.5, 0.5, 0.5, 0.3125},
            {-0.5, -0.5, 0.5, 0.5, -0.375, 0.3125},
            {0.25, -0.5, 0.3125, 0.5, 0.5, 0.125},
            {-0.5, -0.5, 0.3125, -0.25, 0.5, 0.125},
        },
    },
    slit_cross = {
        type = "fixed",
        fixed = {
            {-0.5, -0.125, 0.5, -0.0625, 0.375, 0.3125},
            {0.0625, -0.125, 0.5, 0.5, 0.375, 0.3125},
            {-0.5, 0.375, 0.5, 0.5, 0.5, 0.3125},
            {-0.5, -0.5, 0.5, 0.5, -0.375, 0.3125},
            {0.0625, -0.375, 0.5, 0.5, -0.25, 0.3125},
            {-0.5, -0.375, 0.5, -0.0625, -0.25, 0.3125},
            {-0.5, -0.25, 0.5, -0.1875, -0.125, 0.3125},
            {0.1875, -0.25, 0.5, 0.5, -0.125, 0.3125},
            {0.25, -0.5, 0.3125, 0.5, 0.5, 0.125},
            {-0.5, -0.5, 0.3125, -0.25, 0.5, 0.125},
        },
    },
    slit_hole = {
        type = "fixed",
        fixed = {
            {-0.5, -0.375, 0.5, -0.125, 0.375, 0.3125},
            {0.125, -0.375, 0.5, 0.5, 0.375, 0.3125},
            {-0.5, -0.5, 0.5, 0.5, -0.375, 0.3125},
            {0.0625, -0.125, 0.5, 0.125, 0.375, 0.3125},
            {-0.125, -0.125, 0.5, -0.0625, 0.375, 0.3125},
            {-0.5, 0.375, 0.5, 0.5, 0.5, 0.3125},
            {0.25, -0.5, 0.3125, 0.5, 0.5, 0.125},
            {-0.5, -0.5, 0.3125, -0.25, 0.5, 0.125},
        },
    },
    slit_embrasure = {
        type = "fixed",
        fixed = {
            {-0.25, -0.5, 0.375, -0.125, 0.5, 0.5},
            {0.125, -0.5, 0.375, 0.25, 0.5, 0.5},
            {0.25, -0.5, 0.25, 0.5, 0.5, 0.5},
            {0.375, -0.5, 0.125, 0.5, 0.5, 0.25},
            {-0.5, -0.5, 0.25, -0.25, 0.5, 0.5},
            {-0.5, -0.5, 0.125, -0.375, 0.5, 0.25},
        },
    },
}

---------------------------------------------------------------------------------------------------
-- Stairs from castle modpack
---------------------------------------------------------------------------------------------------

function unilib.stairs._register_hole_murder(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/murder_holes.lua, castle_masonry:hole_XXX
    -- Creates a murder hole stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_hole_murder"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Murder hole"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_castle_flag,
        {
            node_box = node_box_table.hole_murder,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 8/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name .. " 4",
        recipe = {
            {"", full_name, ""},
            {full_name, "", full_name},
            {"", full_name, ""},
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_hole_machicolation"},
    })

    return adj_full_name

end

function unilib.stairs._register_hole_machicolation(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/murder_holes.lua, castle_masonry:machicolation_XXX
    -- Creates a machicolation stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_hole_machicolation"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Machicolation"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_castle_flag,
        {
            node_box = node_box_table.hole_machicolation,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 8/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_hole_murder"},
    })

    return adj_full_name

end

function unilib.stairs._register_pillar_bottom(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/pillars.lua, castle_masonry:pillar_XXX_bottom
    -- Creates a pillar base stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_pillar_bottom"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Pillar base"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_castle_flag,
        {
            node_box = node_box_table.pillar_bottom,
        },
        {crossbrace_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 10/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name .. " 4",
        recipe = {
            {"", full_name, ""},
            {"", full_name, ""},
            {full_name, full_name, full_name},
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_pillar_bottom_half", full_name .. "_pillar_bottom_half"},
    })

    return adj_full_name

end

function unilib.stairs._register_pillar_bottom_half(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/pillars.lua, castle_masonry:pillar_XXX_bottom_half
    -- Creates a half pillar base stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_pillar_bottom_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Half pillar base"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_castle_flag,
        {
            node_box = node_box_table.pillar_bottom_half,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 5/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name .. " 2",
        recipe = {full_name .. "_pillar_bottom"},
    })

    return adj_full_name

end

function unilib.stairs._register_pillar_top(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/pillars.lua, castle_masonry:pillar_XXX_top
    -- Creates a pillar top stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_pillar_top"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Pillar top"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_castle_flag,
        {
            node_box = node_box_table.pillar_top,
        },
        {crossbrace_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 10/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name .. " 4",
        recipe = {
            {full_name, full_name, full_name},
            {"", full_name, ""},
            {"", full_name, ""},
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_pillar_top_half", full_name .. "_pillar_top_half"},
    })

    return adj_full_name

end

function unilib.stairs._register_pillar_top_half(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/pillars.lua, castle_masonry:pillar_XXX_top_half
    -- Creates a half pillar top stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_pillar_top_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Half pillar top"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_castle_flag,
        {
            node_box = node_box_table.pillar_top_half,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 5/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name .. " 2",
        recipe = {full_name .. "_pillar_top"},
    })

    return adj_full_name

end

function unilib.stairs._register_pillar_middle(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/pillars.lua, castle_masonry:pillar_XXX_middle
    -- Creates a pillar middle stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_pillar_middle"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Pillar middle"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_castle_flag,
        {
            node_box = node_box_table.pillar_middle,
        },
        {crossbrace_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 12/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name .. " 4",
        recipe = {
            {full_name, full_name},
            {full_name, full_name},
            {full_name, full_name},
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_pillar_middle_half", full_name .. "_pillar_middle_half"},
    })

    return adj_full_name

end

function unilib.stairs._register_pillar_middle_half(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/pillars.lua, castle_masonry:pillar_XXX_middle_half
    -- Creates a half pillar middle stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_pillar_middle_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Half pillar middle"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_castle_flag,
        {
            node_box = node_box_table.pillar_middle_half,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 6/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name .. " 2",
        recipe = {full_name .. "_pillar_middle"},
    })

    return adj_full_name

end

function unilib.stairs._register_pillar_crossbrace(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/pillars.lua, castle_masonry:pillar_XXX_crossbrace
    -- Creates a pillar crossbrace stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_pillar_crossbrace"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Pillar crossbrace"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_castle_flag,
        {
            node_box = node_box_table.pillar_crossbrace,
        }
    )
    -- (Unusual step to make the crossbrace_connectable group work as intended)
    unilib.override_item(adj_full_name, {
        connects_to = {
            full_name .. "_pillar_crossbrace",
            full_name .. "_pillar_crossbrace_ext",
            "group:crossbrace_connectable",
        },
        connect_sides = {"front", "left", "back", "right"},
    })

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 10/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name .. " 10",
        recipe = {
            {full_name, "", full_name},
            {"", full_name, ""},
            {full_name, "", full_name},
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_pillar_crossbrace_ext"},
    })

    return adj_full_name

end

function unilib.stairs._register_pillar_crossbrace_ext(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/pillars.lua, castle_masonry:pillar_XXX_extended_crossbrace
    -- Creates a pillar extended crossbrace stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_pillar_crossbrace_ext"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Pillar extended crossbrace"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_castle_flag,
        {
            node_box = node_box_table.pillar_crossbrace_ext,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 10/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_pillar_crossbrace"},
    })

    return adj_full_name

end

function unilib.stairs._register_slit(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/arrow_slits.lua, castle_masonry:arrowslit_XXX
    -- Creates an arrow slit stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slit"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Arrow slit"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_castle_flag,
        {
            node_box = node_box_table.slit,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 6/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name .. " 6",
        recipe = {
            {full_name, "", full_name},
            {full_name, "", full_name},
            {full_name, "", full_name},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_slit_embrasure"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_slit_cross(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/arrow_slits.lua, castle_masonry:arrowslit_XXX_cross
    -- Creates an arrow slit with cross stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slit_cross"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Arrow slit with cross"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_castle_flag,
        {
            node_box = node_box_table.slit_cross,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 6/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_slit"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_slit_hole(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/arrow_slits.lua, castle_masonry:arrowslit_XXX_hole
    -- Creates an arrow slit with hole stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slit_hole"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Arrow slit with hole"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_castle_flag,
        {
            node_box = node_box_table.slit_hole,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 6/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_slit_cross"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_slit_embrasure(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/arrow_slits.lua, castle_masonry:arrowslit_XXX_embrasure
    -- Creates an arrow slit with embrasure stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slit_embrasure"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Arrow slit with embrasure"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_castle_flag,
        {
            node_box = node_box_table.slit_embrasure,
        }
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 6/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_slit_hole"},
        },
    })

    return adj_full_name

end
