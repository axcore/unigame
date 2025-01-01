---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_columbite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_columbite.init()

    return {
        description = "Columbite (as mineral)",
        optional = "metal_niobium",
    }

end

function unilib.pkg.mineral_columbite.exec()

    local c_lump = "unilib:mineral_columbite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "columbite",
        description = S("Columbite"),

        hardness = 3,
        metal_list = {"niobium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, columbite.png). Original code
        description = S("Columbite Lump"),
        inventory_image = "unilib_mineral_columbite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_niobium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_niobium_ingot",
            recipe = c_lump,
        })

    end

end
