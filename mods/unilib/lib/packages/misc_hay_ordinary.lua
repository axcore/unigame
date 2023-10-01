---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_hay_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_hay_ordinary.init()

    return {
        description = "Hay",
        notes = "Dig turf with a pitchfork to create a hay mat, which can be crafted into" ..
                " hay piles and hay bales",
        depends = "item_string_ordinary",
    }

end

function unilib.pkg.misc_hay_ordinary.exec()

    unilib.register_node("unilib:misc_hay_ordinary_pile", "cottages:hay_mat", mode, {
        -- From cottages:hay_mat
        description = S("Pile of Hay"),
        tiles = {"unilib_misc_straw_ordinary.png^[multiply:#88BB88"},
        groups = {flammable = 3, hay = 3, oddly_breakable_by_hand = 2, snappy = 2},
        sounds = unilib.sound_table.leaves,

        drawtype = "nodebox",
        is_ground_content = false,
        -- Notes from cottages:
        -- The hay bale is slightly smaller than a full node
        node_box = {
            type = "leveled",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            }
        },
        paramtype2 = "leveled",

        -- Randomly vary the height of the hay (for aesthetics)
        after_place_node = function(pos, placer, itemstack, pointed_thing)

            minetest.swap_node(
                pos,
                {name = "unilib:misc_hay_ordinary_pile", param2 = math.random(2, 25)}
            )

        end,

        on_timer = function(pos, elapsed)

            local node = minetest.get_node(pos)
            if node and node.name == "unilib:misc_hay_ordinary_pile" then

                minetest.remove_node(pos)
                minetest.check_for_falling(pos)

            end

        end,
    })
    unilib.register_craft({
        -- From cottages:hay_mat
        output = "unilib:misc_hay_ordinary_pile 9",
        recipe = {
            {"unilib:misc_hay_ordinary"},
        },
    })

    unilib.register_node("unilib:misc_hay_ordinary", "cottages:hay", mode, {
        -- From cottages:hay
        description = S("Ordinary Hay"),
        tiles = {"unilib_misc_straw_ordinary.png^[multiply:#88BB88"},
        groups = {flammable = 3, hay = 3, oddly_breakable_by_hand = 2, snappy = 2},
        sounds = unilib.sound_table.leaves,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From cottages:hay
        output = "unilib:misc_hay_ordinary",
        ingredient = "unilib:misc_hay_ordinary_pile",
    })
    -- N.B. Not in original code, but added for consistency with "misc_reed_normal" package
    unilib.register_stairs("unilib:misc_hay_ordinary", {
        basic_flag = true,
    })

    unilib.register_node("unilib:misc_hay_ordinary_bale", "cottages:hay_bale", mode, {
        -- From cottages:hay_bale
        description = S("Ordinary Hay Bale"),
        tiles = {"unilib_misc_straw_ordinary_bale.png^[multiply:#88BB88"},
        groups = {flammable = 3, hay = 3, oddly_breakable_by_hand = 2, snappy = 2},
        sounds = unilib.sound_table.leaves,

        drawtype = "nodebox",
        is_ground_content = false,
        -- Notes from cottages:
        -- The hay bale is slightly smaller than a full node
        node_box = {
            type = "fixed",
            fixed = {
                {-0.45, -0.5, -0.45, 0.45, 0.45, 0.45},
            }
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.45, -0.5, -0.45, 0.45, 0.45, 0.45},
            }
        },
    })
    unilib.register_craft({
        -- From cottages:hay_bale
        output = "unilib:misc_hay_ordinary",
        recipe = {
            {"unilib:misc_hay_ordinary_bale"},
        },
    })
    -- N.B. Two craft recipes in the original code conflict with each other; temporary fix using
    --      string. When the original code is fixed, "item_string_ordinary" can be removed as a
    --      package dependency
    --[[
    unilib.register_craft({
        -- From cottages:hay_bale
        output = "unilib:misc_hay_ordinary_bale",
        recipe = {
            {"unilib:misc_hay_ordinary"},
        },
    })
    ]]--
    unilib.register_craft({
        -- From cottages:hay_bale
        output = "unilib:misc_hay_ordinary_bale",
        recipe = {
            {"unilib:misc_hay_ordinary", "unilib:item_string_ordinary"},
        },
    })

end
