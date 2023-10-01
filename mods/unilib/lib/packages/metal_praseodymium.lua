---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_praseodymium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_praseodymium.init()

    return {
        description = "Praseodymium",
    }

end

function unilib.pkg.metal_praseodymium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "praseodymium",
        description = S("Praseodymium"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_praseodymium_chunk", nil, mode, {
        -- Original to unilib
        description = S("Praseodymium Chunk"),
        inventory_image = "unilib_metal_praseodymium_chunk.png",
        groups = {metal_chunk = 1},
    })

end
