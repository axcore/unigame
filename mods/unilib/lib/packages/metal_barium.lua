---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_barium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_barium.init()

    return {
        description = "Barium",
    }

end

function unilib.pkg.metal_barium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "barium",
        description = S("Barium"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:metal_barium_chunk", nil, mode, {
        -- Original to unilib
        description = S("Barium Chunk"),
        inventory_image = "unilib_metal_barium_chunk.png",
        groups = {metal_chunk = 1},
    })

end
