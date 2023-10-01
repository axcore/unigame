---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.item_stick_iron = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_stick_iron.init()

    return {
        description = "Iron stick",
        depends = "metal_steel",
    }

end

function unilib.pkg.item_stick_iron.exec()

    unilib.register_craftitem("unilib:item_stick_iron", "darkage:iron_stick", mode, {
        -- From darkage:iron_stick
        description = S("Iron Stick"),
        inventory_image = "unilib_item_stick_iron.png",
    })
    unilib.register_craft({
        -- From darkage:iron_stick
        output = "unilib:item_stick_iron 4",
        recipe = {
            {"unilib:metal_steel_ingot"},
        }
    })

end
