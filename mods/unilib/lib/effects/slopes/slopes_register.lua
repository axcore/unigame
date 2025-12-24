---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- slopes_register.lua
--      Set up natural slopes. Code adapted from the "naturalslopeslib" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Tables of replacements from solid blocks to slopes, populated during slope node registration by
--      calls to add_replacement()
-- Table in the form
--      main_replacement_table[node_name] = data_table
-- ...where "data_table" is in the form
--      data_table.source = full node reference
--      data_table.straight = straight slope reference
--      data_table.inner = inner corner reference
--      data_table.outer = outer corner reference
--      data_table.pike = pike/slab reference
--      data_table.chance = inverted chance of occuring
--      data_table.chance_factor_table = multiplicator for each chance type, in the form
--          {mapgen = w, stomp = x, time = y, place = z}
--          (by default, all of these factors are 1, corresponding to no effect)
-- Each "reference" is a full node name
local main_replacement_table = {}
-- Table in the form
--      main_replacement_id_table[node_id] = data_table
-- ...where "data_table" is in the same form as above, but each "reference" is a node ID
local main_replacement_id_table = {}
-- A list of source node names, matching the keys in "main_replacement_table"
local source_list = {}

---------------------------------------------------------------------------------------------------
-- Local functions - Registration API (from naturalslopeslib/init.lua)
---------------------------------------------------------------------------------------------------

local function convert_colour_index(colour_index, slope_flag)

    -- Was default_color_convert()
    -- Default colour index conversion: match values for 0-7 and set to 0 for other values

    if slope_flag then

        if colour_index > 7 then
            return 0
        else
            return colour_index
        end

    else

        return colour_index

    end

end

local function add_replacement(
    source_name, update_chance, chance_factor_table, fixed_replacement_list, coloured_source_flag,
    colour_convert_func
)
    -- Was add_replacement()
    -- Populates the tables above ("main_replacement_table" and "main_replacement_id_table")
    -- "coloured_source_flag" is true when paramtype2 specifies the colour of the source node
    -- "colour_convert_func" is a function (int, int, bool) to convert the colour palette values, it
    --      is ignored when "coloured_source_flag" is false
    --
    -- N.B. In the original version of this code, the 6th argument was "color_to_slope"; this seems
    --      to be a mistake, so has been omitted from this version

    if not coloured_source_flag then
        colour_convert_func = nil
    elseif colour_convert_func == nil then
        colour_convert_func = convert_colour_index
    end

--  local item_name = string.sub(source_name, string.find(source_name, ":") + 1)
    local item_name = unilib.utils.get_item_name(source_name)
    local straight_name, ic_name, oc_name, pike_name

    if fixed_replacement_list then

        straight_name = fixed_replacement_list[1]
        ic_name = fixed_replacement_list[2]
        oc_name = fixed_replacement_list[3]
        pike_name = fixed_replacement_list[4]

    else

        straight_name = unilib.slopes.get_straight_slope_name(item_name)
        ic_name = unilib.slopes.get_inner_corner_slope_name(item_name)
        oc_name = unilib.slopes.get_outer_corner_slope_name(item_name)
        pike_name = unilib.slopes.get_pike_slope_name(item_name)

    end

    local source_id = core.get_content_id(source_name)
    local straight_id = core.get_content_id(straight_name)
    local ic_id = core.get_content_id(ic_name)
    local oc_id = core.get_content_id(oc_name)
    local pike_id = core.get_content_id(pike_name)

    -- Full to slopes
    local dest_data = {
        source = source_name,

        straight = straight_name,
        inner = ic_name,
        outer = oc_name,
        pike = pike_name,

        chance = update_chance,
        chance_factor_table = chance_factor_table,

        coloured_source_flag = coloured_source_flag,
        colour_convert_func = colour_convert_func
    }

    local dest_data_id = {
        source = source_id,

        straight = straight_id,
        inner = ic_id,
        outer = oc_id,
        pike = pike_id,

        chance = update_chance,
        chance_factor_table = chance_factor_table,

        coloured_source_flag = coloured_source_flag,
        colour_convert_func = colour_convert_func
    }

    table.insert(source_list, source_name)

    -- Block
    main_replacement_table[source_name] = dest_data
    main_replacement_id_table[source_id] = dest_data_id
    -- Straight
    main_replacement_table[straight_name] = dest_data
    main_replacement_id_table[straight_id] = dest_data_id
    -- Inner
    main_replacement_table[ic_name] = dest_data
    main_replacement_id_table[ic_id] = dest_data_id
    -- Outer
    main_replacement_table[oc_name] = dest_data
    main_replacement_id_table[oc_id] = dest_data_id
    -- Pike
    main_replacement_table[pike_name] = dest_data
    main_replacement_id_table[pike_id] = dest_data_id

