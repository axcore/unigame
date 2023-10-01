---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_tree_pine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_tree_pine.init()

    return {
        description = "Pine tree as decoration",
        depends = {"dirt_ordinary", "tree_pine"},
        at_least_one = {"biome_default_forest_coniferous", "biome_default_taiga"},
    }

end

function unilib.pkg.deco_default_tree_pine.post()

    for _, part_name in pairs({"large", "small"}) do

        unilib.register_decoration_now("default_tree_pine_" .. part_name, nil, {
            -- From default/mapgen.lua
            -- Completes decoration in package "tree_pine"
            biomes = {"default_forest_coniferous", "default_taiga"},
            place_on = {
                "unilib:dirt_ordinary_with_litter_coniferous",
                "unilib:dirt_ordinary_with_cover_snow",
            },
            y_max = unilib.y_max,
            y_min = 4,
        })

    end

end
