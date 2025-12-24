---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- slopes_base.lua
--      Set up natural slopes. Code adapted from the "naturalslopeslib" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Call progressive_area_update() every 0.1 seconds
local generation_interval = 0.1
local generation_dtime = 0

-- (Was naturalslopeslib.progressive_area_updates)
-- List of mini-tables, each specifying an area of the world which has recently been generated, and
--      which must potentially be modified in order to generate natural slopes
-- Mini-tables in the form
--      .i - area index in "progressive_area_update_list"
--      .edge_normal - Table in the form {x = n, y = n, z = n}, in which n is an integer in the
--          range -1 to 1
--      .factor - Inverted factor for chance (0.1 means 10 times more likely to update)
--      .maxp - Higher boundary of area
--      .minp - Lower boundary of area
--      .skip (optional) - If specified, the number of nodes skipped when generating the area is a
--          number in the range ( skip/2, skip )
local progressive_area_update_list = {}

---------------------------------------------------------------------------------------------------
-- Shared variables (from naturalslopeslib/init.lua)
---------------------------------------------------------------------------------------------------

-- Was naturalslopeslib._register_on_generated
-- When true, slopes are created during map generation; can be set to false by a call to
--      unilib.slopes.enable_manual_map_generation()
unilib.slopes.register_on_generated_flag = true
-- Was naturalslopeslib._propagate_overrides
-- Initially set to false, then set to true during the first call to
--      unilib.slopes.propagate_overrides(). Any subsequent calls to that function do nothing
unilib.slopes.propagate_overrides_flag = false
-- Was naturalslopeslib.default_definition
-- A table specifying default node overrides for newly-registered slopes. When calling
--      unilib.slopes.register_slope(), the overrides are added to the "defn_change_table" argument
--      (if not already specified by it); this avoids a lot of copy-pasting and can be used to
--      automate some behaviours
-- Table in the form
--      .drop_source = true/false
--          When true, if no drop is defined, it's set to the source node instead of the slope. For
--              example, digging a dirt slope gives a dirt block (when true) or a dirt slope (when
--              false)
--      .groups = {not_in_creative_inventory = 1}
--          A list of groups and their values to add. Set a group value to 0 to remove it
--      .tiles = { {align_style="world"} }
--          As for tile definitions, the list can hold up to 6 balues, but only .align_style,
--              .backface_culling and .scale are read
--      .KEY = VALUE
--          For all other key-value pairs, override the corresponding key-value pair in the node;
--              UNLESS some other VALUE has been specified by this KEY - see the code in
--              unilib.slopes.get_slope_definitions()
-- Note that changes to this table are not retroactive. If the defaults are changed on the run, all
--      slopes that were previously registered are not affected
-- In the original code, best practice was to set the defaults before registering slopes, then call
--      unilib.slopes.reset_default_definition() after finishing registering them, ready for the
--      next naturalslopeslib-compatible mod. For unilib, that's not necessary; any expansion packs
--      should call unilib.slopes.reset_default_definition() before and after registering their own
--      slopes
-- N.B. In original naturalslopeslib code, the corresponding table was initially empty; here, we use
--      the attributes from the "naturalslopes_minetest_game" mod
unilib.slopes.default_definition = {
    drop_source = true,
    groups = {not_in_creative_inventory = 1},
    tiles = {{align_style = "world"}},
    use_texture_alpha = "clip",
}

---------------------------------------------------------------------------------------------------
-- Local functions (from naturalslopeslib/update_shape.lua)
---------------------------------------------------------------------------------------------------

local function check_area_edges(area)

    -- Was check_area_edges()
    -- Returns true or false

    if area.edge_normal == nil then
        return true
    end

    local pos = area.minp

    local edge = area.edge_normal
    local require_count = math.abs(edge.x) + math.abs(edge.y) + math.abs(edge.z)
    local found_count = 0

    if edge.x ~= 0 and core.get_node_or_nil(vector.add(pos, {x = edge.x, y = 0, z = 0})) ~= nil then
        found_count = found_count + 1
    end

    if edge.y ~= 0 and core.get_node_or_nil(vector.add(pos, {x = 0, y = edge.y, z = 0})) ~= nil then
        found_count = found_count + 1
    end

    if edge.z ~= 0 and core.get_node_or_nil(vector.add(pos, {x = 0, y = 0, z = edge.z})) ~= nil then
        found_count = found_count + 1
    end

    return found_count == require_count

