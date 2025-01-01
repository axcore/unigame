---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_tree_apple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_tree_apple.init()

    return {
        description = "Apple tree as decoration",
        notes = "Because farlands apple trees share the same trunks and leaves as unilib" ..
                " \"exotic\" trees, no new apple tree has been created for this package;" ..
                " instead, we just re-use the existing one",
        depends = {"biome_farlands_forest_deciduous", "dirt_ordinary", "tree_apple"},
    }

end

function unilib.pkg.deco_farlands_tree_apple.post()

    unilib.register_decoration_complete("default_tree_apple", "farlands_tree_apple", {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "tree_apple"
        biomes = "farlands_forest_deciduous_tall",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
