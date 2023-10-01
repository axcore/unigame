---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_ferberite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_ferberite.init()

    return {
        description = "Ferberite (as mineral)",
        optional = "metal_tungsten",
    }

end

function unilib.pkg.mineral_ferberite.exec()

    local c_lump = "unilib:mineral_ferberite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "ferberite",
        description = S("Ferberite"),

        hardness = 2,
        metal_list = {"tungsten"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, ferberite.png). Original code
        description = S("Ferberite Lump"),
        inventory_image = "unilib_mineral_ferberite_lump.png",
    })
    if unilib.pkg_executed_table["metal_tungsten"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_tungsten_ingot",
            recipe = c_lump,
        })

    end

end
