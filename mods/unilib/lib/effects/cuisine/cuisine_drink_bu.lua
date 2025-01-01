---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- cuisine_drink_bu.lua
--      Backups for shared functions in ../lib/effects/cuisine/cuisine_drink_base.lua
---------------------------------------------------------------------------------------------------

--local msg = "Shared function unavailable because \"cuisine\" effects disabled"

---------------------------------------------------------------------------------------------------
-- Shared function backups
---------------------------------------------------------------------------------------------------

function unilib.cuisine.drink_on_use(
    full_name, satiation, replacement_name, old_on_use, force_eat_flag
)
    -- Original to unilib
    -- Returns an .on_use() function for the calling package's craftitem. (Nodes are also
    --      acceptable, though not recommended. Tools should not call this function at all)
    -- Because hydration is not enabled, the drink is treated as a type of food (as is normal for
    --      Minetest drink items), and unilib.cuisine.eat_on_use() is called to provide a return
    --      function instead

    return unilib.cuisine.eat_on_use(full_name, satiation, replacement_name, old_on_use)

end
