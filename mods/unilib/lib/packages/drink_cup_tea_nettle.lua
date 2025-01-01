---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tea
-- Code:    LGPL v2.1
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_cup_tea_nettle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.tea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_cup_tea_nettle.init()

    return {
        description = "Cup of nettle leaf tea",
        depends = {"plant_nettle_normal", "torch_ordinary", "vessel_glass_empty"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
        },
    }

end

function unilib.pkg.drink_cup_tea_nettle.exec()

    unilib.register_craftitem("unilib:drink_cup_tea_nettle", nil, mode, {
        -- Texture from tea, t10.png. Original code
        description = S("Cup of Nettle Leaf Tea"),
        inventory_image = "unilib_drink_cup_tea_nettle.png",
        groups = {drink = 1, flammable = 4, food_tea = 1},

        on_use = unilib.cuisine.drink_on_use(
            "unilib:drink_cup_tea_nettle", 2, "unilib:vessel_glass_empty"
        ),
    })

end

function unilib.pkg.drink_cup_tea_nettle.post()

    local c_nettle = "unilib:plant_nettle_normal"

    local replace_list = unilib.utils.clone_simple_table(unilib.global.potable_bucket_list)
    table.insert(replace_list, {"unilib:torch_ordinary", "unilib:torch_ordinary"})

    unilib.register_craft({
        -- Original to unilib
        output = "unilib:drink_cup_tea_nettle",
        recipe = {
            {c_nettle, c_nettle, c_nettle},
            {"group:potable_bucket", "unilib:torch_ordinary", "unilib:vessel_glass_empty"},
        },
        replacements = replace_list,
    })

end
