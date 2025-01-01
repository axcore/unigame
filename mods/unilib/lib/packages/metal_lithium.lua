---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_lithium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_lithium.init()

    return {
        description = "Lithium",
    }

end

function unilib.pkg.metal_lithium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "lithium",
        description = S("Lithium"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:metal_lithium_chunk", nil, mode, {
        -- Original to unilib
        description = S("Lithium Chunk"),
        inventory_image = "unilib_metal_lithium_chunk.png",
        groups = {metal_chunk = 1},
    })

end
