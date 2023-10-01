---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_corn_cob = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_corn_cob.init()

    return {
        description = "Corn on the cob",
        suggested = {
            "produce_corn_normal",              -- group:food_corn
        },
    }

end

function unilib.pkg.food_corn_cob.exec()

    unilib.register_craftitem("unilib:food_corn_cob", "farming:corn_cob", mode, {
        -- From farming:corn_cob
        description = S("Corn on the Cob"),
        inventory_image = "unilib_food_corn_cob.png",
        groups = {flammable = 2, food_corn_cooked = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_corn_cob", 5),
    })
    unilib.register_craft({
        -- From farming:corn_cob
        type = "cooking",
        output = "unilib:food_corn_cob",
        recipe = "group:food_corn",
        cooktime = 10,
    })

end
