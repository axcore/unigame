---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- carvings_column.lua
--      Carvings from columnia mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local c_blueprint = "unilib:misc_blueprint_column"

local node_shape_table = {
    column_centre = {
        {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
    },
    column_top = {
        {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
        {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},
        {-0.375, 0, -0.375, 0.375, 0.5, 0.375},
    },
    column_bottom = {
        {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
        {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
        {-0.375, -0.5, -0.375, 0.375, 0, 0.375},
    },
    column_crosslink = {
        {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
        {-0.5, 0, -0.25, 0.5, 0.5, 0.25},
        {-0.25, 0, -0.5, 0.25, 0.5, 0.5},
        {-0.4375, 0.0625, -0.4375, 0.4375, 0.4375, 0.4375},
    },
    column_link = {
        {-0.25, 0, -0.5, 0.25, 0.5, 0.5},
    },
    column_downlink = {
        {-0.25, 0, -0.5, 0.25, 0.5, 0.5},
        {-0.125, -0.5, -0.125, 0.125, 0, 0.125},
        {-0.1875, -0.5, -0.1875, 0.1875, -0.375, 0.1875},
        {-0.1875, -0.125, -0.1875, 0.1875, 0, 0.1875},
    },
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function warn_if_exists(adj_full_name)

    -- Adapted from stairs/init.lua

    if core.registered_nodes[adj_full_name] then

        unilib.utils.show_warning(
            "../lib/shared/carvings/carvings_column.lua: Overwriting carving node", adj_full_name
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

local function prepare_column(full_name, def_table, adj_full_name, adj_desc, show_flag, shape_table)

    -- Adapted from columnia/init.lua

    -- Update the original node's groups field
    local adj_group_table = table.copy(def_table.groups)
    if not show_flag then
        adj_group_table.not_in_creative_inventory = 1
    else
        adj_group_table.not_in_creative_inventory = nil
    end

    -- columnia groups did not match the original node's groups very closely (perhaps they were
    --      copied from an ancient version of minetest_game)
    -- This algorithm makes the two sets of groups match more closely, while preserving the
    --      integrity of groups for any node not carved by columnia
    adj_group_table.stone = nil
    adj_group_table.level = nil
    if adj_group_table.wood ~= nil then

        adj_group_table.wood = nil
        if adj_group_table.snappy == nil then
            adj_group_table.snappy = 2
        end

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

        drawtype = "nodebox",
        -- (is_ground_content was true in original columnia code)
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

        on_place = function(itemstack, placer, pointed_thing)

            if pointed_thing.type ~= "node" then
                return itemstack
            end

            local p0 = pointed_thing.under
            local p1 = pointed_thing.above
            local param2 = 0

            local placer_pos = placer:get_pos()
            if placer_pos then

                local dir = {
                    x = p1.x - placer_pos.x,
                    y = p1.y - placer_pos.y,
                    z = p1.z - placer_pos.z
                }

                param2 = core.dir_to_facedir(dir)

            end

            if p0.y-1 == p1.y then

                param2 = param2 + 20
                if param2 == 21 then
                    param2 = 23
                elseif param2 == 23 then
                    param2 = 21
                end

            end

            return core.item_place(itemstack, placer, pointed_thing, param2)

        end,
    }

    -- Light from light sources is reduced by a third (not in original columnia code, but done to be
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

local function create_fuel_recipe(full_name, adj_full_name, factor)

    -- Adapted from stairs/init.lua

    local base_burn_time = core.get_craft_result({
        method = "fuel",
        width = 1,
        items = {full_name}
    }).time

    if base_burn_time > 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = adj_full_name,
            burntime = math.floor(base_burn_time * factor),
        })

    end

end

---------------------------------------------------------------------------------------------------
-- Carvings from columnia mod
---------------------------------------------------------------------------------------------------

function unilib.carvings._register_column_centre(full_name, def_table)

    -- Adapted from columnia/init.lua, columnia:column_mid_XXX
    -- Creates a centred column node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_column_centre"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Centred column"))

    -- Register the node
    prepare_column(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_column_flag or unilib.setting.show_carvings_facade_flag,
        node_shape_table.column_centre
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 2/2)

    -- (From columnia. We disable these craft recipes if carvings from facade are enabled, but
    --      carvings from columnia are not)
    if unilib.setting.add_carvings_column_flag then

        unilib.register_craft({
            output = adj_full_name .. " 2",
            recipe = {
                {"", full_name, ""},
                {"", c_blueprint, ""},
                {"", full_name, ""},
            },
            replacements = {
                {c_blueprint, c_blueprint},
            },
        })

    end

    return adj_full_name

end

function unilib.carvings._register_column_top(full_name, def_table)

    -- Adapted from columnia/init.lua, columnia:column_top_XXX
    -- Creates a column top node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_column_top"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Column top"))

    -- Register the node
    prepare_column(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_column_flag or unilib.setting.show_carvings_facade_flag,
        node_shape_table.column_top
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/4)

    -- (From columnia)
    if unilib.setting.add_carvings_column_flag then

        unilib.register_craft({
            output = adj_full_name .. " 4",
            recipe = {
                {full_name, full_name, full_name},
                {"", full_name, ""},
                {"", c_blueprint, ""},
            },
            replacements = {
                {c_blueprint, c_blueprint},
            },
        })

    end

    return adj_full_name

