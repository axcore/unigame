---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.organ_hide_rabbit = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.organ_hide_rabbit.init()

    return {
        description = "Rabbit hide",
    }

end

function unilib.pkg.organ_hide_rabbit.exec()

    unilib.register_craftitem("unilib:organ_hide_rabbit", "petz:rabbit_hide", mode, {
        -- From petz:rabbit_hide
        description = S("Rabbit Hide"),
        inventory_image = "unilib_organ_hide_rabbit.png",
        groups = {flammable = 2, leather = 1},

        wield_image = "unilib_organ_hide_rabbit.png",
    })

end
