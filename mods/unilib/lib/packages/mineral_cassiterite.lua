---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_cassiterite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_cassiterite.init()

    return {
        description = "Cassiterite (as a mineral)",
        -- (Fallback cooking recipe, in case real copper is not available)
        optional = "metal_tin",
    }

end

function unilib.pkg.mineral_cassiterite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "cassiterite",
        description = S("Cassiterite"),

        hardness = 3,
        -- (Craft recipe provided by the "metal_tin_real" package)
        metal_list = {"tin_real"},
    })

    unilib.register_craftitem(
        -- From real_minerals:cassiterite
        "unilib:mineral_cassiterite_lump",
        "real_minerals:cassiterite",
        mode,
        {
            description = S("Cassiterite Lump"),
            inventory_image = "unilib_mineral_cassiterite_lump.png",
        }
    )

end

function unilib.pkg.mineral_cassiterite.post()

    -- If the real tin package was not executed, smelt into regular tin instead
    if unilib.pkg_executed_table["metal_tin_real"] == nil and
            unilib.pkg_executed_table["metal_tin"] ~= nil then

        unilib.register_craft({
            -- Unilib to unilib
            type = "cooking",
            output = "unilib:metal_tin_ingot",
            recipe = "unilib:mineral_cassiterite_lump",

            cooktime = 5,
        })

        unilib.update_mineral({
            part_name = "cassiterite",
            metal_list = {"tin"},
        })

    end

end
