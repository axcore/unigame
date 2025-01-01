---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- carvings_facade.lua
--      Carvings from facade mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local node_shape_table = {
    facade_bannerstone = {
        {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        {-0.5, 0.25, -0.5625, 0.5, 0.375, -0.5},
        {-0.5, -0.375, -0.5625, 0.5, -0.25, -0.5},
    },
    facade_bannerstone_corner = {
        {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        {-0.5625, 0.25, -0.5625, 0.5625, 0.375, 0.5625},
        {-0.5625, -0.375, -0.5625, 0.5625, -0.25, 0.5625},
    },
    facade_centrestone = {
        {-0.4375, -0.4375, -0.4375, 0.4375, 0.4375, 0.4375},
        {-0.5, -0.25, 0.0625, 0.5, 0.25, 0.25},
        {-0.5, -0.25, -0.25, 0.5, 0.25, -0.0625},
        {-0.25, -0.25, -0.5, -0.0625, 0.25, 0.5},
        {0.0625, -0.25, -0.5, 0.25, 0.25, 0.5},
        {-0.5, 0.0625, -0.25, 0.5, 0.25, 0.25},
        {-0.5, -0.25, -0.25, 0.5, -0.0625, 0.25},
        {-0.25, -0.25, -0.5, 0.25, -0.0625, 0.5},
        {-0.25, 0.0625, -0.5, 0.25, 0.25, 0.5},
        {-0.25, -0.5, -0.25, 0.25, 0.5, -0.0625},
        {-0.25, -0.5, 0.0625, 0.25, 0.5, 0.25},
        {0.0625, -0.5, -0.1875, 0.25, 0.5, 0.1875},
        {-0.25, -0.5, -0.1875, -0.0625, 0.5, 0.1875},
        {-0.5, 0.3125, 0.3125, 0.5, 0.5, 0.5},
        {-0.5, 0.3125, -0.5, 0.5, 0.5, -0.3125},
        {0.3125, 0.3125, -0.5, 0.5, 0.5, 0.5},
        {-0.5, 0.3125, -0.5, -0.3125, 0.5, 0.5},
        {-0.5, -0.5, -0.5, -0.3125, -0.3125, 0.5},
        {0.3125, -0.5, -0.5, 0.5, -0.3125, 0.5},
        {-0.5, -0.5, -0.5, 0.5, -0.3125, -0.3125},
        {-0.5, -0.5, 0.3125, 0.5, -0.3125, 0.5},
        {0.3125, -0.5, -0.5, 0.5, 0.5, -0.3125},
        {0.3125, -0.5, 0.3125, 0.5, 0.5, 0.5},
        {-0.5, -0.5, 0.3125, -0.3125, 0.5, 0.5},
        {-0.5, -0.5, -0.5, -0.3125, 0.5, -0.3125},
    },
    facade_column = {
        {-0.5, -0.5, -0.4375, 0.5, 0.5, 0.4375},
        {-0.5, -0.5, -0.5, -0.3125, 0.5, 0.5},
        {0.3125, -0.5, -0.5, 0.5, 0.5, 0.5},
        {0.0625, -0.5, -0.5, 0.1875, 0.5, 0.5},
        {-0.1875, -0.5, -0.5, -0.0625, 0.5, 0.5},
    },
    facade_column_corner = {
        {-0.4375, -0.5, -0.4375, 0.4375, 0.5, 0.4375},
        {-0.5, -0.5, 0.3125, -0.3125, 0.5, 0.5},
        {0.3125, -0.5, -0.5, 0.5, 0.5, -0.3125},
        {0.0625, -0.5, -0.5, 0.1875, 0.5, 0.5},
        {-0.1875, -0.5, -0.5, -0.0625, 0.5, 0.5},
        {0.3125, -0.5, 0.3125, 0.5, 0.5, 0.5},
        {-0.5, -0.5, -0.5, -0.3125, 0.5, -0.3125},
        {-0.5, -0.5, 0.0625, 0.5, 0.5, 0.1875},
        {-0.5, -0.5, -0.1875, 0.5, 0.5, -0.0625},
    },
    facade_corbel = {
        {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
        {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
        {-0.1875, -0.3125, -0.3125, 0.1875, 0.5, 0},
    },
    facade_corbel_corner = {
        {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
        {-0.5, -0.5, 0, 0, 0.5, 0.5},
        {0, -0.3125, -0.3125, 0.3125, 0.5, 0},
    },
    facade_corbel_corner_inner = {
        {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
        {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
        {0, -0.3125, -0.3125, 0.3125, 0.5, 0},
        {-0.5, -0.5, -0.5, 0, 0.5, 0.5},
    },
    facade_swirl = {
        {-0.5, -0.5, -0.4375, 0.5, 0.5, 0.5},
        {-0.5, 0.4375, -0.5, 0.5, 0.5, -0.4375},
        {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
        {-0.4375, -0.375, -0.5, -0.3125, 0.375, -0.4375},
        {-0.5, -0.375, -0.5, -0.3125, -0.25, 0.5},
        {-0.4375, 0.25, -0.5, 0.4375, 0.375, 0.5},
        {0.3125, -0.125, -0.5, 0.4375, 0.25, 0.5},
        {-0.1875, -0.375, -0.5, 0.5, -0.25, 0.5},
        {-0.1875, -0.25, -0.5, -0.0625, 0.125, 0.5},
        {0.0625, -0.125, -0.5, 0.3125, 0, 0.5},
        {-0.0625, 0, -0.5, 0.1875, 0.125, 0.5},
    },
    facade_swirl_corner = {
        {-0.4375, -0.5, -0.4375, 0.5, 0.5, 0.5},
        {-0.5, 0.4375, -0.5, 0.5, 0.5, -0.4375},
        {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
        {-0.4375, -0.375, -0.5, -0.3125, 0.375, -0.4375},
        {-0.5, -0.375, -0.5, -0.3125, -0.25, 0.1875},
        {-0.4375, 0.25, -0.5, 0.4375, 0.375, 0.5},
        {0.3125, -0.125, -0.5, 0.4375, 0.25, 0.5},
        {-0.1875, -0.375, -0.5, 0.5, -0.25, 0.5},
        {-0.1875, -0.25, -0.5, -0.0625, 0.125, 0.5},
        {0.0625, -0.125, -0.5, 0.3125, 0, 0.5},
        {-0.0625, 0, -0.5, 0.1875, 0.125, 0.5},
        {-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
        {-0.5, -0.125, -0.4375, 0.5, 0.375, -0.3125},
        {-0.5, 0.25, -0.3125, 0.5, 0.375, 0.4375},
        {-0.5, -0.375, 0.3125, 0.4375, 0.375, 0.4375},
        {-0.5, -0.375, 0.3125, 0.4375, -0.25, 0.5},
        {-0.5, -0.125, -0.3125, 0.4375, 0, -0.0625},
        {-0.5, 0, -0.1875, 0.4375, 0.125, 0.1875},
        {-0.5, -0.25, 0.0625, 0.4375, 0.125, 0.1875},
    },
    facade_fascia = {
        {-0.5, -0.5, 0.375, 0.5, -0.3125, 0.5},
        {-0.5, -0.3125, 0.25, 0.5, -0.125, 0.5},
        {-0.5, -0.125, 0.125, 0.5, 0.5, 0.5},
    },
    facade_fascia_corner_inner = {
        {-0.5, -0.5, 0.375, 0.5, -0.3125, 0.5},
        {-0.5, -0.3125, 0.25, 0.5, -0.125, 0.5},
        {-0.5, -0.125, 0.125, 0.5, 0.5, 0.5},
        {0.375, -0.5, -0.5, 0.5, -0.3125, 0.375},
        {0.25, -0.3125, -0.5, 0.5, -0.0625, 0.25},
        {0.125, -0.125, -0.5, 0.5, 0.5, 0.125},
    },
    facade_fascia_corner_outer = {
        {-0.5, -0.5, 0.375, 0.5, -0.3125, 0.5},
        {-0.5, -0.3125, 0.25, 0.5, -0.0625, 0.5},
        {-0.5, -0.125, 0.125, 0.5, 0.5, 0.5},
        {-0.625, -0.5, 0.375, -0.5, -0.3125, 1.5},
        {-0.75, -0.3125, 0.25, -0.5, -0.125, 1.5},
        {-0.875, -0.125, 0.125, -0.5, 0.5, 1.5},
    },
    facade_bricks_corner = {
        {-0.5625, -0.5, 0.4375, -0.5, 0, 1},
        {-0.5, -0.5, 0.4375, 0, 0, 0.5},
        {-0.5625, 0, 0.5, -0.5, 0.5, 1.5},
        {-0.5625, 0, 0.4375, 0.5, 0.5, 0.5},
    },
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function warn_if_exists(adj_full_name)

    -- Adapted from stairs/init.lua

    if core.registered_nodes[adj_full_name] then

        unilib.utils.show_warning(
            "../lib/shared/carvings/carvings_facade.lua: Overwriting carving node", adj_full_name
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

local function prepare_facade(
    full_name, def_table, adj_full_name, adj_desc, show_flag, img_list, shape_table, select_flag
)
    -- Adapted from facade/init.lua

    -- Update the original node's groups field (which was the same for everything)
    -- The original facade code was only applied to stone, but unilib code is less strict, so we
    --      have to be prepared for woods and other node types
    local group_table = table.copy(def_table.groups)
    local adj_group_table = {cracky = 3, oddly_breakable_by_hand = 2}
    if group_table.stone ~= nil then
        adj_group_table.stone = 1
    end

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
        tiles = img_list,
        groups = adj_group_table,
        sounds = def_table.sounds,

        drawtype = "nodebox",
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

    if select_flag ~= nil then

        adj_def_table.selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        }

    end

    -- Light from light sources is reduced by a third (not in original facade code, but done to be
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
-- Carvings from facade mod
---------------------------------------------------------------------------------------------------

function unilib.carvings._register_facade_bannerstone(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_bannerstone
    -- Creates a bannerstone facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_bannerstone"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Bannerstone"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_bannerstone_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_facade_flag,
        {top_img, top_img, top_img, top_img, top_img, overlay_img},
        node_shape_table.facade_bannerstone,
        true
    )

    return adj_full_name

end

function unilib.carvings._register_facade_bannerstone_corner(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_bannerstone_corner
    -- Creates a bannerstone corner facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_bannerstone_corner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Bannerstone corner"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_bannerstone_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_facade_flag,
        {top_img, top_img, overlay_img, overlay_img, overlay_img, overlay_img},
        node_shape_table.facade_bannerstone_corner,
        true
    )

    return adj_full_name

end

function unilib.carvings._register_facade_centrestone(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_centrestone
    -- Creates a centrestone facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_centrestone"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Centerstone"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_centrestone_overlay.png"

    -- (N.B. the original facade code omitted param2 for this node, but unilib includes it)

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_facade_flag,
        {overlay_img},
        node_shape_table.facade_centrestone,
        true
    )

    return adj_full_name

end

function unilib.carvings._register_facade_column(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_column
    -- Creates a column facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_column"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Column facade"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_column_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_facade_flag,
        {top_img, top_img, top_img, top_img, overlay_img, overlay_img},
        node_shape_table.facade_column,
        true
    )

    return adj_full_name

end

function unilib.carvings._register_facade_column_corner(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_column_corner
    -- Creates a column corner facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_column_corner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Column facade corner"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_column_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_facade_flag,
        {top_img, top_img, overlay_img, overlay_img, overlay_img, overlay_img},
        node_shape_table.facade_column_corner,
        true
    )

    return adj_full_name

end

function unilib.carvings._register_facade_corbel(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_corbel
    -- Creates a corbel facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_corbel"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Corbel"))

    local top_img = def_table.tiles[1]

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_facade_flag,
        {top_img},
        node_shape_table.facade_corbel,
        false
    )

    return adj_full_name

end

function unilib.carvings._register_facade_corbel_corner(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_corbel_corner
    -- Creates a corbel corner facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_corbel_corner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Corbel corner"))

    local top_img = def_table.tiles[1]

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_facade_flag,
        {top_img},
        node_shape_table.facade_corbel_corner,
        false
    )

    return adj_full_name

end

function unilib.carvings._register_facade_corbel_corner_inner(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_corbel_corner_inner
    -- Creates an inner corbel corner facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_corbel_corner_inner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Inner corbel corner"))

    local top_img = def_table.tiles[1]

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_facade_flag,
        {top_img},
        node_shape_table.facade_corbel_corner_inner,
        false
    )

    return adj_full_name

end

function unilib.carvings._register_facade_swirl(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_carved_stone_a
    -- Creates a swirl facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_swirl"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Swirl"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_swirl_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_facade_flag,
        {top_img, top_img, top_img, top_img, top_img, overlay_img},
        node_shape_table.facade_swirl,
        true
    )

    return adj_full_name

end

function unilib.carvings._register_facade_swirl_corner(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_carved_stone_a_corner
    -- Creates a swirl corner facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_swirl_corner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Swirl corner"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_swirl_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_facade_flag,
        {top_img, top_img, top_img, overlay_img, top_img, overlay_img},
        node_shape_table.facade_swirl_corner,
        true
    )

    return adj_full_name

end

function unilib.carvings._register_facade_fascia(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_rgspro
    -- Creates a fascia facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_fascia"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Fascia"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_fascia_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_facade_flag,
        {top_img, top_img, overlay_img, overlay_img, overlay_img, overlay_img},
        node_shape_table.facade_fascia,
        false
    )

    return adj_full_name

end

function unilib.carvings._register_facade_fascia_corner_inner(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_rgspro_inner_corner
    -- Creates an inner corner fascia facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_fascia_corner_inner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Inner corner fascia"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_fascia_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_facade_flag,
        {top_img, top_img, overlay_img, overlay_img, overlay_img, overlay_img},
        node_shape_table.facade_fascia_corner_inner,
        false
    )

    return adj_full_name

end

function unilib.carvings._register_facade_fascia_corner_outer(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_rgspro_outer_corner
    -- Creates an outer corner fascia facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_fascia_corner_outer"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Outer corner fascia"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_fascia_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_facade_flag,
        {top_img, top_img, overlay_img, overlay_img, overlay_img, overlay_img},
        node_shape_table.facade_fascia_corner_outer,
        false
    )

    return adj_full_name

end

function unilib.carvings._register_facade_bricks_corner(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_corner_bricks
    -- Creates a corner bricks facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_bricks_corner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Corner bricks"))

    local top_img = def_table.tiles[1]

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_facade_flag,
        {top_img},
        node_shape_table.facade_bricks_corner,
        false
    )

    return adj_full_name

end
