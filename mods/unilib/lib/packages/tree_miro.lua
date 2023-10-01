---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_miro = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_miro.init()

    return {
        description = "Miro tree",
        notes = "Produces miro fruit",
        depends = "fruit_miro",
        optional = {"dye_basic", "torch_ordinary"},
    }

end

function unilib.pkg.tree_miro.exec()

    -- (no burnlevel)
    local sci_name = "Prumnopitys ferruginea"

    unilib.register_tree({
        -- Original to unilib
        part_name = "miro",
        description = S("Miro Wood"),
    })

    unilib.register_tree_trunk({
        -- From aotearoa:miro_tree. Creates unilib:tree_miro_trunk
        part_name = "miro",
        orig_name = "aotearoa:miro_tree",

        replace_mode = mode,
        description = S("Miro Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, tree = 1},
        sci_name = sci_name,
    })
    if unilib.pkg_executed_table["dye_basic"] ~= nil and
            unilib.pkg_executed_table["torch_ordinary"] ~= nil then

        -- Brown dye from Miro soot
        unilib.register_craft({
            -- From aotearoa:rimu_tree
            output = "unilib:dye_brown 4",
            recipe = {
                {"unilib:tree_miro_trunk"},
                {"unilib:torch_ordinary"},
            },
            replacements = {
                {"unilib:torch_ordinary", "unilib:torch_ordinary"},
            },
        })

    end

    unilib.register_tree_wood({
        -- From aotearoa:miro_wood. Creates unilib:tree_miro_wood
        part_name = "miro",
        orig_name = "aotearoa:miro_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Miro Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From aotearoa:miro_leaves. Creates unilib:tree_miro_leaves
        part_name = "miro",
        orig_name = "aotearoa:miro_leaves",

        replace_mode = mode,
        description = S("Miro Tree Leaves"),
        group_table = {flammable = 2, leaves = 1, leafdecay = 1, snappy = 3},
        sapling_rarity = 50,
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From aotearoa:miro_leaves
        trunks = {"unilib:tree_miro_trunk"},
        leaves = {"unilib:tree_miro_leaves", "unilib:fruit_miro"},
        radius = 2,
    })

    unilib.register_tree_sapling({
        -- From aotearoa:miro_sapling. Creates unilib:tree_miro_sapling
        part_name = "miro",
        orig_name = "aotearoa:miro_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Miro Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_miro_1", 7, 1, 7},
            {"unilib_tree_miro_2", 7, 1, 7},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From aotearoa:fence_miro_wood. Creates unilib:tree_miro_wood_fence
        part_name = "miro",
        orig_name = "aotearoa:fence_miro_wood",

        replace_mode = mode,
        base_img = "unilib_tree_miro_wood.png",
        description = S("Miro Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_miro_wood_fence_rail
        part_name = "miro",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_miro_wood.png",
        description = S("Miro Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_gate_quick({
        -- From aotearoa:gate_miro_wood. Creates unilib:gate_miro_closed
        part_name = "miro",
        orig_name = {"aotearoa:gate_miro_wood_closed", "aotearoa:gate_miro_wood_open"},

        replace_mode = mode,
        description = S("Miro Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    for i = 1, 2 do

        unilib.register_decoration("aotearoa_tree_miro_rare_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_miro_" .. i .. ".mts",

            fill_ratio = 0.00039,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end

end
