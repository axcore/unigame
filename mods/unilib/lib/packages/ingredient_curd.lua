---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_curd = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_curd.init()

    return {
        description = "Curd",
        optional = "food_cheese_toma",
    }

end

function unilib.pkg.ingredient_curd.exec()

    unilib.register_craftitem("unilib:ingredient_curd", "cheese:curd", mode, {
        -- From cheese:curd
        description = S("Curd"),
        inventory_image = "unilib_ingredient_curd.png",
        groups = {milk_product = 1},
    })

end

function unilib.pkg.ingredient_curd.post()

    -- Create cheese directly from curd (takes longer than the "correct" method using a cauldron)
    -- The recipes are grouped here for convenience, rather than (for example) placing the toma
    --      recipe in the "food_cheese_toma" package
    if unilib.global.pkg_executed_table["food_cheese_toma"] ~= nil then

        unilib.register_craft({
            -- From cheese:curd
            type = "cooking",
            output = "unilib:food_cheese_toma",
            recipe = "unilib:ingredient_curd",
            cooktime = 20,
        })

    end

    if core.get_modpath("mobs_animal") then

        unilib.register_craft({
            -- From cheese:curd
            type = "cooking",
            output = "mobs:cheese",
            recipe = "unilib:ingredient_curd",
            cooktime = 20,
        })

    end

    if core.get_modpath("petz") then

        unilib.register_craft({
            -- From cheese:curd
            type = "cooking",
            output = "petz:cheese",
            recipe = "unilib:ingredient_curd",
            cooktime = 20,
        })

    end

end
