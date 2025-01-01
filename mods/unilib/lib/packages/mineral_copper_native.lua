---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_copper_native = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_copper_native.init()

    return {
        description = "Native copper (as a mineral)",
        -- (Fallback cooking recipe, in case real copper is not available)
        optional = "metal_copper",
    }

end

function unilib.pkg.mineral_copper_native.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "copper_native",
        description = S("Native Copper"),

        hardness = 3,
        -- (Craft recipe provided by the "metal_copper_rare" package)
        metal_list = {"copper_rare"},
    })

    unilib.register_craftitem(
        -- From real_minerals:native_copper
        "unilib:mineral_copper_native_lump",
        "real_minerals:native_copper",
        mode,
        {
            description = S("Native Copper Lump"),
            inventory_image = "unilib_mineral_copper_native_lump.png",
        }
    )

end

function unilib.pkg.mineral_copper_native.post()

    -- If the real copper package was not executed, smelt into regular copper instead
    if unilib.global.pkg_executed_table["metal_copper_rare"] == nil and
            unilib.global.pkg_executed_table["metal_copper"] ~= nil then

        unilib.register_craft({
            -- Unilib to unilib
            type = "cooking",
            output = "unilib:metal_copper_ingot",
            recipe = "unilib:mineral_copper_native_lump",

            cooktime = 5,
        })

        unilib.minerals.update_mineral({
            part_name = "copper_native",
            metal_list = {"copper"},
        })

    end

end
