---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/sequoia
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cool_trees_tree_sequoia_mature = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.sequoia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cool_trees_tree_sequoia_mature.init()

    return {
        description = "Mature sequoia tree as decoration",
        depends = {"biome_default_grassland", "dirt_ordinary", "tree_sequoia_mature"},
    }

end

function unilib.pkg.deco_cool_trees_tree_sequoia_mature.post()

    for _, part_name in ipairs({"small", "medium", "large"}) do

        unilib.register_decoration_now("cool_trees_tree_sequoia_mature_" .. part_name, nil, {
            -- From sequoia/init.lua
            -- Completes decoration in package "tree_sequoia_mature"
            biomes = "default_grassland",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 80,
            y_min = 1,
        })

    end

end
