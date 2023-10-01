---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_mirabelle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

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
        sounds = unilib.sound_table.leaves,

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

        on_use = unilib.cuisine_eat_on_use("unilib:fruit_mirabelle", 3),
    })
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow",
            recipe = {
                {"unilib:fruit_mirabelle"},
            },
        })

    end

end

function unilib.pkg.fruit_mirabelle.post()

    unilib.setup_regrowing_fruit({
        fruit_name = "unilib:fruit_mirabelle",

        replace_mode = mode,
        leaves_list = {"unilib:tree_mirabelle_leaves"},
        pkg_list = {"tree_mirabelle"},
    })

end
