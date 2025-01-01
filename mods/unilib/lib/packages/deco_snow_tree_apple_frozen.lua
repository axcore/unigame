---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_snow_tree_apple_frozen = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_snow_tree_apple_frozen.init()

    return {
        description = "Frozen apple tree as decoration",
        depends = {"biome_snow_normal", "dirt_ordinary", "fruit_apple_frozen", "tree_apple_frozen"},
    }

end

function unilib.pkg.deco_snow_tree_apple_frozen.post()

    unilib.register_decoration_complete("snow_tree_apple_frozen", nil, {
        -- Original to unilib
        -- Completes decoration in package "tree_apple_frozen"
        biomes = "snow_normal",
        place_on = "unilib:dirt_ordinary_with_cover_snow",
        y_max = unilib.constant.y_max,
        y_min = 4,
    })

end
