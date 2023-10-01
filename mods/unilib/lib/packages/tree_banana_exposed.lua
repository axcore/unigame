---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_banana_exposed = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_banana_exposed.init()

    return {
        description = "Exposed banana tree",
    }

end

function unilib.pkg.tree_banana_exposed.exec()

    -- (no burnlevel)
    local sci_name = "Musa"

    unilib.register_tree({
        -- Original to unilib
        part_name = "banana_exposed",
        description = S("Exposed Banana Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_banana_02_trunk. Creates unilib:tree_banana_exposed_trunk
        part_name = "banana_exposed",
        orig_name = "lib_ecology:tree_banana_02_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Exposed Banana Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_banana_02_wood. Creates unilib:tree_banana_exposed_wood
        part_name = "banana_exposed",
        orig_name = "lib_ecology:tree_banana_02_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Exposed Banana Tree Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_banana_02_leaves. Creates unilib:tree_banana_exposed_leaves
        part_name = "banana_exposed",
        orig_name = "lib_ecology:tree_banana_02_leaves",

        replace_mode = mode,
        description = S("Exposed Banana Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("banana_exposed")

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_banana_02_sapling. Creates
        --      unilib:tree_banana_exposed_sapling
        part_name = "banana_exposed",
        orig_name = "lib_ecology:tree_banana_02_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Exposed Banana Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 6, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        -- N.B. GLEMr4 does not provide a schematic, so hijack the one from ethereal
--      offset_list = {2, 1, 2},
        schem_list = {
            {"unilib_tree_banana", 2, 1, 2},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},

        -- N.B. Also hijack its replacement table
        replace_func = function(pos)

            local replace_table = {
                {"unilib:tree_banana_trunk", "unilib:tree_banana_exposed_trunk"},
                {"unilib:tree_banana_leaves", "unilib:tree_banana_exposed_leaves"},
            }

            if math.random(3) == 1 and
                    minetest.find_node_near(pos, 1, {"unilib:soil_ordinary_wet"}) then

                -- When growing near water, the tree has bunches, rather than single bananas
                table.insert(replace_table, {"unilib:fruit_banana", "unilib:fruit_banana_bunch"})

            end

            return replace_table

        end,
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "banana_exposed",

        replace_mode = mode,
        fence_description = S("Exposed Banana Tree Wood Fence"),
        gate_description = S("Exposed Banana Tree Wood Fence Rail"),
        rail_description = S("Exposed Banana Tree Wood Fence Gate"),
    })

    -- N.B. GLEMr4 does not provide a schematic, so hijack the one from ethereal again
    unilib.register_decoration("glem_tree_banana_exposed", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_banana.mts",

        fill_ratio = 0.015,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
