---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_gersdorffite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_gersdorffite.init()

    return {
        description = "Gersdorffite (as mineral)",
        optional = "metal_nickel",
    }

end

function unilib.pkg.mineral_gersdorffite.exec()

    local c_lump = "unilib:mineral_gersdorffite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "gersdorffite",
        description = S("Gersdorffite"),

        hardness = 3,
        metal_list = {"nickel"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, gersdorffite.png). Original code
        description = S("Gersdorffite Lump"),
        inventory_image = "unilib_mineral_gersdorffite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_nickel"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_nickel_ingot",
            recipe = c_lump,
        })

    end

end
