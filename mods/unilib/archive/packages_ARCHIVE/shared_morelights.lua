---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
function morelights.on_place_hanging(itemstack, placer, pointed_thing,
            ceilingName)
    local ceiling = minetest.get_node(
        vector.add(pointed_thing.above, vector.new(0, 1, 0)))

    if ceiling.name ~= "air"
            and minetest.get_item_group(ceiling.name, "mounted_ceiling") == 0
            and not (placer and placer:get_player_control().sneak) then
        -- Create a dummy itemstack with the ceiling variant's name.
        local fakeStack = ItemStack(itemstack)
        fakeStack:set_name(ceilingName)

        minetest.item_place(fakeStack, placer, pointed_thing, 0)

        -- Subtract an item from the real itemstack if a node was placed.
        itemstack:set_count(fakeStack:get_count())
        return itemstack
    end

    minetest.item_place(itemstack, placer, pointed_thing, 0)
    return itemstack
end

function morelights.rotate_and_place(itemstack, placer, pointed_thing, lookup)
    local dir = minetest.dir_to_wallmounted(
            vector.subtract(pointed_thing.under, pointed_thing.above))
    local fDirs = lookup or {[0] = 20, 0, 16, 12, 8, 4}
    minetest.item_place(itemstack, placer, pointed_thing, fDirs[dir] or 0)
    return itemstack
end
]]--
