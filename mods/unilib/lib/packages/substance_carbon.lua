---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.substance_carbon = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.substance_carbon.init()

    return {
        description = "Carbon",
    }

end

function unilib.pkg.substance_carbon.exec()

    unilib.register_non_metal({
        -- Original to unilib
        part_name = "carbon",
        description = S("Carbon"),
    })

    unilib.register_craftitem("unilib:substance_carbon_sample", nil, mode, {
        -- Original to unilib
        description = S("Carbon Sample"),
        inventory_image = "unilib_substance_carbon_sample.png",
        groups = {substance_sample = 1},
    })

end
