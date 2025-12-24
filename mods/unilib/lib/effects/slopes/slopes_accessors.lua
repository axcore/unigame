---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- slopes_accessors.lua
--      Set up natural slopes. Code adapted from the "naturalslopeslib" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Bounding boxes
local slope_straight_box = {
    type = "fixed",
    fixed = {
        {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        {-0.5, 0, 0, 0.5, 0.5, 0.5},
    },
}
local slope_inner_corner_box = {
    type = "fixed",
    fixed = {
        {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        {-0.5, 0, 0, 0.5, 0.5, 0.5},
        {-0.5, 0, -0.5, 0, 0.5, 0},
    },
}
local slope_outer_corner_box = {
    type = "fixed",
    fixed = {
        {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        {-0.5, 0, 0, 0, 0.5, 0.5},
    },
}
local slope_pike_box = {
    type = "fixed",
    fixed = {
        {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
    },
}

-- Regex list (defined inside a function in original code)
local regex_list = {
    "^(.-:)slope_inner_(.*)$",
    "^(.-:)slope_outer_(.*)$",
    "^(.-:)slope_pike_(.*)$",
    "^(.-:)slope_(.*)$",
}

---------------------------------------------------------------------------------------------------
-- Local functions - Getters (from naturalslopeslib/register_slopes.lua)
---------------------------------------------------------------------------------------------------

local function apply_default_slope_to_node_definition(base_name, def_table, slope_group_value)

    -- Was apply_default_slope_def()
    -- Called by the local functions below to apply default attributes to the node definition,
    --      common to all slopes, before the calling function applies attributes for that specific
    --      slope

    def_table.paramtype = "light"

    if def_table.paramtype2 == "color" or def_table.paramtype2 == "colorfacedir" then
        def_table.paramtype2 = "colorfacedir"
    else
        def_table.paramtype2 = "facedir"
    end

    if not def_table.groups then
        def_table.groups = {}
    end

    def_table.groups.natural_slope = slope_group_value

    -- Add group in the form "family:<full node name>"
    if not def_table.groups["family:" .. base_name] then
        def_table.groups["family:" .. base_name] = 1
    end

    return def_table

end

local function get_straight_slope_definition(base_name, def_table)

    -- Was get_straight_def()
    -- Update the node definition for a straight slope

    def_table = apply_default_slope_to_node_definition(base_name, def_table, 1)

    if unilib.setting.slopes_rendering_mode == "smooth" then

        def_table.drawtype = "mesh"
        def_table.mesh = "unilib_natslope_straight.obj"

    elseif unilib.setting.slopes_rendering_mode == "rough" then

        def_table.drawtype = "mesh"
        def_table.mesh = "unilib_natslope_straight_rough.obj"

    else

        def_table.drawtype = "nodebox"
        def_table.node_box = slope_straight_box

    end

    def_table.selection_box = slope_straight_box
    def_table.collision_box = slope_straight_box

    return def_table

end

local function get_inner_slope_definition(base_name, def_table)

    -- Was get_inner_def()
    -- Update the node definition for an inner corner

    def_table = apply_default_slope_to_node_definition(base_name, def_table, 2)

    if unilib.setting.slopes_rendering_mode == "smooth" then

        def_table.drawtype = "mesh"
        def_table.mesh = "unilib_natslope_inner.obj"

    elseif unilib.setting.slopes_rendering_mode == "rough" then

        def_table.drawtype = "mesh"
        def_table.mesh = "unilib_natslope_inner_rough.obj"

    else

        def_table.drawtype = "nodebox"
        def_table.node_box = slope_inner_corner_box

    end

    def_table.selection_box = slope_inner_corner_box
    def_table.collision_box = slope_inner_corner_box

    return def_table

end

local function get_outer_slope_definition(base_name, def_table)

    -- Was get_outer_def()
    -- Update the node definition for an outer corner

    def_table = apply_default_slope_to_node_definition(base_name, def_table, 3)

    if unilib.setting.slopes_rendering_mode == "smooth" then

        def_table.drawtype = "mesh"
        def_table.mesh = "unilib_natslope_outer.obj"

    elseif unilib.setting.slopes_rendering_mode == "rough" then

        def_table.drawtype = "mesh"
        def_table.mesh = "unilib_natslope_outer_rough.obj"

    else

        def_table.drawtype = "nodebox"
        def_table.node_box = slope_outer_corner_box

    end

    def_table.selection_box = slope_outer_corner_box
    def_table.collision_box = slope_outer_corner_box

    return def_table

end

local function get_pike_slope_definition(base_name, def_table, update_chance)

    -- Was get_pike_def()
    -- Update the node definition for a pike

    def_table = apply_default_slope_to_node_definition(base_name, def_table, 4)

    if unilib.setting.slopes_rendering_mode ~= "cubic" then

        def_table.drawtype = "mesh"
        def_table.mesh = "unilib_natslope_pike.obj"

    else

        def_table.drawtype = "nodebox"
        def_table.node_box = slope_pike_box

    end

    def_table.selection_box = slope_pike_box
    def_table.collision_box = slope_pike_box

    return def_table

end

local function convert_tiles_attribute_to_expanded_format(tiles)

    -- Was convert_to_expanded_tiles_def()
    -- Expand "tiles" to use the {name = "image"} format for each tile

    if tiles then

        for i, tile_def in ipairs(tiles) do

            if type(tile_def) == "string" then
                tiles[i] = {name = tile_def}
            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions - Getters (from naturalslopeslib/register_slopes.lua)
---------------------------------------------------------------------------------------------------

function unilib.slopes.get_slope_definitions(base_name, defn_change_table)

    -- From naturalslopeslib.get_slope_defs()
    -- Returns a list of node definitions for the straight slope, inner corner, outer corner and
    --      pike, in that order
    -- Warning: The palette for slopes can only have 8 colours while the original one can hold up to
    --      256 colours. A reduced palette must be provided for nodes which paramtype2 is "color"
    --      even if not all colours are used
    --
    -- Args:
    --      base_name: The full block node name
    --      defn_change_table: Table of changes to apply from the base node definition (use the
    --          string "nil", and not nil itself, to explicitly erase a value). All attributes are
    --          copied to the sloped nodes, except the following ones, which are replaced:
    --              - .drawtype: set to "nodebox" or "mesh" according to the rendering mode
    --              - .nodebox or .mesh
    --              - .selection_box and .collision_box to match the mesh
    --              - .paramtype is set to "light", and .paramtype2 is set to "facedir" or
    --                  "colorfacedir"
    --          In addition, the following groups are added:
    --              - "natural_slope" (1 = straight, 2 = inner corner, 3 = outer corner, 4 = pike)
    --              - "family:<full node name>"

    local def_table = core.registered_nodes[base_name]
    if not def_table then

        return unilib.utils.show_error(
            "../lib/effects/slopes/slopes_accessors.lua: Cannot get slopes for unknown node",
            (base_name or "nil")
        )


    end

    local full_copy_table = table.copy(def_table)
    local change_copy_table = table.copy(defn_change_table)
    for key, value in pairs(defn_change_table) do

        if value == "nil" then
            full_copy_table[key] = nil
        else
            full_copy_table[key] = value
        end

    end

    -- Handle default drop overrides
    if not def_table.drop and
            not defn_change_table.drop and
            unilib.slopes.default_definition.drop_source then

        -- If .drop is not set and has not been reset
        full_copy_table.drop = base_name

    end

    -- Convert all tile definitions to a list format to be able to override properties
    if not full_copy_table.tiles or #full_copy_table.tiles == 0 then
        full_copy_table.tiles = {{}}
    end

    convert_tiles_attribute_to_expanded_format(full_copy_table.tiles)

    if not change_copy_table.tiles or #change_copy_table.tiles == 0 then
        change_copy_table.tiles = {{}}
    end

    convert_tiles_attribute_to_expanded_format(change_copy_table.tiles)

    local default_tile_changes = table.copy(unilib.slopes.default_definition.tiles)
    if not default_tile_changes or #default_tile_changes == 0 then
        default_tile_changes = {{}}
    end

    convert_tiles_attribute_to_expanded_format(default_tile_changes)

    -- Make tile changes and default changes the same size
    local desired_size = math.max(
        #full_copy_table.tiles, #change_copy_table.tiles, #default_tile_changes
    )

    while #change_copy_table.tiles < desired_size do

        table.insert(
            change_copy_table.tiles, table.copy(change_copy_table.tiles[#change_copy_table.tiles])
        )

    end

    while #default_tile_changes < desired_size do

        -- (No need to copy because defaults won't be altered)
        table.insert(default_tile_changes, default_tile_changes[#default_tile_changes])

    end

    while #full_copy_table.tiles < desired_size do

        table.insert(
            full_copy_table.tiles, table.copy(full_copy_table.tiles[#full_copy_table.tiles])
        )

    end

    -- Apply default tile changes
    for i = 1, desired_size, 1 do

        if default_tile_changes[i].align_style ~= nil and
                change_copy_table.tiles[i].align_style == nil then
            full_copy_table.tiles[i].align_style = default_tile_changes[i].align_style
        end

        if default_tile_changes[i].backface_culling ~= nil and
                change_copy_table.tiles[i].backface_culling == nil then
            full_copy_table.tiles[i].backface_culling = default_tile_changes[i].backface_culling
        end

        if default_tile_changes[i].scale and change_copy_table.tiles[i].scale == nil then
            full_copy_table.tiles[i].scale = default_tile_changes[i].scale
        end

    end

    -- Handle default groups
    for group, value in pairs(unilib.slopes.default_definition.groups) do

        if not defn_change_table.groups or defn_change_table.groups[group] == nil then
            full_copy_table.groups[group] = value
        end

    end

    -- Handle other values
    for key, value in pairs(unilib.slopes.default_definition) do

        if key ~= "groups" and key ~= "drop_source" and key ~= "tiles" then

            if change_copy_table[key] == nil then

                if type(value) == "table" then
                    full_copy_table[key] = table.copy(value)
                else
                    full_copy_table[key] = value
                end

            end

        end

    end

    -- Use a copy because tables are passed by reference. Otherwise the node description is shared
    --      and updated after each call
    return {
        get_straight_slope_definition(base_name, table.copy(full_copy_table)),
        get_inner_slope_definition(base_name, table.copy(full_copy_table)),
        get_outer_slope_definition(base_name, table.copy(full_copy_table)),
        get_pike_slope_definition(base_name, table.copy(full_copy_table))
    }

end

---------------------------------------------------------------------------------------------------
-- Shared functions - Getters (from naturalslopeslib/init.lua)
---------------------------------------------------------------------------------------------------

function unilib.slopes.convert_slope_name_to_block_name(slope_name)

    -- Was naturalslopeslib.get_regular_node_name()
    -- Gets the name of the (original) block node from a slope, or nil
    -- This function may be inaccurate, as it checks only if the name follows the internal pattern
    --      for slope names
    --
    -- Args:
    --      slope_name: The slope's node name
    --
    -- Return values:
    --      Returns the name of the base node (the non-sloping one), or nil if "slope_name" is not a
    --          slope node

    if string.find(slope_name, ":slope_") == nil then
        return nil
    end

    for _, regex in ipairs(regex_list) do

        local match, match2 = string.match(slope_name, regex)
        if match and core.registered_nodes[match .. match2] ~= nil then
            return match .. match2
        end

    end

    return nil

end
