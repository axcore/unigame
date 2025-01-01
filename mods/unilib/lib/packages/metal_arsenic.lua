---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_arsenic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_arsenic.init()

    return {
        description = "Arsenic",
    }

end

function unilib.pkg.metal_arsenic.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "arsenic",
        description = S("Arsenic"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_arsenic_sample", nil, mode, {
        -- Original to unilib
        description = S("Arsenic Sample"),
        inventory_image = "unilib_metal_arsenic_sample.png",
        groups = {metal_sample = 1},
    })

end
