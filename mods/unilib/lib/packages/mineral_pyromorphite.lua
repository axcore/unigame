---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_pyromorphite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_pyromorphite.init()

    return {
        description = "Pyromorphite (as mineral)",
        optional = "metal_lead",
    }

end

function unilib.pkg.mineral_pyromorphite.exec()

    local c_lump = "unilib:mineral_pyromorphite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "pyromorphite",
        description = S("Pyromorphite"),

        hardness = 2,
        metal_list = {"lead"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, pyromorphite.png). Original code
        description = S("Pyromorphite Lump"),
        inventory_image = "unilib_mineral_pyromorphite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_lead"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_lead_ingot",
            recipe = c_lump,
        })

    end

end
