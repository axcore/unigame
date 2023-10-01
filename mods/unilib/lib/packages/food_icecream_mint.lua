---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_mint = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.icecream.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_mint.init()

    return {
        description = "Mint-flavoured ice cream",
        depends = {"crop_mint_normal", "food_cone_icecream", "snow_ordinary"},
        suggested = {
            "food_icecream",                    -- group:food_icecream_base
        },
    }

end

function unilib.pkg.food_icecream_mint.exec()

    local c_mint = "unilib:crop_mint_normal_harvest"

    unilib.register_craftitem("unilib:food_icecream_mint", "icecream:mint", mode, {
        -- From icecream:mint
        description = S("Mint-Flavoured Ice Cream"),
        inventory_image = "unilib_food_icecream_mint.png",
        groups = {food_icecream = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_icecream_mint", 12),
    })
    unilib.register_craft({
        -- From icecream:mint
        output = "unilib:food_icecream_mint",
        recipe = {
            {"unilib:snow_ordinary"},
            {c_mint},
            {"unilib:food_cone_icecream"},
        },
    })
    unilib.register_craft({
        -- Adapted from code in the "cheese" mod (in addition to, rather than replacing, the
        --      original craft recipe)
        output = "unilib:food_icecream_mint",
        recipe = {
            {c_mint, c_mint, c_mint},
            {"", "group:food_icecream_base", ""},
            {"", "unilib:food_cone_icecream", ""},
        },
    })

end
