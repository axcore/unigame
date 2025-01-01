---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_thulium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_thulium.init()

    return {
        description = "Thulium",
    }

end

function unilib.pkg.metal_thulium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "thulium",
        description = S("Thulium"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_thulium_chunk", nil, mode, {
        -- Original to unilib
        description = S("Thulium Chunk"),
        inventory_image = "unilib_metal_thulium_chunk.png",
        groups = {metal_chunk = 1},
    })

end
