---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    orienteering
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.item_sextant_digital = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.orienteering.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_sextant_digital.init()

    return {
        description = "Digital sextant",
        notes = "Displays player pitch (vertical viewing angle)",
        depends = "metal_gold",
    }

end

function unilib.pkg.item_sextant_digital.exec()

    unilib.register_tool("unilib:item_sextant_digital", "orienteering:sextant", mode, {
        -- From orienteering:sextant
        description = unilib.utils.hint(
            S("Digital Sextant"), S("shows pitch/vertical viewing angle")
        ),
        inventory_image = "unilib_item_sextant_digital_inv.png",
        groups = {disable_repair = 1},

        wield_image = "unilib_item_sextant_digital_wield.png",
    })
    unilib.register_craft({
        -- From orienteering:sextant
        output = "unilib:item_sextant_digital",
        recipe = {
            {"", "unilib:metal_gold_ingot", ""},
            {"unilib:metal_gold_ingot", "unilib:metal_gold_ingot", "unilib:metal_gold_ingot"},
        },
    })

end
