---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.organ_feather_pigeon = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.organ_feather_pigeon.init()

    return {
        description = "Pigeon feather",
    }

end

function unilib.pkg.organ_feather_pigeon.exec()

    unilib.register_craftitem("unilib:organ_feather_pigeon", nil, mode, {
        -- Original to unimobs
        description = S("Pigeon Feather"),
        inventory_image = "unilib_organ_feather_pigeon.png",
        groups = {feather = 1},

        wield_image = "unilib_organ_feather_pigeon.png",
    })

end
