---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_tree_pine_log = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_tree_pine_log.init()

    return {
        description = "Pine tree log as decoration",
        depends = {"mushroom_red", "tree_pine"},
        at_least_one = {
            {
                "biome_default_forest_coniferous",
                "biome_default_taiga",
            },
            {
                "dirt_ordinary_with_cover_snow",
                "dirt_ordinary_with_litter_coniferous",
            },
        },
    }

end

function unilib.pkg.deco_default_tree_pine_log.post()

    unilib.register_decoration_complete("default_tree_pine_log", nil, {
        -- From default/mapgen.lua
        -- Completes decoration in package "tree_pine"
        biomes = {"default_forest_coniferous", "default_taiga"},
        num_spawn_by = 8,
        place_on = {
            "unilib:dirt_ordinary_with_cover_snow",
            "unilib:dirt_ordinary_with_litter_coniferous",
        },
        spawn_by = {
            "unilib:dirt_ordinary_with_cover_snow",
            "unilib:dirt_ordinary_with_litter_coniferous",
        },
        y_max = unilib.constant.y_max,
        y_min = 4,
    })

end
