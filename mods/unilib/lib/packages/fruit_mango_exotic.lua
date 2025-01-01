---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_mango_exotic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_mango_exotic.init()

    return {
        description = "Exotic mango",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_mango_exotic.exec()

    unilib.register_craftitem("unilib:fruit_mango_exotic", "fruit:mango", mode, {
        -- From farlands, fruit:mango
        description = S("Exotic Mango"),
        inventory_image = "unilib_fruit_mango_exotic.png",
        -- N.B. No groups in original code
        groups = {food_mango = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_mango_exotic", 2),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_orange",
            recipe = {
                {"unilib:fruit_mango_exotic"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_mango_exotic",
        juice_description = S("Mango"),
        juice_type = "mango",
        rgb = "#f4951a",

        orig_flag = false,
    })

    -- N.B. No call to unilib.register_regrowing_fruit(), as this fruit is implemented as an ore

end
