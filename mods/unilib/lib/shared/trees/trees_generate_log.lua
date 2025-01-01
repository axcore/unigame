---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- trees_generate_log.lua
--      Generate treelog schematics
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Generate treelog schematics
---------------------------------------------------------------------------------------------------

function unilib.trees._generate_treelog_schematic(trunk_name)

    -- Called by unilib.register_decoration_from_csv() or by any other code
    -- Returns a Lua schematic for a treelog composed of the specified node
    -- Our treelog schematics are cached in a global variable, so only one schematic needs to be
    --      generated for each trunk node
    --
    -- Args:
    --      trunk_name (str): e.g. "unilib:tree_apple_trunk"

    if unilib.global.treelog_schem_table[trunk_name] == nil then

        unilib.global.treelog_schem_table[trunk_name] = {
            size = {x = 5, y = 1, z = 1},
            data = {
                {name = trunk_name, param2 = 12, prob = 126},
                {name = trunk_name, param2 = 12, prob = 254},
                {name = trunk_name, param2 = 12, prob = 254},
                {name = trunk_name, param2 = 12, prob = 254},
                {name = trunk_name, param2 = 12, prob = 126},
            },
            yslice_prob = {
                {ypos = 0, prob = 254},
            },
        }

    end

    return unilib.global.treelog_schem_table[trunk_name]

end
