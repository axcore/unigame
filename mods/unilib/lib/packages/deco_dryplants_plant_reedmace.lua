---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/dryplants
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_dryplants_plant_reedmace = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.dryplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_dryplants_plant_reedmace.init()

    return {
        description = "Reedmace as decoration",
        depends = {
            "dirt_ordinary",
            "liquid_water_ordinary",
            "plant_reedmace",
            "sand_desert",
            "sand_ordinary",
        },
    }

end

function unilib.pkg.deco_dryplants_plant_reedmace.post()

    unilib.register_decoration_complete("convert_plant_reedmace_near_water", nil, {
        -- From dryplants/reedmace.lua
        -- Completes decoration in package "plant_reedmace"
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:sand_desert"},
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })
    unilib.register_decoration_complete("convert_plant_reedmace_in_water", nil, {
        -- From dryplants/reedmace.lua
        -- Completes decoration in package "plant_reedmace"
        place_on = {"unilib:dirt_ordinary", "unilib:dirt_ordinary_with_turf"},
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = 0,
        y_min = 0,
    })
    unilib.register_decoration_complete("convert_plant_reedmace_on_sand", nil, {
        -- From dryplants/reedmace.lua
        -- Completes decoration in package "plant_reedmace"
        place_on = "unilib:sand_ordinary",
        spawn_by = {"unilib:liquid_water_ordinary_source", "unilib:sand_desert"},
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
