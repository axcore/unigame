---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_foil_kitchen = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_foil_kitchen.init()

    return {
        description = "Kitchen foil",
        depends = "metal_tin",
    }

end

function unilib.pkg.item_foil_kitchen.exec()

    unilib.register_craftitem("unilib:item_foil_kitchen", "bbq:foil", mode, {
        -- From bbq:foil
        description = S("Kitchen Foil"),
        inventory_image = "unilib_item_foil_kitchen.png",

        wield_image = "unilib_item_foil_kitchen.png",
    })
    unilib.register_craft({
        -- From bbq:foil
        output = "unilib:item_foil_kitchen",
        recipe = {
            {"", "", ""},
            {"", "", ""},
            {"unilib:metal_tin_ingot", "unilib:metal_tin_ingot", "unilib:metal_tin_ingot"}
        },
    })

end
