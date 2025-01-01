---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_sphalerite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_sphalerite.init()

    return {
        description = "Sphalerite (as a mineral)",
        -- (Fallback cooking recipe, in case real copper is not available)
        optional = "metal_zinc",
    }

end

function unilib.pkg.mineral_sphalerite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "sphalerite",
        description = S("Sphalerite"),

        hardness = 2,
        -- (Craft recipe provided by the "metal_zinc_rare" package)
        metal_list = {"zinc_rare"},
    })

    unilib.register_craftitem("unilib:mineral_sphalerite_lump", "real_minerals:sphalerite", mode, {
        -- From real_minerals:sphalerite
        description = S("Sphalerite Lump"),
        inventory_image = "unilib_mineral_sphalerite_lump.png",
    })

end

function unilib.pkg.mineral_sphalerite.post()

    -- If the real zinc package was not executed, smelt into regular zinc instead
    if unilib.global.pkg_executed_table["metal_zinc_rare"] == nil and
            unilib.global.pkg_executed_table["metal_zinc"] ~= nil then

        unilib.register_craft({
            -- Unilib to unilib
            type = "cooking",
            output = "unilib:metal_zinc_ingot",
            recipe = "unilib:mineral_sphalerite_lump",

            cooktime = 5,
        })

        unilib.minerals.update_mineral({
            part_name = "sphalerite",
            metal_list = {"zinc"},
        })

    end

end
