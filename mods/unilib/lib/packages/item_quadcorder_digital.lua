---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    orienteering
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.item_quadcorder_digital = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.orienteering.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_quadcorder_digital.init()

    return {
        description = "Digital quadcorder",
        notes = "Displays coordinates, yaw, pitch, time and speed. Also enables the minimap",
        depends = {
            "item_gps_digital",
            "item_satnav_digital",
            "item_sextant_digital",
            "item_speedometer_digital",
            "metal_gold",
            "mineral_diamond",
            "shared_orienteering",
        },
    }

end

function unilib.pkg.item_quadcorder_digital.exec()

    unilib.register_tool("unilib:item_quadcorder_digital", "orienteering:quadcorder", mode, {
        -- From orienteering:quadcorder
        description = unilib.utils.hint(
            S("Digital Quadcorder"),
            S("shows coordinates, yaw, pitch, time and speed, and enables minimap")
        ),
        inventory_image = "unilib_item_quadcorder_digital.png",
        groups = {disable_repair = 1},

        wield_image = "unilib_item_quadcorder_digital.png",
        wield_scale = {x = 1, y = 1, z = 3.5},

        on_use = unilib.pkg.shared_orienteering.toggle_time_mode,
    })
    unilib.register_craft({
        -- From orienteering:quadcorder
        output = "unilib:item_quadcorder_digital",
        recipe = {
            {
                "unilib:metal_gold_ingot",
                "unilib:metal_gold_ingot",
                "unilib:metal_gold_ingot",
            },
            {
                "unilib:item_speedometer_digital",
                "unilib:mineral_diamond_gem",
                "unilib:item_satnav_digital",
            },
            {
                "unilib:item_sextant_digital",
                "unilib:mineral_diamond_gem",
                "unilib:item_gps_digital",
            },
        },
    })

end
