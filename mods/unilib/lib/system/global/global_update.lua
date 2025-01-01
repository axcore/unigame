---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- global_update.lua
--      Modify the values of various global variables (including Minetest settings), when required
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Update global variables
---------------------------------------------------------------------------------------------------

if unilib.setting.show_dependency_simple_flag or unilib.setting.show_dependency_detailed_flag then

    unilib.setting.force_replace_flag = true
    unilib.setting.force_load_dependent_pkg_flag = true
    unilib.setting.force_load_minimal_pkg_flag = true
    unilib.setting.force_load_optional_pkg_flag = true
    unilib.setting.force_load_suggested_pkg_flag = true

end

for _, stone_type in pairs(
    unilib.utils.split_string_by_whitespace(unilib.setting.super_stone_set, true)
) do

    if stone_type == "nothing" then

        -- (The "nothing" value overrides everything else in the set)
        unilib.global.super_stone_mode = "nothing"
        break

    elseif stone_type == "everything" then

        -- (Continue check unilib.setting.super_stone_set, in case it contains "nothing")
        unilib.global.super_stone_mode = "everything"

    else

        unilib.global.super_stone_table[stone_type] = true

    end

end

if unilib.global.super_stone_mode ~= "default" then

    -- It's now up to unilib.register_stone() to populate unilib.global.super_stone_table()
    unilib.global.super_stone_table = {}

end

for _, dirt_part_name in pairs(
    unilib.utils.split_string_by_whitespace(unilib.setting.super_dirt_set, true)
) do

    if dirt_part_name == "nothing" then

        -- (The "nothing" value overrides everything else in the set)
        unilib.global.super_dirt_mode = "nothing"
        break

    elseif dirt_part_name == "everything" then

        -- (Continue check unilib.setting.super_dirt_set, in case it contains "nothing")
        unilib.global.super_dirt_mode = "everything"

    else

        unilib.global.super_dirt_table[dirt_part_name] = true
        if string.sub(dirt_part_name, 1, 5) ~= "dirt_" then
            unilib.global.super_dirt_table["dirt_" .. dirt_part_name] = true
        end

    end

end

if unilib.global.super_dirt_mode ~= "default" then

    -- It's now up to unilib.register_fertile_dirt() or unilib.register_infertile_dirt() to populate
    --      unilib.global.super_dirt_table()
    unilib.global.super_dirt_table = {}

end

for _, tree_type in pairs(
    unilib.utils.split_string_by_whitespace(unilib.setting.super_tree_set, true)
) do

    if tree_type == "nothing" then

        -- (The "nothing" value overrides everything else in the set)
        unilib.global.super_tree_mode = "nothing"
        break

    elseif tree_type == "everything" then

        -- (Continue check unilib.setting.super_tree_set, in case it contains "nothing")
        unilib.global.super_tree_mode = "everything"

    else

        unilib.global.super_tree_table[tree_type] = true

    end

end

if unilib.global.super_tree_mode ~= "default" then

    -- It's now up to unilib.register_tree() to populate unilib.global.super_tree_table()
    unilib.global.super_tree_table = {}

end

unilib.global.enable_explosives_flag = core.settings:get_bool("enable_tnt")
if unilib.global.enable_explosives_flag == nil then
    unilib.global.enable_explosives_flag = core.is_singleplayer()
end

unilib.global.enable_fire_flag = core.settings:get_bool("enable_fire")
if unilib.global.enable_fire_flag == nil then

    -- "enable_fire" setting not specified, check for "disable_fire"
    local fire_disabled_flag = core.settings:get_bool("disable_fire")
    if fire_disabled_flag == nil then

        -- Neither setting specified, check whether singleplayer
        unilib.global.enable_fire_flag = core.is_singleplayer()

    else

        unilib.global.enable_fire_flag = not fire_disabled_flag

    end

end

if unilib.setting.plantlike_leaves_flag then

    unilib.global.leaves_drawtype = "plantlike"
    unilib.global.leaves_visual_scale = 1.4

end

if unilib.setting.sapling_quick_grow_flag then

    unilib.setting.sapling_grow_min = 5
    unilib.setting.sapling_grow_max = 5
    unilib.setting.sapling_grow_default = 5
    unilib.setting.sapling_grow_retry = 5

end

unilib.global.add_stairs_any_flag = unilib.setting.add_stairs_basic_flag or
        unilib.setting.add_stairs_stairs_redo_flag or
        unilib.setting.add_stairs_stairsplus_flag or
        unilib.setting.add_stairs_moreblocks_flag
unilib.global.show_stairs_any_flag = unilib.setting.show_stairs_basic_flag or
        unilib.show_stairs_stair_redo_flag or
        unilib.setting.show_stairs_stairsplus_flag or
        unilib.setting.show_stairs_moreblocks_flag

unilib.global.add_carvings_any_flag = unilib.setting.add_carvings_column_flag or
        unilib.setting.add_carvings_facade_flag or
        unilib.setting.add_carvings_millwork_flag or
        unilib.setting.add_carvings_farlands_flag
unilib.global.show_carvings_any_flag = unilib.setting.show_carvings_column_flag or
        unilib.setting.show_carvings_facade_flag or
        unilib.setting.show_carvings_millwork_flag or
        unilib.setting.show_carvings_farlands_flag

if unilib.setting.force_unipanes_flag or unilib.core.current_game == "minetest" then
    unilib.global.use_unipanes_flag = true
end

if unilib.setting.advtrains_update_flag and core.get_modpath("advtrains") == nil then
    unilib.setting.advtrains_update_flag = false
end

if unilib.setting.technic_update_flag and core.get_modpath("technic") == nil then
    unilib.setting.technic_update_flag = false
end

if unilib.setting.technic_extra_flag and core.get_modpath("technic") == nil then
    unilib.setting.technic_extra_flag = false
end

if unilib.setting.unifieddyes_update_flag and core.get_modpath("unifieddyes") == nil then
    unilib.setting.unifieddyes_update_flag = false
end

if unilib.setting.unified_inventory_update_flag and
        core.get_modpath("unified_inventory") == nil then
    unilib.setting.unified_inventory_update_flag = false
end

if unilib.setting.hotbar_size < 0 or unilib.setting.hotbar_size > 32 then
    unilib.setting.hotbar_size = 8
end

if not core.settings:get_bool("enable_damage") then
    unilib.setting.hunger_enable_flag = false
end

core.register_on_mods_loaded(function()
    unilib.global.mods_loaded_flag = true
end)

if not unilib.setting.show_covered_dirt_flag then
    unilib.hide_covered_dirt_group = 1
end

if unilib.setting.squeezed_overstack_flag then
    unilib.global.squeezed_stack_max = 999
end
