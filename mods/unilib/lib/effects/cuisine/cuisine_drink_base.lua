---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- cuisine_drink_base.lua
--      Set up advanced cuisine (original to unilib)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.cuisine.drink_on_use(
    full_name, satiation, replacement_name, old_on_use, force_eat_flag
)
    -- Original to unilib
    -- Returns an .on_use() function for the calling package's craftitem. (Nodes are also
    --      acceptable, though not recommended. Tools should not call this function at all)
    -- Because hydration is enabled, the returned function increases the player's hydration (to its
    --      maximum level)

    -- Ignore any food groups for the purposes of food group history - if a player wants to drink
    --      nothing but tea, good for them!
    return function(itemstack, player, pointed_thing)

        -- We ignore the satiation value, increasing the player's hydration to its maximum
        -- (25 is the same value used by unilib:utensil_bowl_wooden)
        unilib.hydration.do_drink(player, 25, 25)

        -- If the flag is specified, satiation and hydration are increased at the same time, (and we
        --      still don't update food group history)
        if force_eat_flag then

            itemstack = core.do_item_eat(
                satiation, replacement_name, itemstack, player, pointed_thing
            )

        else

            -- The call to core.do_item_eat() removes the drink from the player's inventory,
            --      replacing it with "replacement_name"; since it's not called, do that manually
            itemstack:take_item(1)
            if replacement_name ~= nil then

                local inv = player:get_inventory()
                inv:add_item("main", ItemStack(replacement_name .. " 1"))

            end

        end

        -- Call original on_use(), if provided
        if old_on_use ~= nil then
            return old_on_use(itemstack, player, pointed_thing)
        else
            return itemstack
        end

    end

end
