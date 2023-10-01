---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_fern_yellow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_fern_yellow.init()

    return {
        description = "Yellow fern tree",
        notes = "This package provides nodes used by GLEM decoration packages; other nodes are" ..
                " provided by the \"tree_fern_giant\" and \"plant_shrub_banana_large\" packages." ..
                " There is no sapling; the tree must be spawned as a decoration schematic",
        depends = {"plant_shrub_banana_large", "tree_fern_giant"},
    }

end

function unilib.pkg.tree_fern_yellow.exec()

    unilib.register_node(
        -- From GLEMr4, lib_ecology:fern_giant_tree_leaves_2
        "unilib:tree_fern_yellow_crown_middle",
        "lib_ecology:fern_giant_tree_leaves_2",
        mode,
        {
            description = S("Yellow Fern Tree Crown"),
            tiles = {"unilib_tree_fern_yellow_crown_middle.png"},
            groups = {
                attached_node = 1, flammable = 2, leafdecay = 1, leaves = 1,
                not_in_creative_inventory = 1, snappy = 3,
            },
            sounds = unilib.sound_table.leaves,

            drawtype = "raillike",
            drop = "",
            paramtype = "light",
            walkable = false,
        }
    )

    unilib.register_node(
        -- From GLEMr4, lib_ecology:fern_giant_tree_leaves_end_2
        "unilib:tree_fern_yellow_crown_end",
        "lib_ecology:fern_giant_tree_leaves_end_2",
        mode,
        {
            description = S("Yellow Fern Tree Crown"),
            tiles = {"unilib_tree_fern_yellow_crown_end.png"},
            groups = {
                attached_node = 1, flammable = 2, leafdecay = 1, leaves = 1,
                not_in_creative_inventory = 1, snappy = 3,
            },
            sounds = unilib.sound_table.leaves,

            drawtype = "nodebox",
            drop = "",
            node_box = {
                type = "fixed",
                fixed = {-1/2, -1/2, 1/2, 1/2, 33/64, 1/2},
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-1/2, -1/2, 1/2, 1/2, 33/64, 1/2},
            },
            use_texture_alpha = "clip",
            walkable = false,
        }
    )

end
