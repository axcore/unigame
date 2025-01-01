---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    thirsty
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_canteen_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.thirsty.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_canteen_steel.init()

    return {
        description = "Steel canteen",
        notes = "Stores water, in order for the player to increase their hydration. If" ..
                " hydration is not enabled, it does nothing",
        depends = "metal_steel",
    }

end

function unilib.pkg.item_canteen_steel.exec()

    unilib.register_tool("unilib:item_canteen_steel", "thirsty:steel_canteen", mode, {
        -- From thirsty:steel_canteen
        description = S("Steel canteen"),
        inventory_image = "unilib_item_canteen_steel.png",

        stack_max = 1,
    })
    unilib.register_craft({
        -- From thirsty:steel_canteen
        output = "unilib:item_canteen_steel",
        recipe = {
            {"group:wood", ""},
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
        },
    })
    unilib.hydration.enable_drinking_from_container("unilib:item_canteen_steel", 25)
    unilib.hydration.enable_water_storage("unilib:item_canteen_steel", 40)

end
