---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_cerium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_cerium.init()

    return {
        description = "Cerium",
    }

end

function unilib.pkg.metal_cerium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "cerium",
        description = S("Cerium"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:metal_cerium_chunk", nil, mode, {
        -- Original to unilib
        description = S("Cerium Chunk"),
        inventory_image = "unilib_metal_cerium_chunk.png",
        groups = {metal_chunk = 1},
    })

end
