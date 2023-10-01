---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_lutetium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_lutetium.init()

    return {
        description = "Lutetium",
    }

end

function unilib.pkg.metal_lutetium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "lutetium",
        description = S("Lutetium"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_lutetium_chunk", nil, mode, {
        -- Original to unilib
        description = S("Lutetium Chunk"),
        inventory_image = "unilib_metal_lutetium_chunk.png",
        groups = {metal_chunk = 1},
    })

end
