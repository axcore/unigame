---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    orienteering
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.item_speedometer_digital = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.orienteering.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_speedometer_digital.init()

    return {
        description = "Digital speedometer",
        notes = "Displays player's horizontal and vertical speed",
        depends = {"metal_gold", "metal_steel"},
    }

end

function unilib.pkg.item_speedometer_digital.exec()

    unilib.register_tool("unilib:item_speedometer_digital", "orienteering:speedometer", mode, {
        -- From orienteering:speedometer
        description = unilib.utils.hint(S("Digital Speedometer"), S("shows speed")),
        inventory_image = "unilib_item_speedometer_digital_inv.png",
        groups = {disable_repair = 1},

        wield_image = "unilib_item_speedometer_digital_wield.png",
    })
    unilib.register_craft({
        -- From orienteering:speedometer
        output = "unilib:item_speedometer_digital",
        recipe = {
            {"", "unilib:metal_gold_ingot", ""},
            {"unilib:metal_steel_ingot", "group:stick", "unilib:metal_steel_ingot"},
            {"", "unilib:metal_steel_ingot", ""},
        },
    })

end
