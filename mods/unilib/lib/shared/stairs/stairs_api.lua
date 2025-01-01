---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stairs_api.lua
--      API functions for stairs
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- N.B. In this case, it's more efficient to decide while files to load in advance, rather than
--      waiting for various wrapper function to be called
-- (If the player wants shorter startup times, they can disable stairs anyway)

-- Stair support functions and populate global tables
if unilib.setting.add_stairs_basic_flag or
        unilib.setting.add_stairs_castle_flag or
        unilib.setting.add_stairs_moreblocks_flag or
        unilib.setting.add_stairs_pkarcs_flag or
        unilib.setting.add_stairs_plantlife_flag or
        unilib.setting.add_stairs_stairs_redo_flag or
        unilib.setting.add_stairs_stairsplus_flag then

    dofile(unilib.core.path_mod .. "/lib/shared/stairs/stairs_support.lua")
    dofile(unilib.core.path_mod .. "/lib/shared/stairs/stairs_populate_tables.lua")

end

-- Basic stairs
if unilib.setting.add_stairs_basic_flag or
        unilib.setting.add_stairs_stairs_redo_flag or
        unilib.setting.add_stairs_stairsplus_flag or
        unilib.setting.add_stairs_moreblocks_flag then
    dofile(unilib.core.path_mod .. "/lib/shared/stairs/stairs_basic.lua")
end

-- Stairs from castle modpack
if unilib.setting.add_stairs_castle_flag then
    dofile(unilib.core.path_mod .. "/lib/shared/stairs/stairs_castle.lua")
end

-- Stairs from moreblocks
if unilib.setting.add_stairs_moreblocks_flag then
    dofile(unilib.core.path_mod .. "/lib/shared/stairs/stairs_moreblocks.lua")
end

-- Stairs from moreblocks and stairs_redo
if unilib.setting.add_stairs_stairsplus_flag or unilib.setting.add_stairs_moreblocks_flag then
    dofile(unilib.core.path_mod .. "/lib/shared/stairs/stairs_mixed.lua")
end

-- Stairs from pkarcs
if unilib.setting.add_stairs_pkarcs_flag then
    dofile(unilib.core.path_mod .. "/lib/shared/stairs/stairs_pkarcs.lua")
end

-- Stairs from plantlife
if unilib.setting.add_stairs_plantlife_flag then
    dofile(unilib.core.path_mod .. "/lib/shared/stairs/stairs_plantlife.lua")
end

-- Stairs from stairs_redo
if unilib.setting.add_stairs_stairs_redo_flag then
    dofile(unilib.core.path_mod .. "/lib/shared/stairs/stairs_stairs_redo.lua")
end

-- Stairs from stairsplus
if unilib.setting.add_stairs_stairsplus_flag then
    dofile(unilib.core.path_mod .. "/lib/shared/stairs/stairs_stairsplus.lua")
end

---------------------------------------------------------------------------------------------------
-- API functions for stairs
---------------------------------------------------------------------------------------------------

function unilib.stairs._register_stairs(full_name, data_table)

    -- Original to unilib
    -- Most code will call this function to create all available stair types for a node
    --
    -- Other functions below are the direct equivalents of minetest_game/stairs functions, and can
    --      be called directly, if needed (for example, when only a node in the shape of a slab is
    --      to be created). None of them check Minetest settings, so the calling code must do that
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Optional args:
    --      data_table (table or nil): If specified, contains any of the fields:
    --          .basic_flag (bool): If true, only stairs from minetest_game/stairs are created. If
    --              unilib.setting.add_stairs_plantlife_flag is true, then stairs from plantlife are
    --              also created. This flag overrides Minetest settings such as
    --              unilib.setting.add_stairs_stairsplus_flag
    --          .cooked_name (str): If specified, "full_name" is a cobblestone (or similar node)
    --              that can be cooked to produce the node "cooked_name". All derivative stair nodes
    --              can be cooked in the same way
    --          .drop_name (str): If specified, "full_name" is a smooth stone (or similar node) that
    --              produces the node "drop_name" when dug. All derivative stair nodes can be dug in
    --              the same way
    --          .glass_flag (bool): If true, the moreblocks system for cut glass applies: the top
    --              texture is used for all sides of the stair node (which makes them easier to
    --              see). Note that this might not apply to all glass nodes (it does not apply, for
    --              example, to ordinary and obsidian glass from default)
    --          .group_type (str): If specified, used to give each stair node a group that
    --              identifies both the stair type and the node type. For example, tree packages
    --              should call this function with the .group_type "wood", in which case stair
    --              nodes are created with the groups "wood_stair_simple = 1", "wood_stair_slab = 1"
    --              and so on. Thus, other nodes can use "group:wood_stair_simple",
    --              "group:wood_stair_slab" in their craft recipes. Any value is acceptable; unilib
    --              code routinely uses the values "wood" (for tree planks), and "smooth", "block",
    --              "brick", "cobble", "mossy_cobble" and "rubble" (for stone nodes)
    --          .img_rotate_flag (bool): If true, when the stair node is rotated, its textures are
    --              rotated too. If false (or unspecified), when the stair node is rotated, its
    --              textures are kept aligned with the world. Thus, nodes with non-symmetrical
    --              textures (such as unilib:stone_ordinary_brick and most other brick nodes) should
    --              specify this flag
    --          .slab_img_list (list): List of textures to use for slabs. If not specified, the
    --              textures of the original node are used
    --          .super_flag (str): If true, "full_name" is a super stone, super dirt or super tree,
    --              in which any basic stairs created are visible in the creative inventory,
    --              regardless of other Minetest settings

    -- (Any of unilib.setting.add_stairs_basic_flag, .add_stairs_stairs_redo_flag,
    --      .add_stairs_stairsplus_flag or .add_stairs_moreblocks_flag are true)
    if unilib.global.add_stairs_any_flag then

        local def_table = core.registered_nodes[full_name]
        if def_table == nil then

            return unilib.utils.show_error(
                string.format(
                    ".unilib.register_stairs(): cannot add stairs because \"%s\" is not a" ..
                            " registered node",
                    full_name
                )
            )

        elseif def_table.groups ~= nil then

            -- Stairs made from soils must not be used to grow crops, etc
            def_table.groups.soil = nil

        end

        if data_table == nil then
            data_table = {}
        end

        unilib.stairs._register_stairs_all(
            full_name,
            unilib.utils.get_item_name(full_name),
            def_table,
            data_table
        )

    end

