---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_blotchy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_blotchy.init()

    return {
        description = "Blotchy mushroom",
        notes = "This mushroom first appears in GLEMr4, but it is not placed as a decoration;" ..
                " however, code for that exists in the \"deco_glemr6\" package",
    }

end

function unilib.pkg.mushroom_blotchy.exec()

    unilib.register_node("unilib:mushroom_blotchy_trunk", "lib_ecology:mushroom_03_stem", mode, {
        -- From GLEMr4, lib_ecology:mushroom_03_stem
        description = S("Blotchy Mushroom Trunk"),
        tiles = {
            "unilib_tree_mushroom_generic_trunk_top.png",
            "unilib_tree_mushroom_generic_trunk_top.png",
            "unilib_mushroom_blotchy_trunk.png",
        },
        groups = {choppy = 2, flammable = 2, plant = 1, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        -- N.B. removed is_ground_content = false to match other mushrooms
--      is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
            },
        },
        paramtype = "light",
    })

    unilib.register_node("unilib:mushroom_blotchy_cap", "lib_ecology:mushroom_03_cap_giant", mode, {
        -- From GLEMr4, lib_ecology:mushroom_03_cap_giant
        description = S("Blotchy Mushroom Cap"),
        tiles = {
            "unilib_mushroom_blotchy_cap.png",
            "unilib_mushroom_blotchy_pore.png",
            "unilib_mushroom_blotchy_cap.png",
        },
        groups = {dig_immediate = 3, flammable = 2, fleshy = 1, leafdecay = 1, plant = 1},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. removed is_ground_content = false to match other mushrooms
--      is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.4, -0.5, -0.4, 0.4, 0.0, 0.4},
                {-0.75, -0.5, -0.4, -0.4, -0.25, 0.4},
                {0.4, -0.5, -0.4, 0.75, -0.25, 0.4},
                {-0.4, -0.5, -0.75, 0.4, -0.25, -0.4},
                {-0.4, -0.5, 0.4, 0.4, -0.25, 0.75},
            },
        },
        paramtype = "light",
    })

    unilib.register_node(
        -- From GLEMr4, lib_ecology:mushroom_03_cap_huge
        "unilib:mushroom_blotchy_cap_large",
        "lib_ecology:mushroom_03_cap_huge",
        mode,
        {
            description = S("Blotchy Mushroom Large Cap"),
            tiles = {
                "unilib_mushroom_blotchy_cap.png",
                "unilib_mushroom_blotchy_pore.png",
                "unilib_mushroom_blotchy_cap.png",
            },
            groups = {dig_immediate = 3, flammable = 2, fleshy = 1, leafdecay = 1, plant = 1},
            -- (no sounds)

            drawtype = "nodebox",
            -- N.B. removed is_ground_content = false to match other mushrooms
--          is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.33, 0.5, -0.33, 0.33},
                    {-0.33, -0.5, 0.33, 0.33, -0.33, 0.5},
                    {-0.33, -0.5, -0.33, 0.33, -0.33, -0.5},
                    {-0.33, -0.33, -0.33, 0.33, -0.17, 0.33},
                },
            },
            paramtype = "light",
        }
    )

    unilib.register_decoration_generic("glem_mushroom_blotchy", {
        -- From GLEMr4
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_glem_mushroom_blotchy.mts",

        fill_ratio = 0.01,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

    unilib.register_decoration_generic("glem_mushroom_blotchy_large", {
        -- From GLEMr4
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_glem_mushroom_blotchy_large.mts",

        fill_ratio = 0.01,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
