---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_terbium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_terbium.init()

    return {
        description = "Terbium",
    }

end

function unilib.pkg.metal_terbium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "terbium",
        description = S("Terbium"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_terbium_chunk", nil, mode, {
        -- Original to unilib
        description = S("Terbium Chunk"),
        inventory_image = "unilib_metal_terbium_chunk.png",
        groups = {metal_chunk = 1},
    })

end
