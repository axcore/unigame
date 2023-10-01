---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.substance_tennessine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.substance_tennessine.init()

    return {
        description = "Tennessine",
    }

end

function unilib.pkg.substance_tennessine.exec()

    unilib.register_non_metal({
        -- Original to unilib
        part_name = "tennessine",
        description = S("Tennessine"),
    })

    unilib.register_craftitem("unilib:substance_tennessine_sample", nil, mode, {
        -- Original to unilib
        description = S("Tennessine Sample"),
        inventory_image = "unilib_substance_tennessine_sample.png",
        groups = {substance_sample = 1},
    })

end
