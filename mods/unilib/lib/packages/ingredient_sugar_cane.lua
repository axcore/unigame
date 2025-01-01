---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_sugar_cane = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_sugar_cane.init()

    return {
        description = "Cane sugar",
        depends = {"ingredient_flour_ordinary", "plant_papyrus_ordinary", "produce_jute"},
    }

end

function unilib.pkg.ingredient_sugar_cane.exec()

    local c_jute = "unilib:produce_jute_harvest"
    local c_papyrus = "unilib:plant_papyrus_ordinary"

    -- N.B. Removed the .on_use() call to make this sugar non-edible, to match the sugar in the
    --      "ingredient_sugar_normal" package
    unilib.register_craftitem("unilib:ingredient_sugar_cane", "better_farming:sugar", mode, {
        -- From better_farming:sugar
        description = S("Cane Sugar"),
        inventory_image = "unilib_ingredient_sugar_cane.png",
        groups = {food_sugar = 1, flammable = 2},

--      on_use = unilib.cuisine.eat_on_use("unilib:ingredient_sugar_cane", 1),
    })
    -- N.B. The original code's two craft recipes look like an error, so here they are combined
    --      into one
    unilib.register_craft({
        -- From better_farming:sugar
        output = "unilib:ingredient_sugar_cane 3",
        recipe = {
            {c_papyrus, c_papyrus, c_papyrus},
            {c_papyrus, "unilib:ingredient_flour_ordinary", c_papyrus},
            {c_jute, c_jute, c_jute},
        },
    })

end
