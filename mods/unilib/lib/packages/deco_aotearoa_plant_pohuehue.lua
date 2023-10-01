---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_plant_pohuehue = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_plant_pohuehue.init()

    return {
        description = "Pohuehue as decoration",
        depends = {"biome_aotearoa_dunes", "plant_pohuehue"},
        at_least_one = {"sand_ironsand", "sand_ordinary"},
    }

end

function unilib.pkg.deco_aotearoa_plant_pohuehue.post()

    unilib.register_decoration_now("aotearoa_plant_pohuehue", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "plant_pohuehue"
        biomes = {
            "aotearoa_dunes_ironsand",
            "aotearoa_dunes_pohutukawa",
            "aotearoa_dunes_sand",
        },
        place_on = {"unilib:sand_ironsand", "unilib:sand_ordinary"},
        y_max = 5,
        y_min = 3,
    })

end