end

local function get_area_edges(minp, maxp)

    -- Was get_edges()
    -- Returns a list of mini-tables, each in the form ( min_pos, max_pos, normal[x, y, z] )

--  local corner000 = minp
    local corner001 = {x = minp.x, y = minp.y, z = maxp.z}
    local corner010 = {x = minp.x, y = maxp.y, z = minp.z}
    local corner011 = {x = minp.x, y = maxp.y, z = maxp.z}
    local corner100 = {x = maxp.x, y = minp.y, z = minp.z}
    local corner101 = {x = maxp.x, y = minp.y, z = maxp.z}
    local corner110 = {x = maxp.x, y = maxp.y, z = minp.z}
--  local corner111 = maxp

    return {
        -- The 8 corners
        {minp,      minp,      {-1, -1, -1}},
        {corner001, corner001, {-1, -1,  1}},
        {corner010, corner010, {-1,  1, -1}},
        {corner011, corner011, {-1,  1,  1}},
        {corner100, corner100, { 1, -1, -1}},
        {corner101, corner101, { 1, -1,  1}},
        {corner110, corner110, { 1,  1, -1}},
        {maxp,      maxp,      { 1,  1,  1}},

        -- The 8 segments
        {
            {x = minp.x + 1, y = minp.y, z = minp.z},
            {x = maxp.x - 1, y = minp.y, z = minp.z},
            {0, -1, -1},
        },
        {
            {x = minp.x + 1, y = maxp.y, z = minp.z},
            {x = maxp.x - 1, y = maxp.y, z = minp.z},
            {0, 1, -1},
        },
        {
            {x = minp.x, y = minp.y + 1, z = minp.z},
            {x = minp.x, y = maxp.y - 1, z = minp.z},
            {-1, 0, -1},
        },
        {
            {x = maxp.x, y = minp.y + 1, z = minp.z},
            {x = maxp.x, y = maxp.y - 1, z = minp.z},
            {1, 0, -1},
        },
        {
            {x = minp.x + 1, y = minp.y, z = maxp.z},
            {x = maxp.x - 1, y = minp.y, z = maxp.z},
            {0, -1, 1},
        },
        {
            {x = minp.x + 1, y = maxp.y, z = maxp.z},
            {x = maxp.x - 1, y = maxp.y, z = maxp.z},
            {0, 1, 1},
        },
        {
            {x = minp.x, y = minp.y + 1, z = maxp.z},
            {x = minp.x, y = maxp.y - 1, z = maxp.z},
            {-1, 0, 1},
        },
        {
            {x = maxp.x, y = minp.y + 1, z = maxp.z},
            {x = maxp.x, y = maxp.y - 1, z = maxp.z},
            {1, 0, 1},
        },

        -- The 6 faces
        {
            {x = minp.x + 1, y = minp.y, z = minp.z + 1},
            {x = maxp.x - 1, y = minp.y, z = maxp.z - 1},
            {0, -1, 0},
        },
        {
            {x = minp.x + 1, y = maxp.y, z = minp.z + 1},
            {x = maxp.x - 1, y = maxp.y, z = maxp.z - 1},
            {0, 1, 0},
        },
        {
            {x = minp.x, y = minp.y + 1, z = minp.z + 1},
            {x = minp.x, y = maxp.y - 1, z = maxp.z - 1},
            {-1, 0, 0},
        },
        {
            {x = maxp.x, y = minp.y + 1, z = minp.z + 1},
            {x = maxp.x, y = maxp.y - 1, z = maxp.z - 1},
            {1, 0, 0},
        },
        {
            {x = minp.x + 1, y = minp.y + 1, z = minp.z},
            {x = maxp.x - 1, y = maxp.y - 1, z = minp.z},
            {0, 0, -1},
        },
        {
            {x = minp.x + 1, y = minp.y + 1, z = maxp.z},
            {x = maxp.x - 1, y = maxp.y - 1, z = maxp.z},
            {0, 0, 1},
        },
    }