end

local function update_factor_table_with_defaults(init_factor_table)

    -- Was default_factors()

    if init_factor_table == nil then
        init_factor_table = {}
    end

    local return_table = {}
    for _, name in ipairs({"mapgen", "time", "stomp", "place"}) do

        if init_factor_table[name] ~= nil then
            return_table[name] = init_factor_table[name]
        else
            return_table[name] = 1
        end

    end

    return return_table

end

---------------------------------------------------------------------------------------------------
-- Shared functions - Registration API (from naturalslopeslib/init.lua)
---------------------------------------------------------------------------------------------------

function unilib.slopes.reset_default_definition()

    -- Was naturalslopeslib.reset_defaults()
    -- Resets unilib.slopes.default_definition to its minimal state

    unilib.slopes.default_definition = {
        drop_source = false,
        groups = {},
        tiles = {},
    }

end

function unilib.slopes.register_slope(
    base_name, defn_change_table, update_chance, init_factor_table, colour_convert_func
)
    -- Was naturalslopeslib.register_slope()
    -- Register slopes corresponding to the specified full-block node
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
    --      update_chance: Inverted chance for the node to be updated
    --      init_factor_table (optional): Optional table for chance factors. By default each factor
    --          is 1
    --      colour_convert_func (optional): Optional function to convert colour palettes. Ignored
    --          when .paramtype2 from the base node is not "color". By default, it matches the first
    --          8 values, and other color values are set to 0
    --
    -- Return values:
    --      Returns a standard natural slopes replacement table, or nil on error

    if not update_chance then

        return unilib.utils.show_error(
            "../lib/effects/slopes/slopes_register.lua: Chance not set for node", base_name
        )

    end

    local def_table = core.registered_nodes[base_name]
    if not def_table then

        return unilib.utils.show_error(
            "../lib/effects/slopes/slopes_register.lua: Can't register slopes for unknown node",
            (base_name or "nil")
        )

    end

    -- Get new definitions
--  local item_name = string.sub(base_name, string.find(base_name, ":") + 1)
    local item_name = unilib.utils.get_item_name(base_name)
    local slope_name_list = {
        unilib.slopes.get_straight_slope_name(item_name),
        unilib.slopes.get_inner_corner_slope_name(item_name),
        unilib.slopes.get_outer_corner_slope_name(item_name),
        unilib.slopes.get_pike_slope_name(item_name),
    }

    local slope_defn_list = unilib.slopes.get_slope_definitions(base_name, defn_change_table)

    -- Register all slopes
    local chance_factor_table = update_factor_table_with_defaults(init_factor_table)
    local stomp_factor = unilib.setting.slopes_update_on_stomp_factor
    for i, name in ipairs(slope_name_list) do

        core.register_node(name, slope_defn_list[i])

        -- Register walk listener
        if unilib.setting.slopes_enable_shape_on_walk_flag then

            -- N.B. Current version of unilib is not compatible with the "poschangelib" mod (and
            --      thus the "slopes_enable_shape_on_walk_flag setting" is always false); this may
            --      change in the future
            poschangelib.register_stomp(
                name,
                unilib.slopes.update_shape_on_walk,
                {
                    name = name .. "_upd_shape",
                    chance = update_chance * chance_factor_table.stomp * stomp_factor,
                    priority = 500,
                }
            )

        end

    end

    -- Register replacements
    local coloured_flag = def_table.paramtype2 == "color"
    add_replacement(
        base_name,
        update_chance,
        chance_factor_table,
        slope_name_list,
        coloured_flag,
        colour_convert_func
    )

    -- Enable stomp update
    if unilib.setting.slopes_enable_shape_on_walk_flag and
            not unilib.setting.slopes_enable_revert_flag then

        -- N.B. Current version of unilib is not compatible with the "poschangelib" mod (and thus
        --      the "slopes_enable_shape_on_walk_flag setting" is always false); this may change in
        --      the future
        poschangelib.register_stomp(
            base_name,
            unilib.slopes.update_shape_on_walk,
            {
                name = base_name .. "_upd_shape",
                chance = update_chance * chance_factor_table.stomp * stomp_factor,
                priority = 500,
            }
        )

    end

    -- Enable surface update
    local time_factor = unilib.setting.slopes_update_on_time_factor
    if unilib.setting.slopes_enable_surface_update_flag and
            not unilib.setting.slopes_enable_revert_flag then

        -- N.B. Current version of unilib is not compatible with the "twmlib" mod (and thus the
        --      "slopes_enable_surface_update_flag setting" is always false); this may change in the
        --      future
        twmlib.register_twm({
            action = unilib.slopes.update_shape,
            chance = update_chance * chance_factor_table.time * time_factor,
            nodenames = {
                base_name,
                slope_defn_list[1],
                slope_defn_list[2],
                slope_defn_list[3],
                slope_defn_list[4],
            },
        })

    end

    -- Enable revert LBM
    if unilib.setting.slopes_enable_revert_flag then

        unilib.register_lbm({
            label = "Revert natural slopes [unilib]",
            name = "unilib:lbm_system_revert_slopes_" .. unilib.utils.get_item_name(base_name),
            nodenames = slope_name_list,

            run_at_every_load = true,

            action = function (pos, node)
                core.swap_node(pos, {name = base_name})
            end
        })

    end

    return unilib.slopes.get_replacement(base_name)