end

function unilib.stairs._register_stairs_all(full_name, item_name, def_table, data_table)

    -- Adapted from stairs/init.lua, stairs.register_stair_and_slab() and
    --      my_register_stair_and_slab()
    -- This function should only be called as a direct replacement for those functions, when that is
    --      necessary; in almost all circumstances, it's better to call unilib.register_stairs()
    --      instead
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      item_name (str): e.g. "stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()

    -- Create stair nodes derived from "full_name"
    if unilib.setting.add_stairs_basic_flag or
            unilib.setting.add_stairs_stairs_redo_flag or
            unilib.setting.add_stairs_stairsplus_flag or
            unilib.setting.add_stairs_moreblocks_flag then

        unilib.stairs._register_simple(full_name, def_table, data_table)
        unilib.stairs._register_inner(full_name, def_table, data_table)
        unilib.stairs._register_outer(full_name, def_table, data_table)
        unilib.stairs._register_slab(full_name, def_table, data_table)

    end

    if unilib.setting.add_stairs_plantlife_flag then

        unilib.stairs._register_corner_roof(full_name, def_table, data_table)
        unilib.stairs._register_corner_roof_inverted(full_name, def_table, data_table)

    end

    if data_table.basic_flag then
        return
    end

    if unilib.setting.add_stairs_stairsplus_flag or unilib.setting.add_stairs_moreblocks_flag then

        unilib.stairs._register_simple_half(full_name, def_table, data_table)
        unilib.stairs._register_simple_half_right(full_name, def_table, data_table)
        unilib.stairs._register_panel_bottom(full_name, def_table, data_table)
        unilib.stairs._register_micro_bottom(full_name, def_table, data_table)

    end

    if unilib.setting.add_stairs_stairsplus_flag then

        unilib.stairs._register_simple_inverted(full_name, def_table, data_table)
        unilib.stairs._register_simple_half_inverted(full_name, def_table, data_table)
        unilib.stairs._register_simple_half_right_inverted(full_name, def_table, data_table)
        unilib.stairs._register_corner(full_name, def_table, data_table)
        unilib.stairs._register_corner_half(full_name, def_table, data_table)
        unilib.stairs._register_corner_half_inverted(full_name, def_table, data_table)
        unilib.stairs._register_inner_inverted(full_name, def_table, data_table)
        unilib.stairs._register_outer_inverted(full_name, def_table, data_table)
        unilib.stairs._register_slab_inverted(full_name, def_table, data_table)
        unilib.stairs._register_slab_quarter(full_name, def_table, data_table)
        unilib.stairs._register_slab_quarter_inverted(full_name, def_table, data_table)
        unilib.stairs._register_slab_three_quarter(full_name, def_table, data_table)
        unilib.stairs._register_slab_three_quarter_inverted(full_name, def_table, data_table)
        unilib.stairs._register_tile(full_name, def_table, data_table)
        unilib.stairs._register_tile_quarter(full_name, def_table, data_table)
        unilib.stairs._register_tile_three_quarter(full_name, def_table, data_table)
        unilib.stairs._register_panel_top(full_name, def_table, data_table)
        unilib.stairs._register_panel_vertical(full_name, def_table, data_table)
        unilib.stairs._register_micro_top(full_name, def_table, data_table)

    end

    if unilib.setting.add_stairs_stairs_redo_flag then

        unilib.stairs._register_slope(full_name, def_table, data_table)
        unilib.stairs._register_slope_inner(full_name, def_table, data_table)
        unilib.stairs._register_slope_outer(full_name, def_table, data_table)

    end

    if unilib.setting.add_stairs_moreblocks_flag then

        unilib.stairs._register_micro_bottom_cut_eighth(full_name, def_table, data_table)
        unilib.stairs._register_micro_bottom_cut_quarter(full_name, def_table, data_table)
        unilib.stairs._register_micro_bottom_cut_half(full_name, def_table, data_table)
        unilib.stairs._register_panel_vertical_sliced_eighth(full_name, def_table, data_table)
        unilib.stairs._register_panel_vertical_sliced_quarter(full_name, def_table, data_table)
        unilib.stairs._register_panel_vertical_sliced_half(full_name, def_table, data_table)
        unilib.stairs._register_panel_bottom_cut_eighth(full_name, def_table, data_table)
        unilib.stairs._register_panel_bottom_cut_quarter(full_name, def_table, data_table)
        unilib.stairs._register_panel_bottom_cut_half(full_name, def_table, data_table)
        unilib.stairs._register_tile_sliced_eighth(full_name, def_table, data_table)
        unilib.stairs._register_tile_sliced_quarter(full_name, def_table, data_table)
        unilib.stairs._register_tile_sliced_half(full_name, def_table, data_table)
        unilib.stairs._register_slab_cut_eighth(full_name, def_table, data_table)
        unilib.stairs._register_slab_cut_quarter(full_name, def_table, data_table)
        unilib.stairs._register_slab_cut_half(full_name, def_table, data_table)
        unilib.stairs._register_slab_sliced_eighth(full_name, def_table, data_table)
        unilib.stairs._register_slab_sliced_quarter(full_name, def_table, data_table)
        unilib.stairs._register_slab_sliced_half(full_name, def_table, data_table)
        unilib.stairs._register_box_sided_two(full_name, def_table, data_table)
        unilib.stairs._register_box_sided_three(full_name, def_table, data_table)
        unilib.stairs._register_box_sided_three_corner(full_name, def_table, data_table)
        unilib.stairs._register_slope_half(full_name, def_table, data_table)
        unilib.stairs._register_slope_half_raised(full_name, def_table, data_table)
        unilib.stairs._register_slope_inner_half(full_name, def_table, data_table)
        unilib.stairs._register_slope_inner_half_raised(full_name, def_table, data_table)
        unilib.stairs._register_slope_inner_cut(full_name, def_table, data_table)
        unilib.stairs._register_slope_inner_cut_half(full_name, def_table, data_table)
        unilib.stairs._register_slope_inner_cut_half_raised(full_name, def_table, data_table)
        unilib.stairs._register_slope_outer_half(full_name, def_table, data_table)
        unilib.stairs._register_slope_outer_half_raised(full_name, def_table, data_table)
        unilib.stairs._register_slope_outer_cut(full_name, def_table, data_table)
        unilib.stairs._register_slope_outer_cut_half(full_name, def_table, data_table)
        unilib.stairs._register_slope_outer_cut_half_raised(full_name, def_table, data_table)
        unilib.stairs._register_slope_cut(full_name, def_table, data_table)
        unilib.stairs._register_steps(full_name, def_table, data_table)
        unilib.stairs._register_steps_sliced_eighth(full_name, def_table, data_table)
        unilib.stairs._register_steps_sliced_quarter(full_name, def_table, data_table)
        unilib.stairs._register_steps_sliced_half(full_name, def_table, data_table)

    end

    if unilib.setting.add_stairs_castle_flag then

        unilib.stairs._register_hole_murder(full_name, def_table, data_table)
        unilib.stairs._register_hole_machicolation(full_name, def_table, data_table)
        unilib.stairs._register_pillar_bottom(full_name, def_table, data_table)
        unilib.stairs._register_pillar_bottom_half(full_name, def_table, data_table)
        unilib.stairs._register_pillar_top(full_name, def_table, data_table)
        unilib.stairs._register_pillar_top_half(full_name, def_table, data_table)
        unilib.stairs._register_pillar_middle(full_name, def_table, data_table)
        unilib.stairs._register_pillar_middle_half(full_name, def_table, data_table)
        unilib.stairs._register_pillar_crossbrace(full_name, def_table, data_table)
        unilib.stairs._register_pillar_crossbrace_ext(full_name, def_table, data_table)
        unilib.stairs._register_slit(full_name, def_table, data_table)
        unilib.stairs._register_slit_cross(full_name, def_table, data_table)
        unilib.stairs._register_slit_hole(full_name, def_table, data_table)
        unilib.stairs._register_slit_embrasure(full_name, def_table, data_table)

    end

    if unilib.add_stairs_pkarcs_flag then

        unilib.stairs._register_arch_simple(full_name, def_table, data_table)
        unilib.stairs._register_arch_outer(full_name, def_table, data_table)
        unilib.stairs._register_arch_inner(full_name, def_table, data_table)

    end

end
