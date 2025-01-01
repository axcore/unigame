---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes_classic
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_ornamental_raspberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bushes_classic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_ornamental_raspberry.init()

    return {
        description = "Ornamental raspberry bush",
        depends = {"bush_ornamental_fruitless", "shared_bushes_classic"},
    }

end

function unilib.pkg.bush_ornamental_raspberry.exec()

    unilib.pkg.shared_bushes_classic.register_bush({
        -- From bushes:raspberry_bush, provides unilib:bush_ornamental_raspberry
        part_name = "raspberry",
        orig_name = "bushes:raspberry_bush",

        description = S("Ornamental Raspberry Bush"),
    })

    unilib.pkg.shared_bushes_classic.register_berry({
        -- From bushes:raspberry, provides unilib:fruit_raspberry_picked
        part_name = "raspberry",
        orig_name = "bushes:raspberry",

        description = S("Picked Raspberry"),
    })
    unilib.register_juice({
        ingredient = "unilib:fruit_raspberry_picked",
        juice_description = S("Raspberry"),
        juice_type = "raspberry",
        rgb = "#c70039",

        orig_flag = true,
    })

    unilib.pkg.shared_bushes_classic.register_pie({
        -- Provides unilib:item_basket_with_pie_raspberry, unilib:food_pie_raspberry_cooked,
        --      unilib:food_pie_raspberry_raw, unilib:food_pie_raspberry_slice
        part_name = "raspberry",
        basket_orig_name = "bushes:basket_raspberry",
        cooked_orig_name = "bushes:raspberry_pie_cooked",
        raw_orig_name = "bushes:raspberry_pie_raw",
        slice_orig_name = "bushes:raspberry_pie_slice",

        basket_description = S("Basket with Raspberry Pies"),
        cooked_description = S("Cooked Raspberry Pie"),
        raw_description = S("Raw Raspberry Pie"),
        slice_description = S("Slice of Raspberry Pie"),
    })

end
