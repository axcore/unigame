---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- carvings_farlands.lua
--      Carvings from farlands modpack
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local node_shape_table = {
    farlands_arch = {
        {-0.1875, 0.4375, -0.5, 0.1875, 0.5, 0.5},
        {-0.5, 0.375, -0.5, -0.1875, 0.5, 0.5},
        {0.1875, 0.375, -0.5, 0.5, 0.5, 0.5},
        {0.25, 0.3125, -0.5, 0.5, 0.375, 0.5},
        {-0.5, 0.3125, -0.5, -0.25, 0.375, 0.5},
        {-0.5, 0.1875, -0.5, -0.3125, 0.3125, 0.5},
        {0.3125, 0.1875, -0.5, 0.5, 0.3125, 0.5},
        {0.375, 0, -0.5, 0.5, 0.1875, 0.5},
        {-0.5, 0, -0.5, -0.375, 0.1875, 0.5},
        {0.4375, -0.5, -0.5, 0.5, 0, 0.5},
        {-0.5, -0.5, -0.5, -0.4375, 0, 0.5},
    },
    farlands_ledge = {
        {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        {-0.5, 0.3125, -0.5625, 0.5, 0.5, 0.5},
        {-0.5, 0.4375, -0.625, 0.5, 0.5, 0.5},
    },
    farlands_ledge_corner = {
        {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        {-0.5, 0.3125, -0.5625, 0.5625, 0.5, 0.5},
        {-0.5, 0.4375, -0.625, 0.625, 0.5, 0.5},
    },
    farlands_rail = {
        {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        {-0.5, -0.0625, -0.5625, 0.5, 0.125, 0.5},
        {-0.5, 0, -0.625, 0.5, 0.0625, 0.5},
    },
    farlands_rail_corner = {
        {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        {-0.5625, -0.0625, -0.5625, 0.5, 0.125, 0.5},
        {-0.625, 0, -0.625, 0.5, 0.0625, 0.5},
    },
    farlands_window = {
        {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
        {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},
        {0.25, -0.25, -0.5, 0.5, 0.25, 0.5},
        {-0.5, -0.25, -0.5, -0.25, 0.25, 0.5},
        {0.1875, 0.1875, -0.5, 0.25, 0.25, 0.5},
        {-0.25, 0.1875, -0.5, -0.1875, 0.25, 0.5},
        {-0.375, -0.375, -0.5625, 0.375, -0.25, 0.4375},
        {-0.1875, 0.25, -0.5625, 0.1875, 0.3125, -0.5},
        {-0.25, 0.1875, -0.5625, -0.1875, 0.25, -0.5},
        {0.1875, 0.1875, -0.5625, 0.25, 0.25, -0.5},
    },
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function warn_if_exists(adj_full_name)

    -- Adapted from stairs/init.lua

    if core.registered_nodes[adj_full_name] then

        unilib.utils.show_warning(
            "../lib/shared/carvings/carvings_farlands.lua: Overwriting carving node", adj_full_name
        )

    end

end

local function register_node_carving_variant(full_name, def_table)

    -- Original to unilib
    -- A simplified version of unilib.register_node(), called only by code in this file
    -- We don't update unilib.global.node_convert_table (which does not contain carving nodes), nor
    --      do we register aliases in a standard way
    -- We also don't replace carving nodes from an original mod here; that is handled by the call to
    --      unilib.register_node() for the main node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): Usual definition table for the node

    -- (At the moment this function is a simple wrapper, but that might change later)
    core.register_node(full_name, def_table)

end

local function prepare_farlands(
    full_name, def_table, adj_full_name, adj_desc, show_flag, shape_table
)
    -- In the original farlands code, the "carvings" were made from a single ingredient, so did not
    --      have separate functions for each carving type
    -- This function is therefore loosely based on prepare_column(), itself adapted from
    --      columnia/init.lua

    -- Update the original node's groups field. In the original farlands code, only "cracky = 1"
    --      was used for all carvings, but we ignore that here
    local adj_group_table = table.copy(def_table.groups)
    if not show_flag then
        adj_group_table.not_in_creative_inventory = 1
    else
        adj_group_table.not_in_creative_inventory = nil
    end

    -- Basic check
    warn_if_exists(adj_full_name)

    -- Prepare to register the node (the function is a simplified version of
    --      unilib.register_node() )
    local adj_def_table = {
        description = adj_desc,
        tiles = {def_table.tiles[1]},
        groups = adj_group_table,
        -- (no .sounds in the original farlands code)
        sounds = def_table.sounds,

        drawtype = "nodebox",
        -- (no .is_ground_content in the original farlands code)
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = shape_table,
        },
        paramtype = "light",
        paramtype2 = "facedir",
        -- Packages "glass_ordinary" and "glass_obsidian", and presumably others too, generate
        --      warnings about textures unless this line is included
        use_texture_alpha = "clip",
    }

    -- Light from light sources is reduced by a third (not in original farlands code, but done to be
    --      consistent with reduced-light stairs)
    if def_table.light_source ~= nil and def_table.light_source > 0 then

        if not unilib.reduce_carvings_light_flag then
            adj_def_table.light_source = def_table.light_source
        else
            adj_def_table.light_source = math.ceil(def_table.light_source * 0.66)
        end

    end

    if def_table.sunlight_propagates ~= nil then
        adj_def_table.sunlight_propagates = def_table.sunlight_propogates
    end

    -- Register the node
    register_node_carving_variant(adj_full_name, adj_def_table)
    -- Update global variables
    unilib.global.carving_deconvert_table[adj_full_name] = full_name
    if unilib.global.carving_convert_table[full_name] == nil then
        unilib.global.carving_convert_table[full_name] = {adj_full_name}
    else
        table.insert(unilib.global.carving_convert_table[full_name], adj_full_name)
    end

end

---------------------------------------------------------------------------------------------------
-- Carvings from farlands modpack
---------------------------------------------------------------------------------------------------

function unilib.carvings._register_farlands_arch(full_name, def_table)

    -- Adapted from farlands/decoblocks/nodes.lua, decoblocks:sandstone_arch
    -- Creates an arch farlands node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_arch"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Arch"))

    -- Register the node
    prepare_farlands(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_farlands_flag,
        node_shape_table.farlands_arch
    )

    return adj_full_name

end

function unilib.carvings._register_farlands_ledge(full_name, def_table)

    -- Adapted from farlands/decoblocks/nodes.lua, decoblocks:sandstone_ledge
    -- Creates a ledge farlands node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_ledge"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Ledge"))

    -- Register the node
    prepare_farlands(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_farlands_flag,
        node_shape_table.farlands_ledge
    )

    return adj_full_name

