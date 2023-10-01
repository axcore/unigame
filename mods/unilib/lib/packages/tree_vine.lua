---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_vine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_vine.init()

    return {
        description = "Vine tree",
        notes = "This tree re-uses trunks, wood, leaves and saplings from the default apple" ..
                " tree, but itself contains no apples. Its decoration is a schematic containing" ..
                " vines",
        depends = {"tree_apple", "vine_normal"},
    }

end

function unilib.pkg.tree_vine.exec()

    local burnlevel = 3
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "vine",
        description = S("Apple Tree Wood"),

        burnlevel = burnlevel,
        not_super_flag = true,
    })

    unilib.register_leafdecay({
        -- From ethereal-ng/leaves.lua
        trunks = {"unilib:tree_apple_trunk"},
        leaves = {"unilib:tree_apple_leaves", "unilib:vine_normal"},
        radius = 3,
    })

    unilib.register_decoration("ethereal_tree_vine", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_vine_ethereal.mts",

        fill_ratio = 0.02,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
