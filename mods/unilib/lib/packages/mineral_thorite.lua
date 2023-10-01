---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_thorite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_thorite.init()

    return {
        description = "Thorite (as mineral)",
        optional = "metal_thorium",
    }

end

function unilib.pkg.mineral_thorite.exec()

    local c_lump = "unilib:mineral_thorite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "thorite",
        description = S("Thorite"),

        hardness = 2,
        metal_list = {"thorium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, thorite.png). Original code
        description = S("Thorite Lump"),
        inventory_image = "unilib_mineral_thorite_lump.png",
    })
    if unilib.pkg_executed_table["metal_thorium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_thorium_sample",
            recipe = c_lump,
        })

    end

end
