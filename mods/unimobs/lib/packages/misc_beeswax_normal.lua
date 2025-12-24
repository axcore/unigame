---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_beeswax_normal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_beeswax_normal.init()

    return {
        description = "Normal beeswax",
        depends = "misc_honeycomb_normal",
    }

end

function unilib.pkg.misc_beeswax_normal.exec()

    unilib.register_craftitem("unilib:misc_beeswax_normal", "petz:beeswax", mode, {
        -- From petz:beeswax
        description = S("Normal Beeswax"),
        inventory_image = "unilib_misc_beeswax_normal.png",
    })
    unilib.register_craft({
        -- From petz:beeswax
        type = "cooking",
        output = "unilib:misc_beeswax_normal 3",
        recipe = "unilib:misc_honeycomb_normal",
        cooktime = 1,
    })

end
