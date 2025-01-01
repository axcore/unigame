---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes_classic
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_ornamental_strawberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bushes_classic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_ornamental_strawberry.init()

    return {
        description = "Ornamental strawberry bush",
        depends = {"bush_ornamental_fruitless", "shared_bushes_classic"},
    }

end

function unilib.pkg.bush_ornamental_strawberry.exec()

    unilib.pkg.shared_bushes_classic.register_bush({
        -- From bushes:strawberry_bush, provides unilib:bush_ornamental_strawberry
        part_name = "strawberry",
        orig_name = "bushes:strawberry_bush",

        description = S("Ornamental Strawberry Bush"),
    })

    unilib.pkg.shared_bushes_classic.register_berry({
        -- From bushes:strawberry, provides unilib:fruit_strawberry_picked
        part_name = "strawberry",
        orig_name = "bushes:strawberry",

        description = S("Picked Strawberry"),
    })
    unilib.register_juice({
        ingredient = "unilib:fruit_strawberry_picked",
        juice_description = S("Strawberry"),
        juice_type = "strawberry",
        rgb = "#ff3636",

        orig_flag = true,
    })

    unilib.pkg.shared_bushes_classic.register_pie({
        -- Provides unilib:item_basket_with_pie_strawberry, unilib:food_pie_strawberry_cooked,
        --      unilib:food_pie_strawberry_raw, unilib:food_pie_strawberry_slice
        part_name = "strawberry",
        basket_orig_name = "bushes:basket_strawberry",
        cooked_orig_name = "bushes:strawberry_pie_cooked",
        raw_orig_name = "bushes:strawberry_pie_raw",
        slice_orig_name = "bushes:strawberry_pie_slice",

        basket_description = S("Basket with Strawberry Pies"),
        cooked_description = S("Cooked Strawberry Pie"),
        raw_description = S("Raw Strawberry Pie"),
        slice_description = S("Slice of Strawberry Pie"),
    })

end
