---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/pomegranate
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_pomegranate = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pomegranate.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_pomegranate.init()

    return {
        description = "Pomegranate",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_pomegranate.exec()

    unilib.register_node("unilib:fruit_pomegranate", "pomegranate:pomegranate", mode, {
        -- From pomegranate:pomegranate
        description = S("Pomegranate"),
        tiles = {"unilib_fruit_pomegranate.png"},
        -- N.B. no food_pomegranate in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_pomegranate = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_pomegranate.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16},
        },
        sunlight_propagates = true,
        walkable = false,

        -- N.B. No placer:is_player() check in original code
        after_place_node = function(pos, placer)

            if placer:is_player() then
                core.set_node(pos, {name = "unilib:fruit_pomegranate", param2 = 1})
            end

        end,

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_pomegranate", 2),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red",
            recipe = {
                {"unilib:fruit_pomegranate"},
            },
        })

    end

    unilib.register_craftitem("unilib:fruit_pomegranate_section", "pomegranate:section", mode, {
        -- From pomegranate:section
        description = S("Pomegranate Section"),
        inventory_image = "unilib_fruit_pomegranate_section.png",
        -- N.B. no food_pomegranate in original code
        groups = {flammable = 2, food = 2, food_pomegranate = 1},

        -- N.B. Replaced nonsensical value (a fruit section should not be more twelve times more
        --      nutritious than the whole fruit)
--      on_use = core.item_eat(3),
        on_use = unilib.cuisine.eat_on_use("unilib:fruit_pomegranate_section", 1),
    })
    unilib.register_craft({
        -- From pomegranate:section
        output = "unilib:fruit_pomegranate_section 4",
        recipe = {
            {"unilib:fruit_pomegranate"},
        },
    })

    unilib.register_juice({
        ingredient = "unilib:fruit_pomegranate",
        juice_description = S("Pomegranate"),
        juice_type = "pomegranate",
        rgb = "#b43121",

        orig_flag = false,
    })

end

function unilib.pkg.fruit_pomegranate.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_pomegranate",

        replace_mode = mode,
        leaves_list = {"unilib:tree_pomegranate_leaves"},
        pkg_list = {"tree_pomegranate"},
    })

end
