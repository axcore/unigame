---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_mirabelle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_mirabelle.init()

    return {
        description = "Mirabelle tree",
        notes = "Produces mirabelle fruit",
        depends = "fruit_mirabelle",
    }

end

function unilib.pkg.tree_mirabelle.exec()

    -- (no burnlevel)
    local sci_name = "Prunus domestica syriaca"

    unilib.register_tree({
        -- Original to unilib
        part_name = "mirabelle",
        description = S("Mirabelle Wood"),
    })

    unilib.register_tree_trunk({
        -- From lib_ecology:tree_mirabelle_trunk. Creates unilib:tree_mirabelle_trunk
        part_name = "mirabelle",
        orig_name = "lib_ecology:tree_mirabelle_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Mirabelle Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From lib_ecology:tree_mirabelle_wood. Creates unilib:tree_mirabelle_wood
        part_name = "mirabelle",
        orig_name = "lib_ecology:tree_mirabelle_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Mirabelle Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From lib_ecology:tree_mirabelle_leaves. Creates unilib:tree_mirabelle_leaves
        part_name = "mirabelle",
        orig_name = "lib_ecology:tree_mirabelle_leaves",

        replace_mode = mode,
        description = S("Mirabelle Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From lib_ecology:tree_mirabelle_leaves
        trunks = {"unilib:tree_mirabelle_trunk"},
        leaves = {"unilib:tree_mirabelle_leaves", "unilib:fruit_mirabelle"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From lib_ecology:tree_mirabelle_sapling. Creates unilib:tree_mirabelle_sapling
        part_name = "mirabelle",
        orig_name = "lib_ecology:tree_mirabelle_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Mirabelle Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 8, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_glem_tree_mirabelle_1", 2, 1, 2},
        },
        sci_name = sci_name,
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "mirabelle",

        replace_mode = mode,
        fence_description = S("Mirabelle Wood Fence"),
        gate_description = S("Mirabelle Wood Fence Rail"),
        rail_description = S("Mirabelle Wood Fence Gate"),
    })

    unilib.register_decoration("glem_tree_mirabelle_1", {
        -- Original to unilib
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_glem_tree_mirabelle_1.mts",

        fill_ratio = 0.005,
        flags = "place_center_x, place_center_z",
        rotation = "random",
        sidelen = 80,
    })

end
