---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_branching_green = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bushes.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_branching_green.init()

    return {
        description = "Green branching bush",
        depends = {"item_stick_ordinary", "shared_bushes"},
    }

end

function unilib.pkg.bush_branching_green.exec()

    unilib.pkg.shared_bushes.register_bush_stem(
        -- From bushes:bushbranches3
        "unilib:bush_branching_green_stem",
        "bushes:bushbranches3",
        S("Green Branching Bush"),
        "unilib_bush_branching_green_leaves.png",
        "unilib_bush_branching_green_centre.png"
    )

    unilib.pkg.shared_bushes.register_bush_arm(
        -- From bushes:bushbranches4
        "unilib:bush_branching_green_arm",
        "bushes:bushbranches4",
        S("Green Branching Bush"),
        "unilib_bush_branching_green_leaves.png",
        "unilib_bush_branching_green_centre.png",
        "unilib_bush_branching_green_left.png",
        "unilib_bush_branching_green_right.png"
    )

    unilib.pkg.shared_bushes.register_bush_leaves(
        -- From bushes:BushLeaves2
        "unilib:bush_branching_green_leaves",
        "bushes:BushLeaves2",
        S("Green Branching Bush Leaves"),
        "unilib_bush_branching_green_leaves.png"
    )

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_bush_branching_green"
        part_name = "bush_branching_green",
        convert_func = unilib.pkg.shared_bushes.grow_bush,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 99.9,
                rarity_fertility = 1.5,
                plantlife_limit = -1,
            }),
        },
    })

end
