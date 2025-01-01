---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_silver_native = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_silver_native.init()

    return {
        description = "Native silver (as a mineral)",
        -- (Fallback cooking recipe, in case real silver is not available)
        optional = "metal_silver",
    }

end

function unilib.pkg.mineral_silver_native.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "silver_native",
        description = S("Native Silver"),

        hardness = 3,
        -- (Craft recipe provided by the "metal_silver_rare" package)
        metal_list = {"silver_rare"},
    })

    unilib.register_craftitem(
        -- From real_minerals:native_silver
        "unilib:mineral_silver_native_lump",
        "real_minerals:native_silver",
        mode,
        {
            description = S("Native Silver Lump"),
            inventory_image = "unilib_mineral_silver_native_lump.png",
        }
    )

end

function unilib.pkg.mineral_silver_native.post()

    -- If the real silver package was not executed, smelt into regular silver instead
    if unilib.global.pkg_executed_table["metal_silver_rare"] == nil and
            unilib.global.pkg_executed_table["metal_silver"] ~= nil then

        unilib.register_craft({
            -- Unilib to unilib
            type = "cooking",
            output = "unilib:metal_silver_ingot",
            recipe = "unilib:mineral_silver_native_lump",

            cooktime = 5,
        })

        unilib.minerals.update_mineral({
            part_name = "silver_native",
            metal_list = {"silver"},
        })

    end

end
