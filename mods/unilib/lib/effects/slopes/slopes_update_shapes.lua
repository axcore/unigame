---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- slopes_update_shapes.lua
--      Set up natural slopes. Code adapted from the "naturalslopeslib" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local air_id = core.get_content_id("air")

---------------------------------------------------------------------------------------------------
-- Local functions - shape update API (from naturalslopeslib/update_shape.lua)
---------------------------------------------------------------------------------------------------

local function manage_param2_colour(replacement_table, source, dest, param2_source, param2_dest)

    -- Was manage_param2_color()
    -- Manage colours for param2
    --
    -- Arguments:
    --      replacement_table: A standard replacement table
    --      source: The name or ID of the node being transformed
    --      dest: The name or ID of the new shape
    --      param2_source: The param2 value before transformation
    --      param2_dest: The param2 value for facedir (if any) after transformation
    --
    -- Return values:
    --      A new param2 value for the "dest" node with a new colour index if necessary

    if not replacement_table.coloured_source_flag then
        return param2_dest
    end

    if dest == replacement_table.source then

        -- param2_source will have the value "color"
        if source == replacement_table.source then

            -- From "color" to "color"
            return param2_source

        else

            -- From "color" to "colorfacedir"
            local new_colour_index = replacement_table.colour_convert_func(param2_source, true) % 8
            return param2_dest + (new_colour_index * 32)

        end

    else

        -- param2_source will have the value "colorfacedir"
        if dest == replacement_table.source then

            -- from "colorfacedir" to "color"
            local old_colour = math.floor(param2_source / 32)
            return replacement_table.colour_convert_func(old_colour, false) % 256

        else

            -- from "colorfacedir" to another "colorfacedir"
            local colour = math.floor(param2_source / 32)
            return param2_dest + (colour * 32)

        end

    end

end

local function pick_replacement_slope(slope_type, name, old_param2, param2, for_area_flag)

    -- Was pick_replacement()
    -- Picks a replacement slope node
    --
    -- Arguments:
    --      slope_type: The replacement shape - either "block", "straight", "ic" or "oc"
    --      name: The name (or ID, when "for_area_flag" is true) of the node to replace
    --      old_param2: The current value of param2 for the node to replace
    --      param2: facedir value to orient the new node
    --      for_area_flag: true when picking for an area
    --
    -- Return values:
    --      node {name=new_name, param2=new_param2}, area data {id=new_id, param2_data=new_param2}
    --          or nil if dest node is not found

    local replacement_table
    if for_area_flag then
        replacement_table = unilib.slopes.get_replacement_id(name)
    else
        replacement_table = unilib.slopes.get_replacement(name)
    end

    if not replacement_table then
        return nil
    end

    local dest_node_name
    if slope_type == "block" and replacement_table.source then
        dest_node_name = replacement_table.source
    elseif slope_type == "pike" and replacement_table.pike then
        dest_node_name = replacement_table.pike
    elseif slope_type == "straight" and replacement_table.straight then
        dest_node_name = replacement_table.straight
    elseif slope_type == "ic" and replacement_table.inner then
        dest_node_name = replacement_table.inner
    elseif slope_type == "oc" and replacement_table.outer then
        dest_node_name = replacement_table.outer
    end

    if dest_node_name then

        if param2 == nil then
            param2 = 0
        end

        local colour_param2 =
                manage_param2_colour(replacement_table, name, dest_node_name, old_param2, param2)

        if for_area_flag then
            return {id = dest_node_name, param2_data = colour_param2}
        else
            return {name = dest_node_name, param2 = colour_param2}
        end

    end

    return nil

end

---------------------------------------------------------------------------------------------------
-- Shared functions - shape update API (from naturalslopeslib/update_shape.lua)
---------------------------------------------------------------------------------------------------

function unilib.slopes.is_node_free_for_shape_update(pos)

    -- Was naturalslopeslib.is_free_for_shape_update()
    -- Checks if a node is considered free, for the purposes of switching its shape
    --
    -- Arguments:
    --      pos: The position of the node to check (probably a neighbour of a node which is a
    --          candidate for a shape update)
    --
    -- Return values:
    --      Returns true if the node is free, false if occupied, nil if unknown (not loaded)

    if not pos then
        return nil
    end

    local node = core.get_node_or_nil(pos)
    if node == nil then
        return nil
    else
        return node.name == "air"
    end

end

function unilib.slopes.is_area_free_for_shape_update(area, data, index)

    -- Was naturalslopeslib.area_is_free_for_shape_update()
    -- Checks if the nodes in the specified "area" are considered free for the purposes of switching
    --      their shaped
    --
    -- Arguments:
    --      area: The VoxelArea to use
    --      data: Data from VoxelManip
    --      index: The position in "area"
    --
    -- Return values:
    --      Returns true if the node is free, false if occupied, nil if unknown (not loaded)

    if not area:containsi(index) then
        return nil
    else
        return data[index] == air_id
    end

