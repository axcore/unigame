---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_mushroom_brown = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_mushroom_brown.init()

    return {
        description = "Brown mushroom tree",
        depends = {"tree_mushroom_generic", "vine_string_light"},
        optional = "mushroom_red",
    }

end

function unilib.pkg.tree_mushroom_brown.exec()

    local burnlevel = 3
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "mushroom_brown",
        description = S("Brown Mushroom Trunk"),

        burnlevel = burnlevel,
        not_super_flag = true,
    })

    -- (No trunk node, use "unilib:tree_mushroom_generic_trunk" instead)

    -- (No wood node)

    -- (No leaves node, use mushroom caps and mushroom pores instead)

    unilib.register_node("unilib:tree_mushroom_brown_cap", "ethereal:mushroom_brown", mode, {
        -- From ethereal:mushroom_brown
        description = S("Brown Mushroom Cap"),
        tiles = {"unilib_tree_mushroom_brown_cap.png"},
        groups = {choppy = 2, flammable = 2, leafdecay = 3, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.wood,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_mushroom_brown_sapling"}, rarity = 15},
                {items = {"unilib:tree_mushroom_brown_cap"}},
            },
        },
    })
    unilib.register_craft({
        -- From ethereal:mushroom_brown
        type = "fuel",
        recipe = "unilib:tree_mushroom_brown_cap",
        burntime = 10,
    })
    if unilib.global.pkg_executed_table["mushroom_brown"] ~= nil then

        unilib.register_craft({
            -- From ethereal:mushroom_brown
            output = "unilib:tree_mushroom_brown_cap",
            recipe = {
                {"unilib:mushroom_brown", "unilib:mushroom_brown"},
                {"unilib:mushroom_brown", "unilib:mushroom_brown"},
            },
        })

    end
    -- N.B. No stairs for brown mushroom trees in original code; added for compatibility with red
    --      mushroom trees
    unilib.register_stairs("unilib:tree_mushroom_brown_cap", {
        basic_flag = true,
    })

    -- N.B. Code in the "tree_mushroom_generic" package provides a pore node

    -- N.B. Code in the "tree_mushroom_generic" package handles leaf decay for this package

    unilib.register_tree_sapling({
        -- From ethereal:mushroom_brown_sapling. Creates unilib:tree_mushroom_brown_sapling
        part_name = "mushroom_brown",
        orig_name = "ethereal:mushroom_brown_sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Brown Mushroom Tree Sapling"),
--      max_volume = 4,         -- For ethereal-ng trees, use default value
        maxp_table = {x = 1, y = 11, z = 1},
        minp_table = {x = -1, y = 1, z = -1},
        offset_list = {1, 0, 1},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
        under_list = {"unilib:dirt_ordinary_with_turf_mushroom", "ethereal:mushroom_dirt"},
    })

    -- N.B. Code in the "tree_mushroom_generic" package provides fences

    unilib.register_decoration_generic("ethereal_tree_mushroom_brown", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_mushroom_brown.mts",

        fill_ratio = 0.02,
        flags = "place_center_x, place_center_z",
        rotation = "random",
        sidelen = 80,
    })

end