end

function unilib.slopes.set_slopes(
    base_name, straight_name, inner_name, outer_name, pike_name, update_chance, init_factor_table,
    colour_convert_func
)
    -- Was naturalslopeslib.set_slopes()
    -- Links pre-existing nodes. The same as unilib.slopes.register_slope(), but does not register
    --      new nodes. Use it when the shapes are already registered elsewhere. The node definitions
    --      are not changed at all
    --
    -- Args:
    --      base_name: The full node name
    --      straight_name: The straight slope node name
    --      inner_name: The inner corner node name
    --      outer_name: The outer corner node name
    --      pike_name: The pike/slab node name
    --      update_chance: The inverted chance of occuring
    --      init_factor_table (optional): Optional table for chance factors. By default each factor
    --          is 1
    --      colour_convert_func (optional): Optional function to convert colour palettes. Ignored
    --          when .paramtype2 from the base node is not "color". By default, it matches the first
    --          8 values, and other color values are set to 0
    --
    -- Return values:
    --      Returns a standard natural slopes replacement table, or nil on error

    -- Defensive checks
    if not core.registered_nodes[base_name] then

        if not base_name then

            return unilib.utils.show_error(
                "../lib/effects/slopes/slopes_register.lua: unilib.slopes.set_slopes() failed" ..
                        " because base node is nil"
            )

        else

            return unilib.utils.show_error(
                "../lib/effects/slopes/slopes_register.lua: unilib.slopes.set_slopes() failed" ..
                        " because base node is not registered",
                base_name
            )

        end

    end

    if not core.registered_nodes[straight_name] or
            not core.registered_nodes[inner_name] or
            not core.registered_nodes[outer_name] or
            not core.registered_nodes[pike_name] then

        return unilib.utils.show_error(
            "../lib/effects/slopes/slopes_register.lua: unilib.slopes.set_slopes() failed" ..
                    " because one of the slopes for this node is not registered",
            base_name
        )

    end

    if not update_chance then

        return unilib.utils.show_error(
            "../lib/effects/slopes/slopes_register.lua: Chance not set for node", base_name
        )

    end

    -- Set shape update data
    local chance_factor_table = update_factor_table_with_defaults(init_factor_table)
    local slope_name_list = {straight_name, inner_name, outer_name, pike_name}
    local coloured_flag = core.registered_nodes[base_name].paramtype2 == "color"

    add_replacement(
        base_name,
        update_chance,
        chance_factor_table,
        slope_name_list,
        coloured_flag,
        colour_convert_func
    )

    -- Set surface update
    if unilib.setting.slopes_enable_surface_update_flag and
            not unilib.setting.slopes_enable_revert_flag then

        local time_factor = unilib.setting.slopes_update_on_time_factor
        -- N.B. Current version of unilib is not compatible with the "twmlib" mod (and thus the
        --      "slopes_enable_surface_update_flag setting" is always false); this may change in the
        --      future
        twmlib.register_twm({
            action = unilib.slopes.update_shape,
            chance = update_chance * chance_factor_table.time * time_factor,
            nodenames = {base_name, straight_name, inner_name, outer_name, pike_name},
        })

    end

    -- Set walk listener for the 5 nodes
    if unilib.setting.slopes_enable_shape_on_walk_flag and
            not unilib.setting.slopes_enable_revert_flag then

        local stomp_factor = unilib.setting.slopes_update_on_stomp_factor
        local stomp_desc = {
            name = base_name .. "_upd_shape",
            chance = update_chance * chance_factor_table.stomp * stomp_factor,
            priority = 500,
        }

        -- N.B. Current version of unilib is not compatible with the "poschangelib" mod (and thus
        --      the "slopes_enable_shape_on_walk_flag setting" is always false); this may change in
        --      the future
        poschangelib.register_stomp(
            base_name, unilib.slopes.update_shape_on_walk, stomp_desc
        )

        for i, name in pairs(slope_name_list) do
            poschangelib.register_stomp(name, unilib.slopes.update_shape_on_walk, stomp_desc)
        end

    end

    return unilib.slopes.get_replacement(base_name)

