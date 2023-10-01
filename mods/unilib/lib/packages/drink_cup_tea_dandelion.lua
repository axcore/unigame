---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tea
-- Code:    LGPL v2.1
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_cup_tea_dandelion = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.tea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_cup_tea_dandelion.init()

    return {
        description = "Cup of dandelion leaf tea",
        depends = {"torch_ordinary", "vessel_glass_empty"},
        at_least_one = {"flower_dandelion_white", "flower_dandelion_yellow"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
        },
    }

end

function unilib.pkg.drink_cup_tea_dandelion.exec()

    unilib.register_craftitem("unilib:drink_cup_tea_dandelion", nil, mode, {
        -- Texture from tea, t1.png. Original code
        description = S("Cup of Dandelion Leaf Tea"),
        inventory_image = "unilib_drink_cup_tea_dandelion.png",
        groups = {drink = 1, flammable = 4, food_tea = 1},

        on_use = unilib.cuisine_drink_on_use(
            "unilib:drink_cup_tea_dandelion", 2, "unilib:vessel_glass_empty"
        ),
    })

end

function unilib.pkg.drink_cup_tea_dandelion.post()

    local replace_list = unilib.clone_simple_table(unilib.potable_bucket_list)
    table.insert(replace_list, {"unilib:torch_ordinary", "unilib:torch_ordinary"})

    for _, part_name in pairs({"white", "yellow"}) do

        local c_flower = "unilib:flower_dandelion_" .. part_name

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:drink_cup_tea_dandelion",
            recipe = {
                {c_flower, c_flower, c_flower},
                {"group:potable_bucket", "unilib:torch_ordinary", "unilib:vessel_glass_empty"},
            },
            replacements = replace_list,
        })

    end

end
