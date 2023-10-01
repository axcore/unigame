---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/poisonivy
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_poisonivy_plant_ivy_poison = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.poisonivy.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_poisonivy_plant_ivy_poison.init()

    return {
        description = "Poison ivy as decoration",
        depends = {"dirt_ordinary", "plant_ivy_poison"},
    }

end

function unilib.pkg.deco_poisonivy_plant_ivy_poison.exec()

    unilib.register_decoration_now("plant_ivy_poison", nil, {
        -- From poisonivy/init.lua
        -- Completes decoration in package "plant_poison_ivy"
        place_on = "unilib:dirt_ordinary_with_turf",
    })

end
