---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.organ_skin_leopard_normal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.organ_skin_leopard_normal.init()

    return {
        description = "Normal leopard skin",
    }

end

function unilib.pkg.organ_skin_leopard_normal.exec()

    unilib.register_craftitem("unilib:organ_skin_leopard_normal", "petz:leopard_skin", mode, {
        -- From petz:leopard_skin
        description = S("Normal Leopard Skin"),
        inventory_image = "unilib_organ_skin_leopard_normal.png",
        groups = {flammable = 2, leather = 1}
    })

end
