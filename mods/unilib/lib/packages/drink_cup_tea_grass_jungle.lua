---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tea
-- Code:    LGPL v2.1
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_cup_tea_grass_jungle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.tea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_cup_tea_grass_jungle.init()

    return {
        description = "Cup of jungle grass tea",
        depends = {"grass_jungle", "torch_ordinary", "vessel_glass_empty"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
        },
    }

end

function unilib.pkg.drink_cup_tea_grass_jungle.exec()

    unilib.register_craftitem("unilib:drink_cup_tea_grass_jungle", nil, mode, {
        -- Texture from tea, t6.png. Original code
        description = S("Cup of Jungle Grass Tea"),
        inventory_image = "unilib_drink_cup_tea_grass_jungle.png",
        groups = {drink = 1, flammable = 4, food_tea = 1},

        on_use = unilib.cuisine.drink_on_use(
            "unilib:drink_cup_tea_grass_jungle", 2, "unilib:vessel_glass_empty"
        ),
    })

end

function unilib.pkg.drink_cup_tea_grass_jungle.post()

    local c_grass = "unilib:grass_jungle"

    local replace_list = unilib.utils.clone_simple_table(unilib.global.potable_bucket_list)
    table.insert(replace_list, {"unilib:torch_ordinary", "unilib:torch_ordinary"})

    unilib.register_craft({
        -- Original to unilib
        output = "unilib:drink_cup_tea_grass_jungle",
        recipe = {
            {c_grass, c_grass, c_grass},
            {"group:potable_bucket", "unilib:torch_ordinary", "unilib:vessel_glass_empty"},
        },
        replacements = replace_list,
    })

end
