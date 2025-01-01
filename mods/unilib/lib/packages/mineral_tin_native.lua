---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_tin_native = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_tin_native.init()

    return {
        description = "Native tin (as mineral)",
        -- (Fallback cooking recipe, in case real tin is not available)
        optional = "metal_tin",
    }

end

function unilib.pkg.mineral_tin_native.exec()

    local c_lump = "unilib:mineral_tin_native_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "tin_native",
        description = S("Native Tin"),

        hardness = 1,
        -- (Craft recipe provided by the "metal_tin_rare" package)
        metal_list = {"tin_rare"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, native_tin.png). Original code
        description = S("Native Tin Lump"),
        inventory_image = "unilib_mineral_tin_native_lump.png",
    })

end

function unilib.pkg.mineral_tin_native.post()

    -- If the real tin package was not executed, smelt into regular tin instead
    if unilib.global.pkg_executed_table["metal_tin_rare"] == nil and
            unilib.global.pkg_executed_table["metal_tin"] ~= nil then

        unilib.register_craft({
            -- Unilib to unilib
            type = "cooking",
            output = "unilib:metal_tin_ingot",
            recipe = "unilib:mineral_tin_native_lump",

            cooktime = 5,
        })

        unilib.minerals.update_mineral({
            part_name = "tin_native",
            metal_list = {"tin"},
        })

    end

end
