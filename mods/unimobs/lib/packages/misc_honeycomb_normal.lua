---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_honeycomb_normal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_honeycomb_normal.init()

    return {
        description = "Normal honeycomb",
    }

end

function unilib.pkg.misc_honeycomb_normal.exec()

    unilib.register_craftitem("unilib:misc_honeycomb_normal", "petz:honeycomb", mode, {
        -- From petz:honeycomb
        description = S("Normal Honeycomb"),
        inventory_image = "unilib_misc_honeycomb_normal.png",
    })

end
