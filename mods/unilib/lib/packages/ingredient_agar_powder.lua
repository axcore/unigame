---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_agar_powder = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_agar_powder.init()

    return {
        description = "Agar powder",
        notes = "An alternative to cornstarch for recipes requiring gelatin",
        depends = "torch_ordinary",
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
            "plant_seaweed_undersea",           -- group:food_seaweed
        },
    }

end

function unilib.pkg.ingredient_agar_powder.exec()

    unilib.register_craftitem("unilib:ingredient_agar_powder", "ethereal:agar_powder", mode, {
        -- From ethereal:agar_powder
        description = S("Agar Powder"),
        inventory_image = "unilib_ingredient_agar_powder.png",
        groups = {flammable = 2, food_gelatin = 1},
    })

end

function unilib.pkg.ingredient_agar_powder.post()

    local replace_list = {}
    for _, mini_list in pairs(unilib.potable_bucket_list) do
        table.insert(replace_list, {mini_list[1], mini_list[2] .. " 4"})
    end

    unilib.register_craft({
        -- From ethereal:agar_powder
        output = "unilib:ingredient_agar_powder 3",
        recipe = {
            {"group:food_seaweed", "group:food_seaweed", "group:food_seaweed"},
            {"group:potable_bucket", "group:potable_bucket", "unilib:torch_ordinary"},
            {"group:potable_bucket", "group:potable_bucket", "unilib:torch_ordinary"}
        },
        replacements = replace_list,
    })

end
