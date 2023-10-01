---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_calcium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_calcium.init()

    return {
        description = "Calcium",
    }

end

function unilib.pkg.metal_calcium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "calcium",
        description = S("Calcium"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:metal_calcium_chunk", nil, mode, {
        -- Original to unilib
        description = S("Calcium Chunk"),
        inventory_image = "unilib_metal_calcium_chunk.png",
        groups = {metal_chunk = 1},
    })

end
