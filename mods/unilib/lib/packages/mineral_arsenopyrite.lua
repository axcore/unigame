---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_arsenopyrite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_arsenopyrite.init()

    return {
        description = "Arsenopyrite (as mineral)",
        optional = "metal_arsenic",
    }

end

function unilib.pkg.mineral_arsenopyrite.exec()

    local c_lump = "unilib:mineral_arsenopyrite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "arsenopyrite",
        description = S("Arsenopyrite"),

        hardness = 3,
        metal_list = {"arsenic"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, arsenopyrite.png). Original code
        description = S("Arsenopyrite Lump"),
        inventory_image = "unilib_mineral_arsenopyrite_lump.png",
    })
    if unilib.pkg_executed_table["metal_arsenic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_arsenic_sample",
            recipe = c_lump,
        })

    end

end
