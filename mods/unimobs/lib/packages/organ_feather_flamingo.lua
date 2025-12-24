---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.organ_feather_flamingo = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.organ_feather_flamingo.init()

    return {
        description = "Flamingo feather",
    }

end

function unilib.pkg.organ_feather_flamingo.exec()

    unilib.register_craftitem("unilib:organ_feather_flamingo", nil, mode, {
        -- Original to unimobs
        description = S("Flamingo Feather"),
        inventory_image = "unilib_organ_feather_flamingo.png",
        groups = {feather = 1},

        wield_image = "unilib_organ_feather_flamingo.png",
    })

end
