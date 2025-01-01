---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_deco_convertable.lua
--      Register convertable decorations
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register convertable decorations
---------------------------------------------------------------------------------------------------

function unilib.register._register_decoration_convertable(data_table)

    -- Original to unilib
    -- Minetest offers two types of decorations: single nodes, and schematics. This is a workaround
    --      to add a third type, which places one or many nodes (comprising a single decoration)
    --      using a callback function
    --
    -- Calls to this function create an invisible node which can be placed as a "simple" decoration.
    --      We then create an LBM which replaces the invisible node using the specified callback
    --      function (for example, to grow a bush using code, rather than a schematic). Finally, we
    --      create a generic decoration definition, which the calling code can use in a call to
    --      unilib.register_decoration_complete().
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "tree_oak", creates an invisible node called
    --          "unilib:convert_tree_oak" and a generic definition called "convert_tree_oak"
    --      convert_func (func): The specified callback function
    --      replace_mode (str): "add", "defer", "replace" or "hide"
    --
    -- data_table optional fields:
    --      climate_table (table): A selection of key-value pairs adapted from biome_lib. If
    --          specified, the decoration is only placed in suitable positions (otherwise, it is
    --          replaced by air). Table with optional keys in the form:
    --              humidity_min, humidity_max (int): range 0 - 100
    --              light_min, light_max (int): range 0 - unilib.constant.light_max
    --              temp_min, temp_max (int): range 0 - 100
    --      generic_def_table (table): Generic decoration definition, used in the call to
    --          unilib.register_decoration_generic(). The .deco_type and .decoration fields, if
    --          specified, are replaced with default values by this function
    --      space_table (table): If specified, the area around the decoration is checked (for
    --          example, so that trees don't try to grow inside each other). Table with optional
    --          keys in the form:
    --              height (int): Checks all nodes between the invisible node and "height" nodes
    --                  above it. Default value: 3, minimum value = 1
    --              width (int): Checks four columns in each corner of the area "height" x "width".
    --                  Default/minimum value: 1 (in which case only nodes directly above the
    --                  invisible node are checked)
    --              medium_name (str): Full node name for the empty space. Default value: "air"
    --              sub_name (str): Full node name for item to be placed if the decoration can't
    --                  be placed; typically a sapling (which will grow into a tree of its own
    --                  accord, if the situation improves). Default value: nil

    local part_name = data_table.part_name
    local convert_func = data_table.convert_func
    local replace_mode = data_table.replace_mode

    local climate_table = data_table.climate_table or nil
    local generic_def_table = data_table.generic_def_table or {}
    local space_table = data_table.space_table or nil

    if space_table ~= nil then

        if space_table.height == nil or space_table.height < 1 then
            space_table.height = 3
        end

        if space_table.width == nil or space_table.height < 0 then
            space_table.width = 1
        end

        if space_table.medium_name == nil then
            space_table.medium_name = "air"
        end

    end

    local invisible_name = "unilib:convert_" .. part_name
    local deco_name = "convert_" .. part_name

    unilib.register_node(invisible_name, nil, replace_mode, {
        -- (no description)
        -- (no tiles)
        groups = {not_in_creative_inventory = 1, unbreakable = 1},
        -- (no sounds)

        drawtype = "airlike",
        drop = "",
        paramtype = "light",
        pointable = false,
        sunlight_propagates = true,
        walkable = false,
    })

    unilib.register_lbm({
        label = "Handle convertable decorations [unilib]",
        name = "unilib:lbm_system_" .. deco_name,
        nodenames = {invisible_name},

        run_at_every_load = true,

        action = function(pos, node)

            if space_table ~= nil then

                -- Check the area around the invisible node to make sure there is enough free
                --      space
                -- N.B. This algorithm is imperfect, due to poorly-understood engine issues, but
                --      it's a lot better than nothing
                if space_table.width > 1 then

                    -- Check 1% of the positions bounded by the specified width and height
                    --      (typically between 5-100 positions to check, depending on the boundaries
                    --      of the area to be used by the decoration)
                    -- In testing, checking random positions gave better results than any organised
                    --      search pattern
                    local gap = math.floor(space_table.width / 2)
                    local x_min = pos.x - gap
                    local x_max = pos.x + gap
                    local y_min = pos.y + 1
                    local y_max = pos.y + space_table.height
                    local z_min = pos.z - gap
                    local z_max = pos.z + gap
                    local target = math.floor(
                        space_table.width * space_table.width * space_table.height * 0.01
                    )

                    for i = 1, target do

                        if core.get_node({
                            x = math.random(x_min, x_max),
                            y = math.random(y_min, y_max),
                            z = math.random(z_min, z_max),
                        }).name ~= space_table.medium_name then

                            core.remove_node(pos)
                            if space_table.sub_name ~= nil then
                                core.set_node(pos, {name = space_table.sub_name})
                            end

                            -- This position is not free
                            return

                        end

                    end

                else

                    -- Just check every node in the column
                    for i = 1, space_table.height do

                        if core.get_node({x = pos.x, y = pos.y + i, z = pos.z}).name ~=
                                space_table.medium_name then

                            core.remove_node(pos)
                            if space_table.sub_name ~= nil then
                                core.set_node(pos, {name = space_table.sub_name})
                            end

                            -- This position is not free
                            return

                        end

                    end

                end

            end

            if climate_table ~= nil then

                local light = core.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})
                local temp = core.get_heat(pos)
                local humidity = core.get_humidity(pos)

                -- Check the invisible node's position for light, temperature and/or humidity
                if (
                    climate_table.light_min ~= nil and
                            light < climate_table.light_min
                ) or (
                    climate_table.light_max ~= nil and
                            light > climate_table.light_max
                ) then

                    -- This position is not suitable (yet), try again later
                    return

                elseif (
                    climate_table.humidity_min ~= nil and
                            humidity < climate_table.humidity_min
                ) or (
                    climate_table.humidity_max ~= nil and
                            humidity > climate_table.humidity_max
                ) or (
                    climate_table.temp_min ~= nil and
                            temp < climate_table.temp_min
                ) or (
                    climate_table.temp_max ~= nil and
                            temp > climate_table.temp_max
                ) then

                    -- This position is not suitable
                    core.remove_node(pos)
                    core.set_node(pos, {name = "air"})
                    return

                end

            end

            -- (Called code is usually expecting the position of the node on which the decoration
            --      is placed, not the position of the invisible node)
            core.remove_node(pos)
            convert_func({x = pos.x, y = pos.y - 1, z = pos.z}, part_name)

        end,
    })

    if generic_def_table == nil then
        generic_def_table = {}
    end

    generic_def_table.deco_type = "simple"
    generic_def_table.decoration = invisible_name

    unilib.register_decoration_generic(deco_name, generic_def_table)

end
