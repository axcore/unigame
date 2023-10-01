---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_karaka = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_karaka.init()

    return {
        description = "Karaka fruit",
        notes = "Karaka fruit is poisonous",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_karaka.exec()

    unilib.register_node("unilib:fruit_karaka", "aotearoa:karaka_fruit", mode, {
        -- From aotearoa:karaka_fruit
        description = S("Karaka Fruit"),
        tiles = {"unilib_fruit_karaka.png"},
        -- N.B. no food_karaka in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_karaka = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.sound_table.node,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_karaka.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, 0, -0.2, 0.2, 0.5, 0.2},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        wield_image = "unilib_fruit_karaka.png",

        -- N.B. No call to unilib.cuisine_eat_on_use(); checking food history doesn't matter for
        --      poisonous foods
        on_use = minetest.item_eat(-5),
    })
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_orange",
            recipe = {
                {"unilib:fruit_karaka"},
            },
        })

    end

end

function unilib.pkg.fruit_karaka.post()

    unilib.setup_regrowing_fruit({
        fruit_name = "unilib:fruit_karaka",

        replace_mode = mode,
        leaves_list = {"unilib:tree_karaka_leaves"},
        pkg_list = {"tree_karaka"},
    })

end
