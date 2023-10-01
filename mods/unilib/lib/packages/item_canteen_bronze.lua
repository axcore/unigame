---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    thirsty
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_canteen_bronze = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.thirsty.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_canteen_bronze.init()

    return {
        description = "Bronze canteen",
        notes = "Stores water, in order for the player to increase their hydration. If" ..
                " hydration is not enabled, it does nothing. Bronze canteens have a larger" ..
                " capacity than steel canteens",
        depends = "metal_bronze",
    }

end

function unilib.pkg.item_canteen_bronze.exec()

    unilib.register_tool("unilib:item_canteen_bronze", "thirsty:bronze_canteen", mode, {
        -- From thirsty:bronze_canteen
        description = S("Bronze canteen"),
        inventory_image = "unilib_item_canteen_bronze.png",

        stack_max = 1,
    })
    unilib.register_craft({
        -- From thirsty:bronze_canteen
        output = "unilib:item_canteen_bronze",
        recipe = {
            {"group:wood", ""},
            {"unilib:metal_bronze_ingot", "unilib:metal_bronze_ingot"},
            {"unilib:metal_bronze_ingot", "unilib:metal_bronze_ingot"},
        },
    })
    unilib.hydration_enable_drinking_from_container("unilib:item_canteen_bronze", 25)
    unilib.hydration_enable_water_storage("unilib:item_canteen_bronze", 60)

end