end

function unilib.slopes.get_replacement_node(pos, node, area, data, param2_data)

    -- Was naturalslopeslib.get_replacement_node()
    -- Gets the replacement node to match the current node's surroundings
    -- This function exists in two formats, for a single position or a VoxelArea. In both cases, it
    --      returns the parameters to update the node or nil when no replacement is available
    --
    -- Arguments (for a single node):
    --      pos: The position of the node
    --      node: The node at that position
    --
    -- Arguments (for a voxel area):
    --      pos: The index within the area
    --      node: The node at that position of content ID with VoxelArea
    --      area: The VoxelArea, nil for single position update (determines which type the two
    --          previous arguments are)
    --      data: Data from VoxelManip, nil for single position update
    --      param2_data: param2 data from VoxelManip, nil for single position update
    --
    -- Return values:
    --      A node to use with core.set_node() or a table with id and param2_data if called with an
    --          area. nil if no replacement is found or a neighbour cannot be read

    -- Set functions and data according to update mode: single or VoxelManip
    local is_free_func = nil
    local new_pos_func = nil
--  local replacement = nil     -- Unused in original code
    local node_name = nil       -- Either name or ID
    local for_area_flag = false
    local old_param2 = 0

    if area then

        for_area_flag = true

        is_free_func = function(at_index)

            -- Always use with "new_pos_func"
            return unilib.slopes.is_area_free_for_shape_update(area, data, at_index)

        end

        new_pos_func = function(add)

            -- Get new index from current with add position
            local area_pos = area:position(pos)
            return area:indexp(vector.add(area_pos, add))

        end

        node_name = node
        old_param2 = param2_data[pos]

    else

        is_free_func = unilib.slopes.is_node_free_for_shape_update

        new_pos_func = function(add)
            return vector.add(pos, add)
        end

        node_name = node.name
        old_param2 = node.param2

    end

    local is_ground_flag    -- Ground or ceiling node
    local pointing_y = -1

    -- If there's something above and below, get back to full block
    local above_free_flag = is_free_func(new_pos_func({x = 0, y = 1, z = 0}))
    local below_free_flag = is_free_func(new_pos_func({x = 0, y = -1, z = 0}))
    if above_free_flag == nil or below_free_flag == nil then
        return nil
    end

    if above_free_flag and not below_free_flag then

        is_ground_flag = true
        pointing_y = 1

    elseif below_free_flag and not above_free_flag then

        is_ground_flag = false
        pointing_y = 5

    else

        -- Nothing below and above
        return pick_replacement_slope("block", node_name, old_param2, 0, for_area_flag)

    end

    -- Check blocks around
    local air_xp = is_free_func(new_pos_func({x = 1, y = 0, z = 0}))
    if air_xp == nil then
        return nil
    end

    local air_xm = is_free_func(new_pos_func({x = -1, y = 0, z = 0}))
    if air_xm == nil then
        return nil
    end

    local air_zp = is_free_func(new_pos_func({x = 0, y = 0, z = 1}))
    if air_zp == nil then
        return nil
    end

    local air_zm = is_free_func(new_pos_func({x = 0, y = 0, z = -1}))
    if air_zm == nil then
        return nil
    end

    local free_neighbour_count = 0
    for index, free in next, {air_xp, air_xm, air_zp, air_zm} do

        if free then
            free_neighbour_count = free_neighbour_count + 1
        end

    end

    -- For four or three free neighbours, pike (slab)
    if free_neighbour_count == 4 or free_neighbour_count == 3 then

        local param2 = 0
        if is_ground_flag == false then
            param2 = 20
        end

        return pick_replacement_slope("pike", node_name, old_param2, param2, for_area_flag)

    -- For two free neighbours, block or outer corner
    elseif free_neighbour_count == 2 then

        -- At opposite sides, block
        local param2
        if (air_xp and air_xm) or (air_zp and air_zm) then

            return pick_replacement_slope("block", node_name, old_param2, 0, for_area_flag)

        -- Side by side, outer corner
        elseif (air_xp and air_zp) then

            if is_ground_flag then
                param2 = 3
            else
                param2 = 22
            end

            return pick_replacement_slope("oc", node_name, old_param2, param2, for_area_flag)

        elseif (air_xp and air_zm) then

            if is_ground_flag then
                param2 = 0
            else
                param2 = 21
            end

            return pick_replacement_slope("oc", node_name, old_param2, param2, for_area_flag)

        elseif (air_xm and air_zp) then

            if is_ground_flag then
                param2 = 2
            else
                param2 = 23
            end

            return pick_replacement_slope("oc", node_name, old_param2, param2, for_area_flag)

        elseif (air_xm and air_zm) then

            if is_ground_flag then
                param2 = 1
            else
                param2 = 20
            end

            return pick_replacement_slope("oc", node_name, old_param2, param2, for_area_flag)

        end

    -- For one free neighbour, straight slope
    elseif free_neighbour_count == 1 then

        local param2 = 0
        if air_xp then

            if is_ground_flag then
                param2 = 3
            else
                param2 = 15
            end

        elseif air_xm then

            if is_ground_flag then
                param2 = 1
            else
                param2 = 17
            end

        elseif air_zp then

            if is_ground_flag then
                param2 = 2
            else
                param2 = 6
            end

        elseif air_zm then

            if is_ground_flag then
                param2 = 0
            else
                param2 = 8
            end

        end

        return pick_replacement_slope("straight", node_name, old_param2, param2, for_area_flag)

    -- For no free neighbours, check for a free diagonal for an inner corner, or fully surrounded
    --      for a rebuild (what?)
    else

        local air_xp_zp = is_free_func(new_pos_func({x = 1, y = 0, z = 1}))
        local air_xp_zm = is_free_func(new_pos_func({x = 1, y = 0, z = -1}))
        local air_xm_zp = is_free_func(new_pos_func({x = -1, y = 0, z = 1}))
        local air_xm_zm = is_free_func(new_pos_func({x = -1, y = 0, z = -1}))

        local param2
        if air_xp_zp and not air_xp_zm and not air_xm_zp and not air_xm_zm then

            if is_ground_flag then
                param2 = 3
            else
                param2 = 15
            end

            return pick_replacement_slope("ic", node_name, old_param2, param2, for_area_flag)

        elseif not air_xp_zp and air_xp_zm and not air_xm_zp and not air_xm_zm then

            if is_ground_flag then
                param2 = 0
            else
                param2 = 8
            end

            return pick_replacement_slope("ic", node_name, old_param2, param2, for_area_flag)

        elseif not air_xp_zp and not air_xp_zm and air_xm_zp and not air_xm_zm then

            if is_ground_flag then
                param2 = 2
            else
                param2 = 23
            end

            return pick_replacement_slope("ic", node_name, old_param2, param2, for_area_flag)

        elseif not air_xp_zp and not air_xp_zm and not air_xm_zp and air_xm_zm then

            if is_ground_flag then
                param2 = 1
            else
                param2 = 17
            end

            return pick_replacement_slope("ic", node_name, old_param2, param2, for_area_flag)

        else

            return pick_replacement_slope("block", node_name, old_param2, 0, for_area_flag)

        end

    end

