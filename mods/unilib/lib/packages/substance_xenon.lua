---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.substance_xenon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.substance_xenon.init()

    return {
        description = "Xenon",
    }

end

function unilib.pkg.substance_xenon.exec()

    unilib.register_non_metal({
        -- Original to unilib
        part_name = "xenon",
        description = S("Xenon"),
    })

    unilib.register_craftitem("unilib:substance_xenon_sample", nil, mode, {
        -- Original to unilib
        description = S("Xenon Sample"),
        inventory_image = "unilib_substance_xenon_sample.png",
        groups = {substance_sample = 1},
    })

end
