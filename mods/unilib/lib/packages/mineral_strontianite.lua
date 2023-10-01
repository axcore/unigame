---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_strontianite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_strontianite.init()

    return {
        description = "Strontianite (as mineral)",
        optional = "metal_strontium",
    }

end

function unilib.pkg.mineral_strontianite.exec()

    local c_lump = "unilib:mineral_strontianite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "strontianite",
        description = S("Strontianite"),

        hardness = 2,
        metal_list = {"strontium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, strontianite.png). Original code
        description = S("Strontianite Lump"),
        inventory_image = "unilib_mineral_strontianite_lump.png",
    })
    if unilib.pkg_executed_table["metal_strontium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_strontium_chunk",
            recipe = c_lump,
        })

    end

end
