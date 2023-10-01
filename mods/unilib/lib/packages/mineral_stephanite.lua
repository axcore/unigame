---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_stephanite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_stephanite.init()

    return {
        description = "Stephanite (as mineral)",
        optional = "metal_silver",
    }

end

function unilib.pkg.mineral_stephanite.exec()

    local c_lump = "unilib:mineral_stephanite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "stephanite",
        description = S("Stephanite"),

        hardness = 1,
        metal_list = {"silver"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, stephanite.png). Original code
        description = S("Stephanite Lump"),
        inventory_image = "unilib_mineral_stephanite_lump.png",
    })
    if unilib.pkg_executed_table["metal_silver"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_silver_ingot",
            recipe = c_lump,
        })

    end

end
