---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tea
-- Code:    LGPL v2.1
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_cup_tea_grass = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.tea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_cup_tea_grass.init()

    return {
        description = "Cup of grass tea",
        depends = {"grass_ordinary", "torch_ordinary", "vessel_glass_empty"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
        },
    }

end

function unilib.pkg.drink_cup_tea_grass.exec()

    unilib.register_craftitem("unilib:drink_cup_tea_grass", "tea:grass", mode, {
        -- From tea:grass
        description = S("Cup of Grass Tea"),
        inventory_image = "unilib_drink_cup_tea_grass.png",
        -- N.B. no drink/food_tea in original code; matches groups in "drink_cup_tea_mint" package
        groups = {drink = 1, flammable = 4, food_tea = 1},

        -- N.B. no .on_use() in original code; matches function in "drink_cup_tea_mint" package
        on_use = unilib.cuisine_drink_on_use(
            "unilib:drink_cup_tea_grass", 2, "unilib:vessel_glass_empty"
        ),
    })

end

function unilib.pkg.drink_cup_tea_grass.post()

    local c_grass = "unilib:grass_ordinary_1"

    local replace_list = unilib.clone_simple_table(unilib.potable_bucket_list)
    table.insert(replace_list, {"unilib:torch_ordinary", "unilib:torch_ordinary"})

    unilib.register_craft({
        -- From tea:grass, but adapted to match the craft recipe in the
        --      "drink_cup_tea_mint" package
        output = "unilib:drink_cup_tea_grass",
        recipe = {
            {c_grass, c_grass, c_grass},
            {"group:potable_bucket", "unilib:torch_ordinary", "unilib:vessel_glass_empty"},
        },
        replacements = replace_list,
    })

end
