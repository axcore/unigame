---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- cuisine_eat_bu.lua
--      Backups for shared functions in ../lib/effects/cuisine/cuisine_eat_base.lua
---------------------------------------------------------------------------------------------------

local msg = "Shared function unavailable because \"cuisine\" effects disabled"

---------------------------------------------------------------------------------------------------
-- Shared function backups
---------------------------------------------------------------------------------------------------

function unilib.cuisine.eat_on_use(full_name, satiation, replacement_name, old_on_use)

    -- Original to unilib
    -- Returns an .on_use() function for the calling package's craftitem
    -- (Nodes are also acceptable, though not recommended. Tools should not call this function at
    --      all)
    -- The returned function consumes the food, the calls the original .on_use() function (if any)

    return function(itemstack, player, pointed_thing)

        -- Revert to original Minetest code
        core.item_eat(satiation, replacement_name)
        -- Call original on_use(), if provided
        if old_on_use ~= nil then
            return old_on_use(itemstack, player, pointed_thing)
        else
            return itemstack
        end

    end

end

function unilib.cuisine.clear_history(...)
    unilib.utils.show_warning(msg, "unilib.cuisine.clear_history")
end

function unilib.cuisine.get_history(...)
    unilib.utils.show_warning(msg, "unilib.cuisine.get_history")
end
