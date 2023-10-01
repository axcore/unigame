---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- inventory.lua
--      Improve compatibility with inventory mods like unified_inventory
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- unified_inventory
---------------------------------------------------------------------------------------------------

-- If loaded, supply unified_inventory with items to display in any craft recipe using groups
--      (replacing "default:wood" for all nodes in the "wood" group, "default:stone" for all nodes
--      in the "stone" group, and so on)
if unilib.unified_inventory_update_flag then

    -- If the packages have been executed, add the items that correspond to the minetest_game items
    --      used by unified_inventory by default
    local t = {}
    local count = 0

    if unilib.pkg_executed_table["stone_ordinary"] ~= nil then
        t.stone = "unilib:stone_ordinary"
        -- (This group not specified by unified_inventory, but still necessary)
        t.cobble = "unilib:stone_ordinary_cobble"
        count = count + 1
    end

    if unilib.pkg_executed_table["tree_apple"] ~= nil then
        t.tree = "unilib:tree_apple_trunk"
        t.wood = "unilib:tree_apple_wood"
        t.leaves = "unilib:tree_apple_leaves"
        count = count + 3
    end

    if unilib.pkg_executed_table["item_book_ordinary"] ~= nil then
        t.book = "unilib:item_book_ordinary"
        count = count + 1
    end

    if unilib.pkg_executed_table["sand_ordinary"] ~= nil then
        t.sand = "unilib:sand_ordinary"
        count = count + 1
    end

    if unilib.pkg_executed_table["vessel_bottle_glass_empty"] ~= nil then
        t.vessel = "unilib:vessel_bottle_glass_empty"
        count = count + 1
    end

    if unilib.pkg_executed_table["wool_basic"] ~= nil then
        t.wool = "unilib:wool_white"
        count = count + 1
    end

    -- If one or more of those packages are not loaded, choose any suitable item as a replacement
    local reg_list = {
        minetest.registered_nodes,
        minetest.registered_craftitems,
        minetest.registered_tools,
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

    -- Update unified_inventory
    -- N.B. Due to a known bug, this code is currently commented out
    --[[
    for group_name, full_name in pairs(t) do
        unified_inventory.register_group_item(group_name, full_name)
    end
    ]]--

end
