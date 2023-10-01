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

unilib.pkg.tree_apple = {}

local S = unilib.intllib
local default_add_mode = unilib.imported_mod_table.default.add_mode
local doors_add_mode = unilib.imported_mod_table.doors.add_mode
local moreblocks_add_mode = unilib.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_apple.init()

    return {
        description = "Apple tree",
        notes = "In minetest game, the \"default\" tree. Produces apples",
        depends = "fruit_apple",
        optional = {"item_stick_ordinary", "mushroom_brown"},
    }

end

function unilib.pkg.tree_apple.exec()

    local burnlevel = 3
    local sci_name = "Malus sieversii"

    unilib.register_tree({
        -- Original to unilib
        part_name = "apple",
        description = S("Apple Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From default:tree. Creates unilib:tree_apple_trunk
        part_name = "apple",
        orig_name = "default:tree",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Apple Tree Trunk"),
        sci_name = sci_name,
        strip_flag = true,
    })

    unilib.register_tree_wood({
        -- From default:wood. Creates unilib:tree_apple_wood
        part_name = "apple",
        orig_name = "default:wood",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Apple Tree Wood Planks"),
    })
    if unilib.mtgame_tweak_flag and unilib.pkg_executed_table["item_stick_ordinary"] ~= nil then

        minetest.register_craft({
            -- From moreblocks
            output = "unilib:tree_apple_wood",
            recipe = {
                {"unilib:item_stick_ordinary", "unilib:item_stick_ordinary"},
                {"unilib:item_stick_ordinary", "unilib:item_stick_ordinary"},
            }
        })

    end

    unilib.register_tree_leaves({
        -- From default:leaves. Creates unilib:tree_apple_leaves
        part_name = "apple",
        orig_name = "default:leaves",

        replace_mode = default_add_mode,
        description = S("Apple Tree Leaves"),
        sci_name = sci_name,
        special_list = "unilib_tree_apple_leaves_simple.png",
    })
    unilib.register_leafdecay({
        -- From default:leaves
        trunks = {"unilib:tree_apple_trunk"},
        leaves = {"unilib:fruit_apple", "unilib:tree_apple_leaves"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From default:sapling. Creates unilib:tree_apple_sapling
        part_name = "apple",
        orig_name = "default:sapling",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Apple Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 3, y = 6, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        offset_list = {3, 1, 3},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    if unilib.mtgame_tweak_flag and moreblocks_add_mode ~= "defer" then

        unilib.register_tree_panel({
            -- From moreblocks:all_faces_tree. Creates unilib:tree_apple_panel
            part_name = "apple",
            orig_name = "moreblocks:all_faces_tree",

            replace_mode = moreblocks_add_mode,
            burnlevel = burnlevel,
            common_group = 2,
            description = S("Apple Tree Wood Panel"),
        })

    end

    unilib.register_fence_quick({
        -- From default:fence_wood. Creates unilib:tree_apple_wood_fence
        part_name = "apple",
        orig_name = "default:fence_wood",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        description = S("Apple Tree Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From default:fence_rail_wood. Creates unilib:tree_apple_wood_fence_rail
        part_name = "apple",
        orig_name = "default:fence_rail_wood",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        description = S("Apple Tree Wood Fence Rail"),
    })

    if doors_add_mode ~= "defer" then

        unilib.register_fence_gate_quick({
            -- From doors:gate_wood. Creates unilib:gate_apple_closed
            part_name = "apple",
            orig_name = {"doors:gate_wood_closed", "doors:gate_wood_open"},

            replace_mode = doors_add_mode,
            burnlevel = burnlevel,
            description = S("Apple Tree Wood Fence Gate"),
        })

    end

    unilib.register_decoration("default_tree_apple", {
        -- From default/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_apple.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.024,
            persist = 0.66,
            scale = 0.015,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

    if unilib.pkg_executed_table["mushroom_brown"] ~= nil then

        unilib.register_decoration("default_tree_apple_log", {
            -- From default/mapgen.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_apple_log.mts",

            flags = "place_center_x",
            noise_params = {
                octaves = 3,
                offset = 0.0012,
                persist = 0.66,
                scale = 0.0007,
                seed = 2,
                spread = {x = 250, y = 250, z = 250},
            },
            place_offset_y = 1,
            rotation = "random",
            sidelen = 16,
        })

    end

end
