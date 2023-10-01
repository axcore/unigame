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

unilib.pkg.tree_pine = {}

local S = unilib.intllib
local default_add_mode = unilib.imported_mod_table.default.add_mode
local doors_add_mode = unilib.imported_mod_table.doors.add_mode
local moreblocks_add_mode = unilib.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_pine.grow_func(pos)

    -- Adapted from default/trees.lua
    -- Special handling for this tree's sapling, called by unilib.grow_tree_sapling() (instead of
    --      executing that function's own code)

    unilib.log(
        "action",
        "The pine tree sapling grows into a tree at " .. minetest.pos_to_string(pos)
    )

    local snow = unilib.is_snow_nearby(pos)
    if not snow then

        if math.random() > 0.5 then
            mts = "unilib_tree_pine_large_from_sapling.mts"
        else
            mts = "unilib_tree_pine_small_from_sapling.mts"
        end

        minetest.place_schematic(
            {x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
            unilib.path_mod .. "/mts/" .. mts,
            "0",
            nil,
            false
        )

    else

        if math.random() > 0.5 then
            mts = "unilib_tree_pine_snowy_from_sapling.mts"
        else
            mts = "unilib_tree_pine_small_snowy_from_sapling.mts"
        end

        minetest.place_schematic(
            {x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
            unilib.path_mod .. "/mts/" .. mts,
            "random",
            nil,
            false
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_pine.init()

    return {
        description = "Pine tree",
        notes = "Uses four schematics: big or small, with or without snow",
        optional = "mushroom_red",
    }

end

function unilib.pkg.tree_pine.exec()

    local burnlevel = 2
    local sci_name = "Pinus"

    unilib.register_tree({
        -- Original to unilib
        part_name = "pine",
        description = S("Pine Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From default:pine_tree. Creates unilib:tree_pine_trunk
        part_name = "pine",
        orig_name = "default:pine_tree",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        common_group = 3,
        description = S("Pine Tree Trunk"),
        sci_name = sci_name,
        strip_flag = true,
    })

    unilib.register_tree_wood({
        -- From default:pine_wood. Creates unilib:tree_pine_wood
        part_name = "pine",
        orig_name = "default:pine_wood",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        common_group = 3,
        description = S("Pine Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From default:pine_needles. Creates unilib:tree_pine_leaves
        part_name = "pine",
        orig_name = "default:pine_needles",

        replace_mode = default_add_mode,
        description = S("Pine Tree Needles"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("pine")

    unilib.register_tree_sapling({
        -- From default:pine_sapling. Creates unilib:tree_pine_sapling
        part_name = "pine",
        orig_name = "default:pine_sapling",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        common_group = 3,
        description = S("Pine Tree Sapling"),
        grow_func = unilib.pkg.tree_pine.grow_func,
        max_volume = 4,
        maxp_table = {x = 2, y = 14, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {2, 1, 2},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    if unilib.mtgame_tweak_flag and moreblocks_add_mode ~= "defer" then

        unilib.register_tree_panel({
            -- From moreblocks:all_faces_pine_tree. Creates unilib:tree_pine_panel
            part_name = "pine",
            orig_name = "moreblocks:all_faces_pine_tree",

            replace_mode = moreblocks_add_mode,
            burnlevel = burnlevel,
            common_group = 3,
            description = S("Pine Wood Panel"),
        })

    end

    unilib.register_fence_quick({
        -- From default:fence_pine_wood. Creates unilib:tree_pine_wood_fence
        part_name = "pine",
        orig_name = "default:fence_pine_wood",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        description = S("Pine Wood Fence"),
    group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From default:fence_rail_pine_wood. Creates unilib:tree_pine_wood_fence_rail
        part_name = "pine",
        orig_name = "default:fence_rail_pine_wood",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        description = S("Pine Wood Fence Rail"),
    group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
    })

    if doors_add_mode ~= "defer" then

        unilib.register_fence_gate_quick({
            -- From doors:gate_pine_wood. Creates unilib:gate_pine_closed
            part_name = "pine",
            orig_name = {"doors:gate_pine_wood_closed", "doors:gate_pine_wood_open"},

            replace_mode = doors_add_mode,
            burnlevel = burnlevel,
            description = S("Pine Wood Fence Gate"),
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        })

    end

    unilib.register_decoration("default_tree_pine_large", {
        -- From default/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_pine_large.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.010,
            persist = 0.66,
            scale = 0.048,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

    unilib.register_decoration("default_tree_pine_small", {
        -- From default/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_pine_small.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.010,
            persist = 0.66,
            scale = -0.048,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

    if unilib.pkg_executed_table["mushroom_red"] ~= nil then

        unilib.register_decoration("default_tree_pine_log", {
            -- From default/mapgen.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_pine_log.mts",

            fill_ratio = 0.0018,
            flags = "place_center_x",
            place_offset_y = 1,
            rotation = "random",
            sidelen = 80,
        })

    end

end
