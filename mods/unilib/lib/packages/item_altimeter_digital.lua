---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    orienteering
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.item_altimeter_digital = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.orienteering.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_altimeter_digital.init()

    return {
        description = "Digital altimeter",
        notes = "Displays height (Y coordinate)",
        depends = {"glass_ordinary", "metal_steel"},
    }

end

function unilib.pkg.item_altimeter_digital.exec()

    unilib.register_tool("unilib:item_altimeter_digital", "orienteering:altimeter", mode, {
        -- From orienteering:altimeter
        description = unilib.utils.hint(S("Digital Altimeter"), S("shows elevation")),
        inventory_image = "unilib_item_altimeter_digital.png",
        groups = {disable_repair = 1},

        wield_image = "unilib_item_altimeter_digital.png",
    })
    unilib.register_craft({
        -- From orienteering:altimeter
        output = "unilib:item_altimeter_digital",
        recipe = {
            {"unilib:glass_ordinary"},
            {"unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot"},
        },
    })

end
