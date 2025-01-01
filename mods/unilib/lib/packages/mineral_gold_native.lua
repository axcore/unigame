---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_gold_native = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_gold_native.init()

    return {
        description = "Native gold (as a mineral)",
        -- (Fallback cooking recipe, in case real gold is not available)
        optional = "metal_gold",
    }

end

function unilib.pkg.mineral_gold_native.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "gold_native",
        description = S("Native Gold"),

        hardness = 3,
        -- (Craft recipe provided by the "metal_gold_rare" package)
        metal_list = {"gold_rare"},
    })

    unilib.register_craftitem(
        -- From real_minerals:native_gold
        "unilib:mineral_gold_native_lump",
        "real_minerals:native_gold",
        mode,
        {
            description = S("Native Gold Lump"),
            inventory_image = "unilib_mineral_gold_native_lump.png",
        }
    )

end

function unilib.pkg.mineral_gold_native.post()

    -- If the real gold package was not executed, smelt into regular gold instead
    if unilib.global.pkg_executed_table["metal_gold_rare"] == nil and
            unilib.global.pkg_executed_table["metal_gold"] ~= nil then

        unilib.register_craft({
            -- Unilib to unilib
            type = "cooking",
            output = "unilib:metal_gold_ingot",
            recipe = "unilib:mineral_gold_native_lump",

            cooktime = 5,
        })

        unilib.minerals.update_mineral({
            part_name = "gold_native",
            metal_list = {"gold"},
        })

    end

end
