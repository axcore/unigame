---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_cobaltite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_cobaltite.init()

    return {
        description = "Cobaltite (as mineral)",
        optional = "metal_cobalt",
    }

end

function unilib.pkg.mineral_cobaltite.exec()

    local c_lump = "unilib:mineral_cobaltite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "cobaltite",
        description = S("Cobaltite"),

        hardness = 3,
        metal_list = {"cobalt"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, cobaltite.png). Original code
        description = S("Cobaltite Lump"),
        inventory_image = "unilib_mineral_cobaltite_lump.png",
    })
    if unilib.pkg_executed_table["metal_cobalt"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_cobalt_ingot",
            recipe = c_lump,
        })

    end

end
