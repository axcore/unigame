---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_beryllium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_beryllium.init()

    return {
        description = "Beryllium",
    }

end

function unilib.pkg.metal_beryllium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "beryllium",
        description = S("Beryllium"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_beryllium_chunk", nil, mode, {
        -- Original to unilib
        description = S("Beryllium Chunk"),
        inventory_image = "unilib_metal_beryllium_chunk.png",
        groups = {metal_chunk = 1},
    })

end
