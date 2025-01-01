---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_holmium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_holmium.init()

    return {
        description = "Holmium",
    }

end

function unilib.pkg.metal_holmium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "holmium",
        description = S("Holmium"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_holmium_chunk", nil, mode, {
        -- Original to unilib
        description = S("Holmium Chunk"),
        inventory_image = "unilib_metal_holmium_chunk.png",
        groups = {metal_chunk = 1},
    })

end
