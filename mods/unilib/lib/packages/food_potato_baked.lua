---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_potato_baked = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_potato_baked.init()

    return {
        description = "Baked potato",
        suggested = {
            "produce_potato_normal",            -- group:food_potato
        },
    }

end

function unilib.pkg.food_potato_baked.exec()

    unilib.register_craftitem("unilib:food_potato_baked", "farming:baked_potato", mode, {
        -- From farming:baked_potato
        description = S("Baked Potato"),
        inventory_image = "unilib_food_potato_baked.png",
        -- N.B. No groups in original code
        groups = {food_baked_potato = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_potato_baked", 6),
    })
    unilib.register_craft({
        -- From farming:baked_potato
        type = "cooking",
        output = "unilib:food_potato_baked",
        recipe = "group:food_potato",
        cooktime = 10,
    })

end
