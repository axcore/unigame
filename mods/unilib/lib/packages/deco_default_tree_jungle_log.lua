---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_tree_jungle_log = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_tree_jungle_log.init()

    return {
        description = "Jungle tree log as decoration",
        depends = {
            "biome_default_rainforest",
            "dirt_ordinary",
            "mushroom_brown",
            "tree_jungle",
        },
    }

end

function unilib.pkg.deco_default_tree_jungle_log.post()

    unilib.register_decoration_now("default_tree_jungle_log", nil, {
        -- From default/mapgen.lua
        -- Completes decoration in package "tree_jungle"
        biomes = "default_rainforest",
        num_spawn_by = 8,
        place_on = "unilib:dirt_ordinary_with_litter_rainforest",
        spawn_by = "unilib:dirt_ordinary_with_litter_rainforest",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