end

function unilib.slopes.propagate_overrides()

    -- Was naturalslopeslib.propagate_overrides()
    -- Having been called, all further calls to core.override_item() will also apply the
    --      modifications to the corresponding slopes. Once called, this behaviour cannot be
    --      disabled

    if unilib.slopes.propagate_overrides_flag then
        return
    end

    unilib.slopes.propagate_overrides_flag = true

    local old_override = core.override_item
    core.override_item = function(name, redefinition)

        local shape_list = unilib.slopes.get_all_shapes(name)
        if #shape_list == 1 then

            old_override(name, redefinition)
            return

        end

        -- Prevent slopes fixed attribute override
        local slope_redef_table = table.copy(redefinition)
        slope_redef_table.drawtype = nil
        slope_redef_table.nodebox = nil
        slope_redef_table.mesh = nil
        slope_redef_table.selection_box = nil
        slope_redef_table.collision_box = nil
        slope_redef_table.paramtype = nil

        if slope_redef_table.paramtype2 ~= nil then

            if slope_redef_table.paramtype2 == "color" or
                    slope_redef_table.paramtype2 == "colorfacedir" then
                slope_redef_table.paramtype2 = "colorfacedir"
            else
                slope_redef_table.paramtype2 = "facedir"
            end

        end

        old_override(name, redefinition)
        for i = 2, #shape_list, 1 do
            old_override(shape_list[i], slope_redef_table)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions - Registration API (from naturalslopeslib/sloped_stomp.lua)
---------------------------------------------------------------------------------------------------

-- N.B. Current version of unilib is not compatible with the "poschangelib" mod; this may change in
--      the future
if core.get_modpath("poschangelib") == nil then

    -- (Register a function that does nothing, to prevent crashes)
    unilib.slopes.register_sloped_stomp = function() end

else

    unilib.slopes.register_sloped_stomp = function(source_node_name, dest_node_name, stomp_desc)

        -- Was naturalslopeslib.register_sloped_stomp()
        -- Registers the specified "stomp_desc" from all shapes of "source_node_name" to
        --      "dest_node_name"

        local source_slope_table = unilib.slopes.get_replacement(source_node_name)
        if source_slope_table == nil then

            return unilib.utils.show_warning(
                "../lib/effects/slopes/slopes_register.lua: No slope registered", source_node_name
            )

        end


        local dest_slope_table = unilib.slopes.get_replacement(dest_node_name)
        if dest_slope_table == nil then

            return unilib.utils.show_warning(
                "../lib/effects/slopes/slopes_register.lua: No slope registered", dest_node_name
            )

        end

        for _, slope_type in pairs({"source", "straight", "inner", "outer", "pike"}) do

            poschangelib.register_stomp(
                source_slope_table[slope_type], dest_slope_table[slope_type], stomp_desc
            )

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions - Registration API (original to unilib)
---------------------------------------------------------------------------------------------------

function unilib.slopes.register_slope_clay(full_name)

    -- Original to unilib
    -- Registers slopes for "full_name", which is a clay node

    local def_table = core.registered_nodes[full_name]
    if def_table then

        unilib.slopes.register_slope(
            full_name,
            {description = unilib.utils.brackets(def_table.description, S("Slope"))},
            15
        )

    end

end

