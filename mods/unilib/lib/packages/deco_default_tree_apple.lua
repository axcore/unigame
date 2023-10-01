---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_tree_apple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_tree_apple.init()

    return {
        description = "Apple tree as decoration",
        depends = {"biome_default_forest_deciduous", "dirt_ordinary", "tree_apple"},
    }

end

function unilib.pkg.deco_default_tree_apple.post()

    unilib.register_decoration_now("default_tree_apple", nil, {
        -- From default/mapgen.lua
        -- Completes decoration in package "tree_apple"
        biomes = "default_forest_deciduous",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
