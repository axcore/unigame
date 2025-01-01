---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_palm_exotic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_palm_exotic.init()

    return {
        description = "Exotic palm tree",
        depends = "fruit_coconut_exotic",
        optional = {
            -- If the "ore_farlands_tree_palm_exotic" package is not loaded, then the shared package
            --      will use an ABM to place leaves-with-fruit nodes instead
            "abm_farlands_bushes_trees",
            -- Create fruit-as-node variants for use in schematics
            "shared_farlands_fruit",
        },
    }

end

function unilib.pkg.tree_palm_exotic.exec()

    -- N.B. throughout this package, original node names are ignored when they use a mod name (e.g.
    --      default, doors) that's also used by minetest_game

    local burnlevel = 2
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "palm_exotic",
        description = S("Exotic Palm Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From farlands, mapgen:palm_tree. Creates unilib:tree_palm_exotic_trunk
        part_name = "palm_exotic",
        orig_name = "mapgen:palm_tree",

        replace_mode = mode,
        description = S("Exotic Palm Tree Trunk"),
        group_table = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 1, tree = 1},
    })

    unilib.register_tree_wood({
        -- From farlands, mapgen:palm_wood. Creates unilib:tree_palm_exotic_wood
        part_name = "palm_exotic",
        orig_name = "mapgen:palm_wood",

        replace_mode = mode,
        description = S("Exotic Palm Tree Wood Planks"),
        group_table = {choppy = 1, flammable = 1, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From farlands, mapgen:palm_leaves. Creates unilib:tree_palm_exotic_leaves
        part_name = "palm_exotic",
        orig_name = "mapgen:palm_leaves",

        replace_mode = mode,
        description = S("Exotic Palm Tree Leaves"),
        group_table = {flammable = 1, leafdecay = 1, leaves = 1, snappy = 3},
        special_list = {"unilib_tree_palm_exotic_leaves_simple.png"},
    })
    -- (unilib.register_leafdecay() occurs below)

    unilib.register_node(
        -- From farlands, fruit:palm_leaves_coconut
        "unilib:tree_palm_exotic_leaves_with_coconut",
        "fruit:palm_leaves_coconut",
        mode,
        {
            description = S("Exotic Palm Tree Leaves with Coconuts"),
            tiles = {"unilib_tree_palm_exotic_leaves_with_coconut.png"},
            -- N.B. added not_in_creative_inventory for consistency with other farlands stuff
            groups = {
                flammable = 1, leafdecay = 3, leaves = 1, not_in_creative_inventory = 1, snappy = 2,
            },
            sounds = unilib.global.sound_table.leaves,

            drawtype = "allfaces_optional",
            -- N.B. is_ground_content = false not in original code; added to match other leaves
            is_ground_content = false,
            paramtype = "light",
            special_tiles = {"unilib_tree_palm_exotic_leaves_with_coconut.png"},
            waving = 1,

            on_destruct = function(pos, oldnode)
                core.add_item(pos, "unilib:fruit_coconut_exotic")
            end,

            on_rightclick = function(pos)
                core.set_node(pos, {name = "unilib:tree_palm_exotic_leaves"})
            end,
        }
    )

    if unilib.global.pkg_executed_table["shared_farlands_fruit"] ~= nil then

        -- Create the fruit-as-node variant for use in schematics, unilib:fruit_coconut_exotic_node
        unilib.pkg.shared_farlands_fruit.create_fruit_nodes("coconut", "food_coconut")

    end

    unilib.register_leafdecay({
        -- From farlands, mapgen:palm_leaves
        trunk_type = "palm_exotic",
        trunks = {"unilib:tree_palm_exotic_trunk"},
        leaves = {"unilib:tree_palm_exotic_leaves", "unilib:tree_palm_exotic_leaves_with_coconut"},
        -- N.B. required if the "shared_farlands_fruit" package is loaded
        others = {"unilib:fruit_coconut_exotic_node"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From farlands, default:palmtree_sapling. Creates unilib:tree_palm_exotic_sapling
        part_name = "palm_exotic",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Exotic Palm Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 15, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {3, 1, 3},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From farlands, mapgen:fence_palm_wood. Creates unilib:tree_palm_exotic_wood_fence
        part_name = "palm_exotic",
        orig_name = "mapgen:fence_palm_wood",

        replace_mode = mode,
        -- N.B. farlands provides a separate texture, but it's identical to the wood
        base_img = "unilib_tree_palm_exotic_wood.png",
        description = S("Exotic Palm Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_palm_exotic_wood_fence_rail
        part_name = "palm_exotic",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_palm_exotic_wood.png",
        description = S("Exotic Palm Tree Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_palm_exotic_closed, etc
        part_name = "palm_exotic",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Exotic Palm Tree Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("farlands_tree_palm_exotic_" .. i, {
            -- From farlands, mapgen/mapgen.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_palm_exotic.mts",

            flags = "place_center_x, place_center_z",
            noise_params = {
                octaves = 3,
                offset = 0.002,
                persist = 0.66,
                scale = 0.001,
                seed = 2,
                spread = {x = 250, y = 250, z = 250},
            },
            sidelen = 16,
        })

    end

end

function unilib.pkg.tree_palm_exotic.post()

    if unilib.global.pkg_executed_table["shared_farlands_fruit"] ~= nil then

        unilib.register_regrowing_fruit({
            fruit_name = "unilib:fruit_coconut_exotic_node",

            replace_mode = mode,
            leaves_list = {"unilib:tree_palm_exotic_leaves"},
            pkg_list = {"tree_palm_exotic"},
        })

    end

end
