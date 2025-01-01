---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_bismuth_native = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_bismuth_native.init()

    return {
        description = "Native bismuth (as mineral)",
        optional = "metal_bismuth",
    }

end

function unilib.pkg.mineral_bismuth_native.exec()

    local c_lump = "unilib:mineral_bismuth_native_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "bismuth_native",
        description = S("Native Bismuth"),

        hardness = 1,
        -- (Craft recipe provided by the "metal_bismuth" package)
        metal_list = {"bismuth"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, native_bismuth.png). Original code
        description = S("Native Bismuth Lump"),
        inventory_image = "unilib_mineral_bismuth_native_lump.png",
    })

end
