---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_curium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_curium.init()

    return {
        description = "Curium",
    }

end

function unilib.pkg.metal_curium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "curium",
        description = S("Curium"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:metal_curium_sample", nil, mode, {
        -- Original to unilib
        description = S("Curium Sample"),
        inventory_image = "unilib_metal_curium_sample.png",
        groups = {metal_sample = 1},
    })

end
