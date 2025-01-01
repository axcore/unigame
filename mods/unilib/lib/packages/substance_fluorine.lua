---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.substance_fluorine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.substance_fluorine.init()

    return {
        description = "Fluorine",
    }

end

function unilib.pkg.substance_fluorine.exec()

    unilib.register_non_metal({
        -- Original to unilib
        part_name = "fluorine",
        description = S("Fluorine"),
    })

    unilib.register_craftitem("unilib:substance_fluorine_sample", nil, mode, {
        -- Original to unilib
        description = S("Fluorine Sample"),
        inventory_image = "unilib_substance_fluorine_sample.png",
        groups = {substance_sample = 1},
    })

end
