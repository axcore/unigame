---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    orienteering
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.item_gps_digital = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.orienteering.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_gps_digital.init()

    return {
        description = "Digital GPS device",
        notes = "Displays coordinates, yaw and game time",
        depends = {
            "item_altimeter_digital",
            "item_compass_digital",
            "item_triangulator_digital",
            "item_watch_digital",
            "metal_bronze",
            "metal_gold",
            "metal_tin",
            "shared_orienteering",
        },
    }

end

function unilib.pkg.item_gps_digital.exec()

    unilib.register_tool("unilib:item_gps_digital", "orienteering:gps", mode, {
        -- From orienteering:gps
        description = S("Digital GPS Device"),
        inventory_image = "unilib_item_gps_digital_inv.png",
        groups = {disable_repair = 1},

        wield_image = "unilib_item_gps_digital_wield.png",
        wield_scale = {x = 1, y = 1, z = 2},

        on_use = unilib.pkg.shared_orienteering.toggle_time_mode,
    })
    unilib.register_craft({
        -- From orienteering:gps
        output = "unilib:item_gps_digital",
        recipe = {
            {
                "unilib:metal_gold_ingot",
                "unilib:item_triangulator_digital",
                "unilib:metal_gold_ingot",
            },
            {
                "unilib:item_compass_digital",
                "unilib:metal_bronze_ingot",
                "unilib:item_watch_digital",
            },
            {
                "unilib:metal_tin_ingot",
                "unilib:item_altimeter_digital",
                "unilib:metal_tin_ingot",
            },
        },
    })

end
