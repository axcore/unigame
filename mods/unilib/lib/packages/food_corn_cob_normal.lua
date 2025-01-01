---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_corn_cob_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_corn_cob_normal.init()

    return {
        description = "Normal Corn on the cob",
        suggested = {
            "produce_corn_normal",              -- group:food_corn
        },
    }

end

function unilib.pkg.food_corn_cob_normal.exec()

    unilib.register_craftitem("unilib:food_corn_cob_normal", "farming:corn_cob", mode, {
        -- From farming:corn_cob
        description = S("Normal Corn on the Cob"),
        inventory_image = "unilib_food_corn_cob_normal.png",
        -- N.B. food_corn_on_the_cob = 1 not in original code
        groups = {flammable = 2, food_corn_cooked = 1, food_corn_on_the_cob = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_corn_cob_normal", 5),
    })
    unilib.register_craft({
        -- From farming:corn_cob
        type = "cooking",
        output = "unilib:food_corn_cob_normal",
        recipe = "group:food_corn",
        cooktime = 10,
    })

end
