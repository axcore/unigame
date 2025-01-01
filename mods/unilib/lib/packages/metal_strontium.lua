---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_strontium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_strontium.init()

    return {
        description = "Strontium",
    }

end

function unilib.pkg.metal_strontium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "strontium",
        description = S("Strontium"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:metal_strontium_chunk", nil, mode, {
        -- Original to unilib
        description = S("Strontium Chunk"),
        inventory_image = "unilib_metal_strontium_chunk.png",
        groups = {metal_chunk = 1},
    })

end
