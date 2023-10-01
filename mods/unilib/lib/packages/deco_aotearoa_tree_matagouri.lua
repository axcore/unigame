---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_matagouri = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_matagouri.init()

    return {
        description = "Matagouri tree as decoration",
        depends = {"dirt_ordinary", "tree_matagouri"},
        at_least_one = {"biome_aotearoa_coastal", "biome_aotearoa_scrubland"},
    }

end

function unilib.pkg.deco_aotearoa_tree_matagouri.post()

    for i = 1, 2 do

        unilib.register_decoration_now("aotearoa_tree_matagouri_clump_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_matagouri"
            biomes = {
                "aotearoa_coastal_tussock",
                "aotearoa_scrubland_matagouri",
            },
            place_on = "unilib:dirt_ordinary_with_turf_dry",
            y_max = 80,
            y_min = 3,
        })

    end

end
