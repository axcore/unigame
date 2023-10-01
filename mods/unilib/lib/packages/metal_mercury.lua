---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_mercury = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_mercury.init()

    return {
        description = "Mercury",
    }

end

function unilib.pkg.metal_mercury.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "mercury",
        description = S("Mercury"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:metal_mercury_sample", nil, mode, {
        -- Original to unilib
        description = S("Mercury Sample"),
        inventory_image = "unilib_metal_mercury_sample.png",
        groups = {metal_sample = 1},
    })

end
