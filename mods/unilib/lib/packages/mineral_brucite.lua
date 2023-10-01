---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_brucite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_brucite.init()

    return {
        description = "Brucite (as mineral)",
        optional = "metal_magnesium",
    }

end

function unilib.pkg.mineral_brucite.exec()

    local c_lump = "unilib:mineral_brucite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "brucite",
        description = S("Brucite"),

        hardness = 1,
        metal_list = {"magnesium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, brucite.png). Original code
        description = S("Brucite Lump"),
        inventory_image = "unilib_mineral_brucite_lump.png",
    })
    if unilib.pkg_executed_table["metal_magnesium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_magnesium_ingot",
            recipe = c_lump,
        })

    end

end
