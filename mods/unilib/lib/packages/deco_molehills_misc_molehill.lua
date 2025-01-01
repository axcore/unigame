---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/molehills
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_molehills_misc_molehill = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.molehills.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_molehills_misc_molehill.init()

    return {
        description = "Molehill as decoration",
        depends = {"dirt_ordinary", "misc_molehill"},
    }

end

function unilib.pkg.deco_molehills_misc_molehill.post()

    unilib.register_decoration_complete("convert_misc_molehill", nil, {
        -- From molehills/init.lua
        -- Completes decoration in package "misc_molehill"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 40,
        y_min = 1,
    })

end
