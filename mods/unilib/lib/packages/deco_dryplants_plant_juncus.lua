---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/dryplants
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_dryplants_plant_juncus = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.dryplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_dryplants_plant_juncus.init()

    return {
        description = "Juncus as decoration",
        depends = {"dirt_ordinary", "liquid_water_ordinary", "plant_juncus", "sand_ordinary"},
    }

end

function unilib.pkg.deco_dryplants_plant_juncus.exec()

    unilib.register_decoration_now("convert_plant_juncus_near_water", nil, {
        -- From dryplants/juncus.lua
        -- Completes decoration in package "plant_juncus"
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = unilib.y_max,
        y_min = 1,
    })
    unilib.register_decoration_now("convert_plant_juncus_on_sand", nil, {
        -- From dryplants/juncus.lua
        -- Completes decoration in package "plant_juncus"
        place_on = "unilib:sand_ordinary",
        spawn_by = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
