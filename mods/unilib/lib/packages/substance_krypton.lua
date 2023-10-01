---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.substance_krypton = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.substance_krypton.init()

    return {
        description = "Krypton",
    }

end

function unilib.pkg.substance_krypton.exec()

    unilib.register_non_metal({
        -- Original to unilib
        part_name = "krypton",
        description = S("Krypton"),
    })

    unilib.register_craftitem("unilib:substance_krypton_sample", nil, mode, {
        -- Original to unilib
        description = S("Krypton Sample"),
        inventory_image = "unilib_substance_krypton_sample.png",
        groups = {substance_sample = 1},
    })

end
