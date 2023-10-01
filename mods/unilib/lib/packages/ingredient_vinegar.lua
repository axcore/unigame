---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_vinegar = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_vinegar.init()

    return {
        description = "Vinegar",
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.ingredient_vinegar.exec()

    unilib.register_node("unilib:ingredient_vinegar", "bbq:vinegar", mode, {
        -- From bbq:vinegar
        description = S("Vinegar"),
        tiles = {"unilib_ingredient_vinegar.png"},
        groups = {attached_node = 1, dig_immediate = 3, vessel = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_vinegar.png",
        paramtype = "light",
        paramtype2 = "facedir",
        wield_image = "unilib_ingredient_vinegar.png",
    })

    unilib.register_node("unilib:ingredient_vinegar_mother", "bbq:vinegar_mother", mode, {
        -- From bbq:vinegar_mother
        description = S("Vinegar Mother"),
        tiles = {"unilib_ingredient_vinegar_mother.png"},
        groups = {attached_node = 1, dig_immediate = 3, food_vinegarmother = 1, vessel = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_vinegar_mother.png",
        paramtype = "light",
        paramtype2 = "facedir",
        wield_image = "unilib_ingredient_vinegar_mother.png",
    })

end

function unilib.pkg.ingredient_vinegar.post()

    unilib.register_craft({
        -- From bbq:vinegar
        type = "shapeless",
        output = "unilib:ingredient_vinegar",
        recipe = {"group:food_vinegarmother", "group:food_sugar", "group:potable_bucket"},
        replacements = unilib.potable_bucket_list,
    })

end
