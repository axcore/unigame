---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tea
-- Code:    LGPL v2.1
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_cup_tea_chrysanthemum = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.tea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_cup_tea_chrysanthemum.init()

    return {
        description = "Cup of chrysanthemum leaf tea",
        depends = {"flower_chrysanthemum_green", "torch_ordinary", "vessel_glass_empty"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
        },
    }

end

function unilib.pkg.drink_cup_tea_chrysanthemum.exec()

    unilib.register_craftitem("unilib:drink_cup_tea_chrysanthemum", "tea:chrysanthemum", mode, {
        -- From tea:chrysanthemum
        description = S("Cup of Chrysanthemum Leaf Tea"),
        inventory_image = "unilib_drink_cup_tea_chrysanthemum.png",
        -- N.B. no drink/food_tea in original code; matches groups in "drink_cup_tea_mint" package
        groups = {drink = 1, flammable = 4, food_tea = 1},

        -- N.B. no .on_use() in original code; matches function in "drink_cup_tea_mint" package
        on_use = unilib.cuisine_drink_on_use(
            "unilib:drink_cup_tea_chrysanthemum", 2, "unilib:vessel_glass_empty"
        ),
    })

end

function unilib.pkg.drink_cup_tea_chrysanthemum.post()

    local c_flower = "unilib:flower_chrysanthemum_green"

    local replace_list = unilib.clone_simple_table(unilib.potable_bucket_list)
    table.insert(replace_list, {"unilib:torch_ordinary", "unilib:torch_ordinary"})

    unilib.register_craft({
        -- From tea:chrysanthemum, but adapted to match the craft recipe in the
        --      "drink_cup_tea_mint" package
        output = "unilib:drink_cup_tea_chrysanthemum",
        recipe = {
            {c_flower, c_flower, c_flower},
            {"group:potable_bucket", "unilib:torch_ordinary", "unilib:vessel_glass_empty"},
        },
        replacements = replace_list,
    })

end
