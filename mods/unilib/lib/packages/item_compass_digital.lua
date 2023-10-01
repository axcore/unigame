---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    orienteering
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.item_compass_digital = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.orienteering.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_compass_digital.init()

    return {
        description = "Digital compass",
        notes = "Displays player yaw (horizontal viewing angle)",
        depends = "metal_tin",
    }

end

function unilib.pkg.item_compass_digital.exec()

    unilib.register_tool("unilib:item_compass_digital", "orienteering:compass", mode, {
        -- From orienteering:compass
        description = S("Digital Compass"),
        inventory_image = "unilib_item_compass_digital_inv.png",
        groups = {disable_repair = 1},

        wield_image = "unilib_item_compass_digital_wield.png",
    })
    unilib.register_craft({
        -- From orienteering:compass
        output = "unilib:item_compass_digital",
        recipe = {
            {"", "unilib:metal_tin_ingot", ""},
            {"unilib:metal_tin_ingot", "group:stick", "unilib:metal_tin_ingot"},
            {"", "unilib:metal_tin_ingot", ""},
        },
    })

end
