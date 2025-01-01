---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_antimony = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_antimony.init()

    return {
        description = "Antimony",
    }

end

function unilib.pkg.metal_antimony.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "antimony",
        description = S("Antimony"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_antimony_chunk", nil, mode, {
        -- Original to unilib
        description = S("Antimony Chunk"),
        inventory_image = "unilib_metal_antimony_chunk.png",
        groups = {metal_chunk = 1},
    })

end
