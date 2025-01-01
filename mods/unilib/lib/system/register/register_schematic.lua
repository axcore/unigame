---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_schematic.lua
--      Register schematics using a replacement for the Minetest registration function
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register schematics
---------------------------------------------------------------------------------------------------

function unilib.register_schematic(def_table)

    -- Original to unilib
    -- N.B. There is no unilib.register._register_schematic()
    --
    -- Packages should call this function to register a schematic, rather than calling
    --      core.register_schematic() directly
    --
    -- Args:
    --      def_table (table): Usual definition table for the schematic

    -- (At the moment this function is a simple wrapper, but that might change later)
    core.register_schematic(def_table)

end
