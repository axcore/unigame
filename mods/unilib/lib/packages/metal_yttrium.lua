---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_yttrium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_yttrium.init()

    return {
        description = "Yttrium",
    }

end

function unilib.pkg.metal_yttrium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "yttrium",
        description = S("Yttrium"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_yttrium_chunk", nil, mode, {
        -- Original to unilib
        description = S("Yttrium Chunk"),
        inventory_image = "unilib_metal_yttrium_chunk.png",
        groups = {metal_chunk = 1},
    })

end
