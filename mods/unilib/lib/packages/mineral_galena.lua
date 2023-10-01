---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_galena = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_galena.init()

    return {
        description = "Galena (as a mineral)",
        -- (Fallback cooking recipe, in case real copper is not available)
        optional = "metal_lead",
    }

end

function unilib.pkg.mineral_galena.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "galena",
        description = S("Galena"),

        hardness = 1,
        -- (Craft recipe provided by the "metal_lead_real" package)
        metal_list = {"lead_real"},
    })

    unilib.register_craftitem("unilib:mineral_galena_lump", "real_minerals:galena", mode, {
        -- From real_minerals:galena
        description = S("Galena Lump"),
        inventory_image = "unilib_mineral_galena_lump.png",
    })

end

function unilib.pkg.mineral_galena.post()

    -- If the real lead package was not executed, smelt into regular lead instead
    if unilib.pkg_executed_table["metal_lead_real"] == nil and
            unilib.pkg_executed_table["metal_lead"] ~= nil then

        unilib.register_craft({
            -- Unilib to unilib
            type = "cooking",
            output = "unilib:metal_lead_ingot",
            recipe = "unilib:mineral_galena_lump",

            cooktime = 5,
        })

        unilib.update_mineral({
            part_name = "galena",
            metal_list = {"lead"},
        })

    end

end
