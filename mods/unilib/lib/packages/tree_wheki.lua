---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_wheki = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_wheki.init()

    return {
        description = "Wheki tree",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.tree_wheki.exec()

    -- (no burnlevel)
    local sci_name = "Dicksonia squarrosa"

    unilib.register_tree({
        -- Original to unilib
        part_name = "wheki",
        description = S("Wheki Wood"),

        not_super_flag = true,
    })

    unilib.register_node("unilib:tree_wheki_trunk", "aotearoa:wheki_tree", mode, {
        -- From aotearoa:wheki_tree
        description = unilib.annotate(S("Wheki Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_wheki_trunk_top.png",
            "unilib_tree_wheki_trunk_top.png",
            "unilib_tree_wheki_trunk.png",
        },
        groups = {
            attached_node=1, choppy = 3, flammable = 2, oddly_breakable_by_hand = 1, tree = 1,
        },
        sounds = unilib.sound_table.wood,

        climbable = true,
        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {-1/6, -1/2, -1/6, 1/6, 1/2, 1/6},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-1/6, -1/2, -1/6, 1/6, 1/2, 1/6},
        },
        use_texture_alpha = "clip",
    })
    if unilib.pkg_executed_table["item_stick_ordinary"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:wheki_tree
            output = "unilib:item_stick_ordinary 2",
            recipe = {
                {"unilib:tree_wheki_trunk"},
            }
        })

    end

    unilib.register_node("unilib:tree_wheki_trunk_skirt", "aotearoa:wheki_skirt", mode, {
        -- From aotearoa:wheki_skirt
        description = unilib.annotate(S("Wheki Tree Trunk Skirt"), sci_name),
        tiles = {
            "unilib_tree_wheki_trunk_skirt_top.png",
            "unilib_tree_wheki_trunk_skirt_top.png",
            "unilib_tree_wheki_trunk_skirt.png",
        },
        groups = {
            attached_node = 1, choppy = 3, flammable = 2, oddly_breakable_by_hand = 1, tree = 1,
        },
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        -- N.B. Drop the trunk, not the skirt
        drop = "unilib:tree_wheki_trunk",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {-1/3, -1/2, -1/3, 1/3, 1/2, 1/3},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-1/3, -1/2, -1/3, 1/3, 1/2, 1/3},
        },

        -- Collapse whole tree when cut
        after_destruct = function(pos, oldnode)

            local node = minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z})
            if node.name == "unilib:tree_wheki_trunk" then
                minetest.dig_node({x = pos.x, y = pos.y + 1, z = pos.z})
            end

        end,
    })

    -- (no wood)

    unilib.register_node("unilib:tree_wheki_crown", "aotearoa:wheki_crown", mode, {
        -- From aotearoa:wheki_crown
        description = unilib.annotate(S("Wheki Tree Crown"), sci_name),
        tiles = {"unilib_tree_wheki_crown.png"},
        groups = {attached_node = 1, flammable = 2, leaves = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_wheki_sapling"}, rarity = 3},
                {items = {"unilib:tree_wheki_crown"}},
            },
        },
        inventory_image = "unilib_tree_wheki_crown.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
        },
        sunlight_propagates = true,
        visual_scale = 2.5,
        walkable = false,
    })

    unilib.register_tree_sapling({
        -- From aotearoa:wheki_sapling. Creates unilib:tree_wheki_sapling
        part_name = "wheki",
        orig_name = "aotearoa:wheki_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Wheki Tree Spores"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_wheki_1", 0, 0, 0},
            {"unilib_tree_wheki_2", 0, 0, 0},
        },
        sci_name = sci_name,
        select_table = {-0.5, -0.5, -0.5,  0.5, -0.48, 0.5},
    })
    unilib.override_item("unilib:tree_wheki_sapling", {
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5,  0.5, -0.48, 0.5},
        },
        use_texture_alpha = "clip",
    })

    unilib.register_decoration("aotearoa_tree_wheki_clump_1", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_wheki_1.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.7,
            scale = 0.005,
            seed = 688807,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })
    unilib.register_decoration("aotearoa_tree_wheki_clump_2", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_wheki_2.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.7,
            scale = 0.005,
            seed = 564592,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })
    unilib.register_decoration("aotearoa_tree_wheki_dense_1", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_wheki_1.mts",

        fill_ratio = 0.1,
        flags = "place_center_x, place_center_z",
        rotation = "random",
        sidelen = 8,
    })
    unilib.register_decoration("aotearoa_tree_wheki_dense_2", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_wheki_2.mts",

        fill_ratio = 0.02,
        flags = "place_center_x, place_center_z",
        rotation = "random",
        sidelen = 8,
    })
    unilib.register_decoration("aotearoa_tree_wheki_crown", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:tree_wheki_crown",

        fill_ratio = 0.002,
        sidelen = 16,
    })

end
