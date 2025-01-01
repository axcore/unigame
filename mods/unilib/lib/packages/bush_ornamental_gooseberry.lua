---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes_classic
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_ornamental_gooseberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bushes_classic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_ornamental_gooseberry.init()

    return {
        description = "Ornamental gooseberry bush",
        depends = {"bush_ornamental_fruitless", "shared_bushes_classic"},
    }

end

function unilib.pkg.bush_ornamental_gooseberry.exec()

    unilib.pkg.shared_bushes_classic.register_bush({
        -- From bushes:gooseberry_bush, provides unilib:bush_ornamental_gooseberry
        part_name = "gooseberry",
        orig_name = "bushes:gooseberry_bush",

        description = S("Ornamental Gooseberry Bush"),
    })

    unilib.pkg.shared_bushes_classic.register_berry({
        -- From bushes:gooseberry, provides unilib:fruit_gooseberry_picked
        part_name = "gooseberry",
        orig_name = "bushes:gooseberry",

        description = S("Picked Gooseberry"),
    })
    unilib.register_juice({
        ingredient = "unilib:fruit_gooseberry_picked",
        juice_description = S("Gooseberry"),
        juice_type = "gooseberry",
        rgb = "#9cf57c",

        orig_flag = true,
    })

    unilib.pkg.shared_bushes_classic.register_pie({
        -- Provides unilib:item_basket_with_pie_gooseberry, unilib:food_pie_gooseberry_cooked,
        --      unilib:food_pie_gooseberry_raw, unilib:food_pie_gooseberry_slice
        part_name = "gooseberry",
        basket_orig_name = "bushes:basket_gooseberry",
        cooked_orig_name = "bushes:gooseberry_pie_cooked",
        raw_orig_name = "bushes:gooseberry_pie_raw",
        slice_orig_name = "bushes:gooseberry_pie_slice",

        basket_description = S("Basket with Gooseberry Pies"),
        cooked_description = S("Cooked Gooseberry Pie"),
        raw_description = S("Raw Gooseberry Pie"),
        slice_description = S("Slice of Gooseberry Pie"),
    })

end
