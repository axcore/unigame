---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    orienteering
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.item_triangulator_digital = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.orienteering.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_triangulator_digital.init()

    return {
        description = "Digital triangulator",
        notes = "Displays position (X and Z coordinate)",
        depends = "metal_bronze",
    }

end

function unilib.pkg.item_triangulator_digital.exec()

    unilib.register_tool("unilib:item_triangulator_digital", "orienteering:triangulator", mode, {
        -- From orienteering:triangulator
        description = S("Digital Triangulator"),
        inventory_image = "unilib_item_triangulator_digital.png",
        groups = {disable_repair = 1},

        wield_image = "unilib_item_triangulator_digital.png",
    })
    unilib.register_craft({
        -- From orienteering:triangulator
        output = "unilib:item_triangulator_digital",
        recipe = {
            {"", "unilib:metal_bronze_ingot", ""},
            {"unilib:metal_bronze_ingot", "", "unilib:metal_bronze_ingot"},
        },
    })

end
