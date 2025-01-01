---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes_classic
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_bushes_classic_bush_ornamental = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bushes_classic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_bushes_classic_bush_ornamental.init()

    return {
        description = "Ornamental bushes as decoration",
        depends = "shared_bushes_classic",
        at_least_one = {"dirt_ordinary", "dirt_ordinary_with_litter_forest", "soil_ordinary"},
    }

end

function unilib.pkg.deco_bushes_classic_bush_ornamental.post()

    unilib.register_decoration_complete("bushes_classic_bush_ornamental", nil, {
        -- From bushes_classic/init.lua
        -- Completes decoration in package "shared_bushes_classic"
        place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_litter_forest_medium",
            "unilib:dirt_ordinary_with_turf_with_litter_forest_medium",
            "unilib:dirt_ordinary_with_turf_with_litter_forest_light",
            "unilib:soil_ordinary",
            "unilib:soil_ordinary_wet",
        },
    })

end
