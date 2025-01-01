---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- carvings_millwork.lua
--      Carvings from millwork mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Node shape tables for all carving types
local node_shape_table = {
    mill_crownmould = {
        {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
        {-0.5, -0.375, 0.125, 0.5, -0.125, 0.375},
        {-0.5, -0.375, 0.375, 0.5, 0.5, 0.5},
    },
    mill_crownmould_corner_inner = {
        {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
        {-0.5, -0.375, 0.125, 0.375, -0.125, 0.375},
        {0.125, -0.375, -0.5, 0.375, -0.125, 0.125},
        {-0.5, -0.375, 0.375, 0.5, 0.5, 0.5},
        {0.375, -0.375, -0.5, 0.5, 0.5, 0.375},
    },
    mill_crownmould_corner_outer = {
        {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
        {-0.5, -0.375, 0.125, -0.125, -0.125, 0.5},
        {-0.5, -0.125, 0.375, -0.375, 0.5, 0.5},
    },
    mill_crownmould_beam = {
        {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
        {-0.5, -0.375, 0.125, 0.5, -0.125, 0.375},
        {-0.25, -0.375, -0.5, 0.25, -0.1875, 0.125},
        {-0.5, -0.375, 0.375, 0.5, 0.5, 0.5},
    },
    mill_column = {
        {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
    },
    mill_column_base = {
        {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
    },
    mill_column_half = {
        {-0.5, -0.5, 0.0, 0.5, 0.5, 0.5},
    },
    mill_column_half_base = {
        {-0.5, -0.5, 0.0, 0.5, 0.5, 0.5},
    },
    mill_column_half_base_beam = {
        {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
        {-0.5, -0.375, 0.0, 0.5, 0.5, 0.5},
        {-0.25, -0.375, -0.5, 0.25, -0.1875, 0.0},
    },
    mill_column_quarter = {
        {-0.5, -0.5, 0, 0, 0.5, 0.5},
    },
    mill_column_quarter_base = {
        {-0.5, -0.5, 0, 0, 0.5, 0.5},
    },
    mill_column_quarter_base_board = {
        {-0.5, -0.5, 0, 0, 0.5, 0.5},
        {0.0, -0.5, 0.4375, 0.5, -0.1875, 0.5},
        {-0.5, -0.5, -0.5, -0.4375, -0.1875, 0.0},
    },
    mill_column_quarter_base_fancy = {
        {-0.5, -0.5, 0, 0, 0.5, 0.5},
        {0.0, -0.5, 0.3125, 0.5, 0.1875, 0.5},
        {-0.5, -0.5, -0.5, -0.3125, 0.1875, 0.0},
    },
    mill_ceiling = {
        {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
    },
    mill_ceiling_post = {
        {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
        {-0.125, -0.4375, -0.125, 0.125, 0.5, 0.125},
    },
    mill_beam = {
        {-0.25, -0.5, -0.5, 0.25, -0.1875, 0.5},
    },
    mill_beam_t = {
        {-0.5, -0.5, -0.25, -0.25, -0.1875, 0.25},
        {-0.25, -0.5, -0.5, 0.25, -0.1875, 0.5},
        {0.25, -0.5, -0.25, 0.5, -0.1875, 0.25},
    },
    mill_ceiling_beam_t = {
        {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
        {-0.5, -0.4375, -0.25, -0.25, -0.1875, 0.25},
        {-0.25, -0.4375, -0.5, 0.25, -0.1875, 0.5},
        {0.25, -0.4375, -0.25, 0.5, -0.1875, 0.25},
    },
    mill_base = {
        {-0.5, -0.5, 0.4375, 0.5, -0.1875, 0.5},
    },
    mill_base_corner_inner = {
        {-0.5, -0.5, 0.4375, 0.5, -0.1875, 0.5},
        {-0.5, -0.5, -0.5, -0.4375, -0.1875, 0.4375},
    },
    mill_base_corner_outer = {
        {0.4375, -0.5, 0.4375, 0.5, -0.1875, 0.5},
    },
    mill_base_fancy = {
        {-0.5, -0.5, 0.3125, 0.5, 0.1875, 0.5},
    },
    mill_base_fancy_corner_inner = {
        {-0.5, -0.5, 0.3125, 0.5, 0.1875, 0.5},
        {-0.5, -0.5, -0.5, -0.3125, 0.1875, 0.3125},
    },
    mill_base_fancy_corner_outer = {
        {0.3125, -0.5, 0.3125, 0.5, 0.1875, 0.5},
    },
}

-- Extra shape tables for a couple of carving types
local extra_shape_table = {
    mill_base_corner_inner = {
        {-0.5, -0.5, 0.4375, 0.5, -0.1875, 0.5},
    },
    mill_base_corner_outer = {
        {-0.5, -0.5, 0.4375, 0.5, -0.1875, 0.5},
    }
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function warn_if_exists(adj_full_name)

    -- Adapted from stairs/init.lua

    if core.registered_nodes[adj_full_name] then

        unilib.utils.show_warning(
            "../lib/shared/carvings/carvings_millwork.lua: Overwriting carving node", adj_full_name
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

local function prepare_millwork(
    full_name, def_table, adj_full_name, adj_desc, show_flag, model, select_table, collide_table
)
    -- Adapted from mymillwork/nodes.lua

    -- Most (but not all) millwork nodes have identical collision/selection tables
    if collide_table == nil then
        collide_table = select_table
    end

    -- Update the original node's groups field
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
        sounds = def_table.sounds,

        collision_box = {
            type = "fixed",
            fixed = collide_table,
        },
        drawtype = "mesh",
        -- is_ground_content not in original mymillwork code, but used to be consistent with other
        --      carvings
        is_ground_content = false,
        mesh = model,
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = select_table,
        },
        -- Packages "glass_ordinary" and "glass_obsidian", and presumably others too, generate
        --      warnings about textures unless this line is included
        use_texture_alpha = "clip",

        on_place = core.rotate_node,
    }

    -- Light from light sources is reduced by a third (not in original mymillwork code, but done to
    --      be consistent with reduced-light stairs)
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
-- Carvings from millwork mod
---------------------------------------------------------------------------------------------------

function unilib.carvings._register_mill_crownmould(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:crownmould_XXX
    -- Creates a crown mould millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_crownmould"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Crown mould"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_crownmould.obj",
        node_shape_table.mill_crownmould
    )

    return adj_full_name

end

function unilib.carvings._register_mill_crownmould_corner_inner(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:crownmould_ic_XXX
    -- Creates an inner corner crown mould millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_crownmould_corner_inner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Inner corner crown mould"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_crownmould_corner_inner.obj",
        node_shape_table.mill_crownmould_corner_inner
    )

    return adj_full_name

end

function unilib.carvings._register_mill_crownmould_corner_outer(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:crownmould_oc_XXX
    -- Creates an outer corner crown mould millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_crownmould_corner_outer"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Outer corner crown mould"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_crownmould_corner_outer.obj",
        node_shape_table.mill_crownmould_corner_outer
    )

    return adj_full_name

end

function unilib.carvings._register_mill_crownmould_beam(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:crownmould_beam_XXX
    -- Creates a crown mould with beam millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_crownmould_beam"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Crown mould with beam"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_crownmould_beam.obj",
        node_shape_table.mill_crownmould_beam
    )

    return adj_full_name

end

function unilib.carvings._register_mill_column(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:crownmould_XXX
    -- Creates a milled column millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Milled column"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_column.obj",
        node_shape_table.mill_column
    )

    return adj_full_name

end

function unilib.carvings._register_mill_column_base(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:column_base_XXX
    -- Creates a milled column base millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column_base"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Milled column base"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_column_base.obj",
        node_shape_table.mill_column_base
    )

    return adj_full_name

end

function unilib.carvings._register_mill_column_half(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:column_half_XXX
    -- Creates a milled half column millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Milled half column"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_column_half.obj",
        node_shape_table.mill_column_half
    )

    return adj_full_name

end

function unilib.carvings._register_mill_column_half_base(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:column_half_base_XXX
    -- Creates a milled half column base millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column_half_base"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Milled half column base"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_column_half_base.obj",
        node_shape_table.mill_column_half_base
    )

    return adj_full_name

end

function unilib.carvings._register_mill_column_half_base_beam(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:column_half_wbeam_XXX
    -- Creates a milled half column base with beam millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column_half_base_beam"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc =
            unilib.utils.brackets(def_table.description, S("Milled half column base with beam"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_column_half_base_beam.obj",
        node_shape_table.mill_column_half_base_beam
    )

    return adj_full_name

end

function unilib.carvings._register_mill_column_quarter(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:column_quarter_XXX
    -- Creates a milled quarter column millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Milled quarter column"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_column_quarter.obj",
        node_shape_table.mill_column_quarter
    )

    return adj_full_name

end

function unilib.carvings._register_mill_column_quarter_base(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:column_quarter_base_XXX
    -- Creates a milled quarter column base millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column_quarter_base"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Quarter column base"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_column_quarter_base.obj",
        node_shape_table.mill_column_quarter_base
    )

    return adj_full_name

end

function unilib.carvings._register_mill_column_quarter_base_board(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:column_quarter_wbase_XXX
    -- Creates a milled quarter column with baseboard millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column_quarter_base_board"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc =
            unilib.utils.brackets(def_table.description, S("Milled quarter column baseboard"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_column_quarter_base_board.obj",
        node_shape_table.mill_column_quarter_base_board
    )

    return adj_full_name

end

function unilib.carvings._register_mill_column_quarter_base_fancy(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:column_quarter_fancybase_XXX
    -- Creates a milled quarter column with fancy baseboard millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column_quarter_base_fancy"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(
        def_table.description, S("Milled quarter column fancy baseboard")
    )

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_column_quarter_bace_fancy.obj",
        node_shape_table.mill_column_quarter_base_fancy
    )

    return adj_full_name

end

function unilib.carvings._register_mill_ceiling(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:ceiling_XXX
    -- Creates a milled ceiling millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_ceiling"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Milled ceiling"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_ceiling.obj",
        node_shape_table.mill_ceiling
    )

    return adj_full_name

end

function unilib.carvings._register_mill_ceiling_post(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:ceiling_post_XXX
    -- Creates a milled ceiling post millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_ceiling_post"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Milled ceiling post"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_ceiling_post.obj",
        node_shape_table.mill_ceiling_post
    )

    return adj_full_name

end

function unilib.carvings._register_mill_beam(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:beam_XXX
    -- Creates a milled beam millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_beam"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Milled beam"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_beam.obj",
        node_shape_table.mill_beam
    )

    return adj_full_name

end

function unilib.carvings._register_mill_beam_t(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:beam_t_XXX
    -- Creates a milled T-beam millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_beam_t"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Milled T-beam"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_beam_t.obj",
        node_shape_table.mill_beam_t
    )

    return adj_full_name

end

function unilib.carvings._register_mill_ceiling_beam_t(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:beam_ceiling_t_XXX
    -- Creates a milled ceiling with T-beam millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_ceiling_beam_t"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Milled ceiling with T-beam"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_ceiling_beam_t.obj",
        node_shape_table.mill_ceiling_beam_t
    )

    return adj_full_name

end

function unilib.carvings._register_mill_base(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:base_XXX
    -- Creates a baseboard millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_base"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Baseboard"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_base.obj",
        node_shape_table.mill_base
    )

    return adj_full_name

end

function unilib.carvings._register_mill_base_corner_inner(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:base_ic_XXX
    -- Creates an inner corner baseboard millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_base_corner_inner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Inner corner baseboard"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_base_corner_inner.obj",
        node_shape_table.mill_base_corner_inner,
        extra_shape_table.mill_base_corner_inner
    )

    return adj_full_name

end

function unilib.carvings._register_mill_base_corner_outer(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:base_oc_XXX
    -- Creates an outer corner baseboard millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_base_corner_outer"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Outer corner baseboard"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_base_corner_outer.obj",
        node_shape_table.mill_base_corner_outer,
        extra_shape_table.mill_base_corner_outer
    )

    return adj_full_name

end

function unilib.carvings._register_mill_base_fancy(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:base_fancy_XXX
    -- Creates a fancy baseboard millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_base_fancy"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Fancy baseboard"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_base_fancy.obj",
        node_shape_table.mill_base_fancy
    )

    return adj_full_name

end

function unilib.carvings._register_mill_base_fancy_corner_inner(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:base_fancy_ic_XXX
    -- Creates an fancy baseboard inner corner millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_base_fancy_corner_inner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Fancy baseboard inner corner"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_base_fancy_corner_inner.obj",
        node_shape_table.mill_base_fancy_corner_inner
    )

    return adj_full_name

end

function unilib.carvings._register_mill_base_fancy_corner_outer(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:base_fancy_oc_XXX
    -- Creates an fancy baseboard outer corner millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_base_fancy_corner_outer"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Fancy baseboard outer corner"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_millwork_flag,
        "unilib_mill_base_fancy_corner_outer.obj",
        node_shape_table.mill_base_fancy_corner_outer
    )

    return adj_full_name

end
