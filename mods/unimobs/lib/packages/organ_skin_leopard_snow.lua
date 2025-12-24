---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.organ_skin_leopard_snow = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.organ_skin_leopard_snow.init()

    return {
        description = "Snow leopard skin",
    }

end

function unilib.pkg.organ_skin_leopard_snow.exec()

    unilib.register_craftitem("unilib:organ_skin_leopard_snow", "petz:snow_leopard_skin", mode, {
        -- From petz:snow_leopard_skin
        description = S("Snow Leopard Skin"),
        inventory_image = "unilib_organ_skin_leopard_snow.png",
        groups = {flammable = 2, leather = 1}
    })

end