end

local function on_place_or_dig_callback(pos, force_below_flag)

    -- Was on_place_or_dig()
    -- Callback called as a result of core.register_on_placenode() or core.register_on_dignode()
    -- After digging or placing a node, update that node and its neighbours
    --
    -- Args:
    --      pos: Position of the placed/dug node
    --      force_below_flag (optional): True when called as a result of
    --          core.register_on_placenode()

    local function update(pos, x, y, z, factor)

        local new_pos = vector.add(pos, vector.new(x, y, z))
        unilib.slopes.update_shape_on_chance(new_pos, core.get_node(new_pos), factor, "place")

    end

    local place_factor = unilib.setting.slopes_update_on_dig_place_factor
    -- Update the node itself...
    update(pos, 0, 0, 0, place_factor)
    -- ...8 horizontal neighbours...
    update(pos, 1, 0, 0, place_factor)
    update(pos, 0, 0, 1, place_factor)
    update(pos, -1, 0, 0, place_factor)
    update(pos, 0, 0, -1, place_factor)
    update(pos, 1, 0, 1, place_factor)
    update(pos, 1, 0, -1, place_factor)
    update(pos, -1, 0, 1, place_factor)
    update(pos, -1, 0, -1, place_factor)
    -- ...the node below...
    if force_below_flag then
        update(pos, 0, -1, 0, 0)
    else
        update(pos, 0, -1, 0, place_factor)
    end
    -- ...and the node above
    update(pos, 0, 1, 0, place_factor)

end

local function progressive_area_update(start_time)

    -- Was progressive_area_update()
    -- Update areas, replacing nodes with slopes as appropriate

    if #progressive_area_update_list == 0 then
        return true
    end

    if start_time == nil then
        start_time = os.clock()
    end

    -- Pick an area around a player at random and process it
    local processed_area_index, alt_processed_area_index

    for area_index, area in ipairs(progressive_area_update_list) do

        for _, player in ipairs(core.get_connected_players()) do

            local minp = area.minp
            local maxp = area.maxp

            local ppos = player:get_pos()
            if ppos.x >= minp.x and
                    ppos.x <= maxp.x and
                    ppos.y >= minp.y and
                    ppos.y <= maxp.y and
                    ppos.z >= minp.z and
                    ppos.z <= maxp.z then

                -- Prefer an area which contains a player
                if check_area_edges(area) then

                    processed_area_index = area_index
                    break

                end

            elseif alt_processed_area_index == nil and
                    ppos.x + 16 >= minp.x and
                    ppos.x - 16 <= maxp.x and
                    ppos.y + 16 >= minp.y and
                    ppos.y - 16 <= maxp.y and
                    ppos.z + 16 >= minp.z and
                    ppos.z - 16 <= maxp.z then

                -- Otherwise pick an area near a player
                if check_area_edges(area) then
                    alt_processed_area_index = area_index
                end

            end

        end

    end

    if processed_area_index == nil then

        if alt_processed_area_index ~= nil then
            processed_area_index = alt_processed_area_index
        else
            processed_area_index = 1    -- Try to reduce the queue as quickly as possible
        end

    end

    local area = progressive_area_update_list[processed_area_index]
    local i = area.i
    local y_size = area.maxp.y - area.minp.y + 1
    local z_size = area.maxp.z - area.minp.z + 1
    local imax = y_size * z_size * (area.maxp.x - area.minp.x + 1)

    while i <= imax do

        local x = math.floor((i - 1) / (y_size * z_size))
        local y = math.floor((i - 1) / z_size) % y_size
        local z = (i - 1) % (z_size)
        local pos = {x = area.minp.x + x, y = area.minp.y + y, z = area.minp.z + z}
        local node = core.get_node(pos)

        unilib.slopes.update_shape_on_chance(pos, node, area.factor, area.update_type)
        i = i + 1 + math.random(area.skip / 2, area.skip)

        if (os.clock() - start_time) > 0.1 and i <= imax then

            area.i = i
            return false

        end

    end

    table.remove(progressive_area_update_list, processed_area_index)
    if os.clock() - start_time < 0.1 then
        progressive_area_update(start_time)
    end

    return true

