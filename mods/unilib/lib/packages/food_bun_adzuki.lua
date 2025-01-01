---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bun_adzuki = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bun_adzuki.init()

    return {
        description = "Adzuki bean bun",
        depends = {"food_bread_gingerbread", "produce_bean_adzuki"},
    }

end

function unilib.pkg.food_bun_adzuki.exec()

    unilib.register_craftitem("unilib:food_bun_adzuki", "better_farming:adzuki_bun", mode, {
        -- From better_farming:adzuki_bun
        description = S("Adzuki Bean Bun"),
        inventory_image = "unilib_food_bun_adzuki.png",

        -- N.B. Original code used value of 1
        on_use = unilib.cuisine.eat_on_use("unilib:food_bun_adzuki", 2),
    })
    unilib.register_craft({
        -- From better_farming:adzuki_bun
        output = "unilib:food_bun_adzuki",
        recipe = {
            {"unilib:food_bread_gingerbread", "unilib:produce_bean_adzuki_harvest", ""},
        },
    })

end
