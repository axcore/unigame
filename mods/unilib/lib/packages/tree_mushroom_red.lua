---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_mushroom_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_mushroom_red.init()

    return {
        description = "Red mushroom tree",
        notes = "Red mushroom pores can be used to break falls",
        depends = "tree_mushroom_generic",
        optional = {"dirt_ordinary_with_turf_mushroom", "mushroom_red"},
    }

end

function unilib.pkg.tree_mushroom_red.exec()

    local burnlevel = 3
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "mushroom_red",
        description = S("Red Mushroom Trunk"),

        burnlevel = burnlevel,
        not_super_flag = true,
    })

    -- (No trunk node, use "unilib:tree_mushroom_generic_trunk" instead)

    -- (No wood node)

    -- (No leaves node, use mushroom caps and mushroom pores instead)

    unilib.register_node("unilib:tree_mushroom_red_cap", "ethereal:mushroom", mode, {
        -- From ethereal:mushroom
        description = S("Red Mushroom Cap"),
        tiles = {"unilib_tree_mushroom_red_cap.png"},
        groups = {choppy = 2, flammable = 2, leafdecay = 3, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.wood,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_mushroom_red_sapling"}, rarity = 20},
                {items = {"unilib:tree_mushroom_red_cap"}},
            },
        },
    })
    unilib.register_craft({
        -- From ethereal:mushroom
        type = "fuel",
        recipe = "unilib:tree_mushroom_red_cap",
        burntime = 10,
    })
    if unilib.global.pkg_executed_table["mushroom_red"] ~= nil then

        unilib.register_craft({
            -- From ethereal:mushroom
            output = "unilib:tree_mushroom_red_cap",
            recipe = {
                {"unilib:mushroom_red", "unilib:mushroom_red"},
                {"unilib:mushroom_red", "unilib:mushroom_red"},
            },
        })

    end
    unilib.register_stairs("unilib:tree_mushroom_red_cap", {
        basic_flag = true,
    })

    -- N.B. Code in the "tree_mushroom_generic" package provides a pore node

    -- N.B. Code in the "tree_mushroom_generic" package handles leaf decay for this package

    unilib.register_tree_sapling({
        -- From ethereal:mushroom_sapling. Creates unilib:tree_mushroom_red_sapling
        part_name = "mushroom_red",
        orig_name = "ethereal:mushroom_sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Red Mushroom Tree Sapling"),
--      max_volume = 4,         -- For ethereal-ng trees, use default value
        maxp_table = {x = 4, y = 11, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        offset_list = {4, 0, 4},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
        under_list = {"unilib:dirt_ordinary_with_turf_mushroom", "ethereal:mushroom_dirt"},
    })

    -- N.B. Code in the "tree_mushroom_generic" package provides fences

    unilib.register_decoration_generic("ethereal_tree_mushroom_red", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_mushroom_red.mts",

        fill_ratio = 0.018,
        flags = "place_center_x, place_center_z",
        -- N.B. Confirmed with original mod author, this is not a typo
        sidelen = 8,
    })

end
