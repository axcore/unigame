---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_boron = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_boron.init()

    return {
        description = "Boron",
    }

end

function unilib.pkg.metal_boron.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "boron",
        description = S("Boron"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:metal_boron_chunk", nil, mode, {
        -- Original to unilib
        description = S("Boron Chunk"),
        inventory_image = "unilib_metal_boron_chunk.png",
        groups = {metal_chunk = 1},
    })

end
