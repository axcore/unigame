---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_magnetite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_magnetite.init()

    return {
        description = "Magnetite (as a mineral)",
        -- (Fallback cooking recipe, in case pig iron is not available)
        optional = "metal_iron_wrought",
    }

end

function unilib.pkg.mineral_magnetite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "magnetite",
        description = S("Magnetite"),

        hardness = 3,
        -- (Craft recipe provided by the "metal_iron_pig" package)
        metal_list = {"iron_pig"},
    })

    unilib.register_craftitem("unilib:mineral_magnetite_lump", "real_minerals:magnetite", mode, {
        -- From real_minerals:magnetite
        description = S("Magnetite Lump"),
        inventory_image = "unilib_mineral_magnetite_lump.png",
    })

end

function unilib.pkg.mineral_magnetite.post()

    -- If the pig iron package was not executed, smelt into wrought iron instead
    if unilib.pkg_executed_table["metal_iron_pig"] == nil and
            unilib.pkg_executed_table["metal_iron_wrought"] ~= nil then

        unilib.register_craft({
            -- Unilib to unilib
            type = "cooking",
            output = "unilib:metal_iron_wrought_ingot",
            recipe = "unilib:mineral_magnetite_lump",

            cooktime = 5,
        })

        unilib.update_mineral({
            part_name = "magnetite",
            metal_list = {"iron_wrought"},
        })

    end

end
