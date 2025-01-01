---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_mangrove_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_mangrove_white.init()

    return {
        description = "White mangrove tree as decoration",
        depends = {"biome_aotearoa_shore", "dirt_mud_antipodean", "tree_mangrove_white"},
    }

end

function unilib.pkg.deco_aotearoa_tree_mangrove_white.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("aotearoa_tree_mangrove_white_normal_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_mangrove_white"
            biomes = "aotearoa_shore_northern_estuary",
            place_on = {
                "unilib:dirt_mud_antipodean_dry",
                "unilib:dirt_mud_antipodean_wet",
            },
            y_max = 3,
            y_min = 2,
        })

    end

end
