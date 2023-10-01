---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_tennantite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_tennantite.init()

    return {
        description = "Tennantite (as mineral)",
        optional = "metal_copper",
    }

end

function unilib.pkg.mineral_tennantite.exec()

    local c_lump = "unilib:mineral_tennantite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "tennantite",
        description = S("Tennantite"),

        hardness = 2,
        metal_list = {"copper"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, tennantite.png). Original code
        description = S("Tennantite Lump"),
        inventory_image = "unilib_mineral_tennantite_lump.png",
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
