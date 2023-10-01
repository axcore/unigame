---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_aspen_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_aspen_exotic.init()

    return {
        description = "Exotic aspen tree",
        notes = "This package was created because the minetest_game and farlands versions of the" ..
                " five basic trees had similar (but not identical) textures; the farlands trees" ..
                " are therefore named \"exotic\"",
        optional = {"mushroom_brown", "mushroom_red"},
    }

end

function unilib.pkg.tree_aspen_exotic.exec()

    -- (Using same level as the equivalent tree in default)
    local burnlevel = 1
    local sci_name = "Populus tremula"

    unilib.register_tree({
        -- Original to unilib
        part_name = "aspen_exotic",
        description = S("Exotic Aspen Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From farlands, default:aspen_tree. Creates unilib:tree_aspen_exotic_trunk
        part_name = "aspen_exotic",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 3,
        description = S("Exotic Aspen Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From farlands, default:aspen_wood. Creates unilib:tree_aspen_exotic_wood
        part_name = "aspen_exotic",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 3,
        description = S("Exotic Aspen Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From farlands, default:aspen_leaves. Creates unilib:tree_aspen_exotic_leaves
        part_name = "aspen_exotic",
        orig_name = nil,

        replace_mode = mode,
        description = S("Exotic Aspen Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("aspen_exotic")

    unilib.register_tree_sapling({
        -- From farlands, default:aspen_sapling. Creates unilib:tree_aspen_exotic_sapling
        part_name = "aspen_exotic",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 3,
        description = S("Exotic Aspen Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 12, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {2, 1, 2},
        sci_name = sci_name,
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16},
    })

    unilib.register_fence_quick({
        -- From farlands, default:fence_aspen_wood. Creates unilib:tree_aspen_exotic_wood_fence
        part_name = "aspen_exotic",
        orig_name = nil,

        replace_mode = mode,
        -- N.B. farlands provides a separate texture, but it's identical to the wood
        base_img = "unilib_tree_aspen_exotic_wood.png",
        burnlevel = burnlevel,
        description = S("Exotic Aspen Wood Fence"),
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_aspen_exotic_wood_fence_rail
        part_name = "aspen_exotic",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_aspen_exotic_wood.png",
        burnlevel = burnlevel,
        description = S("Exotic Aspen Wood Fence Rail"),
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From farlands, doors:gate_aspen_wood. Creates unilib:gate_aspen_exotic_closed
        part_name = "aspen_exotic",
        orig_name = {nil, nil},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Exotic Aspen Wood Fence Gate"),
        -- N.B. door = 1 omitted from the original code
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration("farlands_tree_aspen_exotic", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_aspen_exotic.mts",

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

    if unilib.pkg_executed_table["mushroom_brown"] ~= nil and
            unilib.pkg_executed_table["mushroom_red"] ~= nil then

        unilib.register_decoration("farlands_tree_aspen_exotic_log", {
            -- From farlands, mapgen/mapgen.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_aspen_exotic_log.mts",

            flags = "place_center_x",
            noise_params = {
                octaves = 3,
                offset = 0.0,
                persist = 0.66,
                scale = -0.0008,
                seed = 2,
                spread = {x = 250, y = 250, z = 250},
            },
            rotation = "random",
            sidelen = 16,
        })

    end

end
