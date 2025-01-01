---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_rhenium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_rhenium.init()

    return {
        description = "Rhenium",
    }

end

function unilib.pkg.metal_rhenium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "rhenium",
        description = S("Rhenium"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:metal_rhenium_sample", nil, mode, {
        -- Original to unilib
        description = S("Rhenium Sample"),
        inventory_image = "unilib_metal_rhenium_sample.png",
        groups = {metal_sample = 1},
    })

end
