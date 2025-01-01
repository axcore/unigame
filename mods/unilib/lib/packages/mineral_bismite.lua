---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_bismite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_bismite.init()

    return {
        description = "Bismite (as mineral)",
        optional = "metal_bismuth",
    }

end

function unilib.pkg.mineral_bismite.exec()

    local c_lump = "unilib:mineral_bismite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "bismite",
        description = S("Bismite"),

        hardness = 2,
        metal_list = {"bismuth"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, bismite.png). Original code
        description = S("Bismite Lump"),
        inventory_image = "unilib_mineral_bismite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_bismuth"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_bismuth_ingot",
            recipe = c_lump,
        })

    end

end
