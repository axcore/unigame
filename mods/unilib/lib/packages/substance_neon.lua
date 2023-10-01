---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.substance_neon = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.substance_neon.init()

    return {
        description = "Neon",
    }

end

function unilib.pkg.substance_neon.exec()

    unilib.register_non_metal({
        -- Original to unilib
        part_name = "neon",
        description = S("Neon"),
    })

    unilib.register_craftitem("unilib:substance_neon_sample", nil, mode, {
        -- Original to unilib
        description = S("Neon Sample"),
        inventory_image = "unilib_substance_neon_sample.png",
        groups = {substance_sample = 1},
    })

end
