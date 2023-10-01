---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_platinum_native = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_platinum_native.init()

    return {
        description = "Native platinum (as a mineral)",
        -- (Fallback cooking recipe, in case real platinum is not available)
        optional = "metal_platinum",
    }

end

function unilib.pkg.mineral_platinum_native.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "platinum_native",
        description = S("Native Platinum"),

        hardness = 3,
        -- (Craft recipe provided by the "metal_platinum_real" package)
        metal_list = {"platinum_real"},
    })

    unilib.register_craftitem(
        -- From real_minerals:native_platinum
        "unilib:mineral_platinum_native_lump",
        "real_minerals:native_platinum",
        mode,
        {
            description = S("Native Platinum Lump"),
            inventory_image = "unilib_mineral_platinum_native_lump.png",
        }
    )

end

function unilib.pkg.mineral_platinum_native.post()

    -- If the real platinum package was not executed, smelt into regular platinum instead
    if unilib.pkg_executed_table["metal_platinum_real"] == nil and
            unilib.pkg_executed_table["metal_platinum"] ~= nil then

        unilib.register_craft({
            -- Unilib to unilib
            type = "cooking",
            output = "unilib:metal_platinum_ingot",
            recipe = "unilib:mineral_platinum_native_lump",

            cooktime = 5,
        })

        unilib.update_mineral({
            part_name = "platinum_native",
            metal_list = {"platinum"},
        })

    end

end

