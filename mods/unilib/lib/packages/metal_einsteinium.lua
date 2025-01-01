---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_einsteinium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_einsteinium.init()

    return {
        description = "Einsteinium",
    }

end

function unilib.pkg.metal_einsteinium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "einsteinium",
        description = S("Einsteinium"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:metal_einsteinium_sample", nil, mode, {
        -- Original to unilib
        description = S("Einsteinium Sample"),
        inventory_image = "unilib_metal_einsteinium_sample.png",
        groups = {metal_sample = 1},
    })

end
