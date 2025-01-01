---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_titanite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_titanite.init()

    return {
        description = "Titanite (as mineral)",
        optional = "metal_titanium",
    }

end

function unilib.pkg.mineral_titanite.exec()

    local c_lump = "unilib:mineral_titanite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "titanite",
        description = S("Titanite"),

        hardness = 3,
        metal_list = {"titanium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, titanite.png). Original code
        description = S("Titanite Lump"),
        inventory_image = "unilib_mineral_titanite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_titanium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_titanium_ingot",
            recipe = c_lump,
        })

    end

end
