---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_copernecium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_copernecium.init()

    return {
        description = "Copernecium",
    }

end

function unilib.pkg.metal_copernecium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "copernecium",
        description = S("Copernecium"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:metal_copernecium_sample", nil, mode, {
        -- Original to unilib
        description = S("Copernecium Sample"),
        inventory_image = "unilib_metal_copernecium_sample.png",
        groups = {metal_sample = 1},
    })

end
