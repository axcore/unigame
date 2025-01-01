---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_kawakawa = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_kawakawa.init()

    return {
        description = "Kawakawa fruit",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_kawakawa.exec()

    unilib.register_node("unilib:fruit_kawakawa", "aotearoa:kawakawa_fruit", mode, {
        -- From aotearoa:kawakawa_fruit
        description = S("Kawakawa Fruit"),
        tiles = {"unilib_fruit_kawakawa.png"},
        -- N.B. no food_kawakawa in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_kawakawa = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.global.sound_table.node,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_kawakawa.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_fruit_kawakawa.png",
        visual_scale = 0.8,

        -- N.B. No standard .after_place_node for fruits, because of unsuitable texture

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_kawakawa", 1),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_orange",
            recipe = {
                {"unilib:fruit_kawakawa"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_kawakawa",
        juice_description = S("Kawakawa Fruit"),
        juice_type = "kawakawa",
        rgb = "#c66b00",

        orig_flag = false,
    })

end

function unilib.pkg.fruit_kawakawa.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_kawakawa",

        replace_mode = mode,
        leaves_list = {"unilib:tree_kawakawa_leaves"},
        pkg_list = {"tree_kawakawa"},
    })

end
