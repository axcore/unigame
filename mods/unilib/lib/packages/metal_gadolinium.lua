---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_gadolinium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_gadolinium.init()

    return {
        description = "Gadolinium",
    }

end

function unilib.pkg.metal_gadolinium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "gadolinium",
        description = S("Gadolinium"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_gadolinium_chunk", nil, mode, {
        -- Original to unilib
        description = S("Gadolinium Chunk"),
        inventory_image = "unilib_metal_gadolinium_chunk.png",
        groups = {metal_chunk = 1},
    })

end
