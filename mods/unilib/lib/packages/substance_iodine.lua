---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.substance_iodine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.substance_iodine.init()

    return {
        description = "Iodine",
    }

end

function unilib.pkg.substance_iodine.exec()

    unilib.register_non_metal({
        -- Original to unilib
        part_name = "iodine",
        description = S("Iodine"),
    })

    unilib.register_craftitem("unilib:substance_iodine_sample", nil, mode, {
        -- Original to unilib
        description = S("Iodine Sample"),
        inventory_image = "unilib_substance_iodine_sample.png",
        groups = {substance_sample = 1},
    })

end
