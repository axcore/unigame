---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.substance_helium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.substance_helium.init()

    return {
        description = "Helium",
    }

end

function unilib.pkg.substance_helium.exec()

    unilib.register_non_metal({
        -- Original to unilib
        part_name = "helium",
        description = S("Helium"),
    })

    unilib.register_craftitem("unilib:substance_helium_sample", nil, mode, {
        -- Original to unilib
        description = S("Helium Sample"),
        inventory_image = "unilib_substance_helium_sample.png",
        groups = {substance_sample = 1},
    })

end
