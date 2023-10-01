---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_tree_pine_log = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_tree_pine_log.init()

    return {
        description = "Pine tree log as decoration",
        depends = {"dirt_ordinary", "mushroom_red", "tree_pine"},
        at_least_one = {"biome_default_forest_coniferous", "biome_default_taiga"},
    }

end

function unilib.pkg.deco_default_tree_pine_log.post()

    unilib.register_decoration_now("default_tree_pine_log", nil, {
        -- From default/mapgen.lua
        -- Completes decoration in package "tree_pine"
        biomes = {"default_forest_coniferous", "default_taiga"},
        num_spawn_by = 8,
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_cover_snow",
        },
        spawn_by = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_cover_snow",
        },
        y_max = unilib.y_max,
        y_min = 4,
    })

end
