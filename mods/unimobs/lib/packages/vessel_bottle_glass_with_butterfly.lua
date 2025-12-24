---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.vessel_bottle_glass_with_butterfly = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vessel_bottle_glass_with_butterfly.init()

    return {
        description = "Moth in a glass bottle",
        depends = {"shared_petz_bottles", "vessel_bottle_glass_empty"},
    }

end

function unilib.pkg.vessel_bottle_glass_with_butterfly.exec()

    unilib.pkg.shared_petz_bottles.generate_bottle({
        -- From petz:bottle_butterfly. Creates unilib:vessel_bottle_glass_with_butterfly
        part_name = "butterfly",
        orig_name = "petz:bottle_butterfly",

        replace_mode = mode,
        description = S("Butterfly in a Glass Bottle"),
    })

end
