---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- carvings_api.lua
--      API functions for carvings
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- N.B. In this case, it's more efficient to decide while files to load in advance, rather than
--      waiting for various wrapper function to be called
-- (If the player wants shorter startup times, they can disable carvings anyway)

-- Populate global tables for carvings
if unilib.setting.add_carvings_column_flag or
        unilib.setting.add_carvings_facade_flag or
        unilib.setting.add_carvings_millwork_flag or
        unilib.setting.add_carvings_farlands_flag then
    dofile(unilib.core.path_mod .. "/lib/shared/carvings/carvings_populate_tables.lua")
end

-- Carvings from columnia mod
if unilib.setting.add_carvings_column_flag then
    dofile(unilib.core.path_mod .. "/lib/shared/carvings/carvings_column.lua")
end

-- Carvings from facade mod
if unilib.setting.add_carvings_facade_flag then
    dofile(unilib.core.path_mod .. "/lib/shared/carvings/carvings_facade.lua")
end

-- Carvings from millwork mod
if unilib.setting.add_carvings_millwork_flag then
    dofile(unilib.core.path_mod .. "/lib/shared/carvings/carvings_millwork.lua")
end

-- Carvings from farlands modpack
if unilib.setting.add_carvings_farlands_flag then
    dofile(unilib.core.path_mod .. "/lib/shared/carvings/carvings_farlands.lua")
end

---------------------------------------------------------------------------------------------------
-- API functions for carvings
---------------------------------------------------------------------------------------------------

function unilib.carvings._register_carvings(full_name, data_table)

    -- Original to unilib
    -- Most code will call this function to create all available carving types for a node
    --
    -- Other functions below are the direct equivalents of functions in columnia, facade and
    --      mymillwork, and can be called directly, if needed. (In the original farlands code, the
    --      "carvings" were made from a single ingredient, so did not have separate functions for
    --      each carving type)
    -- None of the functions below check Minetest settings, so the calling code must do that
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Optional args:
    --      data_table (table or nil): If specified, contains any of the fields:
    --          .all_flag (bool): If true, all column/facade/millwork/farlands nodes are created as
    --              if .column_flag, .facade_flag, .millwork_flag and .farlands_flag were all true
    --              (but not as if .brick_flag is true; that is something separate)
    --          .brick_flag (bool): If true, then the corner bricks facade node is created. If false
    --              or not specified, it is NOT created
    --          .column_flag (bool): If true, all column nodes are created. If false or not
    --              specified, or if Minetest settings prohibit them, they are NOT created
    --          .facade_flag (bool): If true, all facade nodes (except corner bricks) are created.
    --              If false or not specified, or if Minetest settings prohibit them, they are NOT
    --              created. Facades look best on smooth stones, hard clays, etc)
    --          .farlands_flag (bool): If true, all farlands nodes are created. If false or not
    --              specified, or if Minetest settings prohibit them, they are NOT created
    --          .millwork_flag (bool): If true, all millwork nodes are created. If false or not
    --              specified, or if Minetest settings prohibit them, they are NOT created

    -- (Any of unilib.setting.add_carvings_column_flag, .add_carvings_facade_flag,
    --      .add_carvings_millwork_flag or .add_carvings_farlands_flag are true)
    if unilib.global.add_carvings_any_flag then

        local def_table = core.registered_nodes[full_name]
        if def_table == nil then

            return unilib.utils.show_error(
                "../lib/shared/carvings/carvings_api.lua:" ..
                    " cannot add carvings because \"@1\" is not a registered node",
                full_name
            )

        elseif def_table.groups ~= nil then

            -- Carvings made from soils must not be used to grow crops, etc
            def_table.groups.soil = nil

        end

        if data_table == nil then
            data_table = {}
        end

        unilib.carvings._register_carvings_all(
            full_name,
            unilib.utils.get_item_name(full_name),
            def_table,
            data_table
        )

    end

end

