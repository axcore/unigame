---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_loellingite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_loellingite.init()

    return {
        description = "Loellingite (as mineral)",
        optional = "metal_arsenic",
    }

end

function unilib.pkg.mineral_loellingite.exec()

    local c_lump = "unilib:mineral_loellingite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "loellingite",
        description = S("Loellingite"),

        hardness = 3,
        metal_list = {"arsenic"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, lollingite.png). Original code
        description = S("Loellingite Lump"),
        inventory_image = "unilib_mineral_loellingite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_arsenic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_arsenic_sample",
            recipe = c_lump,
        })

    end

end
