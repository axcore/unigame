---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_tree_willow_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_tree_willow_exotic.init()

    return {
        description = "Exotic willow tree as decoration",
        depends = {"biome_farlands_swamp", "dirt_ordinary_with_turf_swamp", "tree_willow_exotic"},
    }

end

function unilib.pkg.deco_farlands_tree_willow_exotic.post()

    -- N.B. The first schematic is commented out in the original code, but is included here
    for i = 1, 2 do

        unilib.register_decoration_now("farlands_tree_willow_exotic_" .. i, nil, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "tree_willow_exotic"
            biomes = "farlands_swamp",
            place_on = "unilib:dirt_ordinary_with_turf_swamp",
            y_max = unilib.y_max,
            y_min = 1,
        })

    end

end
