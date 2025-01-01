---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_carrot_gold = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_carrot_gold.init()

    return {
        description = "Golden carrot",
        depends = "metal_gold",
        suggested = {
            "produce_carrot_normal",            -- group:food_carrot
        },
    }

end

function unilib.pkg.food_carrot_gold.exec()

    unilib.register_craftitem("unilib:food_carrot_gold", "farming:carrot_gold", mode, {
        -- From farming:carrot_gold
        description = S("Golden Carrot"),
        inventory_image = "unilib_food_carrot_gold.png",
        -- N.B. No groups in original code
        groups = {food_carrot = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_carrot_gold", 10),
    })
    unilib.register_craft({
        -- From farming:carrot_gold
        output = "unilib:food_carrot_gold",
        recipe = {
            {"", "unilib:metal_gold_lump", ""},
            {"unilib:metal_gold_lump", "group:food_carrot", "unilib:metal_gold_lump"},
            {"", "unilib:metal_gold_lump", ""},
        },
    })

end
