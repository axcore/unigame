---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes_classic
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_ornamental_blackberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bushes_classic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_ornamental_blackberry.init()

    return {
        description = "Ornamental blackberry bush",
        depends = {"bush_ornamental_fruitless", "shared_bushes_classic"},
    }

end

function unilib.pkg.bush_ornamental_blackberry.exec()

    unilib.pkg.shared_bushes_classic.register_bush({
        -- From bushes:blackberry_bush, provides unilib:bush_ornamental_blackberry
        part_name = "blackberry",
        orig_name = "bushes:blackberry_bush",

        description = S("Ornamental Blackberry Bush"),
    })

    unilib.pkg.shared_bushes_classic.register_berry({
        -- From bushes:blackberry, provides unilib:fruit_blackberry_picked
        part_name = "blackberry",
        orig_name = "bushes:blackberry",

        description = S("Picked Blackberry"),
    })
    unilib.register_juice({
        ingredient = "unilib:fruit_blackberry_picked",
        juice_description = S("Blackberry"),
        juice_type = "blackberry",
        rgb = "#581845",

        orig_flag = true,
    })

    unilib.pkg.shared_bushes_classic.register_pie({
        -- Provides unilib:item_basket_with_pie_blackberry, unilib:food_pie_blackberry_cooked,
        --      unilib:food_pie_blackberry_raw, unilib:food_pie_blackberry_slice
        part_name = "blackberry",
        basket_orig_name = "bushes:basket_blackberry",
        cooked_orig_name = "bushes:blackberry_pie_cooked",
        raw_orig_name = "bushes:blackberry_pie_raw",
        slice_orig_name = "bushes:blackberry_pie_slice",

        basket_description = S("Basket with Blackberry Pies"),
        cooked_description = S("Cooked Blackberry Pie"),
        raw_description = S("Raw Blackberry Pie"),
        slice_description = S("Slice of Blackberry Pie"),
    })

end
