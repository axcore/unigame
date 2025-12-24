---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.organ_tusk_elephant = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.organ_tusk_elephant.init()

    return {
        description = "Elephant tusk",
    }

end

function unilib.pkg.organ_tusk_elephant.exec()

    unilib.register_craftitem("unilib:organ_tusk_elephant", "petz:elephant_tusk", mode, {
        -- From petz:elephant_tusk
        description = S("Elephant Tusk"),
        inventory_image = "unilib_organ_tusk_elephant.png",
        groups = {},
    })

end
