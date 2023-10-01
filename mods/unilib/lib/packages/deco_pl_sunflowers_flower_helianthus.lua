---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/pl_sunflowers
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_pl_sunflowers_flower_helianthus = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pl_sunflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_pl_sunflowers_flower_helianthus.init()

    return {
        description = "Helianthus as decoration",
        depends = {"dirt_ordinary", "flower_helianthus"},
    }

end

function unilib.pkg.deco_pl_sunflowers_flower_helianthus.exec()

    unilib.register_decoration_now("convert_flower_helianthus", nil, {
        -- From pl_sunflowers/init.lua
        -- Completes decoration in package "convert_flower_helianthus"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.y_max,
        y_min = 0,
    })

end
