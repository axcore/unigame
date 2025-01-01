---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_yeast = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_yeast.init()

    return {
        description = "Yeast",
        at_least_one = {"crop_cotton", "crop_wheat"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
        },
    }

end

function unilib.pkg.ingredient_yeast.exec()

    unilib.register_node("unilib:ingredient_yeast", "bbq:yeast", mode, {
        -- From bbq:yeast
        description = S("Yeast"),
        tiles = {"unilib_ingredient_yeast.png"},
        groups = {attached_node = 1, dig_immediate = 3, food_vinegarmother = 1, vessel = 1},
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_yeast.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
        wield_image = "unilib_ingredient_yeast.png",
    })

    -- Original mod's code modifies default grass and jungle grass to occasionally drop yeast; due
    --      to the complexity of the equivalent unilib code, continuing to do that isn't feasible
    -- Instead, manufacture yeast in this (unrealistic) way
    unilib.register_craft({
        -- Original to unilib
        type = "cooking",
        output = "unilib:ingredient_yeast",
        recipe = "unilib:ingredient_yeast_mixture",
        cooktime = 10,
    })

    unilib.register_craftitem("unilib:ingredient_yeast_mixture", nil, mode, {
        -- Original to unilib
        description = S("Yeast Mixture"),
        inventory_image = "unilib_ingredient_yeast_mixture.png",

        wield_image = "unilib_ingredient_yeast_mixture.png",
    })

end

function unilib.pkg.ingredient_yeast.post()

    if unilib.global.pkg_executed_table["crop_cotton"] ~= nil then

        local c_cotton = "unilib:crop_cotton_seed"

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:ingredient_yeast_mixture 3",
            recipe = {
                {c_cotton, "", c_cotton},
                {"", "group:potable_bucket", ""},
                {c_cotton, "", c_cotton},
            },
            replacements = unilib.global.potable_bucket_list,
        })

    end

    if unilib.global.pkg_executed_table["crop_wheat"] ~= nil then

        local c_wheat = "unilib:crop_wheat_seed"

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:ingredient_yeast_mixture 3",
            recipe = {
                {c_wheat, "", c_wheat},
                {"", "group:potable_bucket", ""},
                {c_wheat, "", c_wheat},
            },
            replacements = unilib.global.potable_bucket_list,
        })

    end

end
