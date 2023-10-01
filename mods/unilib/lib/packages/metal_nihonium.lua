---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_nihonium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_nihonium.init()

    return {
        description = "Nihonium",
    }

end

function unilib.pkg.metal_nihonium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "nihonium",
        description = S("Nihonium"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:metal_nihonium_sample", nil, mode, {
        -- Original to unilib
        description = S("Nihonium Sample"),
        inventory_image = "unilib_metal_nihonium_sample.png",
        groups = {metal_sample = 1},
    })

end
