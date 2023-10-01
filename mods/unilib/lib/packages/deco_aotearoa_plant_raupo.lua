---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_plant_raupo = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_plant_raupo.init()

    return {
        description = "Raupo as decoration",
        depends = {"biome_aotearoa_wetland", "dirt_mud_antipodean", "plant_raupo"},
    }

end

function unilib.pkg.deco_aotearoa_plant_raupo.post()

    for i = 1, 2 do

        unilib.register_decoration_now("aotearoa_plant_raupo_normal_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "plant_raupo"
            biomes = "aotearoa_wetland_raupo_swamp",
            place_on = "unilib:dirt_mud_antipodean_wet",
            y_max = 40,
            y_min = 5,
        })

    end

end
