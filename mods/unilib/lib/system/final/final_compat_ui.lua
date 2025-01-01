---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- final_compat_ui.lua
--      Improve compatibility with the "unified_inventory" mod, if loaded
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Improve compatibility with the "unified_inventory" mod, if loaded
---------------------------------------------------------------------------------------------------

-- Supply unified_inventory with items to display in any craft recipe using groups (replacing
--      "default:wood" for all nodes in the "wood" group, "default:stone" for all nodes in the
--      "stone" group, and so on)

-- If the packages have been executed, add the items that correspond to the minetest_game items used
--      by unified_inventory by default
local t = {}
local count = 0

if unilib.global.pkg_executed_table["stone_ordinary"] ~= nil then
    t.stone = "unilib:stone_ordinary"
    -- (This group not specified by unified_inventory, but still necessary)
    t.cobble = "unilib:stone_ordinary_cobble"
    count = count + 1
end

if unilib.global.pkg_executed_table["tree_apple"] ~= nil then
    t.tree = "unilib:tree_apple_trunk"
    t.wood = "unilib:tree_apple_wood"
    t.leaves = "unilib:tree_apple_leaves"
    count = count + 3
end

if unilib.global.pkg_executed_table["item_book_ordinary"] ~= nil then
    t.book = "unilib:item_book_ordinary"
    count = count + 1
end

if unilib.global.pkg_executed_table["sand_ordinary"] ~= nil then
    t.sand = "unilib:sand_ordinary"
    count = count + 1
end

if unilib.global.pkg_executed_table["vessel_bottle_glass_empty"] ~= nil then
    t.vessel = "unilib:vessel_bottle_glass_empty"
    count = count + 1
end

if unilib.global.pkg_executed_table["wool_basic"] ~= nil then
    t.wool = "unilib:wool_white"
    count = count + 1
end

-- If one or more of those packages are not loaded, choose any suitable item as a replacement
local reg_list = {
    core.registered_nodes,
    core.registered_craftitems,
    core.registered_tools,
}

for _, reg_table in ipairs(reg_list) do

    if count < 8 then

        for full_name, _ in pairs(reg_table) do

            if t.stone == nil and string.find(full_name, "unilib:stone_") then

                t.stone = full_name
                count = count + 1

            elseif t.cobble == nil and string.find(full_name, "unilib:stone_.*_cobble") then

                t.cobble = full_name
                count = count + 1

            elseif t.tree == nil and string.find(full_name, "unilib:tree_.*_trunk") then

                t.tree = full_name
                count = count + 1

            elseif t.wood == nil and string.find(full_name, "unilib:tree_.*_wood") then

                t.wood = full_name
                count = count + 1

            elseif t.leaves == nil and string.find(full_name, "unilib:tree_.*_leaves") then

                t.leaves = full_name
                count = count + 1

            elseif t.book == nil and string.find(full_name, "unilib:item_book_") then

                t.book = full_name
                count = count + 1

            elseif t.sand == nil and string.find(full_name, "unilib:sand_") then

                t.sand = full_name
                count = count + 1

            elseif t.vessel == nil and string.find(full_name, "unilib:vessel_") then

                t.vessel = full_name
                count = count + 1

            elseif t.wool == nil and string.find(full_name, "unilib:wool_") then

                t.wool = full_name
                count = count + 1

            end

            if count >= 8 then
                break
            end

        end

    end

end

-- Update unified_inventory groups
-- N.B. unified_inventory.register_group_item() was deprecated in 2022 (version 4, commit 3074d62),
--      and marked for future removal. Calling it will produce a Minetest error
-- The deprecated functionality is too important, and the reasons for deprecating are not
--      sufficiently clear, so we'll just mess with the mod's internal data directly

-- If the functionality has not actually been removed...
if unified_inventory.register_group_item ~= nil then

    -- Do what the original version of unified_inventory.register_group_item() did, i.e.
    --      function unified_inventory.register_group_item(groupname, itemname)
    --          unified_inventory.registered_group_items[groupname] = itemname
    --      end
    for group_name, full_name in pairs(t) do
        unified_inventory.registered_group_items[group_name] = full_name
    end

end

-- Now, replace the textures used by unified_inventory's default categories (which are all from
--      minetest_game, and which might not be available) with unilib textures (which we know are
--      available)
for _, mini_list in pairs({
    {"plants", "unilib:flower_tulip_orange", "unilib_flower_tulip_orange.png"},
    {"tools", "unilib:pick_tool_diamond", "unilib_tool_pick_diamond.png"},
    {"building", "unilib:brick_ordinary_block", "unilib_brick_ordinary_block.png"},
    {"environment", "unilib:dirt_ordinary_with_turf", "unilib_turf_ordinary_top.png"},
    {"minerals", "unilib:metal_iron_lump", "unilib_metal_iron_lump.png"},
    {"lighting", "unilib:torch_ordinary", "unilib_torch_ordinary.png"},
}) do

    if core.registered_nodes[mini_list[2]] ~= nil or
            core.registered_craftitems[mini_list[2]] ~= nil or
            core.registered_tools[mini_list[2]] ~= nil then

        -- Use the node/craftitem/tool if it's available
        unified_inventory.set_category_symbol(mini_list[1], mini_list[2])

    else

        -- As a fallback, use the texture directly
        unified_inventory.set_category_symbol(mini_list[1], mini_list[3])

    end

end
