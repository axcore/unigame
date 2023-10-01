---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_cuprite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_cuprite.init()

    return {
        description = "Cuprite (as mineral)",
        optional = "metal_copper",
    }

end

function unilib.pkg.mineral_cuprite.exec()

    local c_lump = "unilib:mineral_cuprite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "cuprite",
        description = S("Cuprite"),

        hardness = 2,
        metal_list = {"copper"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, cuprite.png). Original code
        description = S("Cuprite Lump"),
        inventory_image = "unilib_mineral_cuprite_lump.png",
    })
    if unilib.pkg_executed_table["metal_copper"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_copper_ingot",
            recipe = c_lump,
        })

    end

end
