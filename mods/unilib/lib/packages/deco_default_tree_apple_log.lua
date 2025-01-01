---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_tree_apple_log = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_tree_apple_log.init()

    return {
        description = "Apple tree log as decoration",
        depends = {
            "biome_default_forest_deciduous",
            "dirt_ordinary",
            "mushroom_brown",
            "tree_apple",
        },
    }

end

function unilib.pkg.deco_default_tree_apple_log.post()

    unilib.register_decoration_complete("default_tree_apple_log", nil, {
        -- From default/mapgen.lua
        -- Completes decoration in package "tree_apple"
        biomes = "default_forest_deciduous",
        num_spawn_by = 8,
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
