---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- update.lua
--      Update global variables, now that override.lua has finished
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Update global variables
---------------------------------------------------------------------------------------------------

if unilib.show_dependency_simple_flag or unilib.show_dependency_detailed_flag then

    unilib.force_replace_flag = true
    unilib.force_load_dependent_pkg_flag = true
    unilib.force_load_minimal_pkg_flag = true
    unilib.force_load_optional_pkg_flag = true
    unilib.force_load_suggested_pkg_flag = true

end

for _, stone_type in pairs(unilib.split_string_by_whitespace(unilib.super_stone_set, true)) do

    if stone_type == "nothing" then

        -- (The "nothing" value overrides everything else in the set)
        unilib.super_stone_mode = "nothing"
        break

    elseif stone_type == "everything" then

        -- (Continue check unilib.super_stone_set, in case it contains "nothing")
        unilib.super_stone_mode = "everything"

    else

        unilib.super_stone_table[stone_type] = true

    end

end

if unilib.super_stone_mode ~= "default" then

    -- It's now up to unilib.register_stone() to populate unilib.super_stone_table()
    unilib.super_stone_table = {}

end

for _, tree_type in pairs(unilib.split_string_by_whitespace(unilib.super_tree_set, true)) do

    if tree_type == "nothing" then

        -- (The "nothing" value overrides everything else in the set)
        unilib.super_tree_mode = "nothing"
        break

    elseif tree_type == "everything" then

        -- (Continue check unilib.super_tree_set, in case it contains "nothing")
        unilib.super_tree_mode = "everything"

    else

        unilib.super_tree_table[tree_type] = true

    end

end

if unilib.super_tree_mode ~= "default" then

    -- It's now up to unilib.register_tree() to populate unilib.super_tree_table()
    unilib.super_tree_table = {}

end

if unilib.plantlike_leaves_flag then

    unilib.leaves_drawtype = "plantlike"
    unilib.leaves_visual_scale = 1.4

end

if unilib.sapling_quick_grow_flag then

    unilib.sapling_grow_min = 5
    unilib.sapling_grow_max = 5
    unilib.sapling_grow_default = 5
    unilib.sapling_grow_retry = 5

end

unilib.add_stairs_any_flag = unilib.add_stairs_basic_flag or
        unilib.add_stairs_stairs_redo_flag or
        unilib.add_stairs_stairsplus_flag or
        unilib.add_stairs_moreblocks_flag
unilib.show_stairs_any_flag = unilib.show_stairs_basic_flag or
        unilib.show_stairs_stair_redo_flag or
        unilib.show_stairs_stairsplus_flag or
        unilib.show_stairs_moreblocks_flag

unilib.add_carvings_any_flag = unilib.add_carvings_column_flag or
        unilib.add_carvings_facade_flag or
        unilib.add_carvings_millwork_flag
unilib.show_carvings_any_flag = unilib.show_carvings_column_flag or
        unilib.show_carvings_facade_flag or
        unilib.show_carvings_millwork_flag

if unilib.force_unipanes_flag or unilib.current_game == "minetest" then
    unilib.use_unipanes_flag = true
end

if unilib.advtrains_update_flag and minetest.get_modpath("advtrains") == nil then
    unilib.advtrains_update_flag = false
end

if unilib.technic_update_flag and minetest.get_modpath("technic") == nil then
    unilib.technic_update_flag = false
end

if unilib.technic_extra_flag and minetest.get_modpath("technic") == nil then
    unilib.technic_extra_flag = false
end

if unilib.unifieddyes_update_flag and minetest.get_modpath("unifieddyes") == nil then
    unilib.unifieddyes_update_flag = false
end

if unilib.unified_inventory_update_flag and
        minetest.get_modpath("unified_inventory") == nil then
    unilib.unified_inventory_update_flag = false
end

if unilib.hotbar_size < 0 or unilib.hotbar_size > 32 then
    unilib.hotbar_size = 8
end
