---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.substance_oxygen = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.substance_oxygen.init()

    return {
        description = "Oxygen",
    }

end

function unilib.pkg.substance_oxygen.exec()

    unilib.register_non_metal({
        -- Original to unilib
        part_name = "oxygen",
        description = S("Oxygen"),
    })

    unilib.register_craftitem("unilib:substance_oxygen_sample", nil, mode, {
        -- Original to unilib
        description = S("Oxygen Sample"),
        inventory_image = "unilib_substance_oxygen_sample.png",
        groups = {substance_sample = 1},
    })

end
