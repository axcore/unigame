---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_promethium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_promethium.init()

    return {
        description = "Promethium",
    }

end

function unilib.pkg.metal_promethium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "promethium",
        description = S("Promethium"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_promethium_sample", nil, mode, {
        -- Original to unilib
        description = S("Promethium Sample"),
        inventory_image = "unilib_metal_promethium_sample.png",
        groups = {metal_sample = 1},
    })

end