end

function unilib.slopes.update_shape_on_chance(pos, node, factor, update_type)

    -- Was naturalslopeslib.chance_update_shape()
    -- Do shape update, or not, depending on a random chance
    --
    -- Args:
    --      pos: The position of the node
    --      node: The node at that position
    --      factor: Optional chance factor, when > 1 it has more chances to happen
    --      update_type: Optional update type for chance factors. Either "mapgen", "stomp", "place"
    --          or "time". When not set, the chance factor is ignored (as if it is 1). It is
    --          cumulative with "factor"
    --
    -- Return values:
    --      Returns true if an update was done, false otherwise

    if factor == nil then
        factor = 1
    end

    local replacement_table = unilib.slopes.get_replacement(node.name)
    if not replacement_table then
        return false
    end

    local chance_factor = 1
    if update_type == "mapgen" or
            update_type == "stomp" or
            update_type == "place" or
            update_type == "time" then
        chance_factor = replacement_table.chance_factor_table[update_type]
    end

    if (math.random() * (replacement_table.chance * factor * chance_factor)) < 1.0 then
        return unilib.slopes.update_shape(pos, node)
    else
        return false
    end

end

function unilib.slopes.update_shape(pos, node)

    -- Was naturalslopeslib.update_shape()
    -- Try to update the shape of a node according to its surroundings, disregarding chance values
    --
    -- Arguments:
    --      pos: The position of the node
    --      node: The node at that position
    --
    -- Return values:
    --      true if the node was updated, false otherwise

    local replacement_table = unilib.slopes.get_replacement_node(pos, node)
    if replacement_table and
            (replacement_table.name ~= node.name or node.param2 ~= replacement_table.param2) then

        core.set_node(pos, replacement_table)
        return true

    else

        return false

    end

end

function unilib.slopes.update_shape_on_walk(player, pos, node, desc, trigger_meta)

    -- Was naturalslopeslib.update_shape_on_walk()
    -- Callback function for the "poschangelib" mod to get the replacement node name, producing the
    --      same effect as unilib.slopes.update_shape()

    return unilib.slopes.get_replacement_node(pos, node)

end
