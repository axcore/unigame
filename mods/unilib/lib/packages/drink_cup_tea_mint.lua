---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_cup_tea_mint = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_cup_tea_mint.init()

    return {
        description = "Cup of mint tea",
        depends = {"utensil_press_hand", "vessel_glass_empty"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
            "crop_mint_normal",                 -- group:food_mint
        },
    }

end

function unilib.pkg.drink_cup_tea_mint.exec()

    unilib.register_craftitem("unilib:drink_cup_tea_mint", "farming:mint_tea", mode, {
        -- From farming:mint_tea
        description = S("Cup of Mint Tea"),
        inventory_image = "unilib_drink_cup_tea_mint.png",
        -- N.B. no drink/food_tea in original code
        groups = {drink = 1, flammable = 4, food_tea = 1},

        on_use = unilib.cuisine.drink_on_use(
            "unilib:drink_cup_tea_mint", 2, "unilib:vessel_glass_empty"
        ),
    })

end

function unilib.pkg.drink_cup_tea_mint.post()

    local c_mint = "group:food_mint"

    unilib.register_craft({
        -- From farming:mint_tea
        output = "unilib:drink_cup_tea_mint",
        recipe = {
            {c_mint, c_mint, c_mint},
            {"group:potable_bucket", "unilib:utensil_press_hand", "unilib:vessel_glass_empty"},
        },
        replacements = unilib.global.potable_bucket_list,
    })

end
