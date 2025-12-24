---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.organ_sting_bee = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.organ_sting_bee.init()

    return {
        description = "Bee sting",
    }

end

function unilib.pkg.organ_sting_bee.exec()

    unilib.register_craftitem("unilib:organ_sting_bee", "petz:bee_sting", mode, {
        -- From petz:bee_sting
        description = S("Bee Sting"),
        inventory_image = "unilib_organ_sting_bee.png",
    })

end
