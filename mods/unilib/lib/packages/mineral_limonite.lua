---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_limonite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_limonite.init()

    return {
        description = "Limonite (as a mineral)",
        -- (Fallback cooking recipe, in case pig iron is not available)
        optional = "metal_iron_wrought",
    }

end

function unilib.pkg.mineral_limonite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "limonite",
        description = S("Limonite"),

        hardness = 1,
        -- (Craft recipe provided by the "metal_iron_pig" package)
        metal_list = {"iron_pig"},
    })

    unilib.register_craftitem("unilib:mineral_limonite_lump", "real_minerals:limonite", mode, {
        -- From real_minerals:limonite
        description = S("Limonite Lump"),
        inventory_image = "unilib_mineral_limonite_lump.png",
    })

end

function unilib.pkg.mineral_limonite.post()

    -- If the pig iron package was not executed, smelt into wrought iron instead
    if unilib.global.pkg_executed_table["metal_iron_pig"] == nil and
            unilib.global.pkg_executed_table["metal_iron_wrought"] ~= nil then

        unilib.register_craft({
            -- Unilib to unilib
            type = "cooking",
            output = "unilib:metal_iron_wrought_ingot",
            recipe = "unilib:mineral_limonite_lump",

            cooktime = 5,
        })

        unilib.minerals.update_mineral({
            part_name = "limonite",
            metal_list = {"iron_wrought"},
        })

    end

end
