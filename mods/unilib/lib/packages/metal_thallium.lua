---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_thallium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_thallium.init()

    return {
        description = "Thallium",
    }

end

function unilib.pkg.metal_thallium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "thallium",
        description = S("Thallium"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:metal_thallium_chunk", nil, mode, {
        -- Original to unilib
        description = S("Thallium Chunk"),
        inventory_image = "unilib_metal_thallium_chunk.png",
        groups = {metal_chunk = 1},
    })

end
