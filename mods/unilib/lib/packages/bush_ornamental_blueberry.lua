---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes_classic
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_ornamental_blueberry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bushes_classic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_ornamental_blueberry.init()

    return {
        description = "Ornamental blueberry bush",
        notes = "The \"picked\" blueberries from this bush are supposed to be the same as" ..
                " ordinary blueberries (from the \"fruit_blueberry_ordinary\" package), but" ..
                " just one, rather than a bunch",
        depends = {"bush_ornamental_fruitless", "shared_bushes_classic"},
        optional = "fruit_blueberry_ordinary",
    }

end

function unilib.pkg.bush_ornamental_blueberry.exec()

    unilib.pkg.shared_bushes_classic.register_bush({
        -- From bushes:blueberry_bush, provides unilib:bush_ornamental_blueberry
        part_name = "blueberry",
        orig_name = "bushes:blueberry_bush",

        description = S("Ornamental Blueberry Bush"),
    })

    unilib.pkg.shared_bushes_classic.register_berry({
        -- From bushes:blueberry, provides unilib:fruit_blueberry_picked
        part_name = "blueberry",
        orig_name = "bushes:blueberry",

        description = S("Picked Blueberry"),
    })
    if unilib.pkg_executed_table["fruit_blueberry_ordinary"] == nil then

        -- (The "fruit_blueberry_ordinary", if available, package already creates blueberry juice)
        unilib.register_juice({
            ingredient = "unilib:fruit_blueberry_picked",
            juice_description = S("Blueberry"),
            juice_type = "blueberry",
            rgb = "#521dcb",
            orig_flag = true,
        })

    else

        -- N.B. This original recipe cements the idea that both blueberry bushes produce "ordinary"
        --      blueberries
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:fruit_blueberry_picked 2",
            recipe = {
                {"unilib:fruit_blueberry_ordinary"},
            },
        })

    end

    unilib.pkg.shared_bushes_classic.register_pie({
        -- Provides unilib:item_basket_with_pie_blueberry, unilib:food_pie_blueberry_cooked,
        --      unilib:food_pie_blueberry_raw, unilib:food_pie_blueberry_slice
        part_name = "blueberry",
        basket_orig_name = "bushes:basket_blueberry",
        cooked_orig_name = "bushes:blueberry_pie_cooked",
        raw_orig_name = "bushes:blueberry_pie_raw",
        slice_orig_name = "bushes:blueberry_pie_slice",

        basket_description = S("Basket with Blueberry Pies"),
        cooked_description = S("Cooked Blueberry Pie"),
        raw_description = S("Raw Blueberry Pie"),
        slice_description = S("Slice of Blueberry Pie"),
    })

end
