---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.organ_leather_normal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.organ_leather_normal.init()

    return {
        description = "Normal leather",
    }

end

function unilib.pkg.organ_leather_normal.exec()

    unilib.register_craftitem("unilib:organ_leather_normal", "petz:leather", mode, {
        -- From petz:leather
        description = S("Normal Leather"),
        inventory_image = "unilib_organ_leather_normal.png",
        groups = {flammable = 2, leather = 1},

        wield_image = "unilib_organ_leather_normal.png",
    })

end
