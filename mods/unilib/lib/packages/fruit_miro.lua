---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_miro = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_miro.init()

    return {
        description = "Miro fruit",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_miro.exec()

    unilib.register_node("unilib:fruit_miro", "aotearoa:miro_fruit", mode, {
        -- From aotearoa:miro_fruit
        description = S("Miro Fruit"),
        tiles = {"unilib_fruit_miro.png"},
        -- N.B. no food_miro in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_miro = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.global.sound_table.node,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_miro.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, 0, -0.2, 0.2, 0.5, 0.2},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        wield_image = "unilib_fruit_miro.png",

        -- N.B. No standard .after_place_node for fruits, because of unsuitable texture

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_miro", 1),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_magenta",
            recipe = {
                {"unilib:fruit_miro"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_miro",
        juice_description = S("Miro Fruit"),
        juice_type = "miro",
        rgb = "#ffce00",

        orig_flag = false,
    })

end

function unilib.pkg.fruit_miro.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_miro",

        replace_mode = mode,
        leaves_list = {"unilib:tree_miro_leaves"},
        pkg_list = {"tree_miro"},
    })

end
