---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_langbeinite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_langbeinite.init()

    return {
        description = "Langbeinite (as mineral)",
        optional = "metal_potassium",
    }

end

function unilib.pkg.mineral_langbeinite.exec()

    local c_lump = "unilib:mineral_langbeinite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "langbeinite",
        description = S("Langbeinite"),

        hardness = 2,
        metal_list = {"potassium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, langbeinite.png). Original code
        description = S("Langbeinite Lump"),
        inventory_image = "unilib_mineral_langbeinite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_potassium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_potassium_chunk",
            recipe = c_lump,
        })

    end

end
