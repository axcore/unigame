---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_coke_natural = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_coke_natural.init()

    return {
        description = "Natural coke (as mineral)",
    }

end

function unilib.pkg.mineral_coke_natural.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "coke_natural",
        description = S("Natural Coke"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_coke_natural_lump", nil, mode, {
        -- Original to unilib
        description = S("Natural Coke Lump"),
        inventory_image = "unilib_mineral_coke_natural_lump.png",
    })

end
