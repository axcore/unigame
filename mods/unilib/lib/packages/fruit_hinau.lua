---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_hinau = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_hinau.init()

    return {
        description = "Hinau fruit",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_hinau.exec()

    unilib.register_node("unilib:fruit_hinau", "aotearoa:hinau_fruit", mode, {
        -- From aotearoa:hinau_fruit
        description = S("Hinau Fruit"),
        tiles = {"unilib_fruit_hinau.png"},
        -- N.B. no food_hinau in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_hinau = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.global.sound_table.node,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_hinau.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, 0, -0.2, 0.2, 0.5, 0.2},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        wield_image = "unilib_fruit_hinau.png",

        -- N.B. No standard .after_place_node for fruits, because of unsuitable texture

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_hinau", 1),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_black",
            recipe = {
                {"unilib:fruit_hinau"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_hinau",
        juice_description = S("Hinau Fruit"),
        juice_type = "hinau",
        rgb = "#200b2f",

        orig_flag = false,
    })

end

function unilib.pkg.fruit_hinau.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_hinau",

        replace_mode = mode,
        leaves_list = {"unilib:tree_hinau_leaves"},
        pkg_list = {"tree_hinau"},
    })

end
