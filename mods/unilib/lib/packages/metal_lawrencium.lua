---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_lawrencium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_lawrencium.init()

    return {
        description = "Lawrencium",
    }

end

function unilib.pkg.metal_lawrencium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "lawrencium",
        description = S("Lawrencium"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:metal_lawrencium_sample", nil, mode, {
        -- Original to unilib
        description = S("Lawrencium Sample"),
        inventory_image = "unilib_metal_lawrencium_sample.png",
        groups = {metal_sample = 1},
    })

end
