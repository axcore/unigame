---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_bush_kokomuka = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_bush_kokomuka.init()

    return {
        description = "Kokomuka bush as decoration",
        depends = {"biome_aotearoa_coastal", "bush_kokomuka", "dirt_custom_antipodean"},
    }

end

function unilib.pkg.deco_aotearoa_bush_kokomuka.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("aotearoa_bush_kokomuka_normal_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "bush_kokomuka"
            biomes = "aotearoa_coastal_tussock",
            place_on = "unilib:dirt_ordinary_with_turf_coastal_tussock",
            y_max = 14,
            y_min = 3,
        })

    end

end
