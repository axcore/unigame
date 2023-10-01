---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_karaka = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_karaka.init()

    return {
        description = "Karaka tree as decoration",
        depends = {"biome_aotearoa_coastal", "dirt_ordinary", "tree_karaka"},
    }

end

function unilib.pkg.deco_aotearoa_tree_karaka.post()

    for i = 1, 2 do

        unilib.register_decoration_now("aotearoa_tree_karaka_dense_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_karaka"
            biomes = "aotearoa_coastal_pohutukawa_forest",
            place_on = "unilib:dirt_ordinary_with_litter_rainforest",
            y_max = 14,
            y_min = 5,
        })
        unilib.register_decoration_now("aotearoa_tree_karaka_grove_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_karaka"
            biomes = "aotearoa_coastal_scrub",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 14,
            y_min = 5,
        })

    end

end
