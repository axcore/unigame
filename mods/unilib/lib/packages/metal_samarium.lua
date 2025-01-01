---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_samarium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_samarium.init()

    return {
        description = "Samarium",
    }

end

function unilib.pkg.metal_samarium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "samarium",
        description = S("Samarium"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_samarium_chunk", nil, mode, {
        -- Original to unilib
        description = S("Samarium Chunk"),
        inventory_image = "unilib_metal_samarium_chunk.png",
        groups = {metal_chunk = 1},
    })

end
