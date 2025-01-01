---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_normal.init()

    return {
        description = "Normal tree",
        notes = "This tree re-uses trunks, wood and leaves from the default apple tree, but" ..
                " itself contains no apples (and is bigger). Since so many packages depend on" ..
                " apple tree wood, if you don\'t want actual apple trees in your remix then" ..
                " you can use this package instead",
        depends = "tree_apple",
        optional = "dirt_ordinary",
    }

end

function unilib.pkg.tree_normal.exec()

    local burnlevel = 3
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "normal",
        description = S("Apple Tree Wood"),

        burnlevel = burnlevel,
        not_super_flag = true,
    })

    -- (Schematic uses trunk, wood and leaves nodes from the default apple tree)

    unilib.register_tree_sapling({
        -- From ethereal:big_tree_sapling. Creates unilib:tree_normal_sapling
        part_name = "normal",
        orig_name = "ethereal:big_tree_sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Normal Tree Sapling"),
--      max_volume = 4,         -- For ethereal-ng trees, use default value
        maxp_table = {x = 4, y = 8, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        offset_list = {4, 0, 4},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
        under_list = {"unilib:dirt_ordinary_with_turf", "default:dirt_with_grass"},
    })
    if unilib.global.pkg_executed_table["soil_ordinary"] ~= nil then

        -- Craft sapling from apple (default) tree saplings
        unilib.register_craft({
            -- From ethereal:big_tree_sapling
            output = "unilib:tree_normal_sapling",
            recipe = {
                {
                    "unilib:tree_apple_sapling",
                    "unilib:tree_apple_sapling",
                    "unilib:tree_apple_sapling",
                },
            },
        })

    end

    unilib.register_decoration_generic("ethereal_tree_normal", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_normal.mts",

        fill_ratio = 0.001,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