end

function unilib.carvings._register_column_bottom(full_name, def_table)

    -- Adapted from columnia/init.lua, columnia:column_bottom_XXX
    -- Creates a column bottom node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_column_bottom"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Column bottom"))

    -- Register the node
    prepare_column(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_column_flag or unilib.setting.show_carvings_facade_flag,
        node_shape_table.column_bottom
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/4)

    -- (From columnia)
    if unilib.setting.add_carvings_column_flag then

        unilib.register_craft({
            output = adj_full_name .. " 4",
            recipe = {
                {"", c_blueprint, ""},
                {"", full_name, ""},
                {full_name, full_name, full_name},
            },
            replacements = {
                {c_blueprint, c_blueprint},
            },
        })

    end

    return adj_full_name

end

function unilib.carvings._register_column_crosslink(full_name, def_table)

    -- Adapted from columnia/init.lua, columnia:column_crosslink_XXX
    -- Creates a column crosslink node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_column_crosslink"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Column crosslink"))

    -- Register the node
    prepare_column(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_column_flag or unilib.setting.show_carvings_facade_flag,
        node_shape_table.column_crosslink
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/4)

    -- (From columnia)
    if unilib.setting.add_carvings_column_flag then

        unilib.register_craft({
            output = adj_full_name .. " 4",
            recipe = {
                {"", full_name, ""},
                {full_name, c_blueprint, full_name},
                {"", full_name, ""},
            },
            replacements = {
                {c_blueprint, c_blueprint},
            },
        })

    end

    return adj_full_name

end

function unilib.carvings._register_column_link(full_name, def_table)

    -- Adapted from columnia/init.lua, columnia:column_link_XXX
    -- Creates a centred column node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_column_link"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Column link"))

    -- Register the node
    prepare_column(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_column_flag or unilib.setting.show_carvings_facade_flag,
        node_shape_table.column_link
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 2/2)

    -- (From columnia)
    if unilib.setting.add_carvings_column_flag then

        unilib.register_craft({
            output = adj_full_name .. " 2",
            recipe = {
                {full_name, c_blueprint, full_name},
                {"", "", ""},
                {"", "", ""},
            },
            replacements = {
                {c_blueprint, c_blueprint},
            },
        })

    end

    return adj_full_name

end

function unilib.carvings._register_column_downlink(full_name, def_table)

    -- Adapted from columnia/init.lua, columnia:column_linkdown_XXX
    -- Creates a centred column node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_column_downlink"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.utils.brackets(def_table.description, S("Column downlink"))

    -- Register the node
    prepare_column(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.setting.show_carvings_column_flag or unilib.setting.show_carvings_facade_flag,
        node_shape_table.column_downlink
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 3/3)

    -- (From columnia)
    if unilib.setting.add_carvings_column_flag then

        unilib.register_craft({
            output = adj_full_name .. " 3",
            recipe = {
                {full_name, c_blueprint, full_name},
                {"", full_name, ""},
                {"", "", ""},
            },
            replacements = {
                {c_blueprint, c_blueprint},
            },
        })

    end

    return adj_full_name

end
