---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.substance_radon = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.substance_radon.init()

    return {
        description = "Radon",
    }

end

function unilib.pkg.substance_radon.exec()

    unilib.register_non_metal({
        -- Original to unilib
        part_name = "radon",
        description = S("Radon"),
    })

    unilib.register_craftitem("unilib:substance_radon_sample", nil, mode, {
        -- Original to unilib
        description = S("Radon Sample"),
        inventory_image = "unilib_substance_radon_sample.png",
        groups = {substance_sample = 1},
    })

end
