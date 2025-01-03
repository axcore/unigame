---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.substance_chlorine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.substance_chlorine.init()

    return {
        description = "Chlorine",
    }

end

function unilib.pkg.substance_chlorine.exec()

    unilib.register_non_metal({
        -- Original to unilib
        part_name = "chlorine",
        description = S("Chlorine"),
    })

    unilib.register_craftitem("unilib:substance_chlorine_sample", nil, mode, {
        -- Original to unilib
        description = S("Chlorine Sample"),
        inventory_image = "unilib_substance_chlorine_sample.png",
        groups = {substance_sample = 1},
    })

end
