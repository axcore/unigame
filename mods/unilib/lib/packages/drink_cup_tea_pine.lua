---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tea
-- Code:    LGPL v2.1
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_cup_tea_pine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.tea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_cup_tea_pine.init()

    return {
        description = "Cup of pine needle tea",
        depends = {"torch_ordinary", "tree_pine", "vessel_glass_empty"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
        },
    }

end

function unilib.pkg.drink_cup_tea_pine.exec()

    unilib.register_craftitem("unilib:drink_cup_tea_pine", nil, mode, {
        -- Texture from tea, t3.png. Original code
        description = S("Cup of Pine Needle Tea"),
        inventory_image = "unilib_drink_cup_tea_pine.png",
        groups = {drink = 1, flammable = 4, food_tea = 1},

        on_use = unilib.cuisine_drink_on_use(
            "unilib:drink_cup_tea_pine", 2, "unilib:vessel_glass_empty"
        ),
    })

end

function unilib.pkg.drink_cup_tea_pine.post()

    local c_leaves = "unilib:tree_pine_leaves"

    local replace_list = unilib.clone_simple_table(unilib.potable_bucket_list)
    table.insert(replace_list, {"unilib:torch_ordinary", "unilib:torch_ordinary"})

    unilib.register_craft({
        -- Original to unilib
        output = "unilib:drink_cup_tea_pine",
        recipe = {
            {c_leaves, c_leaves, c_leaves},
            {"group:potable_bucket", "unilib:torch_ordinary", "unilib:vessel_glass_empty"},
        },
        replacements = replace_list,
    })

end
