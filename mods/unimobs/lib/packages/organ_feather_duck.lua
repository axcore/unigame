---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.organ_feather_duck = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.organ_feather_duck.init()

    return {
        description = "Duck feather",
    }

end

function unilib.pkg.organ_feather_duck.exec()

    unilib.register_craftitem("unilib:organ_feather_duck", "petz:ducky_feather", mode, {
        -- From petz:ducky_feather
        description = S("Duck Feather"),
        inventory_image = "unilib_organ_feather_duck.png",
        groups = {feather = 1},

        wield_image = "unilib_organ_feather_duck.png",
    })

end
