---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_mamaku = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_mamaku.init()

    return {
        description = "Mamaku tree",
        notes = "Mamaku tree crowns can be cooked to produce (edible) fiddlehead",
        optional = {"food_fiddlehead", "item_stick_ordinary"},
    }

end

function unilib.pkg.tree_mamaku.exec()

    -- (no burnlevel)
    local sci_name = "Cyathea medullaris"

    unilib.register_tree({
        -- Original to unilib
        part_name = "mamaku",
        description = S("Mamaku Wood"),

        not_super_flag = true,
    })

    unilib.register_node("unilib:tree_mamaku_trunk", "aotearoa:mamaku_tree", mode, {
        -- From aotearoa:mamaku_tree
        description = unilib.annotate(S("Mamaku Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_mamaku_trunk_top.png",
            "unilib_tree_mamaku_trunk_top.png",
            "unilib_tree_mamaku_trunk.png",
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
            -- From aotearoa:mamaku_tree
            output = "unilib:item_stick_ordinary 2",
            recipe = {
                {"unilib:tree_mamaku_trunk"},
            }
        })

    end

    -- (no wood)

    unilib.register_node("unilib:tree_mamaku_crown", "aotearoa:mamaku_crown", mode, {
        -- From aotearoa:mamaku_crown
        description = unilib.annotate(S("Mamaku Tree Crown"), sci_name),
        tiles = {"unilib_tree_mamaku_crown.png"},
        groups = {attached_node = 1, flammable = 2, leaves = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_mamaku_sapling"}, rarity = 3},
                {items = {"unilib:tree_mamaku_crown"}},
            },
        },
        inventory_image = "unilib_tree_mamaku_crown.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
        },
        sunlight_propagates = true,
        visual_scale = 3.5,
        walkable = false,
    })
    if unilib.pkg_executed_table["food_fiddlehead"] ~= nil then

        unilib.register_craft({
            -- From aotearoa_tree_mamaku_crown
            type = "cooking",
            output = "unilib:food_fiddlehead_cooked",
            recipe = "unilib:tree_mamaku_crown",
        })

    end

    unilib.register_tree_sapling({
        -- From aotearoa:mamaku_sapling. Creates unilib:tree_mamaku_sapling
        part_name = "mamaku",
        orig_name = "aotearoa:mamaku_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Mamaku Tree Spores"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_mamaku_1", 0, 0, 0},
            {"unilib_tree_mamaku_2", 0, 0, 0},
        },
        sci_name = sci_name,
        select_table = {-0.5, -0.5, -0.5,  0.5, -0.48, 0.5},
    })
    unilib.override_item("unilib:tree_mamaku_sapling", {
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5,  0.5, -0.48, 0.5},
        },
        use_texture_alpha = "clip",
    })

    unilib.register_decoration("aotearoa_tree_mamaku_clump_1", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_mamaku_1.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.7,
            scale = 0.005,
            seed = 4588017,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })
    unilib.register_decoration("aotearoa_tree_mamaku_clump_2", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_mamaku_2.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.7,
            scale = 0.005,
            seed = 8945192,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })
    unilib.register_decoration("aotearoa_tree_mamaku_crown", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:tree_mamaku_crown",

        fill_ratio = 0.002,
        sidelen = 16,
    })

end
