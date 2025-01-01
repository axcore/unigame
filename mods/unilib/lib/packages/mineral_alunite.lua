---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_alunite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_alunite.init()

    return {
        description = "Alunite (as mineral)",
        optional = "metal_aluminium",
    }

end

function unilib.pkg.mineral_alunite.exec()

    local c_lump = "unilib:mineral_alunite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "alunite",
        description = S("Alunite"),

        hardness = 2,
        metal_list = {"aluminium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original to unilib
        description = S("Alunite Lump"),
        inventory_image = "unilib_mineral_alunite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_aluminium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_aluminium_ingot",
            recipe = c_lump,
        })

    end

end