function unilib.slopes.register_slope_dirt(full_name)

    -- Original to unilib
    -- Registers slopes for "full_name", which is a dirt node (without turf or other cover)

    local def_table = core.registered_nodes[full_name]
    if def_table then

        local item_name = unilib.utils.get_item_name(full_name)
        if unilib.global.fertile_dirt_table[item_name] == nil or def_table.groups == nil then

            unilib.slopes.register_slope(
                full_name,
                {description = unilib.utils.brackets(def_table.description, S("Slope"))},
                10,
                {place = 0.5, time = 0.75}
            )

        else

            -- Add the "sloped_fertile_dirt" group to allow the "abm_standard_turf_spread" package
            --      to create a special ABM for turf-spreading dirt slopes
            local group_table = def_table.groups
            group_table.sloped_fertile_dirt = 1

            unilib.slopes.register_slope(
                full_name,
                {
                    description = unilib.utils.brackets(def_table.description, S("Slope")),
                    groups = group_table,
                },
                10,
                {place = 0.5, time = 0.75}
            )

        end

    end

end

function unilib.slopes.register_slope_dirt_covered(full_name)

    -- Original to unilib
    -- Registers slopes for "full_name", which is node with the "covered_dirt" group (typically
    --      a dirt node with covers such as litter or snow, or with non-spreading turf)

    local def_table = core.registered_nodes[full_name]
    if def_table then

        local default_tile = def_table.tiles[1],

        unilib.slopes.register_slope(
            full_name,
            {
                description = unilib.utils.brackets(def_table.description, S("Slope")),
                tiles = {
                    def_table.tiles[1] or default_tile,
                    def_table.tiles[2] or default_tile,
                    {name = def_table.tiles[3].name or def_table.tiles[3] or default_tile},
                },
            },
            15
        )

    end

end

function unilib.slopes.register_slope_dirt_permafrost(full_name)

    -- Original to unilib
    -- Registers slopes for "full_name", which is a permafrost dirt node (with or without cover)

    local def_table = core.registered_nodes[full_name]
    if def_table then

        if #def_table.tiles > 1 then

            local default_tile = def_table.tiles[1],

            unilib.slopes.register_slope(
                full_name,
                {
                    description = unilib.utils.brackets(def_table.description, S("Slope")),
                    tiles = {
                        def_table.tiles[1] or default_tile,
                        def_table.tiles[2] or default_tile,
                        {name = def_table.tiles[3].name or def_table.tiles[3] or default_tile},
                    },
                },
                30
            )

        else

            unilib.slopes.register_slope(
                full_name,
                {description = unilib.utils.brackets(def_table.description, S("Slope"))},
                30
            )

        end

    end

end

function unilib.slopes.register_slope_dirt_spreading(full_name)

    -- Original to unilib
    -- Registers slopes for "full_name", which is node with the "spreading_dirt" group (typically
    --      a dirt-with-turf node)

    local def_table = core.registered_nodes[full_name]
    if def_table then

        local default_tile = def_table.tiles[1],

        unilib.slopes.register_slope(
            full_name,
            {
                description = unilib.utils.brackets(def_table.description, S("Slope")),
                tiles = {
                    def_table.tiles[1] or default_tile,
                    def_table.tiles[2] or default_tile,
                    {name = def_table.tiles[3].name or def_table.tiles[3] or default_tile},
                },
            },
            25
        )

    end

end

function unilib.slopes.register_slope_gravel(full_name)

    -- Original to unilib
    -- Registers slopes for "full_name", which is a gravel node

    local def_table = core.registered_nodes[full_name]
    if def_table then

        unilib.slopes.register_slope(
            full_name,
            {description = unilib.utils.brackets(def_table.description, S("Slope"))},
            7,
            {stomp = 0.5, time = 2}
        )

    end

end

function unilib.slopes.register_slope_ice(full_name)

    -- Original to unilib
    -- Registers slopes for "full_name", which is a ground ice node

    local def_table = core.registered_nodes[full_name]
    if def_table then

        unilib.slopes.register_slope(
            full_name,
            {description = unilib.utils.brackets(def_table.description, S("Slope"))},
            60,
            {mapgen = 0.25}
        )

    end

end

function unilib.slopes.register_slope_leaves(full_name)

    -- Original to unilib
    -- Registers slopes for "full_name", which is a tree/bush leaves node

    local def_table = core.registered_nodes[full_name]
    if def_table then

        unilib.slopes.register_slope(
            full_name,
            {description = unilib.utils.brackets(def_table.description, S("Slope"))},
            2,
            {stomp = 6}
        )

    end

end

function unilib.slopes.register_slope_sand(full_name)

    -- Original to unilib
    -- Registers slopes for "full_name", which is a sand node

    local def_table = core.registered_nodes[full_name]
    if def_table then

        unilib.slopes.register_slope(
            full_name,
            {description = unilib.utils.brackets(def_table.description, S("Slope"))},
            5,
            {place = 0.5, time = 0.75}
        )

    end

