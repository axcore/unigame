---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_basandra = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_basandra.init()

    return {
        description = "Basandra bush",
    }

end

function unilib.pkg.bush_basandra.exec()

    local burnlevel = 5
    -- (no sci_name)

    unilib.register_bush_stem({
        -- From ethereal:basandra_bush_stem. Creates unilib:bush_basandra_stem
        part_name = "basandra",
        orig_name = "ethereal:basandra_bush_stem",

        replace_mode = mode,
        common_group = 2,
        description = S("Basandra Bush Stem"),
        select_table = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16},
    })
    unilib.override_item("unilib:bush_basandra_stem", {
        groups = {choppy = 2, oddly_breakable_by_hand = 1},

        damage_per_second = 2,
        walkable = false,
    })
    unilib.register_craft({
        -- From ethereal:basandra_wood
        -- N.B. 2x output in original code
        output = "unilib:bush_basandra_wood",
        recipe = {
            {"unilib:bush_basandra_stem"},
        },
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:bush_basandra_stem",
        burntime = unilib.global.bush_burn_table.stem[burnlevel],
    })

    local on_place, place_param2
    if not unilib.setting.auto_rotate_wood_flag then
        on_place = core.rotate_node
    else
        place_param2 = 0
    end

    unilib.register_node("unilib:bush_basandra_wood", "ethereal:basandra_wood", mode, {
        -- From ethereal:basandra_wood
        description = S("Basandra Wood"),
        tiles = {"unilib_bush_basandra_wood.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 1, wood = 1},
        sounds = unilib.global.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",
        place_param2 = place_param2,

        on_place = on_place,
    })

    unilib.register_bush_leaves({
        -- From ethereal:basandra_bush_leaves. Creates unilib:bush_basandra_leaves
        part_name = "basandra",
        orig_name = "ethereal:basandra_bush_leaves",

        replace_mode = mode,
        description = S("Basadra Bush Leaves"),
        img_list = {"unilib_bush_basandra_leaves.png"},
    })
    unilib.override_item("unilib:bush_basandra_stem", {
        groups = {leaves = 1, snappy = 3},
    })
    unilib.register_quick_bush_leafdecay("basandra")

    unilib.register_bush_sapling({
        -- From ethereal:basandra_bush_sapling. Creates unilib:bush_basandra_sapling
        part_name = "basandra",
        orig_name = "ethereal:basandra_bush_sapling",

        replace_mode = mode,
        common_group = 0,
        description = S("Basandra Bush Sapling"),
        max_volume = 2,
        maxp_table = {x = 1, y = 1, z = 1},
        minp_table = {x = -1, y = 0, z = -1},
        offset_list = {1, 1, 1},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16},
    })
    unilib.register_craft({
        -- From ethereal:basandra_bush_sapling
        type = "fuel",
        recipe = "unilib:bush_basandra_sapling",
        burntime = unilib.global.bush_burn_table.sapling[burnlevel],
    })

    unilib.register_fence_quick({
        -- From ethereal:fence_basandra. Creates unilib:bush_basandra_wood_fence
        part_name = "basandra",
        orig_name = "ethereal:fence_basandra",

        replace_mode = mode,
        base_img = "unilib_bush_basandra_wood.png",
        burnlevel = burnlevel,
        description = S("Basandra Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From ethereal:fence_rail_basandra. Creates unilib:bush_basandra_wood_fence_rail
        part_name = "basandra",
        orig_name = "ethereal:fence_rail_basandra",

        replace_mode = mode,
        burnlevel = burnlevel,
        base_img = "unilib_bush_basandra_wood.png",
        description = S("Basandra Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From ethereal:fencegate_basandra_closed, etc. Creates unilib:gate_basandra_closed, etc
        part_name = "basandra",
        orig_name = {"ethereal:fencegate_basandra_closed", "ethereal:fencegate_basandra_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        base_img = "unilib_bush_basandra_wood.png",
        description = S("Basandra Wood Fence Gate"),
    })

    unilib.register_decoration_generic("ethereal_bush_basandra", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_bush_basandra.mts",

        fill_ratio = 0.03,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