end

local function register_generation_callbacks()

    -- Was register_on_generation()
    -- Called as a result of core.register_on_mods_loaded()
    -- Registers callbacks to be called, as areas of the world are generated

    if not unilib.slopes.register_on_generated_flag then
        return
    end

    -- N.B. Original code checks value of naturalslopeslib.setting_enable_shape_on_generation(),
    --      which always returns true (having checked a non-existent setting); here, we omit that
    --      step
    if unilib.setting.slopes_generation_method == "progressive" then

        core.register_on_generated(function(minp, maxp, seed)

            unilib.slopes.on_generate_progressively_callback(
                minp,
                maxp,
                unilib.setting.slopes_update_on_generate_factor,
                unilib.setting.slopes_skip_nodes_on_generate,
                "mapgen"
            )

        end)

    else

        core.register_on_generated(function(minp, maxp, seed)

            unilib.slopes.on_generate_with_voxelmanip_callback(
                minp,
                maxp,
                unilib.setting.slopes_update_on_generate_factor,
                unilib.setting.slopes_skip_nodes_on_generate,
                true,
                "mapgen"
            )

        end)

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions - map generation (from naturalslopeslib/update_shape.lua)
---------------------------------------------------------------------------------------------------

function unilib.slopes.on_generate_with_voxelmanip_callback(
    minp, maxp, factor, skip, progressive_edges_flag, update_type
)
    -- Was naturalslopeslib.area_chance_update_shape()
    -- Main generation callback for the "VoxelManip" generation method
    --
    -- Arguments:
    --      minp: Lower boundary of area
    --      maxp: Higher boundary of area
    --      factor: Inverted factor for chance (0.1 means 10 times more likely to update)
    --      skip (optional): If specified, the number of nodes skipped when generating the area is a
    --          number in the range ( skip/2, skip )
    --      progressive_edges_flag (optional): When true (default), edges are generated
    --          progressively
    --      update_type (optional): Optional update type for chance factors. Either "mapgen",
    --          "stomp", "place" or "time". When not set, the chance factor is ignored (as if it is
    --          1). It is cumulative with "factor"

    if not skip then
        skip = 0
    end

    if progressive_edges_flag == nil then
        progressive_edges_flag = true
    end

    -- Run on every block
    local vm, emin, emax = core.get_voxel_manip()
    local e1, e2 = vm:read_from_map(minp, maxp)
    local area = VoxelArea:new{MinEdge = e1, MaxEdge = e2}
    local data = vm:get_data()
    local param2_data = vm:get_param2_data()
    local i = area:indexp(e1)
    local imax = area:indexp(e2)

    if progressive_edges_flag then

        for _, edge in ipairs(get_area_edges(minp, maxp)) do

            unilib.slopes.on_generate_progressively_callback(
                edge[1],
                edge[2],
                factor,
                skip,
                update_type,
                {x = edge[3][1], y = edge[3][2], z = edge[3][3]}
            )

        end

    end

    while i <= imax do

        local x = (i - 1) % area.ystride
        local y = (i - 1) % area.zstride
        if x == 0 or x == area.ystride - 1 or y == 0 or y == area.zstride - 1 then

            -- Skip edges

        else

            local replacement_table = unilib.slopes.get_replacement_id(data[i])
            if replacement_table ~= nil then

                local chance_factor = 1
                if update_type == "mapgen" or
                        update_type == "stomp" or
                        update_type == "place" or
                        update_type == "time" then
                    chance_factor = replacement_table.chance_factor_table[update_type]
                end

                if math.random() * (replacement_table.chance * factor * chance_factor) < 1.0 then

                    local new_data_table =
                            unilib.slopes.get_replacement_node(i, data[i], area, data, param2_data)
                    if new_data_table then

                        data[i] = new_data_table.id
                        if new_data_table.param2_data then
                            param2_data[i] = new_data_table.param2_data
                        end

                    end

                end

            end

        end

        i = i + 1 + math.random(skip / 2, skip)

    end

    vm:set_data(data)
    vm:set_param2_data(param2_data)
    vm:write_to_map()