function unilib.carvings._register_carvings_all(full_name, item_name, def_table, data_table)

    -- Original to unilib
    -- This function and unilib.register_carvings() are separate, in order to mirror the structure
    --      of code in ../lib/shared/stairs/. There is probably no need to call this function from
    --      anywhere else in the code
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      item_name (str): e.g. "stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_carvings()

    -- Create carving nodes derived from "full_name"
    if unilib.setting.add_carvings_column_flag and
            (data_table.all_flag or data_table.column_flag) then

        unilib.carvings._register_column_centre(full_name, def_table)
        unilib.carvings._register_column_top(full_name, def_table)
        unilib.carvings._register_column_bottom(full_name, def_table)
        unilib.carvings._register_column_crosslink(full_name, def_table)
        unilib.carvings._register_column_link(full_name, def_table)
        unilib.carvings._register_column_downlink(full_name, def_table)

    end

    if unilib.setting.add_carvings_facade_flag then

        if data_table.all_flag or data_table.facade_flag == true then

            unilib.carvings._register_facade_bannerstone(full_name, def_table)
            unilib.carvings._register_facade_bannerstone_corner(full_name, def_table)
            unilib.carvings._register_facade_centrestone(full_name, def_table)
            unilib.carvings._register_facade_column(full_name, def_table)
            unilib.carvings._register_facade_column_corner(full_name, def_table)
            unilib.carvings._register_facade_corbel(full_name, def_table)
            unilib.carvings._register_facade_corbel_corner(full_name, def_table)
            unilib.carvings._register_facade_corbel_corner_inner(full_name, def_table)
            unilib.carvings._register_facade_swirl(full_name, def_table)
            unilib.carvings._register_facade_swirl_corner(full_name, def_table)
            unilib.carvings._register_facade_fascia(full_name, def_table)
            unilib.carvings._register_facade_fascia_corner_inner(full_name, def_table)
            unilib.carvings._register_facade_fascia_corner_outer(full_name, def_table)

        end

        if data_table.brick_flag == true then
            unilib.carvings._register_facade_bricks_corner(full_name, def_table)
        end

    end

    if unilib.setting.add_carvings_millwork_flag and
            (data_table.all_flag or data_table.millwork_flag) then

        unilib.carvings._register_mill_crownmould(full_name, def_table)
        unilib.carvings._register_mill_crownmould_corner_inner(full_name, def_table)
        unilib.carvings._register_mill_crownmould_corner_outer(full_name, def_table)
        unilib.carvings._register_mill_crownmould_beam(full_name, def_table)
        unilib.carvings._register_mill_column(full_name, def_table)
        unilib.carvings._register_mill_column_base(full_name, def_table)
        unilib.carvings._register_mill_column_half(full_name, def_table)
        unilib.carvings._register_mill_column_half_base(full_name, def_table)
        unilib.carvings._register_mill_column_half_base_beam(full_name, def_table)
        unilib.carvings._register_mill_column_quarter(full_name, def_table)
        unilib.carvings._register_mill_column_quarter_base(full_name, def_table)
        unilib.carvings._register_mill_column_quarter_base_board(full_name, def_table)
        unilib.carvings._register_mill_column_quarter_base_fancy(full_name, def_table)
        unilib.carvings._register_mill_ceiling(full_name, def_table)
        unilib.carvings._register_mill_ceiling_post(full_name, def_table)
        unilib.carvings._register_mill_beam(full_name, def_table)
        unilib.carvings._register_mill_beam_t(full_name, def_table)
        unilib.carvings._register_mill_ceiling_beam_t(full_name, def_table)
        unilib.carvings._register_mill_base(full_name, def_table)
        unilib.carvings._register_mill_base_corner_inner(full_name, def_table)
        unilib.carvings._register_mill_base_corner_outer(full_name, def_table)
        unilib.carvings._register_mill_base_fancy(full_name, def_table)
        unilib.carvings._register_mill_base_fancy_corner_inner(full_name, def_table)
        unilib.carvings._register_mill_base_fancy_corner_outer(full_name, def_table)

    end

    if unilib.setting.add_carvings_farlands_flag and
            (data_table.all_flag or data_table.farlands_flag) then

        unilib.carvings._register_farlands_arch(full_name, def_table)
        unilib.carvings._register_farlands_ledge(full_name, def_table)
        unilib.carvings._register_farlands_ledge_corner(full_name, def_table)
        unilib.carvings._register_farlands_rail(full_name, def_table)
        unilib.carvings._register_farlands_rail_corner(full_name, def_table)
        unilib.carvings._register_farlands_window(full_name, def_table)

    end

end
