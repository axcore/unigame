---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/plumtree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_plum = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.plumtree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_plum.init()

    return {
        description = "Plum",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_plum.exec()

    unilib.register_node("unilib:fruit_plum", "plumtree:plum", mode, {
        -- From plumtree:plum
        description = S("Plum"),
        tiles = {"unilib_fruit_plum.png"},
        -- N.B. no food_plum in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_plum = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_plum.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16},
        },
        sunlight_propagates = true,
        walkable = false,

        after_place_node = function(pos, placer, itemstack)
            minetest.set_node(pos, {name = "unilib:fruit_plum", param2 = 1})
        end,

        on_use = unilib.cuisine_eat_on_use("unilib:fruit_plum", 2),
    })
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_violet",
            recipe = {
                {"unilib:fruit_plum"},
            },
        })

    end

end

function unilib.pkg.fruit_plum.post()

    -- N.B. Standard unilib code for regrowing fruit replaces the cool_trees .on_dig() function
    unilib.setup_regrowing_fruit({
        fruit_name = "unilib:fruit_plum",

        replace_mode = mode,
        leaves_list = {"unilib:tree_plum_leaves"},
        pkg_list = {"tree_plum"},
    })

end