end

function unilib.slopes.on_generate_progressively_callback(
    minp, maxp, factor, skip, update_type, edge_normal
)
    -- Was naturalslopeslib.register_progressive_area_update()
    -- Main generation callback for the "progressive" generation method
    -- Marks an area to be updated progressively. The area is not updated instantly but added to a
    --      list
    --
    -- Args:
    --      minp: Lower boundary of area
    --      maxp: Higher boundary of area
    --      factor: Inverted factor for chance (0.1 means 10 times more likely to update)
    --      skip (optional): If specified, the number of nodes skipped when generating the area is a
    --          number in the range ( skip/2, skip )
    --      update_type: Optional update type for chance factors. Either "mapgen", "stomp", "place"
    --          or "time". When not set, the chance factor is ignored (as if it is 1). It is
    --          cumulative with "factor"

    if edge_normal ~= nil or minp.x == maxp.x or minp.y == maxp.y or minp.z == maxp.z then

        -- Explicit edge or ignored
        table.insert(progressive_area_update_list, {
            i = 1,

            edge_normal = edge_normal,
            factor = factor,
            maxp = maxp,
            minp = minp,
            skip = skip,
        })

        return

    end

    -- Otherwise register the inner cube...
    table.insert(progressive_area_update_list, {
        i = 1,

        edge_normal = nil,
        factor = factor,
        maxp = vector.add(maxp, -1),
        minp = vector.add(minp, 1),
        skip = skip,
    })

    -- ...and all edges
    for _, edge in ipairs(get_area_edges(minp, maxp)) do

        table.insert(progressive_area_update_list, {
            i = 1,

            edge_normal = {x = edge[3][1], y = edge[3][2], z = edge[3][3]},
            factor = factor,
            maxp = edge[2],
            minp = edge[1],
            skip = skip,
            update_type = update_type,
        })

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (from naturalslopeslib/init.lua)
---------------------------------------------------------------------------------------------------

function unilib.slopes.enable_manual_map_generation()

    -- Was naturalslopeslib.set_manual_map_generation()
    -- Disables the default registration to handle the mapgen manually. Once it is called, other
    --      mods should take care of handling shape update on generation; otherwise nothing is done

    unilib.slopes.register_on_generated_flag = false

end

---------------------------------------------------------------------------------------------------
-- Setup code (from naturalslopeslib/update_shape.lua)
---------------------------------------------------------------------------------------------------

core.register_globalstep(function(dtime)

    generation_dtime = generation_dtime + dtime
    if generation_dtime > generation_interval then

        progressive_area_update()
        generation_dtime = 0

    end

end)

core.register_on_shutdown(function()

    if #progressive_area_update_list > 0 then

        unilib.utils.log("info", "Processing slope generation for queued areas")

        for i, area in ipairs(progressive_area_update_list) do

            unilib.utils.log(
                "info", (#progressive_area_update_list - i + 1) .. " remaining area(s)"
            )

            unilib.slopes.on_generate_with_voxelmanip_callback(
                area.minp,
                area.maxp,
                area.factor,
                area.skip,
                false,
                area.update_type
            )

        end

    end

end)

if not unilib.setting.slopes_enable_revert_flag then
    core.register_on_mods_loaded(register_generation_callbacks)
end

if unilib.setting.slopes_update_on_dig_place_flag and
        not unilib.setting.slopes_enable_revert_flag then

    core.register_on_placenode(function(pos, new_node, placer, old_node, item_stack, pointed_thing)
        on_place_or_dig_callback(pos, true)
    end)

    core.register_on_dignode(function(pos, old_node, digger)
        on_place_or_dig_callback(pos)
    end)

end
