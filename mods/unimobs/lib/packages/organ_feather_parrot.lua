---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.organ_feather_parrot = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.organ_feather_parrot.init()

    return {
        description = "Parrot feather",
    }

end

function unilib.pkg.organ_feather_parrot.exec()

    unilib.register_craftitem("unilib:organ_feather_parrot", nil, mode, {
        -- Original to unimobs
        description = S("Parrot Feather"),
        inventory_image = "unilib_organ_feather_parrot.png",
        groups = {feather = 1},

        wield_image = "unilib_organ_feather_parrot.png",
    })

end