end

function unilib.carvings._register_farlands_ledge_corner(full_name, def_table)

    -- Adapted from farlands/decoblocks/nodes.lua, decoblocks:sandstone_ledge_corner
    -- Creates a ledge corner farlands node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_ledge_corner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Ledge Corner"))

    -- Register the node
    prepare_farlands(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_farlands_flag,
        node_shape_table.farlands_ledge_corner
    )

    return adj_full_name

end

function unilib.carvings._register_farlands_rail(full_name, def_table)

    -- Adapted from farlands/decoblocks/nodes.lua, decoblocks:sandstone_rail
    -- Creates a rail farlands node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_rail"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Rail"))

    -- Register the node
    prepare_farlands(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_farlands_flag,
        node_shape_table.farlands_rail
    )

    return adj_full_name

end

function unilib.carvings._register_farlands_rail_corner(full_name, def_table)

    -- Adapted from farlands/decoblocks/nodes.lua, decoblocks:sandstone_rail_corner
    -- Creates a rail corner farlands node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_rail_corner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Rail Corner"))

    -- Register the node
    prepare_farlands(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_farlands_flag,
        node_shape_table.farlands_rail_corner
    )

    return adj_full_name

end

function unilib.carvings._register_farlands_window(full_name, def_table)

    -- Adapted from farlands/decoblocks/nodes.lua, decoblocks:sandstone_window
    -- Creates a window farlands node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_window"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Window"))

    -- Register the node
    prepare_farlands(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_farlands_flag,
        node_shape_table.farlands_window
    )

    return adj_full_name

end
