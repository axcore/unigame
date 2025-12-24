---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.organ_fur_beaver = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.organ_fur_beaver.init()

    return {
        description = "Beaver fur",
    }

end

function unilib.pkg.organ_fur_beaver.exec()

    unilib.register_craftitem("unilib:organ_fur_beaver", "petz:beaver_fur", mode, {
        -- From petz:beaver_fur
        description = S("Beaver Fur"),
        inventory_image = "unilib_organ_fur_beaver.png",
        groups = {flammable = 2, leather = 1},

        wield_image = "unilib_organ_fur_beaver.png",
    })

end
