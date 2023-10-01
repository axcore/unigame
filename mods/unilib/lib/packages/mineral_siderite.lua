---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_siderite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_siderite.init()

    return {
        description = "Siderite (as mineral)",
        optional = "metal_iron_pig",
    }

end

function unilib.pkg.mineral_siderite.exec()

    local c_lump = "unilib:mineral_siderite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "siderite",
        description = S("Siderite"),

        hardness = 2,
        metal_list = {"iron_pig"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, siderite.png). Original code
        description = S("Siderite Lump"),
        inventory_image = "unilib_mineral_siderite_lump.png",
    })
    if unilib.pkg_executed_table["metal_iron_pig"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_iron_pig_ingot 2",
            recipe = c_lump,
        })

    end

end
