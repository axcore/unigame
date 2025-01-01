---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_tree_apple_log = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_tree_apple_log.init()

    return {
        description = "Apple tree log as decoration",
        depends = {
            "biome_farlands_forest_deciduous",
            "dirt_ordinary",
            "mushroom_brown",
            "tree_apple",
        },
    }

end

function unilib.pkg.deco_farlands_tree_apple_log.post()

    unilib.register_decoration_complete("default_tree_apple_log", "farlands_tree_apple_log", {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "tree_apple"
        biomes = "farlands_forest_deciduous",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
