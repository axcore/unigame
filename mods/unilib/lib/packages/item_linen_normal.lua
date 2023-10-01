---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.item_linen_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_linen_normal.init()

    return {
        description = "Normal linen",
        notes = "Even in the original code, this item is not used to craft anything",
        optional = {"item_string_ordinary", "wool_basic"},
    }

end

function unilib.pkg.item_linen_normal.exec()

    unilib.register_craftitem("unilib:item_linen_normal", "cropocalypse:linen", mode, {
        -- From cropocalypse:linen
        description = S("Normal Linen"),
        inventory_image = "unilib_item_linen_normal.png",
        groups = {flammable = 1, linen = 1, thread = 1},
    })
    if unilib.pkg_executed_table["item_string_ordinary"] ~= nil then

        unilib.register_craft_2x2({
            -- From cropocalypse:linen
            output = "unilib:item_linen_normal",
            ingredient = "unilib:item_string_ordinary",
        })

    end
    if unilib.pkg_executed_table["wool_basic"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:linen
            type = "shapeless",
            output = "unilib:wool_white",
            recipe = {
                "unilib:item_linen_normal",
                "unilib:item_linen_normal",
                "unilib:item_linen_normal",
            },
        })

    end

end
