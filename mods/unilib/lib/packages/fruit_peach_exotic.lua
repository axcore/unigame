---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_peach_exotic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_peach_exotic.init()

    return {
        description = "Exotic peach",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_peach_exotic.exec()

    unilib.register_craftitem("unilib:fruit_peach_exotic", "fruit:peach", mode, {
        -- From farlands, fruit:peach
        description = S("Exotic Peach"),
        inventory_image = "unilib_fruit_peach_exotic.png",
        -- N.B. No groups in original code
        groups = {food_peach = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_peach_exotic", 2),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red",
            recipe = {
                {"unilib:fruit_peach_exotic"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_peach_exotic",
        juice_description = S("Peach"),
        juice_type = "peach",
        rgb = "#e77749",

        orig_flag = false,
    })

    -- N.B. No call to unilib.register_regrowing_fruit(), as this fruit is implemented as an ore

end
