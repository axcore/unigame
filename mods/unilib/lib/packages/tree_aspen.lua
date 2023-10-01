---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    doors
-- Code:    MIT
-- Media:   CC BY-SA 3.0
--
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_aspen = {}

local S = unilib.intllib
local default_add_mode = unilib.imported_mod_table.default.add_mode
local doors_add_mode = unilib.imported_mod_table.doors.add_mode
local moreblocks_add_mode = unilib.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_aspen.init()

    return {
        description = "Aspen tree",
        notes = "Code in this package can be used as a basis for all other tree packages. For" ..
                " comparison, the package includes both calls to shared functions (used by" ..
                " most tree packages), as well as the equivalent code from default (but" ..
                " simplified a little)",
        optional = {"mushroom_brown", "mushroom_red"},
    }

end

function unilib.pkg.tree_aspen.exec()

    local burnlevel = 1
    local sci_name = "Populus tremula"

    unilib.register_tree({
        -- Original to unilib
        part_name = "aspen",
        description = S("Aspen Wood"),

        burnlevel = burnlevel,
    })

    --[[
    minetest.register_node("default:aspen_tree", {
        -- From default:aspen_tree
        description = S("Aspen Trunk"),
        tiles = {
            "default_aspen_tree_top.png",
            "default_aspen_tree_top.png",
            "default_aspen_tree.png",
        },
        groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 1, tree = 1},
        sounds = default.node_sound_wood_defaults(),

        is_ground_content = false,
        paramtype2 = "facedir",

        on_place = minetest.rotate_node,
    })
    minetest.register_craft({
        -- From default:aspen_tree
        type = "fuel",
        recipe = "default:aspen_tree",
        burntime = 22,
    })
    ]]--
    unilib.register_tree_trunk({
        -- From default:aspen_tree. Creates unilib:tree_aspen_trunk
        part_name = "aspen",
        orig_name = "default:aspen_tree",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        common_group = 3,
        description = S("Aspen Tree Trunk"),
        sci_name = sci_name,
        strip_flag = true,
    })

    --[[
    minetest.register_node("default:aspen_wood", {
        -- From default:aspen_wood
        description = S("Aspen Wood Planks"),
        tiles = {"default_aspen_wood.png"},
        groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
        sounds = default.node_sound_wood_defaults(),

        is_ground_content = false,
        paramtype2 = "facedir",
        place_param2 = 0,
    })
    minetest.register_craft({
        -- From default:aspen_wood
        output = "default:aspen_wood 4",
        recipe = {
            {"default:aspen_tree"},
        }
    })
    minetest.register_craft({
        -- From default:aspen_wood
        type = "fuel",
        recipe = "default:aspen_wood",
        burntime = 5,
    })
    my_register_stair_and_slab(
        -- From default:aspen_wood
        "aspen_wood",
        "default:aspen_wood",
        {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
        {"default_aspen_wood.png"},
        "Aspen Wood Stair",
        "Aspen Wood Slab",
        default.node_sound_wood_defaults(),
        false
    )
    ]]--
    unilib.register_tree_wood({
        -- From default:aspen_wood. Creates unilib:tree_aspen_wood
        part_name = "aspen",
        orig_name = "default:aspen_wood",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        common_group = 3,
        description = S("Aspen Wood Planks"),
    })

    --[[
    minetest.register_node("default:aspen_leaves", {
        -- From default:aspen_leaves
        description = S("Aspen Tree Leaves"),
        tiles = {"default_aspen_leaves.png"},
        groups = {flammable = 2, leafdecay = 3, leaves = 1, snappy = 3},
        sounds = default.node_sound_leaves_defaults(),

        drawtype = "allfaces_optional",
        drop = {
            max_items = 1,
            items = {
                {items = {"default:aspen_sapling"}, rarity = 20},
                {items = {"default:aspen_leaves"}}
            }
        },
        is_ground_content = false,
        paramtype = "light",
        waving = 1,

        after_place_node = after_place_leaves,
    })
    default.register_leafdecay({
        -- From default:aspen_leaves
        trunks = {"default:aspen_tree"},
        leaves = {"default:aspen_leaves"},
        radius = 3,
    })
    ]]--
    unilib.register_tree_leaves({
        -- From default:aspen_leaves. Creates unilib:tree_aspen_leaves
        part_name = "aspen",
        orig_name = "default:aspen_leaves",

        replace_mode = default_add_mode,
        description = S("Aspen Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("aspen")

    --[[
    local function grow_sapling(pos)

        -- Adapted from default/trees.lua

        if not default.can_grow(pos) then

            -- Try again 5 min later
            minetest.get_node_timer(pos):start(300)
            return

        end

        minetest.log(
            "action",
            "An aspen tree sapling grows into a tree at "..minetest.pos_to_string(pos)
        )

        -- Imported from default.grow_new_aspen_tree()
        minetest.place_schematic(
            {x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
            minetest.get_modpath("default") .. "/schematics/aspen_tree_from_sapling.mts"
            "0",
            nil,
            false
        )

    end

    minetest.register_node("default:aspen_sapling", {
        -- From default:aspen_sapling
        description = S("Aspen Tree Sapling"),
        tiles = {"default_aspen_sapling.png"},
        groups = {attached_node = 1, dig_immediate = 3, flammable = 3, sapling = 1, snappy = 2},
        sounds = default.node_sound_leaves_defaults(),

        drawtype = "plantlike",
        inventory_image = "default_aspen_sapling.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16}
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "default_aspen_sapling.png",

        on_construct = function(pos)
            minetest.get_node_timer(pos):start(math.random(300, 1500))
        end,

        on_place = function(itemstack, placer, pointed_thing)
            itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
                "default:aspen_sapling",
                -- minp, maxp to be checked, relative to sapling pos
                -- minp_relative.y = 1 because sapling pos has been checked
                {x = -2, y = 1, z = -2},
                {x = 2, y = 12, z = 2},
                -- maximum interval of interior volume check
                4
            )

            return itemstack
        end,

        on_timer = grow_sapling
    })
    minetest.register_craft({
        type = "fuel",
        recipe = "default:aspen_sapling",
        burntime = 4,
    })
    minetest.register_lbm({
        name = "default:convert_saplings_to_node_timer",
        nodenames = {"default:aspen_sapling"},
        action = function(pos)
            minetest.get_node_timer(pos):start(math.random(300, 1500))
        end
    })
    ]]--
    unilib.register_tree_sapling({
        -- From default:aspen_sapling. Creates unilib:tree_aspen_sapling
        part_name = "aspen",
        orig_name = "default:aspen_sapling",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        common_group = 3,
        description = S("Aspen Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 12, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {2, 1, 2},
        sci_name = sci_name,
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16},
    })

    --[[
    local nodes = {
        ["all_faces_aspen_tree"] = {
            description = S("All-faces Aspen Tree"),
            tiles = {"default_aspen_tree_top.png"},
            groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
            sounds = sound_wood,
            furnace_burntime = 22,
        },
    }
    minetest.register_craft({
        output = "moreblocks:all_faces_aspen_tree 8",
        recipe = {
            {"default:aspen_tree", "default:aspen_tree", "default:aspen_tree"},
            {"default:aspen_tree", "", "default:aspen_tree"},
            {"default:aspen_tree", "default:aspen_tree", "default:aspen_tree"},
        }
    })
    ]]--
    if unilib.mtgame_tweak_flag and moreblocks_add_mode ~= "defer" then

        unilib.register_tree_panel({
            -- From moreblocks:all_faces_aspen_tree. Creates unilib:tree_aspen_panel
            part_name = "aspen",
            orig_name = "moreblocks:all_faces_aspen_tree",

            replace_mode = moreblocks_add_mode,
            burnlevel = burnlevel,
            common_group = 3,
            description = S("Aspen Wood Panel"),
        })

    end

    --[[
    default.register_fence("default:fence_aspen_wood", {
        description = S("Aspen Wood Fence"),
        groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
        sounds = default.node_sound_wood_defaults()

        inventory_image = "default_fence_overlay.png^default_aspen_wood.png^" ..
                    "default_fence_overlay.png^[makealpha:255,126,126",
        material = "default:aspen_wood",
        texture = "default_fence_aspen_wood.png",
        wield_image = "default_fence_overlay.png^default_aspen_wood.png^" ..
                    "default_fence_overlay.png^[makealpha:255,126,126",
    })
    minetest.register_craft({
        type = "fuel",
        recipe = "default:fence_aspen_wood",
        burntime = 5,
    })
    ]]--
    unilib.register_fence_quick({
        -- From default:fence_aspen_wood. Creates unilib:tree_aspen_wood_fence
        part_name = "aspen",
        orig_name = "default:fence_aspen_wood",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        description = S("Aspen Wood Fence"),
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
    })

    --[[
    default.register_fence_rail("default:fence_rail_aspen_wood", {
        description = S("Aspen Wood Fence Rail"),
        groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 2},
        sounds = default.node_sound_wood_defaults()

        inventory_image = "default_fence_rail_overlay.png^default_aspen_wood.png^" ..
                    "default_fence_rail_overlay.png^[makealpha:255,126,126",
        material = "default:aspen_wood",
        texture = "default_fence_rail_aspen_wood.png",
        wield_image = "default_fence_rail_overlay.png^default_aspen_wood.png^" ..
                    "default_fence_rail_overlay.png^[makealpha:255,126,126",
    })
    minetest.register_craft({
        type = "fuel",
        recipe = "default:fence_rail_aspen_wood",
        burntime = 3,
    })
    ]]--
    unilib.register_fence_rail_quick({
        -- From default:fence_rail_aspen_wood. Creates unilib:tree_aspen_wood_fence_rail
        part_name = "aspen",
        orig_name = "default:fence_rail_aspen_wood",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        description = S("Aspen Wood Fence Rail"),
        group_table = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 2},
    })

    --[[
    doors.register_fencegate("doors:gate_aspen_wood", {
        description = S("Aspen Wood Fence Gate"),
        texture = "default_aspen_wood.png",
        material = "default:aspen_wood",
        groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3}
    })
    minetest.register_craft({
        type = "fuel",
        recipe = "doors:gate_aspen_wood_closed",
        burntime = 5,
    })
    ]]--
    if doors_add_mode ~= "defer" then

        unilib.register_fence_gate_quick({
            -- From doors:gate_aspen_wood. Creates unilib:gate_aspen_closed
            part_name = "aspen",
            orig_name = {"doors:gate_aspen_wood_closed", "doors:gate_aspen_wood_open"},

            replace_mode = doors_add_mode,
            burnlevel = burnlevel,
            description = S("Aspen Wood Fence Gate"),
            group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        })

    end

    --[[
    minetest.register_decoration({
        -- From default/mapgen.lua
        name = "default:aspen_tree",
        deco_type = "schematic",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.0,
            persist = 0.66
            scale = -0.015,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        schematic = minetest.get_modpath("default") .. "/schematics/aspen_tree.mts",
        sidelen = 16,

        biomes = {"deciduous_forest"},
        place_on = {"default:dirt_with_grass"},
        y_max = 31000,
        y_min = 1,
    })
    ]]--
    unilib.register_decoration("default_tree_aspen", {
        -- From default/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_aspen.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.0,
            persist = 0.66,
            scale = -0.015,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

    --[[
    minetest.register_decoration({
        -- From default/mapgen.lua
        name = "default:aspen_log",
        deco_type = "schematic",

        flags = "place_center_x",
        noise_params = {
            octaves = 3,
            offset = 0.0,
            persist = 0.66
            scale = -0.0008,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        place_offset_y = 1,
        rotation = "random",
        schematic = minetest.get_modpath("default") .. "/schematics/aspen_log.mts",
        sidelen = 16,

        biomes = {"deciduous_forest"},
        place_on = {"default:dirt_with_grass"},
        num_spawn_by = 8,
        spawn_by = "default:dirt_with_grass",
        y_max = 31000,
        y_min = 1,
    })
    ]]--

    if unilib.pkg_executed_table["mushroom_brown"] ~= nil and
            unilib.pkg_executed_table["mushroom_red"] ~= nil then

        unilib.register_decoration("default_tree_aspen_log", {
            -- From default/mapgen.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_aspen_log.mts",

            flags = "place_center_x",
            noise_params = {
                octaves = 3,
                offset = 0.0,
                persist = 0.66,
                scale = -0.0008,
                seed = 2,
                spread = {x = 250, y = 250, z = 250},
            },
            place_offset_y = 1,
            rotation = "random",
            sidelen = 16,
        })

    end

end
