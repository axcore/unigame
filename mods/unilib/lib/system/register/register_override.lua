---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_override.lua
--      Override items using a replacement for the Minetest override function
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Overrride items
---------------------------------------------------------------------------------------------------

function unilib.override_item(full_name, def_table)

    -- Original to unilib
    -- A wrapper for core.override_item()
    -- N.B. There is no unilib.register._override_item()
    --
    -- If the item to be overriden does not exist (typically because a package was not loaded,
    --      because its replace_mode was "defer"), then Minetest will crash
    -- So we must check the item exists, before overriding it

    if core.registered_items[full_name] == nil then

        unilib.utils.show_warning(
            "unilib.override_item(): Cannot override non-existent item", full_name
        )

    else

        core.override_item(full_name, def_table)

    end

end
