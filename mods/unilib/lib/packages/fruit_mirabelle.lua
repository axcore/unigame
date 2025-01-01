---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_mirabelle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_mirabelle.init()

    return {
        description = "Mirabelle fruit",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_mirabelle.exec()

    unilib.register_node("unilib:fruit_mirabelle", "lib_ecology:fruit_mirabelle", mode, {
        -- From GLEMr11, lib_ecology:fruit_mirabelle
        description = S("Mirabelle Fruit"),
        tiles = {"unilib_fruit_mirabelle.png"},
        -- N.B. no food_mirabelle in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_mirabelle = 1, leafdecay = 1,
            leafdecay_drop = 1,
        },
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        -- N.B. inventory_image not in original code
        inventory_image = "unilib_fruit_mirabelle.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.35, -0.5, -0.35, 0.35, 0.5, 0.35},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,

        -- N.B. No .after_place_node in original code
        after_place_node = function(pos, placer)

            if placer:is_player() then
                core.set_node(pos, {name = "unilib:fruit_mirabelle", param2 = 1})
            end

        end,

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_mirabelle", 3),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow",
            recipe = {
                {"unilib:fruit_mirabelle"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_mirabelle",
        juice_description = S("Mirabelle Fruit"),
        juice_type = "mirabelle",
        rgb = "#b40f39",

        orig_flag = false,
    })

end

function unilib.pkg.fruit_mirabelle.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_mirabelle",

        replace_mode = mode,
        leaves_list = {"unilib:tree_mirabelle_leaves"},
        pkg_list = {"tree_mirabelle"},
    })

end
