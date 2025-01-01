---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_morelights = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morelights.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_morelights.on_place_hanging(
    itemstack, placer, pointed_thing, ceiling_name
)
    local ceiling = core.get_node(vector.add(pointed_thing.above, vector.new(0, 1, 0)))

    if ceiling.name ~= "air" and
            core.get_item_group(ceiling.name, "mounted_ceiling") == 0 and
            not (placer and placer:get_player_control().sneak) then

        -- Create a dummy itemstack with the ceiling variant's name
        local fakestack = ItemStack(itemstack)
        fakestack:set_name(ceiling_name)

        core.item_place(fakestack, placer, pointed_thing, 0)

        -- Subtract an item from the real itemstack if a node was placed
        itemstack:set_count(fakestack:get_count())
        return itemstack

    end

    core.item_place(itemstack, placer, pointed_thing, 0)
    return itemstack

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_morelights.init()

    return {
        description = "Shared functions for lights (from morelights mod)",
    }

end
