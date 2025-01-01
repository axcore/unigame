---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_coconut = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_coconut.init()

    return {
        description = "Coconut",
        optional = {"dye_basic", "utensil_board_cutting"},
    }

end

function unilib.pkg.fruit_coconut.exec()

    -- The ethereal-ng coconut drops slices, but the moretrees coconut drops itself
    -- That is more convenient for food recipes using coconuts

    unilib.register_node("unilib:fruit_coconut", "ethereal:coconut", mode, {
        -- From ethereal:coconut
        description = S("Coconut"),
        tiles = {"unilib_fruit_coconut.png"},
        groups = {
            choppy = 1, cracky = 1, flammable = 1, food_coconut = 1, leafdecay = 3,
            leafdecay_drop = 1, oddly_breakable_by_hand = 1, snappy = 1,
        },
        sounds = unilib.global.sound_table.wood,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_coconut.png",
        -- N.B. is_ground_content = false not in original code; added to match other fruit
        is_ground_content = false,
        paramtype = "light",
        place_param2 = 1,
        selection_box = {
            type = "fixed",
            fixed = {-0.31, -0.43, -0.31, 0.31, 0.44, 0.31},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_fruit_coconut.png",
    })
    if unilib.global.pkg_executed_table["utensil_board_cutting"] ~= nil then

        -- N.B. Coconut slices fill the same role in craft recipes as "moretrees:raw_coconut"

        unilib.register_craftitem("unilib:fruit_coconut_slice", "ethereal:coconut_slice", mode, {
            -- From ethereal:coconut_slice
            description = S("Coconut Slice"),
            inventory_image = "unilib_fruit_coconut_slice.png",
            groups = {flammable = 2, food_coconut_slice = 1},

            wield_image = "unilib_fruit_coconut_slice.png",

            on_use = unilib.cuisine.eat_on_use("unilib:fruit_coconut_slice", 1),
        })
        unilib.register_craft({
            -- Original to unilib
            type = "shapeless",
            output = "unilib:fruit_coconut_slice 4",
            recipe = {"unilib:fruit_coconut", "group:food_cutting_board"},
            replacements = {
                {"group:food_cutting_board", "unilib:utensil_board_cutting"},
            },
        })
        -- If unilib:fruit_coconut drops itself, then the reverse recipe is no longer needed
        --[[
        unilib.register_craft({
            -- From ethereal:coconut_slice
            output = "unilib:fruit_coconut",
            recipe = {
                {"unilib:fruit_coconut_slice", "unilib:fruit_coconut_slice"},
                {"unilib:fruit_coconut_slice", "unilib:fruit_coconut_slice"},
            },
        })
        ]]--
        if unilib.setting.dye_from_fruit_flag and
                unilib.global.pkg_executed_table["dye_basic"] ~= nil then

            unilib.register_craft({
                -- Original to unilib
                output = "unilib:dye_white",
                recipe = {
                    {"unilib:fruit_coconut_slice"},
                },
            })

        end

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_coconut",
        juice_description = S("Coconut"),
        juice_type = "coconut",
        -- N.B. #FFFFFF in original code
        rgb = "#e8dadb",

        orig_flag = true,
    })
    unilib.juice.register_duplicate("coconut", "unilib:fruit_coconut_slice")

end

function unilib.pkg.fruit_coconut.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_coconut",

        replace_mode = mode,
        leaves_list = {"unilib:tree_palm_leaves", "unilib:tree_palm_caribbean_leaves"},
        pkg_list = {"tree_palm", "tree_palm_caribbean", "tree_palm_exposed"},
    })

end
