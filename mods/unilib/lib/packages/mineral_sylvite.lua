---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_sylvite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_sylvite.init()

    return {
        description = "Sylvite (as a mineral)",
        optional = "metal_potassium",
    }

end

function unilib.pkg.mineral_sylvite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "sylvite",
        description = S("Sylvite"),

        hardness = 1,
        metal_list = {"potassium"},
    })

    unilib.register_craftitem("unilib:mineral_sylvite_lump", "real_minerals:sylvite", mode, {
        -- From real_minerals:sylvite
        description = S("Sylvite Lump"),
        inventory_image = "unilib_mineral_sylvite_lump.png",
    })
    if unilib.pkg_executed_table["metal_potassium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_potassium_chunk",
            recipe = "unilib:mineral_sylvite_lump",
        })

    end

end
