---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_silicon = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_silicon.init()

    return {
        description = "Silicon",
    }

end

function unilib.pkg.metal_silicon.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "silicon",
        description = S("Silicon"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:metal_silicon_chunk", nil, mode, {
        -- Original to unilib
        description = S("Silicon Chunk"),
        inventory_image = "unilib_metal_silicon_chunk.png",
        groups = {metal_chunk = 1},
    })

end
