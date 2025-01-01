---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_rutherfordium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_rutherfordium.init()

    return {
        description = "Rutherfordium",
    }

end

function unilib.pkg.metal_rutherfordium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "rutherfordium",
        description = S("Rutherfordium"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:metal_rutherfordium_sample", nil, mode, {
        -- Original to unilib
        description = S("Rutherfordium Sample"),
        inventory_image = "unilib_metal_rutherfordium_sample.png",
        groups = {metal_sample = 1},
    })

end
