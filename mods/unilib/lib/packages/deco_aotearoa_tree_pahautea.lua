---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_pahautea = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_pahautea.init()

    return {
        description = "Pahautea tree as decoration",
        depends = {"biome_aotearoa_highland", "dirt_antipodean", "tree_pahautea"},
    }

end

function unilib.pkg.deco_aotearoa_tree_pahautea.post()

    for i = 1, 2 do

        unilib.register_decoration_now("aotearoa_tree_pahautea_dense_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_pahautea"
            biomes = "aotearoa_highland_pahautea_forest",
            place_on = "unilib:dirt_antipodean_with_moss",
            y_max = 120,
            y_min = 78,
        })

    end

end
