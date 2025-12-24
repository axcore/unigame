---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_pollen_normal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_pollen_normal.init()

    return {
        description = "Normal pollen",
    }

end

function unilib.pkg.misc_pollen_normal.exec()

    unilib.register_craftitem("unilib:misc_pollen_normal", "petz:pollen", mode, {
        -- From petz:pollen
        description = S("Normal Pollen"),
        inventory_image = "unilib_misc_pollen_normal.png",
    })

end
