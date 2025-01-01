---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/ebony
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_persimmon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ebony.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_persimmon.init()

    return {
        description = "Persimmon",
        notes = "Grows on ebony trees",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_persimmon.exec()

    unilib.register_node("unilib:fruit_persimmon", "ebony:persimmon", mode, {
        -- From ebony:persimmon
        description = S("Persimmon"),
        tiles = {"unilib_fruit_persimmon.png"},
        -- N.B. no food_persimmon in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_persimmon = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_persimmon.png",
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
                core.set_node(pos, {name = "unilib:fruit_persimmon", param2 = 1})
            end

        end,

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_persimmon", 4),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_orange",
            recipe = {
                {"unilib:fruit_persimmon"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_persimmon",
        juice_description = S("Persimmon"),
        juice_type = "persimmon",
        rgb = "#f77c01",

        orig_flag = false,
    })

end

function unilib.pkg.fruit_persimmon.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_persimmon",

        replace_mode = mode,
        leaves_list = {"unilib:tree_ebony_leaves"},
        pkg_list = {"tree_ebony"},
    })

end
