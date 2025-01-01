---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stairs_plantlife.lua
--      Stairs from plantlife
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local node_box_table = {
    corner_roof = {
        type = "fixed",
        fixed = {
            {-1/2, 0, 0, 0, 1/2, 1/2},
            {0, -1/2, 0, 1/2, 0, 1/2},
            {-1/2, -1/2, -1/2, 0, 0, 0},
        },
    },
    corner_roof_inverted = {
        type = "fixed",
        fixed = {
            {-1/2, -1/2, 0, 0, 0, 1/2},
            {0, 0, 0, 1/2, 1/2, 1/2},
            {-1/2, 0, -1/2, 0, 1/2, 0},
        },
    },
}

---------------------------------------------------------------------------------------------------
-- Stairs from plantlife
---------------------------------------------------------------------------------------------------

function unilib.stairs._register_corner_roof(full_name, def_table, data_table)

    -- Adapted from plantlife/trunks/nodes.lua, e.g. woodstuff:twigs_roof_corner
    -- Creates a roof corner stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_corner_roof"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Roof corner"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_plantlife_flag,
        {
            node_box = node_box_table.corner_roof,
        },
        {no_advanced_rotation_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 4/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From plantlife)
    unilib.register_craft({
        output = adj_full_name .. " 8",
        recipe = {
            {"", full_name, ""},
            {full_name, "", full_name},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_corner_roof_inverted"},
        },
    })

    return adj_full_name

end

function unilib.stairs._register_corner_roof_inverted(full_name, def_table, data_table)

    -- Adapted from plantlife/trunks/nodes.lua, e.g. woodstuff:twigs_roof_corner_2
    -- Creates an inverted roof corner stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_corner_roof_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Inverted roof corner"))

    -- Register the node
    unilib.stairs._prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.setting.show_stairs_plantlife_flag,
        {
            node_box = node_box_table.corner_roof_inverted,
        },
        {no_advanced_rotation_flag = true}
    )

    -- Register crafts
    unilib.stairs._create_fuel_recipe(full_name, adj_full_name, 4/16)
    unilib.stairs._create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From plantlife)
    unilib.register_craft({
        output = adj_full_name .. " 8",
        recipe = {
            {full_name, "", full_name},
            {"", full_name, ""},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_corner_roof"},
        },
    })

    return adj_full_name

end
