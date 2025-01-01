---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_cabbage = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_cabbage.init()

    return {
        description = "Cabbage tree",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.tree_cabbage.exec()

    local burnlevel = 2
    local sci_name = "Cordyline australis"

    local node_box = {
        type = "fixed",
        fixed = {-1/6, -1/2, -1/6, 1/6, 1/2, 1/6},
    }

    unilib.register_tree({
        -- Original to unilib
        part_name = "cabbage",
        description = S("Cabbage Tree Wood"),

        not_super_flag = true,
        slim_flag = true,
    })

    unilib.register_node("unilib:tree_cabbage_trunk", "aotearoa:cabbage_tree_tree", mode, {
        -- From aotearoa:cabbage_tree_tree
        description = unilib.utils.annotate(S("Cabbage Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_cabbage_trunk_top.png",
            "unilib_tree_cabbage_trunk_top.png",
            "unilib_tree_cabbage_trunk.png",
        },
        -- N.B. Removed attached_node = 1, so that the trunk collapse function works as intended
        groups = {
--          attached_node = 1, choppy = 3, flammable = 2, oddly_breakable_by_hand = 1, tree = 1,
            choppy = 3, flammable = 2, oddly_breakable_by_hand = 1, tree = 1,
        },
        sounds = unilib.global.sound_table.wood,

        climbable = true,
        drawtype = "nodebox",
        is_ground_content = false,
        node_box = node_box,
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = node_box,
        use_texture_alpha = "clip",

        -- N.B. No .after_destruct in original code
        after_destruct = function(pos, oldnode)
            unilib.flora.collapse_slim_tree(pos, oldnode, {"unilib:tree_cabbage_trunk"})
        end,

        -- N.B. no .on_place in original code
        on_place = core.rotate_node,
    })
    if unilib.global.pkg_executed_table["item_stick_ordinary"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:cabbage_tree_tree
            output = "unilib:item_stick_ordinary 2",
            recipe = {
                {"unilib:tree_cabbage_trunk"},
            },
        })

    end

    unilib.register_tree_trunk_stripped({
        -- Original to unilib. Creates unilib:tree_cabbage_trunk_stripped
        part_name = "cabbage",
        orig_name = nil,

        replace_mode = mode,
        description = S("Cabbage Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        node_box = node_box,
    })

    -- (no wood)

    unilib.register_node("unilib:tree_cabbage_crown", "aotearoa:cabbage_tree_crown", mode, {
        -- From aotearoa:cabbage_tree_crown
        description = unilib.utils.annotate(S("Cabbage Tree Crown"), sci_name),
        tiles = {"unilib_tree_cabbage_crown.png"},
        groups = {attached_node = 1, flammable = 2, leaves = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_cabbage_sapling"}, rarity = 3},
                {items = {"unilib:tree_cabbage_crown"}},
            },
        },
        inventory_image = "unilib_tree_cabbage_crown.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
        },
        sunlight_propagates = true,
        visual_scale = 1.8,
        walkable = false,
    })

    unilib.register_tree_sapling({
        -- From aotearoa:cabbage_tree_sapling. Creates unilib:tree_cabbage_sapling
        part_name = "cabbage",
        orig_name = "aotearoa:cabbage_tree_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Cabbage Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_cabbage_1", 0, 0, 0},
            {"unilib_tree_cabbage_2", 0, 0, 0},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })
    unilib.override_item("unilib:tree_cabbage_sapling", {
        drawtype = "plantlike",
        node_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
        },
    })

    unilib.register_decoration_generic("aotearoa_tree_cabbage_clump_1", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_cabbage_1.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.7,
            scale = 0.005,
            seed = 60715,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })
    unilib.register_decoration_generic("aotearoa_tree_cabbage_clump_2", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_cabbage_2.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.7,
            scale = 0.005,
            seed = 238412,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })
    for i = 1, 2 do

        unilib.register_decoration_generic("aotearoa_tree_cabbage_rare_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_cabbage_" .. i .. ".mts",

            fill_ratio = 0.00039,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end
    unilib.register_decoration_generic("aotearoa_tree_cabbage_crown", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:tree_cabbage_crown",

        fill_ratio = 0.002,
        sidelen = 16,
    })

end
