---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_thorium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_thorium.init()

    return {
        description = "Thorium",
    }

end

function unilib.pkg.metal_thorium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "thorium",
        description = S("Thorium"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_thorium_sample", nil, mode, {
        -- Original to unilib
        description = S("Thorium Sample"),
        inventory_image = "unilib_metal_thorium_sample.png",
        groups = {metal_sample = 1},
    })

end