end

function unilib.slopes.register_slope_snow(full_name)

    -- Original to unilib
    -- Registers slopes for "full_name", which is a ground snow node

    local def_table = core.registered_nodes[full_name]
    if def_table then

        unilib.slopes.register_slope(
            full_name,
            {description = unilib.utils.brackets(def_table.description, S("Slope"))},
            4,
            {stomp = 0}
        )

    end

end

function unilib.slopes.register_slope_stone_cobble(full_name)

    -- Original to unilib
    -- Registers slopes for "full_name", which is a cobblestone node

    local def_table = core.registered_nodes[full_name]
    if def_table then

        unilib.slopes.register_slope(
            full_name,
            {description = unilib.utils.brackets(def_table.description, S("Slope"))},
            10,
            {time = 3}
        )

    end

end

function unilib.slopes.register_slope_stone_cobble_mossy(full_name)

    -- Original to unilib
    -- Registers slopes for "full_name", which is a cobblestone node

    local def_table = core.registered_nodes[full_name]
    if def_table then

        unilib.slopes.register_slope(
            full_name,
            {description = unilib.utils.brackets(def_table.description, S("Slope"))},
            15,
            {time = 3}
        )

    end

end

function unilib.slopes.register_slope_stone_smooth(full_name)

    -- Original to unilib
    -- Registers slopes for "full_name", which is a smooth stone node

    local def_table = core.registered_nodes[full_name]
    if def_table then

        unilib.slopes.register_slope(
            full_name,
            {description = unilib.utils.brackets(def_table.description, S("Slope"))},
            200,
            {mapgen = 0.33, place = 0.5}
        )

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions - Getters (from naturalslopeslib/register_slopes.lua)
---------------------------------------------------------------------------------------------------

function unilib.slopes.get_replacement(source_node_name)

    -- Was naturalslopeslib.get_replacement()
    -- Gets the standard replacement table matching the specified key "source_node_name",
    --      containing references to node names
    --
    -- Args:
    --      source_node_name: A registered node name
    --
    -- Return values:
    --      Returns a standard natural slopes replacement table, or nil if no slopes are registered

    return main_replacement_table[source_node_name]

end

function unilib.slopes.get_replacement_id(source_id)

    -- Was naturalslopeslib.get_replacement_id()
    -- Gets the standard replacement table matching the specified key "source_id", containing
    --      references to node IDs
    --
    -- Args:
    --      source_id: The ID of a registered node name
    --
    -- Return values:
    --      Returns a standard natural slopes replacement table (with node IDs as values), or nil if
    --          no slopes are registered

    return main_replacement_id_table[source_id]

end

function unilib.slopes.get_all_shapes(source_node_name)

    -- Was naturalslopeslib.get_all_shapes()
    -- Returns all variant shape names as a list
    --
    -- Args:
    --      source_node_name: A node name, can be a full block or a slope
    --
    -- Return values:
    --      A list in the form {block, straight slope, inner corner, outer corner, pike}. However,
    --          returns a list in the form {source_node_name} if there are no other shapes for this
    --          node

    if main_replacement_table[source_node_name] then

        local rp = main_replacement_table[source_node_name]
        return {rp.source, rp.straight, rp.inner, rp.outer, rp.pike}

    else

        return {source_node_name}

    end

end

function unilib.slopes.get_all_slopes(source_node_name)

    -- Was naturalslopeslib.get_all_slopes()
    -- Returns all sloped variant shape names
    --
    -- Args:
    --      source_node_name: A node name, can be a full block or a slope
    --
    -- Return values:
    --      A list in the form {straight slope, inner corner, outer corner, pike}. Returns an empty
    --          list if there are no slopes for this node

    if main_replacement_table[source_node_name] then

        local rp = main_replacement_table[source_node_name]
        return {rp.straight, rp.inner, rp.outer, rp.pike}

    else

        return {}

    end

end

function unilib.slopes.list_registered_nodes()

    -- Was naturalslopeslib.list_registered_nodes(); incorrectly described in original API as
    --      naturalslopeslib.list_registered_slopes()
    -- Gets the list of nodes in block shape for which slopes have been registered

    return table.copy(source_list)

end

---------------------------------------------------------------------------------------------------
-- Setup code (from naturalslopeslib/init.lua)
---------------------------------------------------------------------------------------------------

unilib.slopes.reset_default_definition()
