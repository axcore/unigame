---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_craft.lua
--      Register crafts using a replacement for the Minetest registration function
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register crafts
---------------------------------------------------------------------------------------------------

function unilib.register_craft(def_table)

    -- Original to unilib
    -- N.B. There is no unilib.register._register_craft()
    --
    -- Packages should call this function to register a craft recipe, rather than calling
    --      core.register_craft() directly
    -- For common crafting recipes, one of the functions immediately below can be called instead
    --
    -- Args:
    --      def_table (table): Usual definition table for the craft

    -- (At the moment this function is a simple wrapper, but that might change later)
    core.register_craft(def_table)

end
