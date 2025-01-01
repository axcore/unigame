---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_blueberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.icecream.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_blueberry.init()

    return {
        description = "Blueberry-flavoured ice cream",
        depends = {"food_cone_icecream", "snow_ordinary"},
        at_least_one = {"fruit_blueberry_ordinary", "produce_blueberry_highbush"},
        suggested = {
            "food_icecream",                    -- group:food_icecream_base
        },
    }

end

function unilib.pkg.food_icecream_blueberry.exec()

    unilib.register_craftitem("unilib:food_icecream_blueberry", "icecream:blueberries", mode, {
        -- From icecream:blueberries
        description = S("Blueberry-Flavoured Ice Cream"),
        inventory_image = "unilib_food_icecream_blueberry.png",
        groups = {food_icecream = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_icecream_blueberry", 6),
    })
    if unilib.global.pkg_executed_table["fruit_blueberry_ordinary"] ~= nil then

        local c_blueberry = "unilib:fruit_blueberry_ordinary"

        unilib.register_craft({
            -- From icecream:blueberries
            output = "unilib:food_icecream_blueberry",
            recipe = {
                {"unilib:snow_ordinary"},
                {c_blueberry},
                {"unilib:food_cone_icecream"},
            },
        })
        unilib.register_craft({
            -- Adapted from code in the "cheese" mod (in addition to, rather than replacing, the
            --      original craft recipe)
            output = "unilib:food_icecream_blueberry",
            recipe = {
                {c_blueberry, c_blueberry, c_blueberry},
                {"", "group:food_icecream_base", ""},
                {"", "unilib:food_cone_icecream", ""},
            },
        })

    end
    if unilib.global.pkg_executed_table["produce_blueberry_highbush"] ~= nil then

        local c_blueberry = "unilib:produce_blueberry_highbush_harvest"

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:food_icecream_blueberry",
            recipe = {
                {"unilib:snow_ordinary"},
                {c_blueberry},
                {"unilib:food_cone_icecream"},
            },
        })
        unilib.register_craft({
            -- Adapted from code in the "cheese" mod (in addition to, rather than replacing, the
            --      original craft recipe)
            output = "unilib:food_icecream_blueberry",
            recipe = {
                {c_blueberry, c_blueberry, c_blueberry},
                {"", "group:food_icecream_base", ""},
                {"", "unilib:food_cone_icecream", ""},
            },
        })

    end

end
