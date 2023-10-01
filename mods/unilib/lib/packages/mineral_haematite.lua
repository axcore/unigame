---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_haematite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_haematite.init()

    return {
        description = "Haematite (as a mineral)",
        -- (Fallback cooking recipe, in case pig iron is not available)
        optional = "metal_iron_wrought",
    }

end

function unilib.pkg.mineral_haematite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "haematite",
        description = S("Haematite"),

        hardness = 3,
        -- (Craft recipe provided by the "metal_iron_pig" package)
        metal_list = {"iron_pig"},
    })

    unilib.register_craftitem("unilib:mineral_haematite_lump", "real_minerals:hematite", mode, {
        -- From real_minerals:hematite
        description = S("Haematite Lump"),
        inventory_image = "unilib_mineral_haematite_lump.png",
    })

end

function unilib.pkg.mineral_haematite.post()

    -- If the pig iron package was not executed, smelt into wrought iron instead
    if unilib.pkg_executed_table["metal_iron_pig"] == nil and
            unilib.pkg_executed_table["metal_iron_wrought"] ~= nil then

        unilib.register_craft({
            -- Unilib to unilib
            type = "cooking",
            output = "unilib:metal_iron_wrought_ingot",
            recipe = "unilib:mineral_haematite_lump",

            cooktime = 5,
        })

        unilib.update_mineral({
            part_name = "haematite",
            metal_list = {"iron_wrought"},
        })

    end

end
