---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_dolomite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_dolomite.init()

    return {
        description = "Dolomite (as mineral)",
        optional = "metal_magnesium",
    }

end

function unilib.pkg.mineral_dolomite.exec()

    local c_lump = "unilib:mineral_dolomite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "dolomite",
        description = S("Dolomite"),

        hardness = 1,
        metal_list = {"magnesium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original to unilib
        description = S("Dolomite Lump"),
        inventory_image = "unilib_mineral_dolomite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_magnesium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_magnesium_ingot",
            recipe = c_lump,
        })

    end

end
