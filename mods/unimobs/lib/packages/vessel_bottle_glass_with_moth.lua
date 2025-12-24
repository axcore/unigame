---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.vessel_bottle_glass_with_moth = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vessel_bottle_glass_with_moth.init()

    return {
        description = "Moth in a glass bottle",
        depends = {"shared_petz_bottles", "vessel_bottle_glass_empty"},
    }

end

function unilib.pkg.vessel_bottle_glass_with_moth.exec()

    unilib.pkg.shared_petz_bottles.generate_bottle({
        -- From petz:bottle_moth. Creates unilib:vessel_bottle_glass_with_moth
        part_name = "moth",
        orig_name = "petz:bottle_moth",

        replace_mode = mode,
        description = S("Moth in a Glass Bottle"),
    })

end
